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
#include <algorithm>
#include <unordered_map>

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

    struct SelectionOperand;
    struct LogicalOperandPredicate;

    /**
     * Determines how size calculation should be performed, one of `"content"` or `"padding"`.
     * The default setting (`"content"`) interprets the width and height settings as the data
     * rectangle (plotting) dimensions, to which padding is then added. In contrast, the
     * `"padding"` setting includes the padding within the view size calculations, such that the
     * width and height settings indicate the **total** intended size of the view.
     *
     * __Default value__: `"content"`
     */
    enum class Contains : int { CONTENT, PADDING };

    /**
     * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
     * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
     * descriptions of each.
     *
     * __Default value__: `"pad"`
     */
    enum class AutosizeType : int { PAD, FIT, NONE };

    class AutoSizeParams {
        public:
        AutoSizeParams() = default;
        virtual ~AutoSizeParams() = default;

        private:
        std::optional<Contains> contains;
        std::optional<bool> resize;
        std::optional<AutosizeType> type;

        public:
        /**
         * Determines how size calculation should be performed, one of `"content"` or `"padding"`.
         * The default setting (`"content"`) interprets the width and height settings as the data
         * rectangle (plotting) dimensions, to which padding is then added. In contrast, the
         * `"padding"` setting includes the padding within the view size calculations, such that the
         * width and height settings indicate the **total** intended size of the view.
         *
         * __Default value__: `"content"`
         */
        const std::optional<Contains> & get_contains() const { return contains; }
        std::optional<Contains> & get_mutable_contains() { return contains; }
        void set_contains(const std::optional<Contains> & value) { this->contains = value; }

        /**
         * A boolean flag indicating if autosize layout should be re-calculated on every view
         * update.
         *
         * __Default value__: `false`
         */
        const std::optional<bool> & get_resize() const { return resize; }
        std::optional<bool> & get_mutable_resize() { return resize; }
        void set_resize(const std::optional<bool> & value) { this->resize = value; }

        /**
         * The sizing format type. One of `"pad"`, `"fit"` or `"none"`. See the [autosize
         * type](https://vega.github.io/vega-lite/docs/size.html#autosize) documentation for
         * descriptions of each.
         *
         * __Default value__: `"pad"`
         */
        const std::optional<AutosizeType> & get_type() const { return type; }
        std::optional<AutosizeType> & get_mutable_type() { return type; }
        void set_type(const std::optional<AutosizeType> & value) { this->type = value; }
    };

    using Autosize = std::variant<AutoSizeParams, AutosizeType>;

    /**
     * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
     */
    enum class HorizontalAlign : int { LEFT, RIGHT, CENTER };

    /**
     * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
     *
     * __Default value:__ `"middle"`
     *
     * Vertical text baseline for title text.
     */
    enum class VerticalAlign : int { TOP, MIDDLE, BOTTOM };

    /**
     * The mouse cursor used over the mark. Any valid [CSS cursor
     * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
     */
    enum class Cursor : int { AUTO, DEFAULT, NONE, CONTEXT_MENU, HELP, POINTER, PROGRESS, WAIT, CELL, CROSSHAIR, TEXT, VERTICAL_TEXT, ALIAS, COPY, MOVE, NO_DROP, NOT_ALLOWED, E_RESIZE, N_RESIZE, NE_RESIZE, NW_RESIZE, S_RESIZE, SE_RESIZE, SW_RESIZE, W_RESIZE, EW_RESIZE, NS_RESIZE, NESW_RESIZE, NWSE_RESIZE, COL_RESIZE, ROW_RESIZE, ALL_SCROLL, ZOOM_IN, ZOOM_OUT, GRAB, GRABBING };

    /**
     * The font style (e.g., `"italic"`).
     */
    enum class FontStyle : int { NORMAL, ITALIC };

    enum class FontWeight : int { NORMAL, BOLD };

    using FontWeightUnion = std::variant<double, FontWeight>;

    /**
     * The line interpolation method to use for line and area marks. One of the following:
     * - `"linear"`: piecewise linear segments, as in a polyline.
     * - `"linear-closed"`: close the linear segments to form a polygon.
     * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
     * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
     * function.
     * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
     * function.
     * - `"basis"`: a B-spline, with control point duplication on the ends.
     * - `"basis-open"`: an open B-spline; may not intersect the start or end.
     * - `"basis-closed"`: a closed B-spline, as in a loop.
     * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
     * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
     * will intersect other control points.
     * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
     * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
     * spline.
     * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
     */
    enum class Interpolate : int { LINEAR, LINEAR_CLOSED, STEP, STEP_BEFORE, STEP_AFTER, BASIS, BASIS_OPEN, BASIS_CLOSED, CARDINAL, CARDINAL_OPEN, CARDINAL_CLOSED, BUNDLE, MONOTONE };

    /**
     * The orientation of a non-stacked bar, tick, area, and line charts.
     * The value is either horizontal (default) or vertical.
     * - For bar, rule and tick, this determines whether the size of the bar and tick
     * should be applied to x or y dimension.
     * - For area, this property determines the orient property of the Vega output.
     * - For line, this property determines the sort order of the points in the line
     * if `config.sortLineBy` is not specified.
     * For stacked charts, this is always determined by the orientation of the stack;
     * therefore explicitly specified value will be ignored.
     */
    enum class Orient : int { HORIZONTAL, VERTICAL };

    /**
     * Area-Specific Config
     *
     * Circle-Specific Config
     *
     * Geoshape-Specific Config
     *
     * Line-Specific Config
     *
     * Mark Config
     *
     * Point-Specific Config
     *
     * Rect-Specific Config
     *
     * Rule-Specific Config
     *
     * Square-Specific Config
     */
    class MarkConfig {
        public:
        MarkConfig() :
            angle_constraint(std::nullopt, std::nullopt, 0, 360, std::nullopt, std::nullopt, std::nullopt),
            fill_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            radius_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            stroke_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tension_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~MarkConfig() = default;

        private:
        std::optional<HorizontalAlign> align;
        std::optional<double> angle;
        ClassMemberConstraints angle_constraint;
        std::optional<VerticalAlign> baseline;
        std::optional<std::string> color;
        std::optional<Cursor> cursor;
        std::optional<double> dx;
        std::optional<double> dy;
        std::optional<std::string> fill;
        std::optional<bool> filled;
        std::optional<double> fill_opacity;
        ClassMemberConstraints fill_opacity_constraint;
        std::optional<std::string> font;
        std::optional<double> font_size;
        ClassMemberConstraints font_size_constraint;
        std::optional<FontStyle> font_style;
        std::optional<FontWeightUnion> font_weight;
        std::optional<std::string> href;
        std::optional<Interpolate> interpolate;
        std::optional<double> limit;
        std::optional<double> opacity;
        ClassMemberConstraints opacity_constraint;
        std::optional<Orient> orient;
        std::optional<double> radius;
        ClassMemberConstraints radius_constraint;
        std::optional<std::string> shape;
        std::optional<double> size;
        ClassMemberConstraints size_constraint;
        std::optional<std::string> stroke;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_dash_offset;
        std::optional<double> stroke_opacity;
        ClassMemberConstraints stroke_opacity_constraint;
        std::optional<double> stroke_width;
        ClassMemberConstraints stroke_width_constraint;
        std::optional<double> tension;
        ClassMemberConstraints tension_constraint;
        std::optional<std::string> text;
        std::optional<double> theta;

        public:
        /**
         * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
         */
        const std::optional<HorizontalAlign> & get_align() const { return align; }
        std::optional<HorizontalAlign> & get_mutable_align() { return align; }
        void set_align(const std::optional<HorizontalAlign> & value) { this->align = value; }

        /**
         * The rotation angle of the text, in degrees.
         */
        const std::optional<double> & get_angle() const { return angle; }
        std::optional<double> & get_mutable_angle() { return angle; }
        void set_angle(const std::optional<double> & value) { CheckConstraint("angle", angle_constraint, value); this->angle = value; }

        /**
         * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
         *
         * __Default value:__ `"middle"`
         */
        const std::optional<VerticalAlign> & get_baseline() const { return baseline; }
        std::optional<VerticalAlign> & get_mutable_baseline() { return baseline; }
        void set_baseline(const std::optional<VerticalAlign> & value) { this->baseline = value; }

        /**
         * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
         * will override `color`.
         *
         * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<std::string> & get_color() const { return color; }
        std::optional<std::string> & get_mutable_color() { return color; }
        void set_color(const std::optional<std::string> & value) { this->color = value; }

        /**
         * The mouse cursor used over the mark. Any valid [CSS cursor
         * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
         */
        const std::optional<Cursor> & get_cursor() const { return cursor; }
        std::optional<Cursor> & get_mutable_cursor() { return cursor; }
        void set_cursor(const std::optional<Cursor> & value) { this->cursor = value; }

        /**
         * The horizontal offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dx() const { return dx; }
        std::optional<double> & get_mutable_dx() { return dx; }
        void set_dx(const std::optional<double> & value) { this->dx = value; }

        /**
         * The vertical offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dy() const { return dy; }
        std::optional<double> & get_mutable_dy() { return dy; }
        void set_dy(const std::optional<double> & value) { this->dy = value; }

        /**
         * Default Fill Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_fill() const { return fill; }
        std::optional<std::string> & get_mutable_fill() { return fill; }
        void set_fill(const std::optional<std::string> & value) { this->fill = value; }

        /**
         * Whether the mark's color should be used as fill color instead of stroke color.
         *
         * __Default value:__ `true` for all marks except `point` and `false` for `point`.
         *
         * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<bool> & get_filled() const { return filled; }
        std::optional<bool> & get_mutable_filled() { return filled; }
        void set_filled(const std::optional<bool> & value) { this->filled = value; }

        /**
         * The fill opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_fill_opacity() const { return fill_opacity; }
        std::optional<double> & get_mutable_fill_opacity() { return fill_opacity; }
        void set_fill_opacity(const std::optional<double> & value) { CheckConstraint("fill_opacity", fill_opacity_constraint, value); this->fill_opacity = value; }

        /**
         * The typeface to set the text in (e.g., `"Helvetica Neue"`).
         */
        const std::optional<std::string> & get_font() const { return font; }
        std::optional<std::string> & get_mutable_font() { return font; }
        void set_font(const std::optional<std::string> & value) { this->font = value; }

        /**
         * The font size, in pixels.
         */
        const std::optional<double> & get_font_size() const { return font_size; }
        std::optional<double> & get_mutable_font_size() { return font_size; }
        void set_font_size(const std::optional<double> & value) { CheckConstraint("font_size", font_size_constraint, value); this->font_size = value; }

        /**
         * The font style (e.g., `"italic"`).
         */
        const std::optional<FontStyle> & get_font_style() const { return font_style; }
        std::optional<FontStyle> & get_mutable_font_style() { return font_style; }
        void set_font_style(const std::optional<FontStyle> & value) { this->font_style = value; }

        /**
         * The font weight (e.g., `"bold"`).
         */
        const std::optional<FontWeightUnion> & get_font_weight() const { return font_weight; }
        std::optional<FontWeightUnion> & get_mutable_font_weight() { return font_weight; }
        void set_font_weight(const std::optional<FontWeightUnion> & value) { this->font_weight = value; }

        /**
         * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
         */
        const std::optional<std::string> & get_href() const { return href; }
        std::optional<std::string> & get_mutable_href() { return href; }
        void set_href(const std::optional<std::string> & value) { this->href = value; }

        /**
         * The line interpolation method to use for line and area marks. One of the following:
         * - `"linear"`: piecewise linear segments, as in a polyline.
         * - `"linear-closed"`: close the linear segments to form a polygon.
         * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
         * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
         * function.
         * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
         * function.
         * - `"basis"`: a B-spline, with control point duplication on the ends.
         * - `"basis-open"`: an open B-spline; may not intersect the start or end.
         * - `"basis-closed"`: a closed B-spline, as in a loop.
         * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
         * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
         * will intersect other control points.
         * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
         * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
         * spline.
         * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
         */
        const std::optional<Interpolate> & get_interpolate() const { return interpolate; }
        std::optional<Interpolate> & get_mutable_interpolate() { return interpolate; }
        void set_interpolate(const std::optional<Interpolate> & value) { this->interpolate = value; }

        /**
         * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
         * value will be automatically truncated if the rendered size exceeds the limit.
         */
        const std::optional<double> & get_limit() const { return limit; }
        std::optional<double> & get_mutable_limit() { return limit; }
        void set_limit(const std::optional<double> & value) { this->limit = value; }

        /**
         * The overall opacity (value between [0,1]).
         *
         * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
         * `square` marks or layered `bar` charts and `1` otherwise.
         */
        const std::optional<double> & get_opacity() const { return opacity; }
        std::optional<double> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<double> & value) { CheckConstraint("opacity", opacity_constraint, value); this->opacity = value; }

        /**
         * The orientation of a non-stacked bar, tick, area, and line charts.
         * The value is either horizontal (default) or vertical.
         * - For bar, rule and tick, this determines whether the size of the bar and tick
         * should be applied to x or y dimension.
         * - For area, this property determines the orient property of the Vega output.
         * - For line, this property determines the sort order of the points in the line
         * if `config.sortLineBy` is not specified.
         * For stacked charts, this is always determined by the orientation of the stack;
         * therefore explicitly specified value will be ignored.
         */
        const std::optional<Orient> & get_orient() const { return orient; }
        std::optional<Orient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<Orient> & value) { this->orient = value; }

        /**
         * Polar coordinate radial offset, in pixels, of the text label from the origin determined
         * by the `x` and `y` properties.
         */
        const std::optional<double> & get_radius() const { return radius; }
        std::optional<double> & get_mutable_radius() { return radius; }
        void set_radius(const std::optional<double> & value) { CheckConstraint("radius", radius_constraint, value); this->radius = value; }

        /**
         * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
         * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
         *
         * __Default value:__ `"circle"`
         */
        const std::optional<std::string> & get_shape() const { return shape; }
        std::optional<std::string> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<std::string> & value) { this->shape = value; }

        /**
         * The pixel area each the point/circle/square.
         * For example: in the case of circles, the radius is determined in part by the square root
         * of the size value.
         *
         * __Default value:__ `30`
         */
        const std::optional<double> & get_size() const { return size; }
        std::optional<double> & get_mutable_size() { return size; }
        void set_size(const std::optional<double> & value) { CheckConstraint("size", size_constraint, value); this->size = value; }

        /**
         * Default Stroke Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_stroke() const { return stroke; }
        std::optional<std::string> & get_mutable_stroke() { return stroke; }
        void set_stroke(const std::optional<std::string> & value) { this->stroke = value; }

        /**
         * An array of alternating stroke, space lengths for creating dashed or dotted lines.
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the stroke dash array.
         */
        const std::optional<double> & get_stroke_dash_offset() const { return stroke_dash_offset; }
        std::optional<double> & get_mutable_stroke_dash_offset() { return stroke_dash_offset; }
        void set_stroke_dash_offset(const std::optional<double> & value) { this->stroke_dash_offset = value; }

        /**
         * The stroke opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_stroke_opacity() const { return stroke_opacity; }
        std::optional<double> & get_mutable_stroke_opacity() { return stroke_opacity; }
        void set_stroke_opacity(const std::optional<double> & value) { CheckConstraint("stroke_opacity", stroke_opacity_constraint, value); this->stroke_opacity = value; }

        /**
         * The stroke width, in pixels.
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { CheckConstraint("stroke_width", stroke_width_constraint, value); this->stroke_width = value; }

        /**
         * Depending on the interpolation type, sets the tension parameter (for line and area marks).
         */
        const std::optional<double> & get_tension() const { return tension; }
        std::optional<double> & get_mutable_tension() { return tension; }
        void set_tension(const std::optional<double> & value) { CheckConstraint("tension", tension_constraint, value); this->tension = value; }

        /**
         * Placeholder text if the `text` channel is not specified
         */
        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }

        /**
         * Polar coordinate angle, in radians, of the text label from the origin determined by the
         * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
         * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
         * indicating "north".
         */
        const std::optional<double> & get_theta() const { return theta; }
        std::optional<double> & get_mutable_theta() { return theta; }
        void set_theta(const std::optional<double> & value) { this->theta = value; }
    };

    using Label = std::variant<bool, double>;

    enum class LabelOverlapEnum : int { PARITY, GREEDY };

    using LabelOverlapUnion = std::variant<bool, LabelOverlapEnum>;

    using TitleFontWeight = std::variant<double, std::string>;

    /**
     * Axis configuration, which determines default properties for all `x` and `y`
     * [axes](axis.html). For a full list of axis configuration options, please see the
     * [corresponding section of the axis documentation](axis.html#config).
     */
    class AxisConfig {
        public:
        AxisConfig() :
            grid_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            grid_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            label_angle_constraint(std::nullopt, std::nullopt, -360, 360, std::nullopt, std::nullopt, std::nullopt),
            label_font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tick_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tick_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            title_font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~AxisConfig() = default;

        private:
        std::optional<double> band_position;
        std::optional<bool> domain;
        std::optional<std::string> domain_color;
        std::optional<double> domain_width;
        std::optional<bool> grid;
        std::optional<std::string> grid_color;
        std::optional<std::vector<double>> grid_dash;
        std::optional<double> grid_opacity;
        ClassMemberConstraints grid_opacity_constraint;
        std::optional<double> grid_width;
        ClassMemberConstraints grid_width_constraint;
        std::optional<double> label_angle;
        ClassMemberConstraints label_angle_constraint;
        std::optional<Label> label_bound;
        std::optional<std::string> label_color;
        std::optional<Label> label_flush;
        std::optional<std::string> label_font;
        std::optional<double> label_font_size;
        ClassMemberConstraints label_font_size_constraint;
        std::optional<double> label_limit;
        std::optional<LabelOverlapUnion> label_overlap;
        std::optional<double> label_padding;
        std::optional<bool> labels;
        std::optional<double> max_extent;
        std::optional<double> min_extent;
        std::optional<bool> short_time_labels;
        std::optional<std::string> tick_color;
        std::optional<bool> tick_round;
        std::optional<bool> ticks;
        std::optional<double> tick_size;
        ClassMemberConstraints tick_size_constraint;
        std::optional<double> tick_width;
        ClassMemberConstraints tick_width_constraint;
        std::optional<std::string> title_align;
        std::optional<double> title_angle;
        std::optional<std::string> title_baseline;
        std::optional<std::string> title_color;
        std::optional<std::string> title_font;
        std::optional<double> title_font_size;
        ClassMemberConstraints title_font_size_constraint;
        std::optional<TitleFontWeight> title_font_weight;
        std::optional<double> title_limit;
        std::optional<double> title_max_length;
        std::optional<double> title_padding;
        std::optional<double> title_x;
        std::optional<double> title_y;

        public:
        /**
         * An interpolation fraction indicating where, for `band` scales, axis ticks should be
         * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
         * places ticks in the middle of their bands.
         */
        const std::optional<double> & get_band_position() const { return band_position; }
        std::optional<double> & get_mutable_band_position() { return band_position; }
        void set_band_position(const std::optional<double> & value) { this->band_position = value; }

        /**
         * A boolean flag indicating if the domain (the axis baseline) should be included as part of
         * the axis.
         *
         * __Default value:__ `true`
         */
        const std::optional<bool> & get_domain() const { return domain; }
        std::optional<bool> & get_mutable_domain() { return domain; }
        void set_domain(const std::optional<bool> & value) { this->domain = value; }

        /**
         * Color of axis domain line.
         *
         * __Default value:__  (none, using Vega default).
         */
        const std::optional<std::string> & get_domain_color() const { return domain_color; }
        std::optional<std::string> & get_mutable_domain_color() { return domain_color; }
        void set_domain_color(const std::optional<std::string> & value) { this->domain_color = value; }

        /**
         * Stroke width of axis domain line
         *
         * __Default value:__  (none, using Vega default).
         */
        const std::optional<double> & get_domain_width() const { return domain_width; }
        std::optional<double> & get_mutable_domain_width() { return domain_width; }
        void set_domain_width(const std::optional<double> & value) { this->domain_width = value; }

        /**
         * A boolean flag indicating if grid lines should be included as part of the axis
         *
         * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
         * binned; otherwise, `false`.
         */
        const std::optional<bool> & get_grid() const { return grid; }
        std::optional<bool> & get_mutable_grid() { return grid; }
        void set_grid(const std::optional<bool> & value) { this->grid = value; }

        /**
         * Color of gridlines.
         */
        const std::optional<std::string> & get_grid_color() const { return grid_color; }
        std::optional<std::string> & get_mutable_grid_color() { return grid_color; }
        void set_grid_color(const std::optional<std::string> & value) { this->grid_color = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the grid dash array.
         */
        const std::optional<std::vector<double>> & get_grid_dash() const { return grid_dash; }
        std::optional<std::vector<double>> & get_mutable_grid_dash() { return grid_dash; }
        void set_grid_dash(const std::optional<std::vector<double>> & value) { this->grid_dash = value; }

        /**
         * The stroke opacity of grid (value between [0,1])
         *
         * __Default value:__ (`1` by default)
         */
        const std::optional<double> & get_grid_opacity() const { return grid_opacity; }
        std::optional<double> & get_mutable_grid_opacity() { return grid_opacity; }
        void set_grid_opacity(const std::optional<double> & value) { CheckConstraint("grid_opacity", grid_opacity_constraint, value); this->grid_opacity = value; }

        /**
         * The grid width, in pixels.
         */
        const std::optional<double> & get_grid_width() const { return grid_width; }
        std::optional<double> & get_mutable_grid_width() { return grid_width; }
        void set_grid_width(const std::optional<double> & value) { CheckConstraint("grid_width", grid_width_constraint, value); this->grid_width = value; }

        /**
         * The rotation angle of the axis labels.
         *
         * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
         */
        const std::optional<double> & get_label_angle() const { return label_angle; }
        std::optional<double> & get_mutable_label_angle() { return label_angle; }
        void set_label_angle(const std::optional<double> & value) { CheckConstraint("label_angle", label_angle_constraint, value); this->label_angle = value; }

        /**
         * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
         * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
         * they exceed the axis range by more than 1 pixel. If this property is a number, it
         * specifies the pixel tolerance: the maximum amount by which a label bounding box may
         * exceed the axis range.
         *
         * __Default value:__ `false`.
         */
        const std::optional<Label> & get_label_bound() const { return label_bound; }
        std::optional<Label> & get_mutable_label_bound() { return label_bound; }
        void set_label_bound(const std::optional<Label> & value) { this->label_bound = value; }

        /**
         * The color of the tick label, can be in hex color code or regular color name.
         */
        const std::optional<std::string> & get_label_color() const { return label_color; }
        std::optional<std::string> & get_mutable_label_color() { return label_color; }
        void set_label_color(const std::optional<std::string> & value) { this->label_color = value; }

        /**
         * Indicates if the first and last axis labels should be aligned flush with the scale range.
         * Flush alignment for a horizontal axis will left-align the first label and right-align the
         * last label. For vertical axes, bottom and top text baselines are applied instead. If this
         * property is a number, it also indicates the number of pixels by which to offset the first
         * and last labels; for example, a value of 2 will flush-align the first and last labels and
         * also push them 2 pixels outward from the center of the axis. The additional adjustment
         * can sometimes help the labels better visually group with corresponding axis ticks.
         *
         * __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
         */
        const std::optional<Label> & get_label_flush() const { return label_flush; }
        std::optional<Label> & get_mutable_label_flush() { return label_flush; }
        void set_label_flush(const std::optional<Label> & value) { this->label_flush = value; }

        /**
         * The font of the tick label.
         */
        const std::optional<std::string> & get_label_font() const { return label_font; }
        std::optional<std::string> & get_mutable_label_font() { return label_font; }
        void set_label_font(const std::optional<std::string> & value) { this->label_font = value; }

        /**
         * The font size of the label, in pixels.
         */
        const std::optional<double> & get_label_font_size() const { return label_font_size; }
        std::optional<double> & get_mutable_label_font_size() { return label_font_size; }
        void set_label_font_size(const std::optional<double> & value) { CheckConstraint("label_font_size", label_font_size_constraint, value); this->label_font_size = value; }

        /**
         * Maximum allowed pixel width of axis tick labels.
         */
        const std::optional<double> & get_label_limit() const { return label_limit; }
        std::optional<double> & get_mutable_label_limit() { return label_limit; }
        void set_label_limit(const std::optional<double> & value) { this->label_limit = value; }

        /**
         * The strategy to use for resolving overlap of axis labels. If `false` (the default), no
         * overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
         * every other label is used (this works well for standard linear axes). If set to
         * `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
         * with the last visible label (this often works better for log-scaled axes).
         *
         * __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
         * scales; otherwise `false`.
         */
        const std::optional<LabelOverlapUnion> & get_label_overlap() const { return label_overlap; }
        std::optional<LabelOverlapUnion> & get_mutable_label_overlap() { return label_overlap; }
        void set_label_overlap(const std::optional<LabelOverlapUnion> & value) { this->label_overlap = value; }

        /**
         * The padding, in pixels, between axis and text labels.
         */
        const std::optional<double> & get_label_padding() const { return label_padding; }
        std::optional<double> & get_mutable_label_padding() { return label_padding; }
        void set_label_padding(const std::optional<double> & value) { this->label_padding = value; }

        /**
         * A boolean flag indicating if labels should be included as part of the axis.
         *
         * __Default value:__  `true`.
         */
        const std::optional<bool> & get_labels() const { return labels; }
        std::optional<bool> & get_mutable_labels() { return labels; }
        void set_labels(const std::optional<bool> & value) { this->labels = value; }

        /**
         * The maximum extent in pixels that axis ticks and labels should use. This determines a
         * maximum offset value for axis titles.
         *
         * __Default value:__ `undefined`.
         */
        const std::optional<double> & get_max_extent() const { return max_extent; }
        std::optional<double> & get_mutable_max_extent() { return max_extent; }
        void set_max_extent(const std::optional<double> & value) { this->max_extent = value; }

        /**
         * The minimum extent in pixels that axis ticks and labels should use. This determines a
         * minimum offset value for axis titles.
         *
         * __Default value:__ `30` for y-axis; `undefined` for x-axis.
         */
        const std::optional<double> & get_min_extent() const { return min_extent; }
        std::optional<double> & get_mutable_min_extent() { return min_extent; }
        void set_min_extent(const std::optional<double> & value) { this->min_extent = value; }

        /**
         * Whether month names and weekday names should be abbreviated.
         *
         * __Default value:__  `false`
         */
        const std::optional<bool> & get_short_time_labels() const { return short_time_labels; }
        std::optional<bool> & get_mutable_short_time_labels() { return short_time_labels; }
        void set_short_time_labels(const std::optional<bool> & value) { this->short_time_labels = value; }

        /**
         * The color of the axis's tick.
         */
        const std::optional<std::string> & get_tick_color() const { return tick_color; }
        std::optional<std::string> & get_mutable_tick_color() { return tick_color; }
        void set_tick_color(const std::optional<std::string> & value) { this->tick_color = value; }

        /**
         * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
         */
        const std::optional<bool> & get_tick_round() const { return tick_round; }
        std::optional<bool> & get_mutable_tick_round() { return tick_round; }
        void set_tick_round(const std::optional<bool> & value) { this->tick_round = value; }

        /**
         * Boolean value that determines whether the axis should include ticks.
         */
        const std::optional<bool> & get_ticks() const { return ticks; }
        std::optional<bool> & get_mutable_ticks() { return ticks; }
        void set_ticks(const std::optional<bool> & value) { this->ticks = value; }

        /**
         * The size in pixels of axis ticks.
         */
        const std::optional<double> & get_tick_size() const { return tick_size; }
        std::optional<double> & get_mutable_tick_size() { return tick_size; }
        void set_tick_size(const std::optional<double> & value) { CheckConstraint("tick_size", tick_size_constraint, value); this->tick_size = value; }

        /**
         * The width, in pixels, of ticks.
         */
        const std::optional<double> & get_tick_width() const { return tick_width; }
        std::optional<double> & get_mutable_tick_width() { return tick_width; }
        void set_tick_width(const std::optional<double> & value) { CheckConstraint("tick_width", tick_width_constraint, value); this->tick_width = value; }

        /**
         * Horizontal text alignment of axis titles.
         */
        const std::optional<std::string> & get_title_align() const { return title_align; }
        std::optional<std::string> & get_mutable_title_align() { return title_align; }
        void set_title_align(const std::optional<std::string> & value) { this->title_align = value; }

        /**
         * Angle in degrees of axis titles.
         */
        const std::optional<double> & get_title_angle() const { return title_angle; }
        std::optional<double> & get_mutable_title_angle() { return title_angle; }
        void set_title_angle(const std::optional<double> & value) { this->title_angle = value; }

        /**
         * Vertical text baseline for axis titles.
         */
        const std::optional<std::string> & get_title_baseline() const { return title_baseline; }
        std::optional<std::string> & get_mutable_title_baseline() { return title_baseline; }
        void set_title_baseline(const std::optional<std::string> & value) { this->title_baseline = value; }

        /**
         * Color of the title, can be in hex color code or regular color name.
         */
        const std::optional<std::string> & get_title_color() const { return title_color; }
        std::optional<std::string> & get_mutable_title_color() { return title_color; }
        void set_title_color(const std::optional<std::string> & value) { this->title_color = value; }

        /**
         * Font of the title. (e.g., `"Helvetica Neue"`).
         */
        const std::optional<std::string> & get_title_font() const { return title_font; }
        std::optional<std::string> & get_mutable_title_font() { return title_font; }
        void set_title_font(const std::optional<std::string> & value) { this->title_font = value; }

        /**
         * Font size of the title.
         */
        const std::optional<double> & get_title_font_size() const { return title_font_size; }
        std::optional<double> & get_mutable_title_font_size() { return title_font_size; }
        void set_title_font_size(const std::optional<double> & value) { CheckConstraint("title_font_size", title_font_size_constraint, value); this->title_font_size = value; }

        /**
         * Font weight of the title. (e.g., `"bold"`).
         */
        const std::optional<TitleFontWeight> & get_title_font_weight() const { return title_font_weight; }
        std::optional<TitleFontWeight> & get_mutable_title_font_weight() { return title_font_weight; }
        void set_title_font_weight(const std::optional<TitleFontWeight> & value) { this->title_font_weight = value; }

        /**
         * Maximum allowed pixel width of axis titles.
         */
        const std::optional<double> & get_title_limit() const { return title_limit; }
        std::optional<double> & get_mutable_title_limit() { return title_limit; }
        void set_title_limit(const std::optional<double> & value) { this->title_limit = value; }

        /**
         * Max length for axis title if the title is automatically generated from the field's
         * description.
         */
        const std::optional<double> & get_title_max_length() const { return title_max_length; }
        std::optional<double> & get_mutable_title_max_length() { return title_max_length; }
        void set_title_max_length(const std::optional<double> & value) { this->title_max_length = value; }

        /**
         * The padding, in pixels, between title and axis.
         */
        const std::optional<double> & get_title_padding() const { return title_padding; }
        std::optional<double> & get_mutable_title_padding() { return title_padding; }
        void set_title_padding(const std::optional<double> & value) { this->title_padding = value; }

        /**
         * X-coordinate of the axis title relative to the axis group.
         */
        const std::optional<double> & get_title_x() const { return title_x; }
        std::optional<double> & get_mutable_title_x() { return title_x; }
        void set_title_x(const std::optional<double> & value) { this->title_x = value; }

        /**
         * Y-coordinate of the axis title relative to the axis group.
         */
        const std::optional<double> & get_title_y() const { return title_y; }
        std::optional<double> & get_mutable_title_y() { return title_y; }
        void set_title_y(const std::optional<double> & value) { this->title_y = value; }
    };

    /**
     * Specific axis config for axes with "band" scales.
     *
     * Specific axis config for x-axis along the bottom edge of the chart.
     *
     * Specific axis config for y-axis along the left edge of the chart.
     *
     * Specific axis config for y-axis along the right edge of the chart.
     *
     * Specific axis config for x-axis along the top edge of the chart.
     *
     * X-axis specific config.
     *
     * Y-axis specific config.
     */
    class VgAxisConfig {
        public:
        VgAxisConfig() :
            grid_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            grid_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            label_angle_constraint(std::nullopt, std::nullopt, -360, 360, std::nullopt, std::nullopt, std::nullopt),
            label_font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tick_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tick_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            title_font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~VgAxisConfig() = default;

        private:
        std::optional<double> band_position;
        std::optional<bool> domain;
        std::optional<std::string> domain_color;
        std::optional<double> domain_width;
        std::optional<bool> grid;
        std::optional<std::string> grid_color;
        std::optional<std::vector<double>> grid_dash;
        std::optional<double> grid_opacity;
        ClassMemberConstraints grid_opacity_constraint;
        std::optional<double> grid_width;
        ClassMemberConstraints grid_width_constraint;
        std::optional<double> label_angle;
        ClassMemberConstraints label_angle_constraint;
        std::optional<Label> label_bound;
        std::optional<std::string> label_color;
        std::optional<Label> label_flush;
        std::optional<std::string> label_font;
        std::optional<double> label_font_size;
        ClassMemberConstraints label_font_size_constraint;
        std::optional<double> label_limit;
        std::optional<LabelOverlapUnion> label_overlap;
        std::optional<double> label_padding;
        std::optional<bool> labels;
        std::optional<double> max_extent;
        std::optional<double> min_extent;
        std::optional<std::string> tick_color;
        std::optional<bool> tick_round;
        std::optional<bool> ticks;
        std::optional<double> tick_size;
        ClassMemberConstraints tick_size_constraint;
        std::optional<double> tick_width;
        ClassMemberConstraints tick_width_constraint;
        std::optional<std::string> title_align;
        std::optional<double> title_angle;
        std::optional<std::string> title_baseline;
        std::optional<std::string> title_color;
        std::optional<std::string> title_font;
        std::optional<double> title_font_size;
        ClassMemberConstraints title_font_size_constraint;
        std::optional<TitleFontWeight> title_font_weight;
        std::optional<double> title_limit;
        std::optional<double> title_max_length;
        std::optional<double> title_padding;
        std::optional<double> title_x;
        std::optional<double> title_y;

        public:
        /**
         * An interpolation fraction indicating where, for `band` scales, axis ticks should be
         * positioned. A value of `0` places ticks at the left edge of their bands. A value of `0.5`
         * places ticks in the middle of their bands.
         */
        const std::optional<double> & get_band_position() const { return band_position; }
        std::optional<double> & get_mutable_band_position() { return band_position; }
        void set_band_position(const std::optional<double> & value) { this->band_position = value; }

        /**
         * A boolean flag indicating if the domain (the axis baseline) should be included as part of
         * the axis.
         *
         * __Default value:__ `true`
         */
        const std::optional<bool> & get_domain() const { return domain; }
        std::optional<bool> & get_mutable_domain() { return domain; }
        void set_domain(const std::optional<bool> & value) { this->domain = value; }

        /**
         * Color of axis domain line.
         *
         * __Default value:__  (none, using Vega default).
         */
        const std::optional<std::string> & get_domain_color() const { return domain_color; }
        std::optional<std::string> & get_mutable_domain_color() { return domain_color; }
        void set_domain_color(const std::optional<std::string> & value) { this->domain_color = value; }

        /**
         * Stroke width of axis domain line
         *
         * __Default value:__  (none, using Vega default).
         */
        const std::optional<double> & get_domain_width() const { return domain_width; }
        std::optional<double> & get_mutable_domain_width() { return domain_width; }
        void set_domain_width(const std::optional<double> & value) { this->domain_width = value; }

        /**
         * A boolean flag indicating if grid lines should be included as part of the axis
         *
         * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
         * binned; otherwise, `false`.
         */
        const std::optional<bool> & get_grid() const { return grid; }
        std::optional<bool> & get_mutable_grid() { return grid; }
        void set_grid(const std::optional<bool> & value) { this->grid = value; }

        /**
         * Color of gridlines.
         */
        const std::optional<std::string> & get_grid_color() const { return grid_color; }
        std::optional<std::string> & get_mutable_grid_color() { return grid_color; }
        void set_grid_color(const std::optional<std::string> & value) { this->grid_color = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the grid dash array.
         */
        const std::optional<std::vector<double>> & get_grid_dash() const { return grid_dash; }
        std::optional<std::vector<double>> & get_mutable_grid_dash() { return grid_dash; }
        void set_grid_dash(const std::optional<std::vector<double>> & value) { this->grid_dash = value; }

        /**
         * The stroke opacity of grid (value between [0,1])
         *
         * __Default value:__ (`1` by default)
         */
        const std::optional<double> & get_grid_opacity() const { return grid_opacity; }
        std::optional<double> & get_mutable_grid_opacity() { return grid_opacity; }
        void set_grid_opacity(const std::optional<double> & value) { CheckConstraint("grid_opacity", grid_opacity_constraint, value); this->grid_opacity = value; }

        /**
         * The grid width, in pixels.
         */
        const std::optional<double> & get_grid_width() const { return grid_width; }
        std::optional<double> & get_mutable_grid_width() { return grid_width; }
        void set_grid_width(const std::optional<double> & value) { CheckConstraint("grid_width", grid_width_constraint, value); this->grid_width = value; }

        /**
         * The rotation angle of the axis labels.
         *
         * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
         */
        const std::optional<double> & get_label_angle() const { return label_angle; }
        std::optional<double> & get_mutable_label_angle() { return label_angle; }
        void set_label_angle(const std::optional<double> & value) { CheckConstraint("label_angle", label_angle_constraint, value); this->label_angle = value; }

        /**
         * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
         * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
         * they exceed the axis range by more than 1 pixel. If this property is a number, it
         * specifies the pixel tolerance: the maximum amount by which a label bounding box may
         * exceed the axis range.
         *
         * __Default value:__ `false`.
         */
        const std::optional<Label> & get_label_bound() const { return label_bound; }
        std::optional<Label> & get_mutable_label_bound() { return label_bound; }
        void set_label_bound(const std::optional<Label> & value) { this->label_bound = value; }

        /**
         * The color of the tick label, can be in hex color code or regular color name.
         */
        const std::optional<std::string> & get_label_color() const { return label_color; }
        std::optional<std::string> & get_mutable_label_color() { return label_color; }
        void set_label_color(const std::optional<std::string> & value) { this->label_color = value; }

        /**
         * Indicates if the first and last axis labels should be aligned flush with the scale range.
         * Flush alignment for a horizontal axis will left-align the first label and right-align the
         * last label. For vertical axes, bottom and top text baselines are applied instead. If this
         * property is a number, it also indicates the number of pixels by which to offset the first
         * and last labels; for example, a value of 2 will flush-align the first and last labels and
         * also push them 2 pixels outward from the center of the axis. The additional adjustment
         * can sometimes help the labels better visually group with corresponding axis ticks.
         *
         * __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
         */
        const std::optional<Label> & get_label_flush() const { return label_flush; }
        std::optional<Label> & get_mutable_label_flush() { return label_flush; }
        void set_label_flush(const std::optional<Label> & value) { this->label_flush = value; }

        /**
         * The font of the tick label.
         */
        const std::optional<std::string> & get_label_font() const { return label_font; }
        std::optional<std::string> & get_mutable_label_font() { return label_font; }
        void set_label_font(const std::optional<std::string> & value) { this->label_font = value; }

        /**
         * The font size of the label, in pixels.
         */
        const std::optional<double> & get_label_font_size() const { return label_font_size; }
        std::optional<double> & get_mutable_label_font_size() { return label_font_size; }
        void set_label_font_size(const std::optional<double> & value) { CheckConstraint("label_font_size", label_font_size_constraint, value); this->label_font_size = value; }

        /**
         * Maximum allowed pixel width of axis tick labels.
         */
        const std::optional<double> & get_label_limit() const { return label_limit; }
        std::optional<double> & get_mutable_label_limit() { return label_limit; }
        void set_label_limit(const std::optional<double> & value) { this->label_limit = value; }

        /**
         * The strategy to use for resolving overlap of axis labels. If `false` (the default), no
         * overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
         * every other label is used (this works well for standard linear axes). If set to
         * `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
         * with the last visible label (this often works better for log-scaled axes).
         *
         * __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
         * scales; otherwise `false`.
         */
        const std::optional<LabelOverlapUnion> & get_label_overlap() const { return label_overlap; }
        std::optional<LabelOverlapUnion> & get_mutable_label_overlap() { return label_overlap; }
        void set_label_overlap(const std::optional<LabelOverlapUnion> & value) { this->label_overlap = value; }

        /**
         * The padding, in pixels, between axis and text labels.
         */
        const std::optional<double> & get_label_padding() const { return label_padding; }
        std::optional<double> & get_mutable_label_padding() { return label_padding; }
        void set_label_padding(const std::optional<double> & value) { this->label_padding = value; }

        /**
         * A boolean flag indicating if labels should be included as part of the axis.
         *
         * __Default value:__  `true`.
         */
        const std::optional<bool> & get_labels() const { return labels; }
        std::optional<bool> & get_mutable_labels() { return labels; }
        void set_labels(const std::optional<bool> & value) { this->labels = value; }

        /**
         * The maximum extent in pixels that axis ticks and labels should use. This determines a
         * maximum offset value for axis titles.
         *
         * __Default value:__ `undefined`.
         */
        const std::optional<double> & get_max_extent() const { return max_extent; }
        std::optional<double> & get_mutable_max_extent() { return max_extent; }
        void set_max_extent(const std::optional<double> & value) { this->max_extent = value; }

        /**
         * The minimum extent in pixels that axis ticks and labels should use. This determines a
         * minimum offset value for axis titles.
         *
         * __Default value:__ `30` for y-axis; `undefined` for x-axis.
         */
        const std::optional<double> & get_min_extent() const { return min_extent; }
        std::optional<double> & get_mutable_min_extent() { return min_extent; }
        void set_min_extent(const std::optional<double> & value) { this->min_extent = value; }

        /**
         * The color of the axis's tick.
         */
        const std::optional<std::string> & get_tick_color() const { return tick_color; }
        std::optional<std::string> & get_mutable_tick_color() { return tick_color; }
        void set_tick_color(const std::optional<std::string> & value) { this->tick_color = value; }

        /**
         * Boolean flag indicating if pixel position values should be rounded to the nearest integer.
         */
        const std::optional<bool> & get_tick_round() const { return tick_round; }
        std::optional<bool> & get_mutable_tick_round() { return tick_round; }
        void set_tick_round(const std::optional<bool> & value) { this->tick_round = value; }

        /**
         * Boolean value that determines whether the axis should include ticks.
         */
        const std::optional<bool> & get_ticks() const { return ticks; }
        std::optional<bool> & get_mutable_ticks() { return ticks; }
        void set_ticks(const std::optional<bool> & value) { this->ticks = value; }

        /**
         * The size in pixels of axis ticks.
         */
        const std::optional<double> & get_tick_size() const { return tick_size; }
        std::optional<double> & get_mutable_tick_size() { return tick_size; }
        void set_tick_size(const std::optional<double> & value) { CheckConstraint("tick_size", tick_size_constraint, value); this->tick_size = value; }

        /**
         * The width, in pixels, of ticks.
         */
        const std::optional<double> & get_tick_width() const { return tick_width; }
        std::optional<double> & get_mutable_tick_width() { return tick_width; }
        void set_tick_width(const std::optional<double> & value) { CheckConstraint("tick_width", tick_width_constraint, value); this->tick_width = value; }

        /**
         * Horizontal text alignment of axis titles.
         */
        const std::optional<std::string> & get_title_align() const { return title_align; }
        std::optional<std::string> & get_mutable_title_align() { return title_align; }
        void set_title_align(const std::optional<std::string> & value) { this->title_align = value; }

        /**
         * Angle in degrees of axis titles.
         */
        const std::optional<double> & get_title_angle() const { return title_angle; }
        std::optional<double> & get_mutable_title_angle() { return title_angle; }
        void set_title_angle(const std::optional<double> & value) { this->title_angle = value; }

        /**
         * Vertical text baseline for axis titles.
         */
        const std::optional<std::string> & get_title_baseline() const { return title_baseline; }
        std::optional<std::string> & get_mutable_title_baseline() { return title_baseline; }
        void set_title_baseline(const std::optional<std::string> & value) { this->title_baseline = value; }

        /**
         * Color of the title, can be in hex color code or regular color name.
         */
        const std::optional<std::string> & get_title_color() const { return title_color; }
        std::optional<std::string> & get_mutable_title_color() { return title_color; }
        void set_title_color(const std::optional<std::string> & value) { this->title_color = value; }

        /**
         * Font of the title. (e.g., `"Helvetica Neue"`).
         */
        const std::optional<std::string> & get_title_font() const { return title_font; }
        std::optional<std::string> & get_mutable_title_font() { return title_font; }
        void set_title_font(const std::optional<std::string> & value) { this->title_font = value; }

        /**
         * Font size of the title.
         */
        const std::optional<double> & get_title_font_size() const { return title_font_size; }
        std::optional<double> & get_mutable_title_font_size() { return title_font_size; }
        void set_title_font_size(const std::optional<double> & value) { CheckConstraint("title_font_size", title_font_size_constraint, value); this->title_font_size = value; }

        /**
         * Font weight of the title. (e.g., `"bold"`).
         */
        const std::optional<TitleFontWeight> & get_title_font_weight() const { return title_font_weight; }
        std::optional<TitleFontWeight> & get_mutable_title_font_weight() { return title_font_weight; }
        void set_title_font_weight(const std::optional<TitleFontWeight> & value) { this->title_font_weight = value; }

        /**
         * Maximum allowed pixel width of axis titles.
         */
        const std::optional<double> & get_title_limit() const { return title_limit; }
        std::optional<double> & get_mutable_title_limit() { return title_limit; }
        void set_title_limit(const std::optional<double> & value) { this->title_limit = value; }

        /**
         * Max length for axis title if the title is automatically generated from the field's
         * description.
         */
        const std::optional<double> & get_title_max_length() const { return title_max_length; }
        std::optional<double> & get_mutable_title_max_length() { return title_max_length; }
        void set_title_max_length(const std::optional<double> & value) { this->title_max_length = value; }

        /**
         * The padding, in pixels, between title and axis.
         */
        const std::optional<double> & get_title_padding() const { return title_padding; }
        std::optional<double> & get_mutable_title_padding() { return title_padding; }
        void set_title_padding(const std::optional<double> & value) { this->title_padding = value; }

        /**
         * X-coordinate of the axis title relative to the axis group.
         */
        const std::optional<double> & get_title_x() const { return title_x; }
        std::optional<double> & get_mutable_title_x() { return title_x; }
        void set_title_x(const std::optional<double> & value) { this->title_x = value; }

        /**
         * Y-coordinate of the axis title relative to the axis group.
         */
        const std::optional<double> & get_title_y() const { return title_y; }
        std::optional<double> & get_mutable_title_y() { return title_y; }
        void set_title_y(const std::optional<double> & value) { this->title_y = value; }
    };

    /**
     * Bar-Specific Config
     */
    class BarConfig {
        public:
        BarConfig() :
            angle_constraint(std::nullopt, std::nullopt, 0, 360, std::nullopt, std::nullopt, std::nullopt),
            bin_spacing_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            continuous_band_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            discrete_band_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            fill_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            radius_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            stroke_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tension_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~BarConfig() = default;

        private:
        std::optional<HorizontalAlign> align;
        std::optional<double> angle;
        ClassMemberConstraints angle_constraint;
        std::optional<VerticalAlign> baseline;
        std::optional<double> bin_spacing;
        ClassMemberConstraints bin_spacing_constraint;
        std::optional<std::string> color;
        std::optional<double> continuous_band_size;
        ClassMemberConstraints continuous_band_size_constraint;
        std::optional<Cursor> cursor;
        std::optional<double> discrete_band_size;
        ClassMemberConstraints discrete_band_size_constraint;
        std::optional<double> dx;
        std::optional<double> dy;
        std::optional<std::string> fill;
        std::optional<bool> filled;
        std::optional<double> fill_opacity;
        ClassMemberConstraints fill_opacity_constraint;
        std::optional<std::string> font;
        std::optional<double> font_size;
        ClassMemberConstraints font_size_constraint;
        std::optional<FontStyle> font_style;
        std::optional<FontWeightUnion> font_weight;
        std::optional<std::string> href;
        std::optional<Interpolate> interpolate;
        std::optional<double> limit;
        std::optional<double> opacity;
        ClassMemberConstraints opacity_constraint;
        std::optional<Orient> orient;
        std::optional<double> radius;
        ClassMemberConstraints radius_constraint;
        std::optional<std::string> shape;
        std::optional<double> size;
        ClassMemberConstraints size_constraint;
        std::optional<std::string> stroke;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_dash_offset;
        std::optional<double> stroke_opacity;
        ClassMemberConstraints stroke_opacity_constraint;
        std::optional<double> stroke_width;
        ClassMemberConstraints stroke_width_constraint;
        std::optional<double> tension;
        ClassMemberConstraints tension_constraint;
        std::optional<std::string> text;
        std::optional<double> theta;

        public:
        /**
         * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
         */
        const std::optional<HorizontalAlign> & get_align() const { return align; }
        std::optional<HorizontalAlign> & get_mutable_align() { return align; }
        void set_align(const std::optional<HorizontalAlign> & value) { this->align = value; }

        /**
         * The rotation angle of the text, in degrees.
         */
        const std::optional<double> & get_angle() const { return angle; }
        std::optional<double> & get_mutable_angle() { return angle; }
        void set_angle(const std::optional<double> & value) { CheckConstraint("angle", angle_constraint, value); this->angle = value; }

        /**
         * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
         *
         * __Default value:__ `"middle"`
         */
        const std::optional<VerticalAlign> & get_baseline() const { return baseline; }
        std::optional<VerticalAlign> & get_mutable_baseline() { return baseline; }
        void set_baseline(const std::optional<VerticalAlign> & value) { this->baseline = value; }

        /**
         * Offset between bar for binned field.  Ideal value for this is either 0 (Preferred by
         * statisticians) or 1 (Vega-Lite Default, D3 example style).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_bin_spacing() const { return bin_spacing; }
        std::optional<double> & get_mutable_bin_spacing() { return bin_spacing; }
        void set_bin_spacing(const std::optional<double> & value) { CheckConstraint("bin_spacing", bin_spacing_constraint, value); this->bin_spacing = value; }

        /**
         * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
         * will override `color`.
         *
         * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<std::string> & get_color() const { return color; }
        std::optional<std::string> & get_mutable_color() { return color; }
        void set_color(const std::optional<std::string> & value) { this->color = value; }

        /**
         * The default size of the bars on continuous scales.
         *
         * __Default value:__ `5`
         */
        const std::optional<double> & get_continuous_band_size() const { return continuous_band_size; }
        std::optional<double> & get_mutable_continuous_band_size() { return continuous_band_size; }
        void set_continuous_band_size(const std::optional<double> & value) { CheckConstraint("continuous_band_size", continuous_band_size_constraint, value); this->continuous_band_size = value; }

        /**
         * The mouse cursor used over the mark. Any valid [CSS cursor
         * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
         */
        const std::optional<Cursor> & get_cursor() const { return cursor; }
        std::optional<Cursor> & get_mutable_cursor() { return cursor; }
        void set_cursor(const std::optional<Cursor> & value) { this->cursor = value; }

        /**
         * The size of the bars.  If unspecified, the default size is  `bandSize-1`,
         * which provides 1 pixel offset between bars.
         */
        const std::optional<double> & get_discrete_band_size() const { return discrete_band_size; }
        std::optional<double> & get_mutable_discrete_band_size() { return discrete_band_size; }
        void set_discrete_band_size(const std::optional<double> & value) { CheckConstraint("discrete_band_size", discrete_band_size_constraint, value); this->discrete_band_size = value; }

        /**
         * The horizontal offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dx() const { return dx; }
        std::optional<double> & get_mutable_dx() { return dx; }
        void set_dx(const std::optional<double> & value) { this->dx = value; }

        /**
         * The vertical offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dy() const { return dy; }
        std::optional<double> & get_mutable_dy() { return dy; }
        void set_dy(const std::optional<double> & value) { this->dy = value; }

        /**
         * Default Fill Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_fill() const { return fill; }
        std::optional<std::string> & get_mutable_fill() { return fill; }
        void set_fill(const std::optional<std::string> & value) { this->fill = value; }

        /**
         * Whether the mark's color should be used as fill color instead of stroke color.
         *
         * __Default value:__ `true` for all marks except `point` and `false` for `point`.
         *
         * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<bool> & get_filled() const { return filled; }
        std::optional<bool> & get_mutable_filled() { return filled; }
        void set_filled(const std::optional<bool> & value) { this->filled = value; }

        /**
         * The fill opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_fill_opacity() const { return fill_opacity; }
        std::optional<double> & get_mutable_fill_opacity() { return fill_opacity; }
        void set_fill_opacity(const std::optional<double> & value) { CheckConstraint("fill_opacity", fill_opacity_constraint, value); this->fill_opacity = value; }

        /**
         * The typeface to set the text in (e.g., `"Helvetica Neue"`).
         */
        const std::optional<std::string> & get_font() const { return font; }
        std::optional<std::string> & get_mutable_font() { return font; }
        void set_font(const std::optional<std::string> & value) { this->font = value; }

        /**
         * The font size, in pixels.
         */
        const std::optional<double> & get_font_size() const { return font_size; }
        std::optional<double> & get_mutable_font_size() { return font_size; }
        void set_font_size(const std::optional<double> & value) { CheckConstraint("font_size", font_size_constraint, value); this->font_size = value; }

        /**
         * The font style (e.g., `"italic"`).
         */
        const std::optional<FontStyle> & get_font_style() const { return font_style; }
        std::optional<FontStyle> & get_mutable_font_style() { return font_style; }
        void set_font_style(const std::optional<FontStyle> & value) { this->font_style = value; }

        /**
         * The font weight (e.g., `"bold"`).
         */
        const std::optional<FontWeightUnion> & get_font_weight() const { return font_weight; }
        std::optional<FontWeightUnion> & get_mutable_font_weight() { return font_weight; }
        void set_font_weight(const std::optional<FontWeightUnion> & value) { this->font_weight = value; }

        /**
         * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
         */
        const std::optional<std::string> & get_href() const { return href; }
        std::optional<std::string> & get_mutable_href() { return href; }
        void set_href(const std::optional<std::string> & value) { this->href = value; }

        /**
         * The line interpolation method to use for line and area marks. One of the following:
         * - `"linear"`: piecewise linear segments, as in a polyline.
         * - `"linear-closed"`: close the linear segments to form a polygon.
         * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
         * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
         * function.
         * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
         * function.
         * - `"basis"`: a B-spline, with control point duplication on the ends.
         * - `"basis-open"`: an open B-spline; may not intersect the start or end.
         * - `"basis-closed"`: a closed B-spline, as in a loop.
         * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
         * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
         * will intersect other control points.
         * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
         * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
         * spline.
         * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
         */
        const std::optional<Interpolate> & get_interpolate() const { return interpolate; }
        std::optional<Interpolate> & get_mutable_interpolate() { return interpolate; }
        void set_interpolate(const std::optional<Interpolate> & value) { this->interpolate = value; }

        /**
         * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
         * value will be automatically truncated if the rendered size exceeds the limit.
         */
        const std::optional<double> & get_limit() const { return limit; }
        std::optional<double> & get_mutable_limit() { return limit; }
        void set_limit(const std::optional<double> & value) { this->limit = value; }

        /**
         * The overall opacity (value between [0,1]).
         *
         * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
         * `square` marks or layered `bar` charts and `1` otherwise.
         */
        const std::optional<double> & get_opacity() const { return opacity; }
        std::optional<double> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<double> & value) { CheckConstraint("opacity", opacity_constraint, value); this->opacity = value; }

        /**
         * The orientation of a non-stacked bar, tick, area, and line charts.
         * The value is either horizontal (default) or vertical.
         * - For bar, rule and tick, this determines whether the size of the bar and tick
         * should be applied to x or y dimension.
         * - For area, this property determines the orient property of the Vega output.
         * - For line, this property determines the sort order of the points in the line
         * if `config.sortLineBy` is not specified.
         * For stacked charts, this is always determined by the orientation of the stack;
         * therefore explicitly specified value will be ignored.
         */
        const std::optional<Orient> & get_orient() const { return orient; }
        std::optional<Orient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<Orient> & value) { this->orient = value; }

        /**
         * Polar coordinate radial offset, in pixels, of the text label from the origin determined
         * by the `x` and `y` properties.
         */
        const std::optional<double> & get_radius() const { return radius; }
        std::optional<double> & get_mutable_radius() { return radius; }
        void set_radius(const std::optional<double> & value) { CheckConstraint("radius", radius_constraint, value); this->radius = value; }

        /**
         * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
         * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
         *
         * __Default value:__ `"circle"`
         */
        const std::optional<std::string> & get_shape() const { return shape; }
        std::optional<std::string> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<std::string> & value) { this->shape = value; }

        /**
         * The pixel area each the point/circle/square.
         * For example: in the case of circles, the radius is determined in part by the square root
         * of the size value.
         *
         * __Default value:__ `30`
         */
        const std::optional<double> & get_size() const { return size; }
        std::optional<double> & get_mutable_size() { return size; }
        void set_size(const std::optional<double> & value) { CheckConstraint("size", size_constraint, value); this->size = value; }

        /**
         * Default Stroke Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_stroke() const { return stroke; }
        std::optional<std::string> & get_mutable_stroke() { return stroke; }
        void set_stroke(const std::optional<std::string> & value) { this->stroke = value; }

        /**
         * An array of alternating stroke, space lengths for creating dashed or dotted lines.
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the stroke dash array.
         */
        const std::optional<double> & get_stroke_dash_offset() const { return stroke_dash_offset; }
        std::optional<double> & get_mutable_stroke_dash_offset() { return stroke_dash_offset; }
        void set_stroke_dash_offset(const std::optional<double> & value) { this->stroke_dash_offset = value; }

        /**
         * The stroke opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_stroke_opacity() const { return stroke_opacity; }
        std::optional<double> & get_mutable_stroke_opacity() { return stroke_opacity; }
        void set_stroke_opacity(const std::optional<double> & value) { CheckConstraint("stroke_opacity", stroke_opacity_constraint, value); this->stroke_opacity = value; }

        /**
         * The stroke width, in pixels.
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { CheckConstraint("stroke_width", stroke_width_constraint, value); this->stroke_width = value; }

        /**
         * Depending on the interpolation type, sets the tension parameter (for line and area marks).
         */
        const std::optional<double> & get_tension() const { return tension; }
        std::optional<double> & get_mutable_tension() { return tension; }
        void set_tension(const std::optional<double> & value) { CheckConstraint("tension", tension_constraint, value); this->tension = value; }

        /**
         * Placeholder text if the `text` channel is not specified
         */
        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }

        /**
         * Polar coordinate angle, in radians, of the text label from the origin determined by the
         * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
         * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
         * indicating "north".
         */
        const std::optional<double> & get_theta() const { return theta; }
        std::optional<double> & get_mutable_theta() { return theta; }
        void set_theta(const std::optional<double> & value) { this->theta = value; }
    };

    /**
     * Defines how Vega-Lite generates title for fields.  There are three possible styles:
     *
     * - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
     * "Year-month of date", "field (binned)").
     * - `"function"` - displays function using parentheses and capitalized texts (e.g.,
     * "SUM(field)", "YEARMONTH(date)", "BIN(field)").
     * - `"plain"` - displays only the field name without functions (e.g., "field", "date",
     * "field").
     */
    enum class FieldTitle : int { VERBAL, FUNCTIONAL, PLAIN };

    /**
     * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
     * - If set to `"filter"` (default), all data items with null values are filtered.
     * - If `null`, all data items are included. In this case, invalid values will be
     * interpreted as zeroes.
     */
    enum class InvalidValues : int { FILTER };

    /**
     * The orientation of the legend, which determines how the legend is positioned within the
     * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
     * "none".
     *
     * __Default value:__ `"right"`
     */
    enum class LegendOrient : int { LEFT, RIGHT, TOP_LEFT, TOP_RIGHT, BOTTOM_LEFT, BOTTOM_RIGHT, NONE };

    /**
     * Legend configuration, which determines default properties for all [legends](legend.html).
     * For a full list of legend configuration options, please see the [corresponding section of
     * in the legend documentation](legend.html#config).
     */
    class LegendConfig {
        public:
        LegendConfig() :
            gradient_height_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            gradient_stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            gradient_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            label_font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            label_offset_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            symbol_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            symbol_stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~LegendConfig() = default;

        private:
        std::optional<double> corner_radius;
        std::optional<double> entry_padding;
        std::optional<std::string> fill_color;
        std::optional<double> gradient_height;
        ClassMemberConstraints gradient_height_constraint;
        std::optional<std::string> gradient_label_baseline;
        std::optional<double> gradient_label_limit;
        std::optional<double> gradient_label_offset;
        std::optional<std::string> gradient_stroke_color;
        std::optional<double> gradient_stroke_width;
        ClassMemberConstraints gradient_stroke_width_constraint;
        std::optional<double> gradient_width;
        ClassMemberConstraints gradient_width_constraint;
        std::optional<std::string> label_align;
        std::optional<std::string> label_baseline;
        std::optional<std::string> label_color;
        std::optional<std::string> label_font;
        std::optional<double> label_font_size;
        ClassMemberConstraints label_font_size_constraint;
        std::optional<double> label_limit;
        std::optional<double> label_offset;
        ClassMemberConstraints label_offset_constraint;
        std::optional<double> offset;
        std::optional<LegendOrient> orient;
        std::optional<double> padding;
        std::optional<bool> short_time_labels;
        std::optional<std::string> stroke_color;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_width;
        std::optional<std::string> symbol_color;
        std::optional<double> symbol_size;
        ClassMemberConstraints symbol_size_constraint;
        std::optional<double> symbol_stroke_width;
        ClassMemberConstraints symbol_stroke_width_constraint;
        std::optional<std::string> symbol_type;
        std::optional<std::string> title_align;
        std::optional<std::string> title_baseline;
        std::optional<std::string> title_color;
        std::optional<std::string> title_font;
        std::optional<double> title_font_size;
        std::optional<TitleFontWeight> title_font_weight;
        std::optional<double> title_limit;
        std::optional<double> title_padding;

        public:
        /**
         * Corner radius for the full legend.
         */
        const std::optional<double> & get_corner_radius() const { return corner_radius; }
        std::optional<double> & get_mutable_corner_radius() { return corner_radius; }
        void set_corner_radius(const std::optional<double> & value) { this->corner_radius = value; }

        /**
         * Padding (in pixels) between legend entries in a symbol legend.
         */
        const std::optional<double> & get_entry_padding() const { return entry_padding; }
        std::optional<double> & get_mutable_entry_padding() { return entry_padding; }
        void set_entry_padding(const std::optional<double> & value) { this->entry_padding = value; }

        /**
         * Background fill color for the full legend.
         */
        const std::optional<std::string> & get_fill_color() const { return fill_color; }
        std::optional<std::string> & get_mutable_fill_color() { return fill_color; }
        void set_fill_color(const std::optional<std::string> & value) { this->fill_color = value; }

        /**
         * The height of the gradient, in pixels.
         */
        const std::optional<double> & get_gradient_height() const { return gradient_height; }
        std::optional<double> & get_mutable_gradient_height() { return gradient_height; }
        void set_gradient_height(const std::optional<double> & value) { CheckConstraint("gradient_height", gradient_height_constraint, value); this->gradient_height = value; }

        /**
         * Text baseline for color ramp gradient labels.
         */
        const std::optional<std::string> & get_gradient_label_baseline() const { return gradient_label_baseline; }
        std::optional<std::string> & get_mutable_gradient_label_baseline() { return gradient_label_baseline; }
        void set_gradient_label_baseline(const std::optional<std::string> & value) { this->gradient_label_baseline = value; }

        /**
         * The maximum allowed length in pixels of color ramp gradient labels.
         */
        const std::optional<double> & get_gradient_label_limit() const { return gradient_label_limit; }
        std::optional<double> & get_mutable_gradient_label_limit() { return gradient_label_limit; }
        void set_gradient_label_limit(const std::optional<double> & value) { this->gradient_label_limit = value; }

        /**
         * Vertical offset in pixels for color ramp gradient labels.
         */
        const std::optional<double> & get_gradient_label_offset() const { return gradient_label_offset; }
        std::optional<double> & get_mutable_gradient_label_offset() { return gradient_label_offset; }
        void set_gradient_label_offset(const std::optional<double> & value) { this->gradient_label_offset = value; }

        /**
         * The color of the gradient stroke, can be in hex color code or regular color name.
         */
        const std::optional<std::string> & get_gradient_stroke_color() const { return gradient_stroke_color; }
        std::optional<std::string> & get_mutable_gradient_stroke_color() { return gradient_stroke_color; }
        void set_gradient_stroke_color(const std::optional<std::string> & value) { this->gradient_stroke_color = value; }

        /**
         * The width of the gradient stroke, in pixels.
         */
        const std::optional<double> & get_gradient_stroke_width() const { return gradient_stroke_width; }
        std::optional<double> & get_mutable_gradient_stroke_width() { return gradient_stroke_width; }
        void set_gradient_stroke_width(const std::optional<double> & value) { CheckConstraint("gradient_stroke_width", gradient_stroke_width_constraint, value); this->gradient_stroke_width = value; }

        /**
         * The width of the gradient, in pixels.
         */
        const std::optional<double> & get_gradient_width() const { return gradient_width; }
        std::optional<double> & get_mutable_gradient_width() { return gradient_width; }
        void set_gradient_width(const std::optional<double> & value) { CheckConstraint("gradient_width", gradient_width_constraint, value); this->gradient_width = value; }

        /**
         * The alignment of the legend label, can be left, middle or right.
         */
        const std::optional<std::string> & get_label_align() const { return label_align; }
        std::optional<std::string> & get_mutable_label_align() { return label_align; }
        void set_label_align(const std::optional<std::string> & value) { this->label_align = value; }

        /**
         * The position of the baseline of legend label, can be top, middle or bottom.
         */
        const std::optional<std::string> & get_label_baseline() const { return label_baseline; }
        std::optional<std::string> & get_mutable_label_baseline() { return label_baseline; }
        void set_label_baseline(const std::optional<std::string> & value) { this->label_baseline = value; }

        /**
         * The color of the legend label, can be in hex color code or regular color name.
         */
        const std::optional<std::string> & get_label_color() const { return label_color; }
        std::optional<std::string> & get_mutable_label_color() { return label_color; }
        void set_label_color(const std::optional<std::string> & value) { this->label_color = value; }

        /**
         * The font of the legend label.
         */
        const std::optional<std::string> & get_label_font() const { return label_font; }
        std::optional<std::string> & get_mutable_label_font() { return label_font; }
        void set_label_font(const std::optional<std::string> & value) { this->label_font = value; }

        /**
         * The font size of legend label.
         *
         * __Default value:__ `10`.
         */
        const std::optional<double> & get_label_font_size() const { return label_font_size; }
        std::optional<double> & get_mutable_label_font_size() { return label_font_size; }
        void set_label_font_size(const std::optional<double> & value) { CheckConstraint("label_font_size", label_font_size_constraint, value); this->label_font_size = value; }

        /**
         * Maximum allowed pixel width of axis tick labels.
         */
        const std::optional<double> & get_label_limit() const { return label_limit; }
        std::optional<double> & get_mutable_label_limit() { return label_limit; }
        void set_label_limit(const std::optional<double> & value) { this->label_limit = value; }

        /**
         * The offset of the legend label.
         */
        const std::optional<double> & get_label_offset() const { return label_offset; }
        std::optional<double> & get_mutable_label_offset() { return label_offset; }
        void set_label_offset(const std::optional<double> & value) { CheckConstraint("label_offset", label_offset_constraint, value); this->label_offset = value; }

        /**
         * The offset, in pixels, by which to displace the legend from the edge of the enclosing
         * group or data rectangle.
         *
         * __Default value:__  `0`
         */
        const std::optional<double> & get_offset() const { return offset; }
        std::optional<double> & get_mutable_offset() { return offset; }
        void set_offset(const std::optional<double> & value) { this->offset = value; }

        /**
         * The orientation of the legend, which determines how the legend is positioned within the
         * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
         * "none".
         *
         * __Default value:__ `"right"`
         */
        const std::optional<LegendOrient> & get_orient() const { return orient; }
        std::optional<LegendOrient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<LegendOrient> & value) { this->orient = value; }

        /**
         * The padding, in pixels, between the legend and axis.
         */
        const std::optional<double> & get_padding() const { return padding; }
        std::optional<double> & get_mutable_padding() { return padding; }
        void set_padding(const std::optional<double> & value) { this->padding = value; }

        /**
         * Whether month names and weekday names should be abbreviated.
         *
         * __Default value:__  `false`
         */
        const std::optional<bool> & get_short_time_labels() const { return short_time_labels; }
        std::optional<bool> & get_mutable_short_time_labels() { return short_time_labels; }
        void set_short_time_labels(const std::optional<bool> & value) { this->short_time_labels = value; }

        /**
         * Border stroke color for the full legend.
         */
        const std::optional<std::string> & get_stroke_color() const { return stroke_color; }
        std::optional<std::string> & get_mutable_stroke_color() { return stroke_color; }
        void set_stroke_color(const std::optional<std::string> & value) { this->stroke_color = value; }

        /**
         * Border stroke dash pattern for the full legend.
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * Border stroke width for the full legend.
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { this->stroke_width = value; }

        /**
         * The color of the legend symbol,
         */
        const std::optional<std::string> & get_symbol_color() const { return symbol_color; }
        std::optional<std::string> & get_mutable_symbol_color() { return symbol_color; }
        void set_symbol_color(const std::optional<std::string> & value) { this->symbol_color = value; }

        /**
         * The size of the legend symbol, in pixels.
         */
        const std::optional<double> & get_symbol_size() const { return symbol_size; }
        std::optional<double> & get_mutable_symbol_size() { return symbol_size; }
        void set_symbol_size(const std::optional<double> & value) { CheckConstraint("symbol_size", symbol_size_constraint, value); this->symbol_size = value; }

        /**
         * The width of the symbol's stroke.
         */
        const std::optional<double> & get_symbol_stroke_width() const { return symbol_stroke_width; }
        std::optional<double> & get_mutable_symbol_stroke_width() { return symbol_stroke_width; }
        void set_symbol_stroke_width(const std::optional<double> & value) { CheckConstraint("symbol_stroke_width", symbol_stroke_width_constraint, value); this->symbol_stroke_width = value; }

        /**
         * Default shape type (such as "circle") for legend symbols.
         */
        const std::optional<std::string> & get_symbol_type() const { return symbol_type; }
        std::optional<std::string> & get_mutable_symbol_type() { return symbol_type; }
        void set_symbol_type(const std::optional<std::string> & value) { this->symbol_type = value; }

        /**
         * Horizontal text alignment for legend titles.
         */
        const std::optional<std::string> & get_title_align() const { return title_align; }
        std::optional<std::string> & get_mutable_title_align() { return title_align; }
        void set_title_align(const std::optional<std::string> & value) { this->title_align = value; }

        /**
         * Vertical text baseline for legend titles.
         */
        const std::optional<std::string> & get_title_baseline() const { return title_baseline; }
        std::optional<std::string> & get_mutable_title_baseline() { return title_baseline; }
        void set_title_baseline(const std::optional<std::string> & value) { this->title_baseline = value; }

        /**
         * The color of the legend title, can be in hex color code or regular color name.
         */
        const std::optional<std::string> & get_title_color() const { return title_color; }
        std::optional<std::string> & get_mutable_title_color() { return title_color; }
        void set_title_color(const std::optional<std::string> & value) { this->title_color = value; }

        /**
         * The font of the legend title.
         */
        const std::optional<std::string> & get_title_font() const { return title_font; }
        std::optional<std::string> & get_mutable_title_font() { return title_font; }
        void set_title_font(const std::optional<std::string> & value) { this->title_font = value; }

        /**
         * The font size of the legend title.
         */
        const std::optional<double> & get_title_font_size() const { return title_font_size; }
        std::optional<double> & get_mutable_title_font_size() { return title_font_size; }
        void set_title_font_size(const std::optional<double> & value) { this->title_font_size = value; }

        /**
         * The font weight of the legend title.
         */
        const std::optional<TitleFontWeight> & get_title_font_weight() const { return title_font_weight; }
        std::optional<TitleFontWeight> & get_mutable_title_font_weight() { return title_font_weight; }
        void set_title_font_weight(const std::optional<TitleFontWeight> & value) { this->title_font_weight = value; }

        /**
         * Maximum allowed pixel width of axis titles.
         */
        const std::optional<double> & get_title_limit() const { return title_limit; }
        std::optional<double> & get_mutable_title_limit() { return title_limit; }
        void set_title_limit(const std::optional<double> & value) { this->title_limit = value; }

        /**
         * The padding, in pixels, between title and legend.
         */
        const std::optional<double> & get_title_padding() const { return title_padding; }
        std::optional<double> & get_mutable_title_padding() { return title_padding; }
        void set_title_padding(const std::optional<double> & value) { this->title_padding = value; }
    };

    class PaddingClass {
        public:
        PaddingClass() = default;
        virtual ~PaddingClass() = default;

        private:
        std::optional<double> bottom;
        std::optional<double> left;
        std::optional<double> right;
        std::optional<double> top;

        public:
        const std::optional<double> & get_bottom() const { return bottom; }
        std::optional<double> & get_mutable_bottom() { return bottom; }
        void set_bottom(const std::optional<double> & value) { this->bottom = value; }

        const std::optional<double> & get_left() const { return left; }
        std::optional<double> & get_mutable_left() { return left; }
        void set_left(const std::optional<double> & value) { this->left = value; }

        const std::optional<double> & get_right() const { return right; }
        std::optional<double> & get_mutable_right() { return right; }
        void set_right(const std::optional<double> & value) { this->right = value; }

        const std::optional<double> & get_top() const { return top; }
        std::optional<double> & get_mutable_top() { return top; }
        void set_top(const std::optional<double> & value) { this->top = value; }
    };

    using Padding = std::variant<PaddingClass, double>;

    /**
     * The cartographic projection to use. This value is case-insensitive, for example
     * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
     * projection types [in the
     * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
     *
     * __Default value:__ `mercator`
     */
    enum class VgProjectionType : int { ALBERS, ALBERS_USA, AZIMUTHAL_EQUAL_AREA, AZIMUTHAL_EQUIDISTANT, CONIC_CONFORMAL, CONIC_EQUAL_AREA, CONIC_EQUIDISTANT, EQUIRECTANGULAR, GNOMONIC, MERCATOR, ORTHOGRAPHIC, STEREOGRAPHIC, TRANSVERSE_MERCATOR };

    /**
     * Projection configuration, which determines default properties for all
     * [projections](projection.html). For a full list of projection configuration options,
     * please see the [corresponding section of the projection
     * documentation](projection.html#config).
     *
     * Any property of Projection can be in config
     */
    class ProjectionConfig {
        public:
        ProjectionConfig() = default;
        virtual ~ProjectionConfig() = default;

        private:
        std::optional<std::vector<double>> center;
        std::optional<double> clip_angle;
        std::optional<std::vector<std::vector<double>>> clip_extent;
        std::optional<double> coefficient;
        std::optional<double> distance;
        std::optional<double> fraction;
        std::optional<double> lobes;
        std::optional<double> parallel;
        std::optional<std::map<std::string, TitleFontWeight>> precision;
        std::optional<double> radius;
        std::optional<double> ratio;
        std::optional<std::vector<double>> rotate;
        std::optional<double> spacing;
        std::optional<double> tilt;
        std::optional<VgProjectionType> type;

        public:
        /**
         * Sets the projection’s center to the specified center, a two-element array of longitude
         * and latitude in degrees.
         *
         * __Default value:__ `[0, 0]`
         */
        const std::optional<std::vector<double>> & get_center() const { return center; }
        std::optional<std::vector<double>> & get_mutable_center() { return center; }
        void set_center(const std::optional<std::vector<double>> & value) { this->center = value; }

        /**
         * Sets the projection’s clipping circle radius to the specified angle in degrees. If
         * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
         * than small-circle clipping.
         */
        const std::optional<double> & get_clip_angle() const { return clip_angle; }
        std::optional<double> & get_mutable_clip_angle() { return clip_angle; }
        void set_clip_angle(const std::optional<double> & value) { this->clip_angle = value; }

        /**
         * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
         * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
         * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
         * viewport clipping is performed.
         */
        const std::optional<std::vector<std::vector<double>>> & get_clip_extent() const { return clip_extent; }
        std::optional<std::vector<std::vector<double>>> & get_mutable_clip_extent() { return clip_extent; }
        void set_clip_extent(const std::optional<std::vector<std::vector<double>>> & value) { this->clip_extent = value; }

        const std::optional<double> & get_coefficient() const { return coefficient; }
        std::optional<double> & get_mutable_coefficient() { return coefficient; }
        void set_coefficient(const std::optional<double> & value) { this->coefficient = value; }

        const std::optional<double> & get_distance() const { return distance; }
        std::optional<double> & get_mutable_distance() { return distance; }
        void set_distance(const std::optional<double> & value) { this->distance = value; }

        const std::optional<double> & get_fraction() const { return fraction; }
        std::optional<double> & get_mutable_fraction() { return fraction; }
        void set_fraction(const std::optional<double> & value) { this->fraction = value; }

        const std::optional<double> & get_lobes() const { return lobes; }
        std::optional<double> & get_mutable_lobes() { return lobes; }
        void set_lobes(const std::optional<double> & value) { this->lobes = value; }

        const std::optional<double> & get_parallel() const { return parallel; }
        std::optional<double> & get_mutable_parallel() { return parallel; }
        void set_parallel(const std::optional<double> & value) { this->parallel = value; }

        /**
         * Sets the threshold for the projection’s [adaptive
         * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
         * value corresponds to the [Douglas–Peucker
         * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
         * If precision is not specified, returns the projection’s current resampling precision
         * which defaults to `√0.5 ≅ 0.70710…`.
         */
        const std::optional<std::map<std::string, TitleFontWeight>> & get_precision() const { return precision; }
        std::optional<std::map<std::string, TitleFontWeight>> & get_mutable_precision() { return precision; }
        void set_precision(const std::optional<std::map<std::string, TitleFontWeight>> & value) { this->precision = value; }

        const std::optional<double> & get_radius() const { return radius; }
        std::optional<double> & get_mutable_radius() { return radius; }
        void set_radius(const std::optional<double> & value) { this->radius = value; }

        const std::optional<double> & get_ratio() const { return ratio; }
        std::optional<double> & get_mutable_ratio() { return ratio; }
        void set_ratio(const std::optional<double> & value) { this->ratio = value; }

        /**
         * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
         * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
         * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
         *
         * __Default value:__ `[0, 0, 0]`
         */
        const std::optional<std::vector<double>> & get_rotate() const { return rotate; }
        std::optional<std::vector<double>> & get_mutable_rotate() { return rotate; }
        void set_rotate(const std::optional<std::vector<double>> & value) { this->rotate = value; }

        const std::optional<double> & get_spacing() const { return spacing; }
        std::optional<double> & get_mutable_spacing() { return spacing; }
        void set_spacing(const std::optional<double> & value) { this->spacing = value; }

        const std::optional<double> & get_tilt() const { return tilt; }
        std::optional<double> & get_mutable_tilt() { return tilt; }
        void set_tilt(const std::optional<double> & value) { this->tilt = value; }

        /**
         * The cartographic projection to use. This value is case-insensitive, for example
         * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
         * projection types [in the
         * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
         *
         * __Default value:__ `mercator`
         */
        const std::optional<VgProjectionType> & get_type() const { return type; }
        std::optional<VgProjectionType> & get_mutable_type() { return type; }
        void set_type(const std::optional<VgProjectionType> & value) { this->type = value; }
    };

    class VgScheme {
        public:
        VgScheme() = default;
        virtual ~VgScheme() = default;

        private:
        std::optional<double> count;
        std::optional<std::vector<double>> extent;
        std::optional<std::string> scheme;
        std::optional<double> step;

        public:
        const std::optional<double> & get_count() const { return count; }
        std::optional<double> & get_mutable_count() { return count; }
        void set_count(const std::optional<double> & value) { this->count = value; }

        const std::optional<std::vector<double>> & get_extent() const { return extent; }
        std::optional<std::vector<double>> & get_mutable_extent() { return extent; }
        void set_extent(const std::optional<std::vector<double>> & value) { this->extent = value; }

        const std::optional<std::string> & get_scheme() const { return scheme; }
        std::optional<std::string> & get_mutable_scheme() { return scheme; }
        void set_scheme(const std::optional<std::string> & value) { this->scheme = value; }

        const std::optional<double> & get_step() const { return step; }
        std::optional<double> & get_mutable_step() { return step; }
        void set_step(const std::optional<double> & value) { this->step = value; }
    };

    using RangeConfigValue = std::variant<std::vector<TitleFontWeight>, VgScheme>;

    /**
     * Scale configuration determines default properties for all [scales](scale.html). For a
     * full list of scale configuration options, please see the [corresponding section of the
     * scale documentation](scale.html#config).
     */
    class ScaleConfig {
        public:
        ScaleConfig() :
            band_padding_inner_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            band_padding_outer_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            continuous_padding_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            max_band_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            max_font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            max_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            max_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            max_stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            min_band_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            min_font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            min_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            min_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            min_stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            point_padding_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            text_x_range_step_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~ScaleConfig() = default;

        private:
        std::optional<double> band_padding_inner;
        ClassMemberConstraints band_padding_inner_constraint;
        std::optional<double> band_padding_outer;
        ClassMemberConstraints band_padding_outer_constraint;
        std::optional<bool> clamp;
        std::optional<double> continuous_padding;
        ClassMemberConstraints continuous_padding_constraint;
        std::optional<double> max_band_size;
        ClassMemberConstraints max_band_size_constraint;
        std::optional<double> max_font_size;
        ClassMemberConstraints max_font_size_constraint;
        std::optional<double> max_opacity;
        ClassMemberConstraints max_opacity_constraint;
        std::optional<double> max_size;
        ClassMemberConstraints max_size_constraint;
        std::optional<double> max_stroke_width;
        ClassMemberConstraints max_stroke_width_constraint;
        std::optional<double> min_band_size;
        ClassMemberConstraints min_band_size_constraint;
        std::optional<double> min_font_size;
        ClassMemberConstraints min_font_size_constraint;
        std::optional<double> min_opacity;
        ClassMemberConstraints min_opacity_constraint;
        std::optional<double> min_size;
        ClassMemberConstraints min_size_constraint;
        std::optional<double> min_stroke_width;
        ClassMemberConstraints min_stroke_width_constraint;
        std::optional<double> point_padding;
        ClassMemberConstraints point_padding_constraint;
        std::optional<double> range_step;
        std::optional<bool> round;
        std::optional<double> text_x_range_step;
        ClassMemberConstraints text_x_range_step_constraint;
        std::optional<bool> use_unaggregated_domain;

        public:
        /**
         * Default inner padding for `x` and `y` band-ordinal scales.
         *
         * __Default value:__ `0.1`
         */
        const std::optional<double> & get_band_padding_inner() const { return band_padding_inner; }
        std::optional<double> & get_mutable_band_padding_inner() { return band_padding_inner; }
        void set_band_padding_inner(const std::optional<double> & value) { CheckConstraint("band_padding_inner", band_padding_inner_constraint, value); this->band_padding_inner = value; }

        /**
         * Default outer padding for `x` and `y` band-ordinal scales.
         * If not specified, by default, band scale's paddingOuter is paddingInner/2.
         */
        const std::optional<double> & get_band_padding_outer() const { return band_padding_outer; }
        std::optional<double> & get_mutable_band_padding_outer() { return band_padding_outer; }
        void set_band_padding_outer(const std::optional<double> & value) { CheckConstraint("band_padding_outer", band_padding_outer_constraint, value); this->band_padding_outer = value; }

        /**
         * If true, values that exceed the data domain are clamped to either the minimum or maximum
         * range value
         */
        const std::optional<bool> & get_clamp() const { return clamp; }
        std::optional<bool> & get_mutable_clamp() { return clamp; }
        void set_clamp(const std::optional<bool> & value) { this->clamp = value; }

        /**
         * Default padding for continuous scales.
         *
         * __Default:__ `5` for continuous x-scale of a vertical bar and continuous y-scale of a
         * horizontal bar.; `0` otherwise.
         */
        const std::optional<double> & get_continuous_padding() const { return continuous_padding; }
        std::optional<double> & get_mutable_continuous_padding() { return continuous_padding; }
        void set_continuous_padding(const std::optional<double> & value) { CheckConstraint("continuous_padding", continuous_padding_constraint, value); this->continuous_padding = value; }

        /**
         * The default max value for mapping quantitative fields to bar's size/bandSize.
         *
         * If undefined (default), we will use the scale's `rangeStep` - 1.
         */
        const std::optional<double> & get_max_band_size() const { return max_band_size; }
        std::optional<double> & get_mutable_max_band_size() { return max_band_size; }
        void set_max_band_size(const std::optional<double> & value) { CheckConstraint("max_band_size", max_band_size_constraint, value); this->max_band_size = value; }

        /**
         * The default max value for mapping quantitative fields to text's size/fontSize.
         *
         * __Default value:__ `40`
         */
        const std::optional<double> & get_max_font_size() const { return max_font_size; }
        std::optional<double> & get_mutable_max_font_size() { return max_font_size; }
        void set_max_font_size(const std::optional<double> & value) { CheckConstraint("max_font_size", max_font_size_constraint, value); this->max_font_size = value; }

        /**
         * Default max opacity for mapping a field to opacity.
         *
         * __Default value:__ `0.8`
         */
        const std::optional<double> & get_max_opacity() const { return max_opacity; }
        std::optional<double> & get_mutable_max_opacity() { return max_opacity; }
        void set_max_opacity(const std::optional<double> & value) { CheckConstraint("max_opacity", max_opacity_constraint, value); this->max_opacity = value; }

        /**
         * Default max value for point size scale.
         */
        const std::optional<double> & get_max_size() const { return max_size; }
        std::optional<double> & get_mutable_max_size() { return max_size; }
        void set_max_size(const std::optional<double> & value) { CheckConstraint("max_size", max_size_constraint, value); this->max_size = value; }

        /**
         * Default max strokeWidth for strokeWidth  (or rule/line's size) scale.
         *
         * __Default value:__ `4`
         */
        const std::optional<double> & get_max_stroke_width() const { return max_stroke_width; }
        std::optional<double> & get_mutable_max_stroke_width() { return max_stroke_width; }
        void set_max_stroke_width(const std::optional<double> & value) { CheckConstraint("max_stroke_width", max_stroke_width_constraint, value); this->max_stroke_width = value; }

        /**
         * The default min value for mapping quantitative fields to bar and tick's size/bandSize
         * scale with zero=false.
         *
         * __Default value:__ `2`
         */
        const std::optional<double> & get_min_band_size() const { return min_band_size; }
        std::optional<double> & get_mutable_min_band_size() { return min_band_size; }
        void set_min_band_size(const std::optional<double> & value) { CheckConstraint("min_band_size", min_band_size_constraint, value); this->min_band_size = value; }

        /**
         * The default min value for mapping quantitative fields to tick's size/fontSize scale with
         * zero=false
         *
         * __Default value:__ `8`
         */
        const std::optional<double> & get_min_font_size() const { return min_font_size; }
        std::optional<double> & get_mutable_min_font_size() { return min_font_size; }
        void set_min_font_size(const std::optional<double> & value) { CheckConstraint("min_font_size", min_font_size_constraint, value); this->min_font_size = value; }

        /**
         * Default minimum opacity for mapping a field to opacity.
         *
         * __Default value:__ `0.3`
         */
        const std::optional<double> & get_min_opacity() const { return min_opacity; }
        std::optional<double> & get_mutable_min_opacity() { return min_opacity; }
        void set_min_opacity(const std::optional<double> & value) { CheckConstraint("min_opacity", min_opacity_constraint, value); this->min_opacity = value; }

        /**
         * Default minimum value for point size scale with zero=false.
         *
         * __Default value:__ `9`
         */
        const std::optional<double> & get_min_size() const { return min_size; }
        std::optional<double> & get_mutable_min_size() { return min_size; }
        void set_min_size(const std::optional<double> & value) { CheckConstraint("min_size", min_size_constraint, value); this->min_size = value; }

        /**
         * Default minimum strokeWidth for strokeWidth (or rule/line's size) scale with zero=false.
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_min_stroke_width() const { return min_stroke_width; }
        std::optional<double> & get_mutable_min_stroke_width() { return min_stroke_width; }
        void set_min_stroke_width(const std::optional<double> & value) { CheckConstraint("min_stroke_width", min_stroke_width_constraint, value); this->min_stroke_width = value; }

        /**
         * Default outer padding for `x` and `y` point-ordinal scales.
         *
         * __Default value:__ `0.5`
         */
        const std::optional<double> & get_point_padding() const { return point_padding; }
        std::optional<double> & get_mutable_point_padding() { return point_padding; }
        void set_point_padding(const std::optional<double> & value) { CheckConstraint("point_padding", point_padding_constraint, value); this->point_padding = value; }

        /**
         * Default range step for band and point scales of (1) the `y` channel
         * and (2) the `x` channel when the mark is not `text`.
         *
         * __Default value:__ `21`
         */
        std::optional<double> get_range_step() const { return range_step; }
        void set_range_step(std::optional<double> value) { this->range_step = value; }

        /**
         * If true, rounds numeric output values to integers.
         * This can be helpful for snapping to the pixel grid.
         * (Only available for `x`, `y`, and `size` scales.)
         */
        const std::optional<bool> & get_round() const { return round; }
        std::optional<bool> & get_mutable_round() { return round; }
        void set_round(const std::optional<bool> & value) { this->round = value; }

        /**
         * Default range step for `x` band and point scales of text marks.
         *
         * __Default value:__ `90`
         */
        const std::optional<double> & get_text_x_range_step() const { return text_x_range_step; }
        std::optional<double> & get_mutable_text_x_range_step() { return text_x_range_step; }
        void set_text_x_range_step(const std::optional<double> & value) { CheckConstraint("text_x_range_step", text_x_range_step_constraint, value); this->text_x_range_step = value; }

        /**
         * Use the source data range before aggregation as scale domain instead of aggregated data
         * for aggregate axis.
         *
         * This is equivalent to setting `domain` to `"unaggregate"` for aggregated _quantitative_
         * fields by default.
         *
         * This property only works with aggregate functions that produce values within the raw data
         * domain (`"mean"`, `"average"`, `"median"`, `"q1"`, `"q3"`, `"min"`, `"max"`). For other
         * aggregations that produce values outside of the raw data domain (e.g. `"count"`,
         * `"sum"`), this property is ignored.
         *
         * __Default value:__ `false`
         */
        const std::optional<bool> & get_use_unaggregated_domain() const { return use_unaggregated_domain; }
        std::optional<bool> & get_mutable_use_unaggregated_domain() { return use_unaggregated_domain; }
        void set_use_unaggregated_domain(const std::optional<bool> & value) { this->use_unaggregated_domain = value; }
    };

    /**
     * Establishes a two-way binding between the interval selection and the scales
     * used within the same view. This allows a user to interactively pan and
     * zoom the view.
     */
    enum class BindEnum : int { SCALES };

    /**
     * By default, all data values are considered to lie within an empty selection.
     * When set to `none`, empty selections contain no data values.
     */
    enum class Empty : int { ALL, NONE };

    enum class SingleDefChannel : int { X, Y, X2, Y2, ROW, COLUMN, SIZE, SHAPE, COLOR, OPACITY, TEXT, TOOLTIP, HREF };

    /**
     * An interval selection also adds a rectangle mark to depict the
     * extents of the interval. The `mark` property can be used to customize the
     * appearance of the mark.
     */
    class BrushConfig {
        public:
        BrushConfig() = default;
        virtual ~BrushConfig() = default;

        private:
        std::optional<std::string> fill;
        std::optional<double> fill_opacity;
        std::optional<std::string> stroke;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_dash_offset;
        std::optional<double> stroke_opacity;
        std::optional<double> stroke_width;

        public:
        /**
         * The fill color of the interval mark.
         *
         * __Default value:__ `#333333`
         */
        const std::optional<std::string> & get_fill() const { return fill; }
        std::optional<std::string> & get_mutable_fill() { return fill; }
        void set_fill(const std::optional<std::string> & value) { this->fill = value; }

        /**
         * The fill opacity of the interval mark (a value between 0 and 1).
         *
         * __Default value:__ `0.125`
         */
        const std::optional<double> & get_fill_opacity() const { return fill_opacity; }
        std::optional<double> & get_mutable_fill_opacity() { return fill_opacity; }
        void set_fill_opacity(const std::optional<double> & value) { this->fill_opacity = value; }

        /**
         * The stroke color of the interval mark.
         *
         * __Default value:__ `#ffffff`
         */
        const std::optional<std::string> & get_stroke() const { return stroke; }
        std::optional<std::string> & get_mutable_stroke() { return stroke; }
        void set_stroke(const std::optional<std::string> & value) { this->stroke = value; }

        /**
         * An array of alternating stroke and space lengths,
         * for creating dashed or dotted lines.
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * The offset (in pixels) with which to begin drawing the stroke dash array.
         */
        const std::optional<double> & get_stroke_dash_offset() const { return stroke_dash_offset; }
        std::optional<double> & get_mutable_stroke_dash_offset() { return stroke_dash_offset; }
        void set_stroke_dash_offset(const std::optional<double> & value) { this->stroke_dash_offset = value; }

        /**
         * The stroke opacity of the interval mark (a value between 0 and 1).
         */
        const std::optional<double> & get_stroke_opacity() const { return stroke_opacity; }
        std::optional<double> & get_mutable_stroke_opacity() { return stroke_opacity; }
        void set_stroke_opacity(const std::optional<double> & value) { this->stroke_opacity = value; }

        /**
         * The stroke width of the interval mark.
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { this->stroke_width = value; }
    };

    /**
     * With layered and multi-view displays, a strategy that determines how
     * selections' data queries are resolved when applied in a filter transform,
     * conditional encoding rule, or scale domain.
     */
    enum class SelectionResolution : int { GLOBAL, UNION, INTERSECT };

    using Translate = std::variant<bool, std::string>;

    /**
     * The default definition for an [`interval`](selection.html#type) selection. All properties
     * and transformations
     * for an interval selection definition (except `type`) may be specified here.
     *
     * For instance, setting `interval` to `{"translate": false}` disables the ability to move
     * interval selections by default.
     */
    class IntervalSelectionConfig {
        public:
        IntervalSelectionConfig() = default;
        virtual ~IntervalSelectionConfig() = default;

        private:
        std::optional<BindEnum> bind;
        std::optional<Empty> empty;
        std::optional<std::vector<SingleDefChannel>> encodings;
        std::optional<std::vector<std::string>> fields;
        std::optional<BrushConfig> mark;
        nlohmann::json on;
        std::optional<SelectionResolution> resolve;
        std::optional<Translate> translate;
        std::optional<Translate> zoom;

        public:
        /**
         * Establishes a two-way binding between the interval selection and the scales
         * used within the same view. This allows a user to interactively pan and
         * zoom the view.
         */
        const std::optional<BindEnum> & get_bind() const { return bind; }
        std::optional<BindEnum> & get_mutable_bind() { return bind; }
        void set_bind(const std::optional<BindEnum> & value) { this->bind = value; }

        /**
         * By default, all data values are considered to lie within an empty selection.
         * When set to `none`, empty selections contain no data values.
         */
        const std::optional<Empty> & get_empty() const { return empty; }
        std::optional<Empty> & get_mutable_empty() { return empty; }
        void set_empty(const std::optional<Empty> & value) { this->empty = value; }

        /**
         * An array of encoding channels. The corresponding data field values
         * must match for a data tuple to fall within the selection.
         */
        const std::optional<std::vector<SingleDefChannel>> & get_encodings() const { return encodings; }
        std::optional<std::vector<SingleDefChannel>> & get_mutable_encodings() { return encodings; }
        void set_encodings(const std::optional<std::vector<SingleDefChannel>> & value) { this->encodings = value; }

        /**
         * An array of field names whose values must match for a data tuple to
         * fall within the selection.
         */
        const std::optional<std::vector<std::string>> & get_fields() const { return fields; }
        std::optional<std::vector<std::string>> & get_mutable_fields() { return fields; }
        void set_fields(const std::optional<std::vector<std::string>> & value) { this->fields = value; }

        /**
         * An interval selection also adds a rectangle mark to depict the
         * extents of the interval. The `mark` property can be used to customize the
         * appearance of the mark.
         */
        const std::optional<BrushConfig> & get_mark() const { return mark; }
        std::optional<BrushConfig> & get_mutable_mark() { return mark; }
        void set_mark(const std::optional<BrushConfig> & value) { this->mark = value; }

        /**
         * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
         * selector) that triggers the selection.
         * For interval selections, the event stream must specify a [start and
         * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
         */
        const nlohmann::json & get_on() const { return on; }
        nlohmann::json & get_mutable_on() { return on; }
        void set_on(const nlohmann::json & value) { this->on = value; }

        /**
         * With layered and multi-view displays, a strategy that determines how
         * selections' data queries are resolved when applied in a filter transform,
         * conditional encoding rule, or scale domain.
         */
        const std::optional<SelectionResolution> & get_resolve() const { return resolve; }
        std::optional<SelectionResolution> & get_mutable_resolve() { return resolve; }
        void set_resolve(const std::optional<SelectionResolution> & value) { this->resolve = value; }

        /**
         * When truthy, allows a user to interactively move an interval selection
         * back-and-forth. Can be `true`, `false` (to disable panning), or a
         * [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
         * which must include a start and end event to trigger continuous panning.
         *
         * __Default value:__ `true`, which corresponds to
         * `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
         * clicks and dragging within an interval selection to reposition it.
         */
        const std::optional<Translate> & get_translate() const { return translate; }
        std::optional<Translate> & get_mutable_translate() { return translate; }
        void set_translate(const std::optional<Translate> & value) { this->translate = value; }

        /**
         * When truthy, allows a user to interactively resize an interval selection.
         * Can be `true`, `false` (to disable zooming), or a [Vega event stream
         * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
         * only `wheel` events are supported.
         *
         *
         * __Default value:__ `true`, which corresponds to `wheel!`.
         */
        const std::optional<Translate> & get_zoom() const { return zoom; }
        std::optional<Translate> & get_mutable_zoom() { return zoom; }
        void set_zoom(const std::optional<Translate> & value) { this->zoom = value; }
    };

    /**
     * The default definition for a [`multi`](selection.html#type) selection. All properties and
     * transformations
     * for a multi selection definition (except `type`) may be specified here.
     *
     * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
     * multi selections when clicking with the alt-key pressed by default.
     */
    class MultiSelectionConfig {
        public:
        MultiSelectionConfig() = default;
        virtual ~MultiSelectionConfig() = default;

        private:
        std::optional<Empty> empty;
        std::optional<std::vector<SingleDefChannel>> encodings;
        std::optional<std::vector<std::string>> fields;
        std::optional<bool> nearest;
        nlohmann::json on;
        std::optional<SelectionResolution> resolve;
        std::optional<Translate> toggle;

        public:
        /**
         * By default, all data values are considered to lie within an empty selection.
         * When set to `none`, empty selections contain no data values.
         */
        const std::optional<Empty> & get_empty() const { return empty; }
        std::optional<Empty> & get_mutable_empty() { return empty; }
        void set_empty(const std::optional<Empty> & value) { this->empty = value; }

        /**
         * An array of encoding channels. The corresponding data field values
         * must match for a data tuple to fall within the selection.
         */
        const std::optional<std::vector<SingleDefChannel>> & get_encodings() const { return encodings; }
        std::optional<std::vector<SingleDefChannel>> & get_mutable_encodings() { return encodings; }
        void set_encodings(const std::optional<std::vector<SingleDefChannel>> & value) { this->encodings = value; }

        /**
         * An array of field names whose values must match for a data tuple to
         * fall within the selection.
         */
        const std::optional<std::vector<std::string>> & get_fields() const { return fields; }
        std::optional<std::vector<std::string>> & get_mutable_fields() { return fields; }
        void set_fields(const std::optional<std::vector<std::string>> & value) { this->fields = value; }

        /**
         * When true, an invisible voronoi diagram is computed to accelerate discrete
         * selection. The data value _nearest_ the mouse cursor is added to the selection.
         *
         * See the [nearest transform](nearest.html) documentation for more information.
         */
        const std::optional<bool> & get_nearest() const { return nearest; }
        std::optional<bool> & get_mutable_nearest() { return nearest; }
        void set_nearest(const std::optional<bool> & value) { this->nearest = value; }

        /**
         * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
         * selector) that triggers the selection.
         * For interval selections, the event stream must specify a [start and
         * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
         */
        const nlohmann::json & get_on() const { return on; }
        nlohmann::json & get_mutable_on() { return on; }
        void set_on(const nlohmann::json & value) { this->on = value; }

        /**
         * With layered and multi-view displays, a strategy that determines how
         * selections' data queries are resolved when applied in a filter transform,
         * conditional encoding rule, or scale domain.
         */
        const std::optional<SelectionResolution> & get_resolve() const { return resolve; }
        std::optional<SelectionResolution> & get_mutable_resolve() { return resolve; }
        void set_resolve(const std::optional<SelectionResolution> & value) { this->resolve = value; }

        /**
         * Controls whether data values should be toggled or only ever inserted into
         * multi selections. Can be `true`, `false` (for insertion only), or a
         * [Vega expression](https://vega.github.io/vega/docs/expressions/).
         *
         * __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
         * data values are toggled when a user interacts with the shift-key pressed).
         *
         * See the [toggle transform](toggle.html) documentation for more information.
         */
        const std::optional<Translate> & get_toggle() const { return toggle; }
        std::optional<Translate> & get_mutable_toggle() { return toggle; }
        void set_toggle(const std::optional<Translate> & value) { this->toggle = value; }
    };

    class VgBinding {
        public:
        VgBinding() = default;
        virtual ~VgBinding() = default;

        private:
        std::optional<std::string> element;
        std::string input;
        std::optional<std::vector<std::string>> options;
        std::optional<double> max;
        std::optional<double> min;
        std::optional<double> step;

        public:
        const std::optional<std::string> & get_element() const { return element; }
        std::optional<std::string> & get_mutable_element() { return element; }
        void set_element(const std::optional<std::string> & value) { this->element = value; }

        const std::string & get_input() const { return input; }
        std::string & get_mutable_input() { return input; }
        void set_input(const std::string & value) { this->input = value; }

        const std::optional<std::vector<std::string>> & get_options() const { return options; }
        std::optional<std::vector<std::string>> & get_mutable_options() { return options; }
        void set_options(const std::optional<std::vector<std::string>> & value) { this->options = value; }

        const std::optional<double> & get_max() const { return max; }
        std::optional<double> & get_mutable_max() { return max; }
        void set_max(const std::optional<double> & value) { this->max = value; }

        const std::optional<double> & get_min() const { return min; }
        std::optional<double> & get_mutable_min() { return min; }
        void set_min(const std::optional<double> & value) { this->min = value; }

        const std::optional<double> & get_step() const { return step; }
        std::optional<double> & get_mutable_step() { return step; }
        void set_step(const std::optional<double> & value) { this->step = value; }
    };

    /**
     * The default definition for a [`single`](selection.html#type) selection. All properties
     * and transformations
     * for a single selection definition (except `type`) may be specified here.
     *
     * For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
     * double-click by default.
     */
    class SingleSelectionConfig {
        public:
        SingleSelectionConfig() = default;
        virtual ~SingleSelectionConfig() = default;

        private:
        std::optional<std::map<std::string, VgBinding>> bind;
        std::optional<Empty> empty;
        std::optional<std::vector<SingleDefChannel>> encodings;
        std::optional<std::vector<std::string>> fields;
        std::optional<bool> nearest;
        nlohmann::json on;
        std::optional<SelectionResolution> resolve;

        public:
        /**
         * Establish a two-way binding between a single selection and input elements
         * (also known as dynamic query widgets). A binding takes the form of
         * Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
         * or can be a mapping between projected field/encodings and binding definitions.
         *
         * See the [bind transform](bind.html) documentation for more information.
         */
        const std::optional<std::map<std::string, VgBinding>> & get_bind() const { return bind; }
        std::optional<std::map<std::string, VgBinding>> & get_mutable_bind() { return bind; }
        void set_bind(const std::optional<std::map<std::string, VgBinding>> & value) { this->bind = value; }

        /**
         * By default, all data values are considered to lie within an empty selection.
         * When set to `none`, empty selections contain no data values.
         */
        const std::optional<Empty> & get_empty() const { return empty; }
        std::optional<Empty> & get_mutable_empty() { return empty; }
        void set_empty(const std::optional<Empty> & value) { this->empty = value; }

        /**
         * An array of encoding channels. The corresponding data field values
         * must match for a data tuple to fall within the selection.
         */
        const std::optional<std::vector<SingleDefChannel>> & get_encodings() const { return encodings; }
        std::optional<std::vector<SingleDefChannel>> & get_mutable_encodings() { return encodings; }
        void set_encodings(const std::optional<std::vector<SingleDefChannel>> & value) { this->encodings = value; }

        /**
         * An array of field names whose values must match for a data tuple to
         * fall within the selection.
         */
        const std::optional<std::vector<std::string>> & get_fields() const { return fields; }
        std::optional<std::vector<std::string>> & get_mutable_fields() { return fields; }
        void set_fields(const std::optional<std::vector<std::string>> & value) { this->fields = value; }

        /**
         * When true, an invisible voronoi diagram is computed to accelerate discrete
         * selection. The data value _nearest_ the mouse cursor is added to the selection.
         *
         * See the [nearest transform](nearest.html) documentation for more information.
         */
        const std::optional<bool> & get_nearest() const { return nearest; }
        std::optional<bool> & get_mutable_nearest() { return nearest; }
        void set_nearest(const std::optional<bool> & value) { this->nearest = value; }

        /**
         * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
         * selector) that triggers the selection.
         * For interval selections, the event stream must specify a [start and
         * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
         */
        const nlohmann::json & get_on() const { return on; }
        nlohmann::json & get_mutable_on() { return on; }
        void set_on(const nlohmann::json & value) { this->on = value; }

        /**
         * With layered and multi-view displays, a strategy that determines how
         * selections' data queries are resolved when applied in a filter transform,
         * conditional encoding rule, or scale domain.
         */
        const std::optional<SelectionResolution> & get_resolve() const { return resolve; }
        std::optional<SelectionResolution> & get_mutable_resolve() { return resolve; }
        void set_resolve(const std::optional<SelectionResolution> & value) { this->resolve = value; }
    };

    /**
     * An object hash for defining default properties for each type of selections.
     */
    class SelectionConfig {
        public:
        SelectionConfig() = default;
        virtual ~SelectionConfig() = default;

        private:
        std::optional<IntervalSelectionConfig> interval;
        std::optional<MultiSelectionConfig> multi;
        std::optional<SingleSelectionConfig> single;

        public:
        /**
         * The default definition for an [`interval`](selection.html#type) selection. All properties
         * and transformations
         * for an interval selection definition (except `type`) may be specified here.
         *
         * For instance, setting `interval` to `{"translate": false}` disables the ability to move
         * interval selections by default.
         */
        const std::optional<IntervalSelectionConfig> & get_interval() const { return interval; }
        std::optional<IntervalSelectionConfig> & get_mutable_interval() { return interval; }
        void set_interval(const std::optional<IntervalSelectionConfig> & value) { this->interval = value; }

        /**
         * The default definition for a [`multi`](selection.html#type) selection. All properties and
         * transformations
         * for a multi selection definition (except `type`) may be specified here.
         *
         * For instance, setting `multi` to `{"toggle": "event.altKey"}` adds additional values to
         * multi selections when clicking with the alt-key pressed by default.
         */
        const std::optional<MultiSelectionConfig> & get_multi() const { return multi; }
        std::optional<MultiSelectionConfig> & get_mutable_multi() { return multi; }
        void set_multi(const std::optional<MultiSelectionConfig> & value) { this->multi = value; }

        /**
         * The default definition for a [`single`](selection.html#type) selection. All properties
         * and transformations
         * for a single selection definition (except `type`) may be specified here.
         *
         * For instance, setting `single` to `{"on": "dblclick"}` populates single selections on
         * double-click by default.
         */
        const std::optional<SingleSelectionConfig> & get_single() const { return single; }
        std::optional<SingleSelectionConfig> & get_mutable_single() { return single; }
        void set_single(const std::optional<SingleSelectionConfig> & value) { this->single = value; }
    };

    /**
     * Default stack offset for stackable mark.
     */
    enum class StackOffset : int { ZERO, CENTER, NORMALIZE };

    class VgMarkConfig {
        public:
        VgMarkConfig() :
            angle_constraint(std::nullopt, std::nullopt, 0, 360, std::nullopt, std::nullopt, std::nullopt),
            fill_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            radius_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            stroke_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tension_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~VgMarkConfig() = default;

        private:
        std::optional<HorizontalAlign> align;
        std::optional<double> angle;
        ClassMemberConstraints angle_constraint;
        std::optional<VerticalAlign> baseline;
        std::optional<Cursor> cursor;
        std::optional<double> dx;
        std::optional<double> dy;
        std::optional<std::string> fill;
        std::optional<double> fill_opacity;
        ClassMemberConstraints fill_opacity_constraint;
        std::optional<std::string> font;
        std::optional<double> font_size;
        ClassMemberConstraints font_size_constraint;
        std::optional<FontStyle> font_style;
        std::optional<FontWeightUnion> font_weight;
        std::optional<std::string> href;
        std::optional<Interpolate> interpolate;
        std::optional<double> limit;
        std::optional<double> opacity;
        ClassMemberConstraints opacity_constraint;
        std::optional<Orient> orient;
        std::optional<double> radius;
        ClassMemberConstraints radius_constraint;
        std::optional<std::string> shape;
        std::optional<double> size;
        ClassMemberConstraints size_constraint;
        std::optional<std::string> stroke;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_dash_offset;
        std::optional<double> stroke_opacity;
        ClassMemberConstraints stroke_opacity_constraint;
        std::optional<double> stroke_width;
        ClassMemberConstraints stroke_width_constraint;
        std::optional<double> tension;
        ClassMemberConstraints tension_constraint;
        std::optional<std::string> text;
        std::optional<double> theta;

        public:
        /**
         * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
         */
        const std::optional<HorizontalAlign> & get_align() const { return align; }
        std::optional<HorizontalAlign> & get_mutable_align() { return align; }
        void set_align(const std::optional<HorizontalAlign> & value) { this->align = value; }

        /**
         * The rotation angle of the text, in degrees.
         */
        const std::optional<double> & get_angle() const { return angle; }
        std::optional<double> & get_mutable_angle() { return angle; }
        void set_angle(const std::optional<double> & value) { CheckConstraint("angle", angle_constraint, value); this->angle = value; }

        /**
         * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
         *
         * __Default value:__ `"middle"`
         */
        const std::optional<VerticalAlign> & get_baseline() const { return baseline; }
        std::optional<VerticalAlign> & get_mutable_baseline() { return baseline; }
        void set_baseline(const std::optional<VerticalAlign> & value) { this->baseline = value; }

        /**
         * The mouse cursor used over the mark. Any valid [CSS cursor
         * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
         */
        const std::optional<Cursor> & get_cursor() const { return cursor; }
        std::optional<Cursor> & get_mutable_cursor() { return cursor; }
        void set_cursor(const std::optional<Cursor> & value) { this->cursor = value; }

        /**
         * The horizontal offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dx() const { return dx; }
        std::optional<double> & get_mutable_dx() { return dx; }
        void set_dx(const std::optional<double> & value) { this->dx = value; }

        /**
         * The vertical offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dy() const { return dy; }
        std::optional<double> & get_mutable_dy() { return dy; }
        void set_dy(const std::optional<double> & value) { this->dy = value; }

        /**
         * Default Fill Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_fill() const { return fill; }
        std::optional<std::string> & get_mutable_fill() { return fill; }
        void set_fill(const std::optional<std::string> & value) { this->fill = value; }

        /**
         * The fill opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_fill_opacity() const { return fill_opacity; }
        std::optional<double> & get_mutable_fill_opacity() { return fill_opacity; }
        void set_fill_opacity(const std::optional<double> & value) { CheckConstraint("fill_opacity", fill_opacity_constraint, value); this->fill_opacity = value; }

        /**
         * The typeface to set the text in (e.g., `"Helvetica Neue"`).
         */
        const std::optional<std::string> & get_font() const { return font; }
        std::optional<std::string> & get_mutable_font() { return font; }
        void set_font(const std::optional<std::string> & value) { this->font = value; }

        /**
         * The font size, in pixels.
         */
        const std::optional<double> & get_font_size() const { return font_size; }
        std::optional<double> & get_mutable_font_size() { return font_size; }
        void set_font_size(const std::optional<double> & value) { CheckConstraint("font_size", font_size_constraint, value); this->font_size = value; }

        /**
         * The font style (e.g., `"italic"`).
         */
        const std::optional<FontStyle> & get_font_style() const { return font_style; }
        std::optional<FontStyle> & get_mutable_font_style() { return font_style; }
        void set_font_style(const std::optional<FontStyle> & value) { this->font_style = value; }

        /**
         * The font weight (e.g., `"bold"`).
         */
        const std::optional<FontWeightUnion> & get_font_weight() const { return font_weight; }
        std::optional<FontWeightUnion> & get_mutable_font_weight() { return font_weight; }
        void set_font_weight(const std::optional<FontWeightUnion> & value) { this->font_weight = value; }

        /**
         * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
         */
        const std::optional<std::string> & get_href() const { return href; }
        std::optional<std::string> & get_mutable_href() { return href; }
        void set_href(const std::optional<std::string> & value) { this->href = value; }

        /**
         * The line interpolation method to use for line and area marks. One of the following:
         * - `"linear"`: piecewise linear segments, as in a polyline.
         * - `"linear-closed"`: close the linear segments to form a polygon.
         * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
         * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
         * function.
         * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
         * function.
         * - `"basis"`: a B-spline, with control point duplication on the ends.
         * - `"basis-open"`: an open B-spline; may not intersect the start or end.
         * - `"basis-closed"`: a closed B-spline, as in a loop.
         * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
         * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
         * will intersect other control points.
         * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
         * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
         * spline.
         * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
         */
        const std::optional<Interpolate> & get_interpolate() const { return interpolate; }
        std::optional<Interpolate> & get_mutable_interpolate() { return interpolate; }
        void set_interpolate(const std::optional<Interpolate> & value) { this->interpolate = value; }

        /**
         * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
         * value will be automatically truncated if the rendered size exceeds the limit.
         */
        const std::optional<double> & get_limit() const { return limit; }
        std::optional<double> & get_mutable_limit() { return limit; }
        void set_limit(const std::optional<double> & value) { this->limit = value; }

        /**
         * The overall opacity (value between [0,1]).
         *
         * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
         * `square` marks or layered `bar` charts and `1` otherwise.
         */
        const std::optional<double> & get_opacity() const { return opacity; }
        std::optional<double> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<double> & value) { CheckConstraint("opacity", opacity_constraint, value); this->opacity = value; }

        /**
         * The orientation of a non-stacked bar, tick, area, and line charts.
         * The value is either horizontal (default) or vertical.
         * - For bar, rule and tick, this determines whether the size of the bar and tick
         * should be applied to x or y dimension.
         * - For area, this property determines the orient property of the Vega output.
         * - For line, this property determines the sort order of the points in the line
         * if `config.sortLineBy` is not specified.
         * For stacked charts, this is always determined by the orientation of the stack;
         * therefore explicitly specified value will be ignored.
         */
        const std::optional<Orient> & get_orient() const { return orient; }
        std::optional<Orient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<Orient> & value) { this->orient = value; }

        /**
         * Polar coordinate radial offset, in pixels, of the text label from the origin determined
         * by the `x` and `y` properties.
         */
        const std::optional<double> & get_radius() const { return radius; }
        std::optional<double> & get_mutable_radius() { return radius; }
        void set_radius(const std::optional<double> & value) { CheckConstraint("radius", radius_constraint, value); this->radius = value; }

        /**
         * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
         * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
         *
         * __Default value:__ `"circle"`
         */
        const std::optional<std::string> & get_shape() const { return shape; }
        std::optional<std::string> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<std::string> & value) { this->shape = value; }

        /**
         * The pixel area each the point/circle/square.
         * For example: in the case of circles, the radius is determined in part by the square root
         * of the size value.
         *
         * __Default value:__ `30`
         */
        const std::optional<double> & get_size() const { return size; }
        std::optional<double> & get_mutable_size() { return size; }
        void set_size(const std::optional<double> & value) { CheckConstraint("size", size_constraint, value); this->size = value; }

        /**
         * Default Stroke Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_stroke() const { return stroke; }
        std::optional<std::string> & get_mutable_stroke() { return stroke; }
        void set_stroke(const std::optional<std::string> & value) { this->stroke = value; }

        /**
         * An array of alternating stroke, space lengths for creating dashed or dotted lines.
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the stroke dash array.
         */
        const std::optional<double> & get_stroke_dash_offset() const { return stroke_dash_offset; }
        std::optional<double> & get_mutable_stroke_dash_offset() { return stroke_dash_offset; }
        void set_stroke_dash_offset(const std::optional<double> & value) { this->stroke_dash_offset = value; }

        /**
         * The stroke opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_stroke_opacity() const { return stroke_opacity; }
        std::optional<double> & get_mutable_stroke_opacity() { return stroke_opacity; }
        void set_stroke_opacity(const std::optional<double> & value) { CheckConstraint("stroke_opacity", stroke_opacity_constraint, value); this->stroke_opacity = value; }

        /**
         * The stroke width, in pixels.
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { CheckConstraint("stroke_width", stroke_width_constraint, value); this->stroke_width = value; }

        /**
         * Depending on the interpolation type, sets the tension parameter (for line and area marks).
         */
        const std::optional<double> & get_tension() const { return tension; }
        std::optional<double> & get_mutable_tension() { return tension; }
        void set_tension(const std::optional<double> & value) { CheckConstraint("tension", tension_constraint, value); this->tension = value; }

        /**
         * Placeholder text if the `text` channel is not specified
         */
        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }

        /**
         * Polar coordinate angle, in radians, of the text label from the origin determined by the
         * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
         * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
         * indicating "north".
         */
        const std::optional<double> & get_theta() const { return theta; }
        std::optional<double> & get_mutable_theta() { return theta; }
        void set_theta(const std::optional<double> & value) { this->theta = value; }
    };

    /**
     * Text-Specific Config
     */
    class TextConfig {
        public:
        TextConfig() :
            angle_constraint(std::nullopt, std::nullopt, 0, 360, std::nullopt, std::nullopt, std::nullopt),
            fill_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            radius_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            stroke_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tension_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~TextConfig() = default;

        private:
        std::optional<HorizontalAlign> align;
        std::optional<double> angle;
        ClassMemberConstraints angle_constraint;
        std::optional<VerticalAlign> baseline;
        std::optional<std::string> color;
        std::optional<Cursor> cursor;
        std::optional<double> dx;
        std::optional<double> dy;
        std::optional<std::string> fill;
        std::optional<bool> filled;
        std::optional<double> fill_opacity;
        ClassMemberConstraints fill_opacity_constraint;
        std::optional<std::string> font;
        std::optional<double> font_size;
        ClassMemberConstraints font_size_constraint;
        std::optional<FontStyle> font_style;
        std::optional<FontWeightUnion> font_weight;
        std::optional<std::string> href;
        std::optional<Interpolate> interpolate;
        std::optional<double> limit;
        std::optional<double> opacity;
        ClassMemberConstraints opacity_constraint;
        std::optional<Orient> orient;
        std::optional<double> radius;
        ClassMemberConstraints radius_constraint;
        std::optional<std::string> shape;
        std::optional<bool> short_time_labels;
        std::optional<double> size;
        ClassMemberConstraints size_constraint;
        std::optional<std::string> stroke;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_dash_offset;
        std::optional<double> stroke_opacity;
        ClassMemberConstraints stroke_opacity_constraint;
        std::optional<double> stroke_width;
        ClassMemberConstraints stroke_width_constraint;
        std::optional<double> tension;
        ClassMemberConstraints tension_constraint;
        std::optional<std::string> text;
        std::optional<double> theta;

        public:
        /**
         * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
         */
        const std::optional<HorizontalAlign> & get_align() const { return align; }
        std::optional<HorizontalAlign> & get_mutable_align() { return align; }
        void set_align(const std::optional<HorizontalAlign> & value) { this->align = value; }

        /**
         * The rotation angle of the text, in degrees.
         */
        const std::optional<double> & get_angle() const { return angle; }
        std::optional<double> & get_mutable_angle() { return angle; }
        void set_angle(const std::optional<double> & value) { CheckConstraint("angle", angle_constraint, value); this->angle = value; }

        /**
         * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
         *
         * __Default value:__ `"middle"`
         */
        const std::optional<VerticalAlign> & get_baseline() const { return baseline; }
        std::optional<VerticalAlign> & get_mutable_baseline() { return baseline; }
        void set_baseline(const std::optional<VerticalAlign> & value) { this->baseline = value; }

        /**
         * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
         * will override `color`.
         *
         * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<std::string> & get_color() const { return color; }
        std::optional<std::string> & get_mutable_color() { return color; }
        void set_color(const std::optional<std::string> & value) { this->color = value; }

        /**
         * The mouse cursor used over the mark. Any valid [CSS cursor
         * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
         */
        const std::optional<Cursor> & get_cursor() const { return cursor; }
        std::optional<Cursor> & get_mutable_cursor() { return cursor; }
        void set_cursor(const std::optional<Cursor> & value) { this->cursor = value; }

        /**
         * The horizontal offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dx() const { return dx; }
        std::optional<double> & get_mutable_dx() { return dx; }
        void set_dx(const std::optional<double> & value) { this->dx = value; }

        /**
         * The vertical offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dy() const { return dy; }
        std::optional<double> & get_mutable_dy() { return dy; }
        void set_dy(const std::optional<double> & value) { this->dy = value; }

        /**
         * Default Fill Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_fill() const { return fill; }
        std::optional<std::string> & get_mutable_fill() { return fill; }
        void set_fill(const std::optional<std::string> & value) { this->fill = value; }

        /**
         * Whether the mark's color should be used as fill color instead of stroke color.
         *
         * __Default value:__ `true` for all marks except `point` and `false` for `point`.
         *
         * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<bool> & get_filled() const { return filled; }
        std::optional<bool> & get_mutable_filled() { return filled; }
        void set_filled(const std::optional<bool> & value) { this->filled = value; }

        /**
         * The fill opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_fill_opacity() const { return fill_opacity; }
        std::optional<double> & get_mutable_fill_opacity() { return fill_opacity; }
        void set_fill_opacity(const std::optional<double> & value) { CheckConstraint("fill_opacity", fill_opacity_constraint, value); this->fill_opacity = value; }

        /**
         * The typeface to set the text in (e.g., `"Helvetica Neue"`).
         */
        const std::optional<std::string> & get_font() const { return font; }
        std::optional<std::string> & get_mutable_font() { return font; }
        void set_font(const std::optional<std::string> & value) { this->font = value; }

        /**
         * The font size, in pixels.
         */
        const std::optional<double> & get_font_size() const { return font_size; }
        std::optional<double> & get_mutable_font_size() { return font_size; }
        void set_font_size(const std::optional<double> & value) { CheckConstraint("font_size", font_size_constraint, value); this->font_size = value; }

        /**
         * The font style (e.g., `"italic"`).
         */
        const std::optional<FontStyle> & get_font_style() const { return font_style; }
        std::optional<FontStyle> & get_mutable_font_style() { return font_style; }
        void set_font_style(const std::optional<FontStyle> & value) { this->font_style = value; }

        /**
         * The font weight (e.g., `"bold"`).
         */
        const std::optional<FontWeightUnion> & get_font_weight() const { return font_weight; }
        std::optional<FontWeightUnion> & get_mutable_font_weight() { return font_weight; }
        void set_font_weight(const std::optional<FontWeightUnion> & value) { this->font_weight = value; }

        /**
         * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
         */
        const std::optional<std::string> & get_href() const { return href; }
        std::optional<std::string> & get_mutable_href() { return href; }
        void set_href(const std::optional<std::string> & value) { this->href = value; }

        /**
         * The line interpolation method to use for line and area marks. One of the following:
         * - `"linear"`: piecewise linear segments, as in a polyline.
         * - `"linear-closed"`: close the linear segments to form a polygon.
         * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
         * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
         * function.
         * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
         * function.
         * - `"basis"`: a B-spline, with control point duplication on the ends.
         * - `"basis-open"`: an open B-spline; may not intersect the start or end.
         * - `"basis-closed"`: a closed B-spline, as in a loop.
         * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
         * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
         * will intersect other control points.
         * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
         * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
         * spline.
         * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
         */
        const std::optional<Interpolate> & get_interpolate() const { return interpolate; }
        std::optional<Interpolate> & get_mutable_interpolate() { return interpolate; }
        void set_interpolate(const std::optional<Interpolate> & value) { this->interpolate = value; }

        /**
         * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
         * value will be automatically truncated if the rendered size exceeds the limit.
         */
        const std::optional<double> & get_limit() const { return limit; }
        std::optional<double> & get_mutable_limit() { return limit; }
        void set_limit(const std::optional<double> & value) { this->limit = value; }

        /**
         * The overall opacity (value between [0,1]).
         *
         * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
         * `square` marks or layered `bar` charts and `1` otherwise.
         */
        const std::optional<double> & get_opacity() const { return opacity; }
        std::optional<double> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<double> & value) { CheckConstraint("opacity", opacity_constraint, value); this->opacity = value; }

        /**
         * The orientation of a non-stacked bar, tick, area, and line charts.
         * The value is either horizontal (default) or vertical.
         * - For bar, rule and tick, this determines whether the size of the bar and tick
         * should be applied to x or y dimension.
         * - For area, this property determines the orient property of the Vega output.
         * - For line, this property determines the sort order of the points in the line
         * if `config.sortLineBy` is not specified.
         * For stacked charts, this is always determined by the orientation of the stack;
         * therefore explicitly specified value will be ignored.
         */
        const std::optional<Orient> & get_orient() const { return orient; }
        std::optional<Orient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<Orient> & value) { this->orient = value; }

        /**
         * Polar coordinate radial offset, in pixels, of the text label from the origin determined
         * by the `x` and `y` properties.
         */
        const std::optional<double> & get_radius() const { return radius; }
        std::optional<double> & get_mutable_radius() { return radius; }
        void set_radius(const std::optional<double> & value) { CheckConstraint("radius", radius_constraint, value); this->radius = value; }

        /**
         * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
         * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
         *
         * __Default value:__ `"circle"`
         */
        const std::optional<std::string> & get_shape() const { return shape; }
        std::optional<std::string> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<std::string> & value) { this->shape = value; }

        /**
         * Whether month names and weekday names should be abbreviated.
         */
        const std::optional<bool> & get_short_time_labels() const { return short_time_labels; }
        std::optional<bool> & get_mutable_short_time_labels() { return short_time_labels; }
        void set_short_time_labels(const std::optional<bool> & value) { this->short_time_labels = value; }

        /**
         * The pixel area each the point/circle/square.
         * For example: in the case of circles, the radius is determined in part by the square root
         * of the size value.
         *
         * __Default value:__ `30`
         */
        const std::optional<double> & get_size() const { return size; }
        std::optional<double> & get_mutable_size() { return size; }
        void set_size(const std::optional<double> & value) { CheckConstraint("size", size_constraint, value); this->size = value; }

        /**
         * Default Stroke Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_stroke() const { return stroke; }
        std::optional<std::string> & get_mutable_stroke() { return stroke; }
        void set_stroke(const std::optional<std::string> & value) { this->stroke = value; }

        /**
         * An array of alternating stroke, space lengths for creating dashed or dotted lines.
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the stroke dash array.
         */
        const std::optional<double> & get_stroke_dash_offset() const { return stroke_dash_offset; }
        std::optional<double> & get_mutable_stroke_dash_offset() { return stroke_dash_offset; }
        void set_stroke_dash_offset(const std::optional<double> & value) { this->stroke_dash_offset = value; }

        /**
         * The stroke opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_stroke_opacity() const { return stroke_opacity; }
        std::optional<double> & get_mutable_stroke_opacity() { return stroke_opacity; }
        void set_stroke_opacity(const std::optional<double> & value) { CheckConstraint("stroke_opacity", stroke_opacity_constraint, value); this->stroke_opacity = value; }

        /**
         * The stroke width, in pixels.
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { CheckConstraint("stroke_width", stroke_width_constraint, value); this->stroke_width = value; }

        /**
         * Depending on the interpolation type, sets the tension parameter (for line and area marks).
         */
        const std::optional<double> & get_tension() const { return tension; }
        std::optional<double> & get_mutable_tension() { return tension; }
        void set_tension(const std::optional<double> & value) { CheckConstraint("tension", tension_constraint, value); this->tension = value; }

        /**
         * Placeholder text if the `text` channel is not specified
         */
        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }

        /**
         * Polar coordinate angle, in radians, of the text label from the origin determined by the
         * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
         * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
         * indicating "north".
         */
        const std::optional<double> & get_theta() const { return theta; }
        std::optional<double> & get_mutable_theta() { return theta; }
        void set_theta(const std::optional<double> & value) { this->theta = value; }
    };

    /**
     * Tick-Specific Config
     */
    class TickConfig {
        public:
        TickConfig() :
            angle_constraint(std::nullopt, std::nullopt, 0, 360, std::nullopt, std::nullopt, std::nullopt),
            band_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            fill_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            radius_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            stroke_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tension_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            thickness_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~TickConfig() = default;

        private:
        std::optional<HorizontalAlign> align;
        std::optional<double> angle;
        ClassMemberConstraints angle_constraint;
        std::optional<double> band_size;
        ClassMemberConstraints band_size_constraint;
        std::optional<VerticalAlign> baseline;
        std::optional<std::string> color;
        std::optional<Cursor> cursor;
        std::optional<double> dx;
        std::optional<double> dy;
        std::optional<std::string> fill;
        std::optional<bool> filled;
        std::optional<double> fill_opacity;
        ClassMemberConstraints fill_opacity_constraint;
        std::optional<std::string> font;
        std::optional<double> font_size;
        ClassMemberConstraints font_size_constraint;
        std::optional<FontStyle> font_style;
        std::optional<FontWeightUnion> font_weight;
        std::optional<std::string> href;
        std::optional<Interpolate> interpolate;
        std::optional<double> limit;
        std::optional<double> opacity;
        ClassMemberConstraints opacity_constraint;
        std::optional<Orient> orient;
        std::optional<double> radius;
        ClassMemberConstraints radius_constraint;
        std::optional<std::string> shape;
        std::optional<double> size;
        ClassMemberConstraints size_constraint;
        std::optional<std::string> stroke;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_dash_offset;
        std::optional<double> stroke_opacity;
        ClassMemberConstraints stroke_opacity_constraint;
        std::optional<double> stroke_width;
        ClassMemberConstraints stroke_width_constraint;
        std::optional<double> tension;
        ClassMemberConstraints tension_constraint;
        std::optional<std::string> text;
        std::optional<double> theta;
        std::optional<double> thickness;
        ClassMemberConstraints thickness_constraint;

        public:
        /**
         * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
         */
        const std::optional<HorizontalAlign> & get_align() const { return align; }
        std::optional<HorizontalAlign> & get_mutable_align() { return align; }
        void set_align(const std::optional<HorizontalAlign> & value) { this->align = value; }

        /**
         * The rotation angle of the text, in degrees.
         */
        const std::optional<double> & get_angle() const { return angle; }
        std::optional<double> & get_mutable_angle() { return angle; }
        void set_angle(const std::optional<double> & value) { CheckConstraint("angle", angle_constraint, value); this->angle = value; }

        /**
         * The width of the ticks.
         *
         * __Default value:__  2/3 of rangeStep.
         */
        const std::optional<double> & get_band_size() const { return band_size; }
        std::optional<double> & get_mutable_band_size() { return band_size; }
        void set_band_size(const std::optional<double> & value) { CheckConstraint("band_size", band_size_constraint, value); this->band_size = value; }

        /**
         * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
         *
         * __Default value:__ `"middle"`
         */
        const std::optional<VerticalAlign> & get_baseline() const { return baseline; }
        std::optional<VerticalAlign> & get_mutable_baseline() { return baseline; }
        void set_baseline(const std::optional<VerticalAlign> & value) { this->baseline = value; }

        /**
         * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
         * will override `color`.
         *
         * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<std::string> & get_color() const { return color; }
        std::optional<std::string> & get_mutable_color() { return color; }
        void set_color(const std::optional<std::string> & value) { this->color = value; }

        /**
         * The mouse cursor used over the mark. Any valid [CSS cursor
         * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
         */
        const std::optional<Cursor> & get_cursor() const { return cursor; }
        std::optional<Cursor> & get_mutable_cursor() { return cursor; }
        void set_cursor(const std::optional<Cursor> & value) { this->cursor = value; }

        /**
         * The horizontal offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dx() const { return dx; }
        std::optional<double> & get_mutable_dx() { return dx; }
        void set_dx(const std::optional<double> & value) { this->dx = value; }

        /**
         * The vertical offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dy() const { return dy; }
        std::optional<double> & get_mutable_dy() { return dy; }
        void set_dy(const std::optional<double> & value) { this->dy = value; }

        /**
         * Default Fill Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_fill() const { return fill; }
        std::optional<std::string> & get_mutable_fill() { return fill; }
        void set_fill(const std::optional<std::string> & value) { this->fill = value; }

        /**
         * Whether the mark's color should be used as fill color instead of stroke color.
         *
         * __Default value:__ `true` for all marks except `point` and `false` for `point`.
         *
         * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<bool> & get_filled() const { return filled; }
        std::optional<bool> & get_mutable_filled() { return filled; }
        void set_filled(const std::optional<bool> & value) { this->filled = value; }

        /**
         * The fill opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_fill_opacity() const { return fill_opacity; }
        std::optional<double> & get_mutable_fill_opacity() { return fill_opacity; }
        void set_fill_opacity(const std::optional<double> & value) { CheckConstraint("fill_opacity", fill_opacity_constraint, value); this->fill_opacity = value; }

        /**
         * The typeface to set the text in (e.g., `"Helvetica Neue"`).
         */
        const std::optional<std::string> & get_font() const { return font; }
        std::optional<std::string> & get_mutable_font() { return font; }
        void set_font(const std::optional<std::string> & value) { this->font = value; }

        /**
         * The font size, in pixels.
         */
        const std::optional<double> & get_font_size() const { return font_size; }
        std::optional<double> & get_mutable_font_size() { return font_size; }
        void set_font_size(const std::optional<double> & value) { CheckConstraint("font_size", font_size_constraint, value); this->font_size = value; }

        /**
         * The font style (e.g., `"italic"`).
         */
        const std::optional<FontStyle> & get_font_style() const { return font_style; }
        std::optional<FontStyle> & get_mutable_font_style() { return font_style; }
        void set_font_style(const std::optional<FontStyle> & value) { this->font_style = value; }

        /**
         * The font weight (e.g., `"bold"`).
         */
        const std::optional<FontWeightUnion> & get_font_weight() const { return font_weight; }
        std::optional<FontWeightUnion> & get_mutable_font_weight() { return font_weight; }
        void set_font_weight(const std::optional<FontWeightUnion> & value) { this->font_weight = value; }

        /**
         * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
         */
        const std::optional<std::string> & get_href() const { return href; }
        std::optional<std::string> & get_mutable_href() { return href; }
        void set_href(const std::optional<std::string> & value) { this->href = value; }

        /**
         * The line interpolation method to use for line and area marks. One of the following:
         * - `"linear"`: piecewise linear segments, as in a polyline.
         * - `"linear-closed"`: close the linear segments to form a polygon.
         * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
         * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
         * function.
         * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
         * function.
         * - `"basis"`: a B-spline, with control point duplication on the ends.
         * - `"basis-open"`: an open B-spline; may not intersect the start or end.
         * - `"basis-closed"`: a closed B-spline, as in a loop.
         * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
         * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
         * will intersect other control points.
         * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
         * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
         * spline.
         * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
         */
        const std::optional<Interpolate> & get_interpolate() const { return interpolate; }
        std::optional<Interpolate> & get_mutable_interpolate() { return interpolate; }
        void set_interpolate(const std::optional<Interpolate> & value) { this->interpolate = value; }

        /**
         * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
         * value will be automatically truncated if the rendered size exceeds the limit.
         */
        const std::optional<double> & get_limit() const { return limit; }
        std::optional<double> & get_mutable_limit() { return limit; }
        void set_limit(const std::optional<double> & value) { this->limit = value; }

        /**
         * The overall opacity (value between [0,1]).
         *
         * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
         * `square` marks or layered `bar` charts and `1` otherwise.
         */
        const std::optional<double> & get_opacity() const { return opacity; }
        std::optional<double> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<double> & value) { CheckConstraint("opacity", opacity_constraint, value); this->opacity = value; }

        /**
         * The orientation of a non-stacked bar, tick, area, and line charts.
         * The value is either horizontal (default) or vertical.
         * - For bar, rule and tick, this determines whether the size of the bar and tick
         * should be applied to x or y dimension.
         * - For area, this property determines the orient property of the Vega output.
         * - For line, this property determines the sort order of the points in the line
         * if `config.sortLineBy` is not specified.
         * For stacked charts, this is always determined by the orientation of the stack;
         * therefore explicitly specified value will be ignored.
         */
        const std::optional<Orient> & get_orient() const { return orient; }
        std::optional<Orient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<Orient> & value) { this->orient = value; }

        /**
         * Polar coordinate radial offset, in pixels, of the text label from the origin determined
         * by the `x` and `y` properties.
         */
        const std::optional<double> & get_radius() const { return radius; }
        std::optional<double> & get_mutable_radius() { return radius; }
        void set_radius(const std::optional<double> & value) { CheckConstraint("radius", radius_constraint, value); this->radius = value; }

        /**
         * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
         * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
         *
         * __Default value:__ `"circle"`
         */
        const std::optional<std::string> & get_shape() const { return shape; }
        std::optional<std::string> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<std::string> & value) { this->shape = value; }

        /**
         * The pixel area each the point/circle/square.
         * For example: in the case of circles, the radius is determined in part by the square root
         * of the size value.
         *
         * __Default value:__ `30`
         */
        const std::optional<double> & get_size() const { return size; }
        std::optional<double> & get_mutable_size() { return size; }
        void set_size(const std::optional<double> & value) { CheckConstraint("size", size_constraint, value); this->size = value; }

        /**
         * Default Stroke Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_stroke() const { return stroke; }
        std::optional<std::string> & get_mutable_stroke() { return stroke; }
        void set_stroke(const std::optional<std::string> & value) { this->stroke = value; }

        /**
         * An array of alternating stroke, space lengths for creating dashed or dotted lines.
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the stroke dash array.
         */
        const std::optional<double> & get_stroke_dash_offset() const { return stroke_dash_offset; }
        std::optional<double> & get_mutable_stroke_dash_offset() { return stroke_dash_offset; }
        void set_stroke_dash_offset(const std::optional<double> & value) { this->stroke_dash_offset = value; }

        /**
         * The stroke opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_stroke_opacity() const { return stroke_opacity; }
        std::optional<double> & get_mutable_stroke_opacity() { return stroke_opacity; }
        void set_stroke_opacity(const std::optional<double> & value) { CheckConstraint("stroke_opacity", stroke_opacity_constraint, value); this->stroke_opacity = value; }

        /**
         * The stroke width, in pixels.
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { CheckConstraint("stroke_width", stroke_width_constraint, value); this->stroke_width = value; }

        /**
         * Depending on the interpolation type, sets the tension parameter (for line and area marks).
         */
        const std::optional<double> & get_tension() const { return tension; }
        std::optional<double> & get_mutable_tension() { return tension; }
        void set_tension(const std::optional<double> & value) { CheckConstraint("tension", tension_constraint, value); this->tension = value; }

        /**
         * Placeholder text if the `text` channel is not specified
         */
        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }

        /**
         * Polar coordinate angle, in radians, of the text label from the origin determined by the
         * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
         * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
         * indicating "north".
         */
        const std::optional<double> & get_theta() const { return theta; }
        std::optional<double> & get_mutable_theta() { return theta; }
        void set_theta(const std::optional<double> & value) { this->theta = value; }

        /**
         * Thickness of the tick mark.
         *
         * __Default value:__  `1`
         */
        const std::optional<double> & get_thickness() const { return thickness; }
        std::optional<double> & get_mutable_thickness() { return thickness; }
        void set_thickness(const std::optional<double> & value) { CheckConstraint("thickness", thickness_constraint, value); this->thickness = value; }
    };

    /**
     * The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
     * example, with an orientation of top these anchor positions map to a left-, center-, or
     * right-aligned title.
     *
     * __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
     * `"start"` for other composite views.
     *
     * __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
     * customizable only for [single](spec.html) and [layered](layer.html) views.  For other
     * composite views, `anchor` is always `"start"`.
     */
    enum class Anchor : int { START, MIDDLE, END };

    /**
     * Default title orientation ("top", "bottom", "left", or "right")
     *
     * The orientation of the title relative to the chart. One of `"top"` (the default),
     * `"bottom"`, `"left"`, or `"right"`.
     *
     * The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
     * orientation can be used to further specialize the axis type (e.g., a y axis oriented for
     * the right edge of the chart).
     *
     * __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
     */
    enum class TitleOrient : int { TOP, BOTTOM, LEFT, RIGHT };

    /**
     * Title configuration, which determines default properties for all [titles](title.html).
     * For a full list of title configuration options, please see the [corresponding section of
     * the title documentation](title.html#config).
     */
    class VgTitleConfig {
        public:
        VgTitleConfig() :
            font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            limit_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~VgTitleConfig() = default;

        private:
        std::optional<Anchor> anchor;
        std::optional<double> angle;
        std::optional<VerticalAlign> baseline;
        std::optional<std::string> color;
        std::optional<std::string> font;
        std::optional<double> font_size;
        ClassMemberConstraints font_size_constraint;
        std::optional<FontWeightUnion> font_weight;
        std::optional<double> limit;
        ClassMemberConstraints limit_constraint;
        std::optional<double> offset;
        std::optional<TitleOrient> orient;

        public:
        /**
         * The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
         * example, with an orientation of top these anchor positions map to a left-, center-, or
         * right-aligned title.
         *
         * __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
         * `"start"` for other composite views.
         *
         * __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
         * customizable only for [single](spec.html) and [layered](layer.html) views.  For other
         * composite views, `anchor` is always `"start"`.
         */
        const std::optional<Anchor> & get_anchor() const { return anchor; }
        std::optional<Anchor> & get_mutable_anchor() { return anchor; }
        void set_anchor(const std::optional<Anchor> & value) { this->anchor = value; }

        /**
         * Angle in degrees of title text.
         */
        const std::optional<double> & get_angle() const { return angle; }
        std::optional<double> & get_mutable_angle() { return angle; }
        void set_angle(const std::optional<double> & value) { this->angle = value; }

        /**
         * Vertical text baseline for title text.
         */
        const std::optional<VerticalAlign> & get_baseline() const { return baseline; }
        std::optional<VerticalAlign> & get_mutable_baseline() { return baseline; }
        void set_baseline(const std::optional<VerticalAlign> & value) { this->baseline = value; }

        /**
         * Text color for title text.
         */
        const std::optional<std::string> & get_color() const { return color; }
        std::optional<std::string> & get_mutable_color() { return color; }
        void set_color(const std::optional<std::string> & value) { this->color = value; }

        /**
         * Font name for title text.
         */
        const std::optional<std::string> & get_font() const { return font; }
        std::optional<std::string> & get_mutable_font() { return font; }
        void set_font(const std::optional<std::string> & value) { this->font = value; }

        /**
         * Font size in pixels for title text.
         *
         * __Default value:__ `10`.
         */
        const std::optional<double> & get_font_size() const { return font_size; }
        std::optional<double> & get_mutable_font_size() { return font_size; }
        void set_font_size(const std::optional<double> & value) { CheckConstraint("font_size", font_size_constraint, value); this->font_size = value; }

        /**
         * Font weight for title text.
         */
        const std::optional<FontWeightUnion> & get_font_weight() const { return font_weight; }
        std::optional<FontWeightUnion> & get_mutable_font_weight() { return font_weight; }
        void set_font_weight(const std::optional<FontWeightUnion> & value) { this->font_weight = value; }

        /**
         * The maximum allowed length in pixels of legend labels.
         */
        const std::optional<double> & get_limit() const { return limit; }
        std::optional<double> & get_mutable_limit() { return limit; }
        void set_limit(const std::optional<double> & value) { CheckConstraint("limit", limit_constraint, value); this->limit = value; }

        /**
         * Offset in pixels of the title from the chart body and axes.
         */
        const std::optional<double> & get_offset() const { return offset; }
        std::optional<double> & get_mutable_offset() { return offset; }
        void set_offset(const std::optional<double> & value) { this->offset = value; }

        /**
         * Default title orientation ("top", "bottom", "left", or "right")
         */
        const std::optional<TitleOrient> & get_orient() const { return orient; }
        std::optional<TitleOrient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<TitleOrient> & value) { this->orient = value; }
    };

    /**
     * Default properties for [single view plots](spec.html#single).
     */
    class ViewConfig {
        public:
        ViewConfig() = default;
        virtual ~ViewConfig() = default;

        private:
        std::optional<bool> clip;
        std::optional<std::string> fill;
        std::optional<double> fill_opacity;
        std::optional<double> height;
        std::optional<std::string> stroke;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_dash_offset;
        std::optional<double> stroke_opacity;
        std::optional<double> stroke_width;
        std::optional<double> width;

        public:
        /**
         * Whether the view should be clipped.
         */
        const std::optional<bool> & get_clip() const { return clip; }
        std::optional<bool> & get_mutable_clip() { return clip; }
        void set_clip(const std::optional<bool> & value) { this->clip = value; }

        /**
         * The fill color.
         *
         * __Default value:__ (none)
         */
        const std::optional<std::string> & get_fill() const { return fill; }
        std::optional<std::string> & get_mutable_fill() { return fill; }
        void set_fill(const std::optional<std::string> & value) { this->fill = value; }

        /**
         * The fill opacity (value between [0,1]).
         *
         * __Default value:__ (none)
         */
        const std::optional<double> & get_fill_opacity() const { return fill_opacity; }
        std::optional<double> & get_mutable_fill_opacity() { return fill_opacity; }
        void set_fill_opacity(const std::optional<double> & value) { this->fill_opacity = value; }

        /**
         * The default height of the single plot or each plot in a trellis plot when the
         * visualization has a continuous (non-ordinal) y-scale with `rangeStep` = `null`.
         *
         * __Default value:__ `200`
         */
        const std::optional<double> & get_height() const { return height; }
        std::optional<double> & get_mutable_height() { return height; }
        void set_height(const std::optional<double> & value) { this->height = value; }

        /**
         * The stroke color.
         *
         * __Default value:__ (none)
         */
        const std::optional<std::string> & get_stroke() const { return stroke; }
        std::optional<std::string> & get_mutable_stroke() { return stroke; }
        void set_stroke(const std::optional<std::string> & value) { this->stroke = value; }

        /**
         * An array of alternating stroke, space lengths for creating dashed or dotted lines.
         *
         * __Default value:__ (none)
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the stroke dash array.
         *
         * __Default value:__ (none)
         */
        const std::optional<double> & get_stroke_dash_offset() const { return stroke_dash_offset; }
        std::optional<double> & get_mutable_stroke_dash_offset() { return stroke_dash_offset; }
        void set_stroke_dash_offset(const std::optional<double> & value) { this->stroke_dash_offset = value; }

        /**
         * The stroke opacity (value between [0,1]).
         *
         * __Default value:__ (none)
         */
        const std::optional<double> & get_stroke_opacity() const { return stroke_opacity; }
        std::optional<double> & get_mutable_stroke_opacity() { return stroke_opacity; }
        void set_stroke_opacity(const std::optional<double> & value) { this->stroke_opacity = value; }

        /**
         * The stroke width, in pixels.
         *
         * __Default value:__ (none)
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { this->stroke_width = value; }

        /**
         * The default width of the single plot or each plot in a trellis plot when the
         * visualization has a continuous (non-ordinal) x-scale or ordinal x-scale with `rangeStep`
         * = `null`.
         *
         * __Default value:__ `200`
         */
        const std::optional<double> & get_width() const { return width; }
        std::optional<double> & get_mutable_width() { return width; }
        void set_width(const std::optional<double> & value) { this->width = value; }
    };

    /**
     * Vega-Lite configuration object.  This property can only be defined at the top-level of a
     * specification.
     */
    class Config {
        public:
        Config() = default;
        virtual ~Config() = default;

        private:
        std::optional<MarkConfig> area;
        std::optional<Autosize> autosize;
        std::optional<AxisConfig> axis;
        std::optional<VgAxisConfig> axis_band;
        std::optional<VgAxisConfig> axis_bottom;
        std::optional<VgAxisConfig> axis_left;
        std::optional<VgAxisConfig> axis_right;
        std::optional<VgAxisConfig> axis_top;
        std::optional<VgAxisConfig> axis_x;
        std::optional<VgAxisConfig> axis_y;
        std::optional<std::string> background;
        std::optional<BarConfig> bar;
        std::optional<MarkConfig> circle;
        std::optional<std::string> count_title;
        std::optional<FieldTitle> field_title;
        std::optional<MarkConfig> geoshape;
        std::optional<InvalidValues> invalid_values;
        std::optional<LegendConfig> legend;
        std::optional<MarkConfig> line;
        std::optional<MarkConfig> mark;
        std::optional<std::string> number_format;
        std::optional<Padding> padding;
        std::optional<MarkConfig> point;
        std::optional<ProjectionConfig> projection;
        std::optional<std::map<std::string, RangeConfigValue>> range;
        std::optional<MarkConfig> rect;
        std::optional<MarkConfig> rule;
        std::optional<ScaleConfig> scale;
        std::optional<SelectionConfig> selection;
        std::optional<MarkConfig> square;
        std::optional<StackOffset> stack;
        std::optional<std::map<std::string, VgMarkConfig>> style;
        std::optional<TextConfig> text;
        std::optional<TickConfig> tick;
        std::optional<std::string> time_format;
        std::optional<VgTitleConfig> title;
        std::optional<ViewConfig> view;

        public:
        /**
         * Area-Specific Config
         */
        const std::optional<MarkConfig> & get_area() const { return area; }
        std::optional<MarkConfig> & get_mutable_area() { return area; }
        void set_area(const std::optional<MarkConfig> & value) { this->area = value; }

        /**
         * Sets how the visualization size should be determined. If a string, should be one of
         * `"pad"`, `"fit"` or `"none"`.
         * Object values can additionally specify parameters for content sizing and automatic
         * resizing.
         * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
         *
         * __Default value__: `pad`
         */
        const std::optional<Autosize> & get_autosize() const { return autosize; }
        std::optional<Autosize> & get_mutable_autosize() { return autosize; }
        void set_autosize(const std::optional<Autosize> & value) { this->autosize = value; }

        /**
         * Axis configuration, which determines default properties for all `x` and `y`
         * [axes](axis.html). For a full list of axis configuration options, please see the
         * [corresponding section of the axis documentation](axis.html#config).
         */
        const std::optional<AxisConfig> & get_axis() const { return axis; }
        std::optional<AxisConfig> & get_mutable_axis() { return axis; }
        void set_axis(const std::optional<AxisConfig> & value) { this->axis = value; }

        /**
         * Specific axis config for axes with "band" scales.
         */
        const std::optional<VgAxisConfig> & get_axis_band() const { return axis_band; }
        std::optional<VgAxisConfig> & get_mutable_axis_band() { return axis_band; }
        void set_axis_band(const std::optional<VgAxisConfig> & value) { this->axis_band = value; }

        /**
         * Specific axis config for x-axis along the bottom edge of the chart.
         */
        const std::optional<VgAxisConfig> & get_axis_bottom() const { return axis_bottom; }
        std::optional<VgAxisConfig> & get_mutable_axis_bottom() { return axis_bottom; }
        void set_axis_bottom(const std::optional<VgAxisConfig> & value) { this->axis_bottom = value; }

        /**
         * Specific axis config for y-axis along the left edge of the chart.
         */
        const std::optional<VgAxisConfig> & get_axis_left() const { return axis_left; }
        std::optional<VgAxisConfig> & get_mutable_axis_left() { return axis_left; }
        void set_axis_left(const std::optional<VgAxisConfig> & value) { this->axis_left = value; }

        /**
         * Specific axis config for y-axis along the right edge of the chart.
         */
        const std::optional<VgAxisConfig> & get_axis_right() const { return axis_right; }
        std::optional<VgAxisConfig> & get_mutable_axis_right() { return axis_right; }
        void set_axis_right(const std::optional<VgAxisConfig> & value) { this->axis_right = value; }

        /**
         * Specific axis config for x-axis along the top edge of the chart.
         */
        const std::optional<VgAxisConfig> & get_axis_top() const { return axis_top; }
        std::optional<VgAxisConfig> & get_mutable_axis_top() { return axis_top; }
        void set_axis_top(const std::optional<VgAxisConfig> & value) { this->axis_top = value; }

        /**
         * X-axis specific config.
         */
        const std::optional<VgAxisConfig> & get_axis_x() const { return axis_x; }
        std::optional<VgAxisConfig> & get_mutable_axis_x() { return axis_x; }
        void set_axis_x(const std::optional<VgAxisConfig> & value) { this->axis_x = value; }

        /**
         * Y-axis specific config.
         */
        const std::optional<VgAxisConfig> & get_axis_y() const { return axis_y; }
        std::optional<VgAxisConfig> & get_mutable_axis_y() { return axis_y; }
        void set_axis_y(const std::optional<VgAxisConfig> & value) { this->axis_y = value; }

        /**
         * CSS color property to use as the background of visualization.
         *
         * __Default value:__ none (transparent)
         */
        const std::optional<std::string> & get_background() const { return background; }
        std::optional<std::string> & get_mutable_background() { return background; }
        void set_background(const std::optional<std::string> & value) { this->background = value; }

        /**
         * Bar-Specific Config
         */
        const std::optional<BarConfig> & get_bar() const { return bar; }
        std::optional<BarConfig> & get_mutable_bar() { return bar; }
        void set_bar(const std::optional<BarConfig> & value) { this->bar = value; }

        /**
         * Circle-Specific Config
         */
        const std::optional<MarkConfig> & get_circle() const { return circle; }
        std::optional<MarkConfig> & get_mutable_circle() { return circle; }
        void set_circle(const std::optional<MarkConfig> & value) { this->circle = value; }

        /**
         * Default axis and legend title for count fields.
         *
         * __Default value:__ `'Number of Records'`.
         */
        const std::optional<std::string> & get_count_title() const { return count_title; }
        std::optional<std::string> & get_mutable_count_title() { return count_title; }
        void set_count_title(const std::optional<std::string> & value) { this->count_title = value; }

        /**
         * Defines how Vega-Lite generates title for fields.  There are three possible styles:
         *
         * - `"verbal"` (Default) - displays function in a verbal style (e.g., "Sum of field",
         * "Year-month of date", "field (binned)").
         * - `"function"` - displays function using parentheses and capitalized texts (e.g.,
         * "SUM(field)", "YEARMONTH(date)", "BIN(field)").
         * - `"plain"` - displays only the field name without functions (e.g., "field", "date",
         * "field").
         */
        const std::optional<FieldTitle> & get_field_title() const { return field_title; }
        std::optional<FieldTitle> & get_mutable_field_title() { return field_title; }
        void set_field_title(const std::optional<FieldTitle> & value) { this->field_title = value; }

        /**
         * Geoshape-Specific Config
         */
        const std::optional<MarkConfig> & get_geoshape() const { return geoshape; }
        std::optional<MarkConfig> & get_mutable_geoshape() { return geoshape; }
        void set_geoshape(const std::optional<MarkConfig> & value) { this->geoshape = value; }

        /**
         * Defines how Vega-Lite should handle invalid values (`null` and `NaN`).
         * - If set to `"filter"` (default), all data items with null values are filtered.
         * - If `null`, all data items are included. In this case, invalid values will be
         * interpreted as zeroes.
         */
        const std::optional<InvalidValues> & get_invalid_values() const { return invalid_values; }
        std::optional<InvalidValues> & get_mutable_invalid_values() { return invalid_values; }
        void set_invalid_values(const std::optional<InvalidValues> & value) { this->invalid_values = value; }

        /**
         * Legend configuration, which determines default properties for all [legends](legend.html).
         * For a full list of legend configuration options, please see the [corresponding section of
         * in the legend documentation](legend.html#config).
         */
        const std::optional<LegendConfig> & get_legend() const { return legend; }
        std::optional<LegendConfig> & get_mutable_legend() { return legend; }
        void set_legend(const std::optional<LegendConfig> & value) { this->legend = value; }

        /**
         * Line-Specific Config
         */
        const std::optional<MarkConfig> & get_line() const { return line; }
        std::optional<MarkConfig> & get_mutable_line() { return line; }
        void set_line(const std::optional<MarkConfig> & value) { this->line = value; }

        /**
         * Mark Config
         */
        const std::optional<MarkConfig> & get_mark() const { return mark; }
        std::optional<MarkConfig> & get_mutable_mark() { return mark; }
        void set_mark(const std::optional<MarkConfig> & value) { this->mark = value; }

        /**
         * D3 Number format for axis labels and text tables. For example "s" for SI units. Use [D3's
         * number format pattern](https://github.com/d3/d3-format#locale_format).
         */
        const std::optional<std::string> & get_number_format() const { return number_format; }
        std::optional<std::string> & get_mutable_number_format() { return number_format; }
        void set_number_format(const std::optional<std::string> & value) { this->number_format = value; }

        /**
         * The default visualization padding, in pixels, from the edge of the visualization canvas
         * to the data rectangle.  If a number, specifies padding for all sides.
         * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
         * "bottom": 5}` to specify padding for each side of the visualization.
         *
         * __Default value__: `5`
         */
        const std::optional<Padding> & get_padding() const { return padding; }
        std::optional<Padding> & get_mutable_padding() { return padding; }
        void set_padding(const std::optional<Padding> & value) { this->padding = value; }

        /**
         * Point-Specific Config
         */
        const std::optional<MarkConfig> & get_point() const { return point; }
        std::optional<MarkConfig> & get_mutable_point() { return point; }
        void set_point(const std::optional<MarkConfig> & value) { this->point = value; }

        /**
         * Projection configuration, which determines default properties for all
         * [projections](projection.html). For a full list of projection configuration options,
         * please see the [corresponding section of the projection
         * documentation](projection.html#config).
         */
        const std::optional<ProjectionConfig> & get_projection() const { return projection; }
        std::optional<ProjectionConfig> & get_mutable_projection() { return projection; }
        void set_projection(const std::optional<ProjectionConfig> & value) { this->projection = value; }

        /**
         * An object hash that defines default range arrays or schemes for using with scales.
         * For a full list of scale range configuration options, please see the [corresponding
         * section of the scale documentation](scale.html#config).
         */
        const std::optional<std::map<std::string, RangeConfigValue>> & get_range() const { return range; }
        std::optional<std::map<std::string, RangeConfigValue>> & get_mutable_range() { return range; }
        void set_range(const std::optional<std::map<std::string, RangeConfigValue>> & value) { this->range = value; }

        /**
         * Rect-Specific Config
         */
        const std::optional<MarkConfig> & get_rect() const { return rect; }
        std::optional<MarkConfig> & get_mutable_rect() { return rect; }
        void set_rect(const std::optional<MarkConfig> & value) { this->rect = value; }

        /**
         * Rule-Specific Config
         */
        const std::optional<MarkConfig> & get_rule() const { return rule; }
        std::optional<MarkConfig> & get_mutable_rule() { return rule; }
        void set_rule(const std::optional<MarkConfig> & value) { this->rule = value; }

        /**
         * Scale configuration determines default properties for all [scales](scale.html). For a
         * full list of scale configuration options, please see the [corresponding section of the
         * scale documentation](scale.html#config).
         */
        const std::optional<ScaleConfig> & get_scale() const { return scale; }
        std::optional<ScaleConfig> & get_mutable_scale() { return scale; }
        void set_scale(const std::optional<ScaleConfig> & value) { this->scale = value; }

        /**
         * An object hash for defining default properties for each type of selections.
         */
        const std::optional<SelectionConfig> & get_selection() const { return selection; }
        std::optional<SelectionConfig> & get_mutable_selection() { return selection; }
        void set_selection(const std::optional<SelectionConfig> & value) { this->selection = value; }

        /**
         * Square-Specific Config
         */
        const std::optional<MarkConfig> & get_square() const { return square; }
        std::optional<MarkConfig> & get_mutable_square() { return square; }
        void set_square(const std::optional<MarkConfig> & value) { this->square = value; }

        /**
         * Default stack offset for stackable mark.
         */
        const std::optional<StackOffset> & get_stack() const { return stack; }
        std::optional<StackOffset> & get_mutable_stack() { return stack; }
        void set_stack(const std::optional<StackOffset> & value) { this->stack = value; }

        /**
         * An object hash that defines key-value mappings to determine default properties for marks
         * with a given [style](mark.html#mark-def).  The keys represent styles names; the value are
         * valid [mark configuration objects](mark.html#config).
         */
        const std::optional<std::map<std::string, VgMarkConfig>> & get_style() const { return style; }
        std::optional<std::map<std::string, VgMarkConfig>> & get_mutable_style() { return style; }
        void set_style(const std::optional<std::map<std::string, VgMarkConfig>> & value) { this->style = value; }

        /**
         * Text-Specific Config
         */
        const std::optional<TextConfig> & get_text() const { return text; }
        std::optional<TextConfig> & get_mutable_text() { return text; }
        void set_text(const std::optional<TextConfig> & value) { this->text = value; }

        /**
         * Tick-Specific Config
         */
        const std::optional<TickConfig> & get_tick() const { return tick; }
        std::optional<TickConfig> & get_mutable_tick() { return tick; }
        void set_tick(const std::optional<TickConfig> & value) { this->tick = value; }

        /**
         * Default datetime format for axis and legend labels. The format can be set directly on
         * each axis and legend. Use [D3's time format
         * pattern](https://github.com/d3/d3-time-format#locale_format).
         *
         * __Default value:__ `'%b %d, %Y'`.
         */
        const std::optional<std::string> & get_time_format() const { return time_format; }
        std::optional<std::string> & get_mutable_time_format() { return time_format; }
        void set_time_format(const std::optional<std::string> & value) { this->time_format = value; }

        /**
         * Title configuration, which determines default properties for all [titles](title.html).
         * For a full list of title configuration options, please see the [corresponding section of
         * the title documentation](title.html#config).
         */
        const std::optional<VgTitleConfig> & get_title() const { return title; }
        std::optional<VgTitleConfig> & get_mutable_title() { return title; }
        void set_title(const std::optional<VgTitleConfig> & value) { this->title = value; }

        /**
         * Default properties for [single view plots](spec.html#single).
         */
        const std::optional<ViewConfig> & get_view() const { return view; }
        std::optional<ViewConfig> & get_mutable_view() { return view; }
        void set_view(const std::optional<ViewConfig> & value) { this->view = value; }
    };

    enum class ParseEnum : int { AUTO };

    using ParseUnion = std::variant<ParseEnum, std::map<std::string, nlohmann::json>>;

    /**
     * Type of input data: `"json"`, `"csv"`, `"tsv"`.
     * The default format type is determined by the extension of the file URL.
     * If no extension is detected, `"json"` will be used by default.
     */
    enum class DataFormatType : int { CSV, TSV, JSON, TOPOJSON };

    /**
     * An object that specifies the format for parsing the data file.
     *
     * An object that specifies the format for parsing the data values.
     *
     * An object that specifies the format for parsing the data.
     */
    class DataFormat {
        public:
        DataFormat() = default;
        virtual ~DataFormat() = default;

        private:
        std::optional<ParseUnion> parse;
        std::optional<DataFormatType> type;
        std::optional<std::string> property;
        std::optional<std::string> feature;
        std::optional<std::string> mesh;

        public:
        /**
         * If set to auto (the default), perform automatic type inference to determine the desired
         * data types.
         * Alternatively, a parsing directive object can be provided for explicit data types. Each
         * property of the object corresponds to a field name, and the value to the desired data
         * type (one of `"number"`, `"boolean"` or `"date"`).
         * For example, `"parse": {"modified_on": "date"}` parses the `modified_on` field in each
         * input record a Date value.
         *
         * For `"date"`, we parse data based using Javascript's
         * [`Date.parse()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/parse).
         * For Specific date formats can be provided (e.g., `{foo: 'date:"%m%d%Y"'}`), using the
         * [d3-time-format syntax](https://github.com/d3/d3-time-format#locale_format). UTC date
         * format parsing is supported similarly (e.g., `{foo: 'utc:"%m%d%Y"'}`). See more about
         * [UTC time](timeunit.html#utc)
         */
        const std::optional<ParseUnion> & get_parse() const { return parse; }
        std::optional<ParseUnion> & get_mutable_parse() { return parse; }
        void set_parse(const std::optional<ParseUnion> & value) { this->parse = value; }

        /**
         * Type of input data: `"json"`, `"csv"`, `"tsv"`.
         * The default format type is determined by the extension of the file URL.
         * If no extension is detected, `"json"` will be used by default.
         */
        const std::optional<DataFormatType> & get_type() const { return type; }
        std::optional<DataFormatType> & get_mutable_type() { return type; }
        void set_type(const std::optional<DataFormatType> & value) { this->type = value; }

        /**
         * The JSON property containing the desired data.
         * This parameter can be used when the loaded JSON file may have surrounding structure or
         * meta-data.
         * For example `"property": "values.features"` is equivalent to retrieving
         * `json.values.features`
         * from the loaded JSON object.
         */
        const std::optional<std::string> & get_property() const { return property; }
        std::optional<std::string> & get_mutable_property() { return property; }
        void set_property(const std::optional<std::string> & value) { this->property = value; }

        /**
         * The name of the TopoJSON object set to convert to a GeoJSON feature collection.
         * For example, in a map of the world, there may be an object set named `"countries"`.
         * Using the feature property, we can extract this set and generate a GeoJSON feature object
         * for each country.
         */
        const std::optional<std::string> & get_feature() const { return feature; }
        std::optional<std::string> & get_mutable_feature() { return feature; }
        void set_feature(const std::optional<std::string> & value) { this->feature = value; }

        /**
         * The name of the TopoJSON object set to convert to mesh.
         * Similar to the `feature` option, `mesh` extracts a named TopoJSON object set.
         * Unlike the `feature` option, the corresponding geo data is returned as a single, unified
         * mesh instance, not as individual GeoJSON features.
         * Extracting a mesh is useful for more efficiently drawing borders or other geographic
         * elements that you do not need to associate with specific regions such as individual
         * countries, states or counties.
         */
        const std::optional<std::string> & get_mesh() const { return mesh; }
        std::optional<std::string> & get_mutable_mesh() { return mesh; }
        void set_mesh(const std::optional<std::string> & value) { this->mesh = value; }
    };

    using ValuesValue = std::variant<bool, double, std::map<std::string, nlohmann::json>, std::string>;

    using Values = std::variant<std::vector<ValuesValue>, std::map<std::string, nlohmann::json>, std::string>;

    /**
     * An object describing the data source
     *
     * Secondary data source to lookup in.
     */
    class Data {
        public:
        Data() = default;
        virtual ~Data() = default;

        private:
        std::optional<DataFormat> format;
        std::optional<std::string> url;
        std::optional<Values> values;
        std::optional<std::string> name;

        public:
        /**
         * An object that specifies the format for parsing the data file.
         *
         * An object that specifies the format for parsing the data values.
         *
         * An object that specifies the format for parsing the data.
         */
        const std::optional<DataFormat> & get_format() const { return format; }
        std::optional<DataFormat> & get_mutable_format() { return format; }
        void set_format(const std::optional<DataFormat> & value) { this->format = value; }

        /**
         * An URL from which to load the data set. Use the `format.type` property
         * to ensure the loaded data is correctly parsed.
         */
        const std::optional<std::string> & get_url() const { return url; }
        std::optional<std::string> & get_mutable_url() { return url; }
        void set_url(const std::optional<std::string> & value) { this->url = value; }

        /**
         * The full data set, included inline. This can be an array of objects or primitive values
         * or a string.
         * Arrays of primitive values are ingested as objects with a `data` property. Strings are
         * parsed according to the specified format type.
         */
        const std::optional<Values> & get_values() const { return values; }
        std::optional<Values> & get_mutable_values() { return values; }
        void set_values(const std::optional<Values> & value) { this->values = value; }

        /**
         * Provide a placeholder name and bind data at runtime.
         */
        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }
    };

    /**
     * Aggregation function for the field
     * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
     *
     * __Default value:__ `undefined` (None)
     *
     * An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
     * (e.g., `"count"`, `"mean"` and `"median"`).
     * This property is required in cases where the sort field and the data reference field do
     * not match.
     * The input data objects will be aggregated, grouped by the encoded data field.
     *
     * For a full list of operations, please see the documentation for
     * [aggregate](aggregate.html#ops).
     *
     * The aggregation operations to apply to the fields, such as sum, average or count.
     * See the [full list of supported aggregation
     * operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
     * for more information.
     */
    enum class AggregateOp : int { ARGMAX, ARGMIN, AVERAGE, COUNT, DISTINCT, MAX, MEAN, MEDIAN, MIN, MISSING, Q1, Q3, CI0, CI1, STDEV, STDEVP, SUM, VALID, VALUES, VARIANCE, VARIANCEP };

    /**
     * Binning properties or boolean flag for determining whether to bin data or not.
     */
    class BinParams {
        public:
        BinParams() :
            maxbins_constraint(std::nullopt, std::nullopt, 2, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~BinParams() = default;

        private:
        std::optional<double> base;
        std::optional<std::vector<double>> divide;
        std::optional<std::vector<double>> extent;
        std::optional<double> maxbins;
        ClassMemberConstraints maxbins_constraint;
        std::optional<double> minstep;
        std::optional<bool> nice;
        std::optional<double> step;
        std::optional<std::vector<double>> steps;

        public:
        /**
         * The number base to use for automatic bin determination (default is base 10).
         *
         * __Default value:__ `10`
         */
        const std::optional<double> & get_base() const { return base; }
        std::optional<double> & get_mutable_base() { return base; }
        void set_base(const std::optional<double> & value) { this->base = value; }

        /**
         * Scale factors indicating allowable subdivisions. The default value is [5, 2], which
         * indicates that for base 10 numbers (the default base), the method may consider dividing
         * bin sizes by 5 and/or 2. For example, for an initial step size of 10, the method can
         * check if bin sizes of 2 (= 10/5), 5 (= 10/2), or 1 (= 10/(5*2)) might also satisfy the
         * given constraints.
         *
         * __Default value:__ `[5, 2]`
         */
        const std::optional<std::vector<double>> & get_divide() const { return divide; }
        std::optional<std::vector<double>> & get_mutable_divide() { return divide; }
        void set_divide(const std::optional<std::vector<double>> & value) { this->divide = value; }

        /**
         * A two-element (`[min, max]`) array indicating the range of desired bin values.
         */
        const std::optional<std::vector<double>> & get_extent() const { return extent; }
        std::optional<std::vector<double>> & get_mutable_extent() { return extent; }
        void set_extent(const std::optional<std::vector<double>> & value) { this->extent = value; }

        /**
         * Maximum number of bins.
         *
         * __Default value:__ `6` for `row`, `column` and `shape` channels; `10` for other channels
         */
        const std::optional<double> & get_maxbins() const { return maxbins; }
        std::optional<double> & get_mutable_maxbins() { return maxbins; }
        void set_maxbins(const std::optional<double> & value) { CheckConstraint("maxbins", maxbins_constraint, value); this->maxbins = value; }

        /**
         * A minimum allowable step size (particularly useful for integer values).
         */
        const std::optional<double> & get_minstep() const { return minstep; }
        std::optional<double> & get_mutable_minstep() { return minstep; }
        void set_minstep(const std::optional<double> & value) { this->minstep = value; }

        /**
         * If true (the default), attempts to make the bin boundaries use human-friendly boundaries,
         * such as multiples of ten.
         */
        const std::optional<bool> & get_nice() const { return nice; }
        std::optional<bool> & get_mutable_nice() { return nice; }
        void set_nice(const std::optional<bool> & value) { this->nice = value; }

        /**
         * An exact step size to use between bins.
         *
         * __Note:__ If provided, options such as maxbins will be ignored.
         */
        const std::optional<double> & get_step() const { return step; }
        std::optional<double> & get_mutable_step() { return step; }
        void set_step(const std::optional<double> & value) { this->step = value; }

        /**
         * An array of allowable step sizes to choose from.
         */
        const std::optional<std::vector<double>> & get_steps() const { return steps; }
        std::optional<std::vector<double>> & get_mutable_steps() { return steps; }
        void set_steps(const std::optional<std::vector<double>> & value) { this->steps = value; }
    };

    using Bin = std::variant<bool, BinParams>;

    class Selection;

    struct SelectionOperand : std::variant<std::shared_ptr<Selection>, std::string> {
        using base = std::variant<std::shared_ptr<Selection>, std::string>;
        using base::base;
        using base::operator=;
    };

    class Selection {
        public:
        Selection() = default;
        virtual ~Selection() = default;

        private:
        std::shared_ptr<SelectionOperand> selection_not;
        std::optional<std::vector<SelectionOperand>> selection_and;
        std::optional<std::vector<SelectionOperand>> selection_or;

        public:
        const std::shared_ptr<SelectionOperand> & get_selection_not() const { return selection_not; }
        std::shared_ptr<SelectionOperand> & get_mutable_selection_not() { return selection_not; }
        void set_selection_not(const std::shared_ptr<SelectionOperand> & value) { this->selection_not = value; }

        const std::optional<std::vector<SelectionOperand>> & get_selection_and() const { return selection_and; }
        std::optional<std::vector<SelectionOperand>> & get_mutable_selection_and() { return selection_and; }
        void set_selection_and(const std::optional<std::vector<SelectionOperand>> & value) { this->selection_and = value; }

        const std::optional<std::vector<SelectionOperand>> & get_selection_or() const { return selection_or; }
        std::optional<std::vector<SelectionOperand>> & get_mutable_selection_or() { return selection_or; }
        void set_selection_or(const std::optional<std::vector<SelectionOperand>> & value) { this->selection_or = value; }
    };

    using Day = std::variant<double, std::string>;

    using Month = std::variant<double, std::string>;

    /**
     * Object for defining datetime in Vega-Lite Filter.
     * If both month and quarter are provided, month has higher precedence.
     * `day` cannot be combined with other date.
     * We accept string for month and day names.
     */
    class DateTime {
        public:
        DateTime() :
            date_constraint(std::nullopt, std::nullopt, 1, 31, std::nullopt, std::nullopt, std::nullopt),
            hours_constraint(std::nullopt, std::nullopt, 0, 23, std::nullopt, std::nullopt, std::nullopt),
            milliseconds_constraint(std::nullopt, std::nullopt, 0, 999, std::nullopt, std::nullopt, std::nullopt),
            minutes_constraint(std::nullopt, std::nullopt, 0, 59, std::nullopt, std::nullopt, std::nullopt),
            quarter_constraint(std::nullopt, std::nullopt, 1, 4, std::nullopt, std::nullopt, std::nullopt),
            seconds_constraint(std::nullopt, std::nullopt, 0, 59, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~DateTime() = default;

        private:
        std::optional<double> date;
        ClassMemberConstraints date_constraint;
        std::optional<Day> day;
        std::optional<double> hours;
        ClassMemberConstraints hours_constraint;
        std::optional<double> milliseconds;
        ClassMemberConstraints milliseconds_constraint;
        std::optional<double> minutes;
        ClassMemberConstraints minutes_constraint;
        std::optional<Month> month;
        std::optional<double> quarter;
        ClassMemberConstraints quarter_constraint;
        std::optional<double> seconds;
        ClassMemberConstraints seconds_constraint;
        std::optional<bool> utc;
        std::optional<double> year;

        public:
        /**
         * Integer value representing the date from 1-31.
         */
        const std::optional<double> & get_date() const { return date; }
        std::optional<double> & get_mutable_date() { return date; }
        void set_date(const std::optional<double> & value) { CheckConstraint("date", date_constraint, value); this->date = value; }

        /**
         * Value representing the day of a week.  This can be one of: (1) integer value -- `1`
         * represents Monday; (2) case-insensitive day name (e.g., `"Monday"`);  (3)
         * case-insensitive, 3-character short day name (e.g., `"Mon"`).   <br/> **Warning:** A
         * DateTime definition object with `day`** should not be combined with `year`, `quarter`,
         * `month`, or `date`.
         */
        const std::optional<Day> & get_day() const { return day; }
        std::optional<Day> & get_mutable_day() { return day; }
        void set_day(const std::optional<Day> & value) { this->day = value; }

        /**
         * Integer value representing the hour of a day from 0-23.
         */
        const std::optional<double> & get_hours() const { return hours; }
        std::optional<double> & get_mutable_hours() { return hours; }
        void set_hours(const std::optional<double> & value) { CheckConstraint("hours", hours_constraint, value); this->hours = value; }

        /**
         * Integer value representing the millisecond segment of time.
         */
        const std::optional<double> & get_milliseconds() const { return milliseconds; }
        std::optional<double> & get_mutable_milliseconds() { return milliseconds; }
        void set_milliseconds(const std::optional<double> & value) { CheckConstraint("milliseconds", milliseconds_constraint, value); this->milliseconds = value; }

        /**
         * Integer value representing the minute segment of time from 0-59.
         */
        const std::optional<double> & get_minutes() const { return minutes; }
        std::optional<double> & get_mutable_minutes() { return minutes; }
        void set_minutes(const std::optional<double> & value) { CheckConstraint("minutes", minutes_constraint, value); this->minutes = value; }

        /**
         * One of: (1) integer value representing the month from `1`-`12`. `1` represents January;
         * (2) case-insensitive month name (e.g., `"January"`);  (3) case-insensitive, 3-character
         * short month name (e.g., `"Jan"`).
         */
        const std::optional<Month> & get_month() const { return month; }
        std::optional<Month> & get_mutable_month() { return month; }
        void set_month(const std::optional<Month> & value) { this->month = value; }

        /**
         * Integer value representing the quarter of the year (from 1-4).
         */
        const std::optional<double> & get_quarter() const { return quarter; }
        std::optional<double> & get_mutable_quarter() { return quarter; }
        void set_quarter(const std::optional<double> & value) { CheckConstraint("quarter", quarter_constraint, value); this->quarter = value; }

        /**
         * Integer value representing the second segment (0-59) of a time value
         */
        const std::optional<double> & get_seconds() const { return seconds; }
        std::optional<double> & get_mutable_seconds() { return seconds; }
        void set_seconds(const std::optional<double> & value) { CheckConstraint("seconds", seconds_constraint, value); this->seconds = value; }

        /**
         * A boolean flag indicating if date time is in utc time. If false, the date time is in
         * local time
         */
        const std::optional<bool> & get_utc() const { return utc; }
        std::optional<bool> & get_mutable_utc() { return utc; }
        void set_utc(const std::optional<bool> & value) { this->utc = value; }

        /**
         * Integer value representing the year.
         */
        const std::optional<double> & get_year() const { return year; }
        std::optional<double> & get_mutable_year() { return year; }
        void set_year(const std::optional<double> & value) { this->year = value; }
    };

    using Equal = std::variant<bool, DateTime, double, std::string>;

    using RangeElement = std::optional<std::variant<DateTime, double>>;

    /**
     * Time unit for the field to be filtered.
     *
     * time unit for the field to be filtered.
     *
     * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
     * or [a temporal field that gets casted as ordinal](type.html#cast).
     *
     * __Default value:__ `undefined` (None)
     *
     * The timeUnit.
     */
    enum class TimeUnit : int { YEAR, QUARTER, MONTH, DAY, DATE, HOURS, MINUTES, SECONDS, MILLISECONDS, UTCYEAR, UTCQUARTER, UTCMONTH, UTCDAY, UTCDATE, UTCHOURS, UTCMINUTES, UTCSECONDS, UTCMILLISECONDS, YEARQUARTER, YEARQUARTERMONTH, YEARMONTH, YEARMONTHDATE, YEARMONTHDATEHOURS, YEARMONTHDATEHOURSMINUTES, YEARMONTHDATEHOURSMINUTESSECONDS, QUARTERMONTH, MONTHDATE, HOURSMINUTES, HOURSMINUTESSECONDS, MINUTESSECONDS, SECONDSMILLISECONDS, UTCYEARQUARTER, UTCYEARQUARTERMONTH, UTCYEARMONTH, UTCYEARMONTHDATE, UTCYEARMONTHDATEHOURS, UTCYEARMONTHDATEHOURSMINUTES, UTCYEARMONTHDATEHOURSMINUTESSECONDS, UTCQUARTERMONTH, UTCMONTHDATE, UTCHOURSMINUTES, UTCHOURSMINUTESSECONDS, UTCMINUTESSECONDS, UTCSECONDSMILLISECONDS };

    class Predicate;

    struct LogicalOperandPredicate : std::variant<std::shared_ptr<Predicate>, std::string> {
        using base = std::variant<std::shared_ptr<Predicate>, std::string>;
        using base::base;
        using base::operator=;
    };

    class Predicate {
        public:
        Predicate() = default;
        virtual ~Predicate() = default;

        private:
        std::shared_ptr<LogicalOperandPredicate> predicate_not;
        std::optional<std::vector<LogicalOperandPredicate>> predicate_and;
        std::optional<std::vector<LogicalOperandPredicate>> predicate_or;
        std::optional<Equal> equal;
        std::optional<std::string> field;
        std::optional<TimeUnit> time_unit;
        std::optional<std::vector<RangeElement>> range;
        std::optional<std::vector<Equal>> one_of;
        std::shared_ptr<SelectionOperand> selection;

        public:
        const std::shared_ptr<LogicalOperandPredicate> & get_predicate_not() const { return predicate_not; }
        std::shared_ptr<LogicalOperandPredicate> & get_mutable_predicate_not() { return predicate_not; }
        void set_predicate_not(const std::shared_ptr<LogicalOperandPredicate> & value) { this->predicate_not = value; }

        const std::optional<std::vector<LogicalOperandPredicate>> & get_predicate_and() const { return predicate_and; }
        std::optional<std::vector<LogicalOperandPredicate>> & get_mutable_predicate_and() { return predicate_and; }
        void set_predicate_and(const std::optional<std::vector<LogicalOperandPredicate>> & value) { this->predicate_and = value; }

        const std::optional<std::vector<LogicalOperandPredicate>> & get_predicate_or() const { return predicate_or; }
        std::optional<std::vector<LogicalOperandPredicate>> & get_mutable_predicate_or() { return predicate_or; }
        void set_predicate_or(const std::optional<std::vector<LogicalOperandPredicate>> & value) { this->predicate_or = value; }

        /**
         * The value that the field should be equal to.
         */
        const std::optional<Equal> & get_equal() const { return equal; }
        std::optional<Equal> & get_mutable_equal() { return equal; }
        void set_equal(const std::optional<Equal> & value) { this->equal = value; }

        /**
         * Field to be filtered.
         *
         * Field to be filtered
         */
        const std::optional<std::string> & get_field() const { return field; }
        std::optional<std::string> & get_mutable_field() { return field; }
        void set_field(const std::optional<std::string> & value) { this->field = value; }

        /**
         * Time unit for the field to be filtered.
         *
         * time unit for the field to be filtered.
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * An array of inclusive minimum and maximum values
         * for a field value of a data item to be included in the filtered data.
         */
        const std::optional<std::vector<RangeElement>> & get_range() const { return range; }
        std::optional<std::vector<RangeElement>> & get_mutable_range() { return range; }
        void set_range(const std::optional<std::vector<RangeElement>> & value) { this->range = value; }

        /**
         * A set of values that the `field`'s value should be a member of,
         * for a data item included in the filtered data.
         */
        const std::optional<std::vector<Equal>> & get_one_of() const { return one_of; }
        std::optional<std::vector<Equal>> & get_mutable_one_of() { return one_of; }
        void set_one_of(const std::optional<std::vector<Equal>> & value) { this->one_of = value; }

        /**
         * Filter using a selection name.
         */
        const std::shared_ptr<SelectionOperand> & get_selection() const { return selection; }
        std::shared_ptr<SelectionOperand> & get_mutable_selection() { return selection; }
        void set_selection(const std::shared_ptr<SelectionOperand> & value) { this->selection = value; }
    };

    using ConditionalValueDefValue = std::variant<bool, double, std::string>;

    class ConditionalValueDef {
        public:
        ConditionalValueDef() = default;
        virtual ~ConditionalValueDef() = default;

        private:
        std::shared_ptr<LogicalOperandPredicate> test;
        ConditionalValueDefValue value;
        std::shared_ptr<SelectionOperand> selection;

        public:
        const std::shared_ptr<LogicalOperandPredicate> & get_test() const { return test; }
        std::shared_ptr<LogicalOperandPredicate> & get_mutable_test() { return test; }
        void set_test(const std::shared_ptr<LogicalOperandPredicate> & value) { this->test = value; }

        /**
         * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
         * `0` to `1` for opacity).
         */
        const ConditionalValueDefValue & get_value() const { return value; }
        ConditionalValueDefValue & get_mutable_value() { return value; }
        void set_value(const ConditionalValueDefValue & value) { this->value = value; }

        /**
         * A [selection name](selection.html), or a series of [composed
         * selections](selection.html#compose).
         */
        const std::shared_ptr<SelectionOperand> & get_selection() const { return selection; }
        std::shared_ptr<SelectionOperand> & get_mutable_selection() { return selection; }
        void set_selection(const std::shared_ptr<SelectionOperand> & value) { this->selection = value; }
    };

    enum class RepeatEnum : int { ROW, COLUMN };

    /**
     * Reference to a repeated value.
     */
    class RepeatRef {
        public:
        RepeatRef() = default;
        virtual ~RepeatRef() = default;

        private:
        RepeatEnum repeat;

        public:
        const RepeatEnum & get_repeat() const { return repeat; }
        RepeatEnum & get_mutable_repeat() { return repeat; }
        void set_repeat(const RepeatEnum & value) { this->repeat = value; }
    };

    using Field = std::variant<RepeatRef, std::string>;

    /**
     * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
     * continuous color gradient.
     *
     * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
     * `"symbol"` otherwise.
     */
    enum class LegendType : int { SYMBOL, GRADIENT };

    using LegendValue = std::variant<DateTime, double, std::string>;

    /**
     * Properties of a legend or boolean flag for determining whether to show it.
     */
    class Legend {
        public:
        Legend() :
            zindex_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~Legend() = default;

        private:
        std::optional<double> entry_padding;
        std::optional<std::string> format;
        std::optional<double> offset;
        std::optional<LegendOrient> orient;
        std::optional<double> padding;
        std::optional<double> tick_count;
        std::optional<std::string> title;
        std::optional<LegendType> type;
        std::optional<std::vector<LegendValue>> values;
        std::optional<double> zindex;
        ClassMemberConstraints zindex_constraint;

        public:
        /**
         * Padding (in pixels) between legend entries in a symbol legend.
         */
        const std::optional<double> & get_entry_padding() const { return entry_padding; }
        std::optional<double> & get_mutable_entry_padding() { return entry_padding; }
        void set_entry_padding(const std::optional<double> & value) { this->entry_padding = value; }

        /**
         * The formatting pattern for labels. This is D3's [number format
         * pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
         * [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
         * field.
         *
         * See the [format documentation](format.html) for more information.
         *
         * __Default value:__  derived from [numberFormat](config.html#format) config for
         * quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
         */
        const std::optional<std::string> & get_format() const { return format; }
        std::optional<std::string> & get_mutable_format() { return format; }
        void set_format(const std::optional<std::string> & value) { this->format = value; }

        /**
         * The offset, in pixels, by which to displace the legend from the edge of the enclosing
         * group or data rectangle.
         *
         * __Default value:__  `0`
         */
        const std::optional<double> & get_offset() const { return offset; }
        std::optional<double> & get_mutable_offset() { return offset; }
        void set_offset(const std::optional<double> & value) { this->offset = value; }

        /**
         * The orientation of the legend, which determines how the legend is positioned within the
         * scene. One of "left", "right", "top-left", "top-right", "bottom-left", "bottom-right",
         * "none".
         *
         * __Default value:__ `"right"`
         */
        const std::optional<LegendOrient> & get_orient() const { return orient; }
        std::optional<LegendOrient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<LegendOrient> & value) { this->orient = value; }

        /**
         * The padding, in pixels, between the legend and axis.
         */
        const std::optional<double> & get_padding() const { return padding; }
        std::optional<double> & get_mutable_padding() { return padding; }
        void set_padding(const std::optional<double> & value) { this->padding = value; }

        /**
         * The desired number of tick values for quantitative legends.
         */
        const std::optional<double> & get_tick_count() const { return tick_count; }
        std::optional<double> & get_mutable_tick_count() { return tick_count; }
        void set_tick_count(const std::optional<double> & value) { this->tick_count = value; }

        /**
         * A title for the field. If `null`, the title will be removed.
         *
         * __Default value:__  derived from the field's name and transformation function
         * (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
         * function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
         * binned or has a time unit applied, the applied function will be denoted in parentheses
         * (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
         * simply the field name.
         *
         * __Note__: You can customize the default field title format by providing the [`fieldTitle`
         * property in the [config](config.html) or [`fieldTitle` function via the `compile`
         * function's options](compile.html#field-title).
         */
        std::optional<std::string> get_title() const { return title; }
        void set_title(std::optional<std::string> value) { this->title = value; }

        /**
         * The type of the legend. Use `"symbol"` to create a discrete legend and `"gradient"` for a
         * continuous color gradient.
         *
         * __Default value:__ `"gradient"` for non-binned quantitative fields and temporal fields;
         * `"symbol"` otherwise.
         */
        const std::optional<LegendType> & get_type() const { return type; }
        std::optional<LegendType> & get_mutable_type() { return type; }
        void set_type(const std::optional<LegendType> & value) { this->type = value; }

        /**
         * Explicitly set the visible legend values.
         */
        const std::optional<std::vector<LegendValue>> & get_values() const { return values; }
        std::optional<std::vector<LegendValue>> & get_mutable_values() { return values; }
        void set_values(const std::optional<std::vector<LegendValue>> & value) { this->values = value; }

        /**
         * A non-positive integer indicating z-index of the legend.
         * If zindex is 0, legend should be drawn behind all chart elements.
         * To put them in front, use zindex = 1.
         */
        const std::optional<double> & get_zindex() const { return zindex; }
        std::optional<double> & get_mutable_zindex() { return zindex; }
        void set_zindex(const std::optional<double> & value) { CheckConstraint("zindex", zindex_constraint, value); this->zindex = value; }
    };

    class DomainClass {
        public:
        DomainClass() = default;
        virtual ~DomainClass() = default;

        private:
        std::optional<std::string> field;
        std::string selection;
        std::optional<std::string> encoding;

        public:
        /**
         * The field name to extract selected values for, when a selection is
         * [projected](project.html)
         * over multiple fields or encodings.
         */
        const std::optional<std::string> & get_field() const { return field; }
        std::optional<std::string> & get_mutable_field() { return field; }
        void set_field(const std::optional<std::string> & value) { this->field = value; }

        /**
         * The name of a selection.
         */
        const std::string & get_selection() const { return selection; }
        std::string & get_mutable_selection() { return selection; }
        void set_selection(const std::string & value) { this->selection = value; }

        /**
         * The encoding channel to extract selected values for, when a selection is
         * [projected](project.html)
         * over multiple fields or encodings.
         */
        const std::optional<std::string> & get_encoding() const { return encoding; }
        std::optional<std::string> & get_mutable_encoding() { return encoding; }
        void set_encoding(const std::optional<std::string> & value) { this->encoding = value; }
    };

    enum class Domain : int { UNAGGREGATED };

    using DomainUnion = std::variant<std::vector<Equal>, DomainClass, Domain>;

    enum class InterpolateParamsType : int { RGB, CUBEHELIX, CUBEHELIX_LONG };

    class InterpolateParams {
        public:
        InterpolateParams() = default;
        virtual ~InterpolateParams() = default;

        private:
        std::optional<double> gamma;
        InterpolateParamsType type;

        public:
        const std::optional<double> & get_gamma() const { return gamma; }
        std::optional<double> & get_mutable_gamma() { return gamma; }
        void set_gamma(const std::optional<double> & value) { this->gamma = value; }

        const InterpolateParamsType & get_type() const { return type; }
        InterpolateParamsType & get_mutable_type() { return type; }
        void set_type(const InterpolateParamsType & value) { this->type = value; }
    };

    using InterpolateUnion = std::variant<InterpolateParams, Interpolate>;

    class NiceClass {
        public:
        NiceClass() = default;
        virtual ~NiceClass() = default;

        private:
        std::string interval;
        double step;

        public:
        const std::string & get_interval() const { return interval; }
        std::string & get_mutable_interval() { return interval; }
        void set_interval(const std::string & value) { this->interval = value; }

        const double & get_step() const { return step; }
        double & get_mutable_step() { return step; }
        void set_step(const double & value) { this->step = value; }
    };

    enum class NiceTime : int { SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, YEAR };

    using NiceUnion = std::variant<bool, NiceClass, double, NiceTime>;

    using ScaleRange = std::variant<std::vector<TitleFontWeight>, std::string>;

    class SchemeParams {
        public:
        SchemeParams() = default;
        virtual ~SchemeParams() = default;

        private:
        std::optional<std::vector<double>> extent;
        std::string name;

        public:
        /**
         * For sequential and diverging schemes only, determines the extent of the color range to
         * use. For example `[0.2, 1]` will rescale the color scheme such that color values in the
         * range _[0, 0.2)_ are excluded from the scheme.
         */
        const std::optional<std::vector<double>> & get_extent() const { return extent; }
        std::optional<std::vector<double>> & get_mutable_extent() { return extent; }
        void set_extent(const std::optional<std::vector<double>> & value) { this->extent = value; }

        /**
         * A color scheme name for sequential/ordinal scales (e.g., `"category10"` or `"viridis"`).
         *
         * For the full list of supported scheme, please refer to the [Vega
         * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
         */
        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string & value) { this->name = value; }
    };

    using Scheme = std::variant<SchemeParams, std::string>;

    /**
     * The type of scale.  Vega-Lite supports the following categories of scale types:
     *
     * 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
     * continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
     * [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
     * [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
     *
     * 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
     * ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
     * [`"point"`](scale.html#point)) output ranges.
     *
     * 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
     * discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
     * [`"bin-ordinal"`](scale.html#bin-ordinal)).
     *
     * __Default value:__ please see the [scale type table](scale.html#type).
     */
    enum class ScaleType : int { LINEAR, BIN_LINEAR, LOG, POW, SQRT, TIME, UTC, SEQUENTIAL, ORDINAL, BIN_ORDINAL, POINT, BAND };

    /**
     * An object defining properties of the channel's scale, which is the function that
     * transforms values in the data domain (numbers, dates, strings, etc) to visual values
     * (pixels, colors, sizes) of the encoding channels.
     *
     * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
     */
    class Scale {
        public:
        Scale() :
            padding_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            padding_inner_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            padding_outer_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~Scale() = default;

        private:
        std::optional<double> base;
        std::optional<bool> clamp;
        std::optional<DomainUnion> domain;
        std::optional<double> exponent;
        std::optional<InterpolateUnion> interpolate;
        std::optional<NiceUnion> nice;
        std::optional<double> padding;
        ClassMemberConstraints padding_constraint;
        std::optional<double> padding_inner;
        ClassMemberConstraints padding_inner_constraint;
        std::optional<double> padding_outer;
        ClassMemberConstraints padding_outer_constraint;
        std::optional<ScaleRange> range;
        std::optional<double> range_step;
        std::optional<bool> round;
        std::optional<Scheme> scheme;
        std::optional<ScaleType> type;
        std::optional<bool> zero;

        public:
        /**
         * The logarithm base of the `log` scale (default `10`).
         */
        const std::optional<double> & get_base() const { return base; }
        std::optional<double> & get_mutable_base() { return base; }
        void set_base(const std::optional<double> & value) { this->base = value; }

        /**
         * If `true`, values that exceed the data domain are clamped to either the minimum or
         * maximum range value
         *
         * __Default value:__ derived from the [scale config](config.html#scale-config)'s `clamp`
         * (`true` by default).
         */
        const std::optional<bool> & get_clamp() const { return clamp; }
        std::optional<bool> & get_mutable_clamp() { return clamp; }
        void set_clamp(const std::optional<bool> & value) { this->clamp = value; }

        /**
         * Customized domain values.
         *
         * For _quantitative_ fields, `domain` can take the form of a two-element array with minimum
         * and maximum values.  [Piecewise scales](scale.html#piecewise) can be created by providing
         * a `domain` with more than two entries.
         * If the input field is aggregated, `domain` can also be a string value `"unaggregated"`,
         * indicating that the domain should include the raw data values prior to the aggregation.
         *
         * For _temporal_ fields, `domain` can be a two-element array minimum and maximum values, in
         * the form of either timestamps or the [DateTime definition objects](types.html#datetime).
         *
         * For _ordinal_ and _nominal_ fields, `domain` can be an array that lists valid input
         * values.
         *
         * The `selection` property can be used to [interactively
         * determine](selection.html#scale-domains) the scale domain.
         */
        const std::optional<DomainUnion> & get_domain() const { return domain; }
        std::optional<DomainUnion> & get_mutable_domain() { return domain; }
        void set_domain(const std::optional<DomainUnion> & value) { this->domain = value; }

        /**
         * The exponent of the `pow` scale.
         */
        const std::optional<double> & get_exponent() const { return exponent; }
        std::optional<double> & get_mutable_exponent() { return exponent; }
        void set_exponent(const std::optional<double> & value) { this->exponent = value; }

        /**
         * The interpolation method for range values. By default, a general interpolator for
         * numbers, dates, strings and colors (in RGB space) is used. For color ranges, this
         * property allows interpolation in alternative color spaces. Legal values include `rgb`,
         * `hsl`, `hsl-long`, `lab`, `hcl`, `hcl-long`, `cubehelix` and `cubehelix-long` ('-long'
         * variants use longer paths in polar coordinate spaces). If object-valued, this property
         * accepts an object with a string-valued _type_ property and an optional numeric _gamma_
         * property applicable to rgb and cubehelix interpolators. For more, see the [d3-interpolate
         * documentation](https://github.com/d3/d3-interpolate).
         *
         * __Note:__ Sequential scales do not support `interpolate` as they have a fixed
         * interpolator.  Since Vega-Lite uses sequential scales for quantitative fields by default,
         * you have to set the scale `type` to other quantitative scale type such as `"linear"` to
         * customize `interpolate`.
         */
        const std::optional<InterpolateUnion> & get_interpolate() const { return interpolate; }
        std::optional<InterpolateUnion> & get_mutable_interpolate() { return interpolate; }
        void set_interpolate(const std::optional<InterpolateUnion> & value) { this->interpolate = value; }

        /**
         * Extending the domain so that it starts and ends on nice round values. This method
         * typically modifies the scale’s domain, and may only extend the bounds to the nearest
         * round value. Nicing is useful if the domain is computed from data and may be irregular.
         * For example, for a domain of _[0.201479…, 0.996679…]_, a nice domain might be _[0.2,
         * 1.0]_.
         *
         * For quantitative scales such as linear, `nice` can be either a boolean flag or a number.
         * If `nice` is a number, it will represent a desired tick count. This allows greater
         * control over the step size used to extend the bounds, guaranteeing that the returned
         * ticks will exactly cover the domain.
         *
         * For temporal fields with time and utc scales, the `nice` value can be a string indicating
         * the desired time interval. Legal values are `"millisecond"`, `"second"`, `"minute"`,
         * `"hour"`, `"day"`, `"week"`, `"month"`, and `"year"`. Alternatively, `time` and `utc`
         * scales can accept an object-valued interval specifier of the form `{"interval": "month",
         * "step": 3}`, which includes a desired number of interval steps. Here, the domain would
         * snap to quarter (Jan, Apr, Jul, Oct) boundaries.
         *
         * __Default value:__ `true` for unbinned _quantitative_ fields; `false` otherwise.
         */
        const std::optional<NiceUnion> & get_nice() const { return nice; }
        std::optional<NiceUnion> & get_mutable_nice() { return nice; }
        void set_nice(const std::optional<NiceUnion> & value) { this->nice = value; }

        /**
         * For _[continuous](scale.html#continuous)_ scales, expands the scale domain to accommodate
         * the specified number of pixels on each of the scale range. The scale range must represent
         * pixels for this parameter to function as intended. Padding adjustment is performed prior
         * to all other adjustments, including the effects of the zero, nice, domainMin, and
         * domainMax properties.
         *
         * For _[band](scale.html#band)_ scales, shortcut for setting `paddingInner` and
         * `paddingOuter` to the same value.
         *
         * For _[point](scale.html#point)_ scales, alias for `paddingOuter`.
         *
         * __Default value:__ For _continuous_ scales, derived from the [scale
         * config](scale.html#config)'s `continuousPadding`.
         * For _band and point_ scales, see `paddingInner` and `paddingOuter`.
         */
        const std::optional<double> & get_padding() const { return padding; }
        std::optional<double> & get_mutable_padding() { return padding; }
        void set_padding(const std::optional<double> & value) { CheckConstraint("padding", padding_constraint, value); this->padding = value; }

        /**
         * The inner padding (spacing) within each band step of band scales, as a fraction of the
         * step size. This value must lie in the range [0,1].
         *
         * For point scale, this property is invalid as point scales do not have internal band
         * widths (only step sizes between bands).
         *
         * __Default value:__ derived from the [scale config](scale.html#config)'s
         * `bandPaddingInner`.
         */
        const std::optional<double> & get_padding_inner() const { return padding_inner; }
        std::optional<double> & get_mutable_padding_inner() { return padding_inner; }
        void set_padding_inner(const std::optional<double> & value) { CheckConstraint("padding_inner", padding_inner_constraint, value); this->padding_inner = value; }

        /**
         * The outer padding (spacing) at the ends of the range of band and point scales,
         * as a fraction of the step size. This value must lie in the range [0,1].
         *
         * __Default value:__ derived from the [scale config](scale.html#config)'s
         * `bandPaddingOuter` for band scales and `pointPadding` for point scales.
         */
        const std::optional<double> & get_padding_outer() const { return padding_outer; }
        std::optional<double> & get_mutable_padding_outer() { return padding_outer; }
        void set_padding_outer(const std::optional<double> & value) { CheckConstraint("padding_outer", padding_outer_constraint, value); this->padding_outer = value; }

        /**
         * The range of the scale. One of:
         *
         * - A string indicating a [pre-defined named scale range](scale.html#range-config) (e.g.,
         * example, `"symbol"`, or `"diverging"`).
         *
         * - For [continuous scales](scale.html#continuous), two-element array indicating  minimum
         * and maximum values, or an array with more than two entries for specifying a [piecewise
         * scale](scale.html#piecewise).
         *
         * - For [discrete](scale.html#discrete) and [discretizing](scale.html#discretizing) scales,
         * an array of desired output values.
         *
         * __Notes:__
         *
         * 1) For [sequential](scale.html#sequential), [ordinal](scale.html#ordinal), and
         * discretizing color scales, you can also specify a color [`scheme`](scale.html#scheme)
         * instead of `range`.
         *
         * 2) Any directly specified `range` for `x` and `y` channels will be ignored. Range can be
         * customized via the view's corresponding [size](size.html) (`width` and `height`) or via
         * [range steps and paddings properties](#range-step) for [band](#band) and [point](#point)
         * scales.
         */
        const std::optional<ScaleRange> & get_range() const { return range; }
        std::optional<ScaleRange> & get_mutable_range() { return range; }
        void set_range(const std::optional<ScaleRange> & value) { this->range = value; }

        /**
         * The distance between the starts of adjacent bands or points in [band](scale.html#band)
         * and [point](scale.html#point) scales.
         *
         * If `rangeStep` is `null` or if the view contains the scale's corresponding
         * [size](size.html) (`width` for `x` scales and `height` for `y` scales), `rangeStep` will
         * be automatically determined to fit the size of the view.
         *
         * __Default value:__  derived the [scale config](config.html#scale-config)'s
         * `textXRangeStep` (`90` by default) for x-scales of `text` marks and `rangeStep` (`21` by
         * default) for x-scales of other marks and y-scales.
         *
         * __Warning__: If `rangeStep` is `null` and the cardinality of the scale's domain is higher
         * than `width` or `height`, the rangeStep might become less than one pixel and the mark
         * might not appear correctly.
         */
        std::optional<double> get_range_step() const { return range_step; }
        void set_range_step(std::optional<double> value) { this->range_step = value; }

        /**
         * If `true`, rounds numeric output values to integers. This can be helpful for snapping to
         * the pixel grid.
         *
         * __Default value:__ `false`.
         */
        const std::optional<bool> & get_round() const { return round; }
        std::optional<bool> & get_mutable_round() { return round; }
        void set_round(const std::optional<bool> & value) { this->round = value; }

        /**
         * A string indicating a color [scheme](scale.html#scheme) name (e.g., `"category10"` or
         * `"viridis"`) or a [scheme parameter object](scale.html#scheme-params).
         *
         * Discrete color schemes may be used with [discrete](scale.html#discrete) or
         * [discretizing](scale.html#discretizing) scales. Continuous color schemes are intended for
         * use with [sequential](scales.html#sequential) scales.
         *
         * For the full list of supported scheme, please refer to the [Vega
         * Scheme](https://vega.github.io/vega/docs/schemes/#reference) reference.
         */
        const std::optional<Scheme> & get_scheme() const { return scheme; }
        std::optional<Scheme> & get_mutable_scheme() { return scheme; }
        void set_scheme(const std::optional<Scheme> & value) { this->scheme = value; }

        /**
         * The type of scale.  Vega-Lite supports the following categories of scale types:
         *
         * 1) [**Continuous Scales**](scale.html#continuous) -- mapping continuous domains to
         * continuous output ranges ([`"linear"`](scale.html#linear), [`"pow"`](scale.html#pow),
         * [`"sqrt"`](scale.html#sqrt), [`"log"`](scale.html#log), [`"time"`](scale.html#time),
         * [`"utc"`](scale.html#utc), [`"sequential"`](scale.html#sequential)).
         *
         * 2) [**Discrete Scales**](scale.html#discrete) -- mapping discrete domains to discrete
         * ([`"ordinal"`](scale.html#ordinal)) or continuous ([`"band"`](scale.html#band) and
         * [`"point"`](scale.html#point)) output ranges.
         *
         * 3) [**Discretizing Scales**](scale.html#discretizing) -- mapping continuous domains to
         * discrete output ranges ([`"bin-linear"`](scale.html#bin-linear) and
         * [`"bin-ordinal"`](scale.html#bin-ordinal)).
         *
         * __Default value:__ please see the [scale type table](scale.html#type).
         */
        const std::optional<ScaleType> & get_type() const { return type; }
        std::optional<ScaleType> & get_mutable_type() { return type; }
        void set_type(const std::optional<ScaleType> & value) { this->type = value; }

        /**
         * If `true`, ensures that a zero baseline value is included in the scale domain.
         *
         * __Default value:__ `true` for x and y channels if the quantitative field is not binned
         * and no custom `domain` is provided; `false` otherwise.
         *
         * __Note:__ Log, time, and utc scales do not support `zero`.
         */
        const std::optional<bool> & get_zero() const { return zero; }
        std::optional<bool> & get_mutable_zero() { return zero; }
        void set_zero(const std::optional<bool> & value) { this->zero = value; }
    };

    enum class SortEnum : int { ASCENDING, DESCENDING };

    class SortField {
        public:
        SortField() = default;
        virtual ~SortField() = default;

        private:
        std::optional<Field> field;
        AggregateOp op;
        std::optional<SortEnum> order;

        public:
        /**
         * The data [field](field.html) to sort by.
         *
         * __Default value:__ If unspecified, defaults to the field specified in the outer data
         * reference.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * An [aggregate operation](aggregate.html#ops) to perform on the field prior to sorting
         * (e.g., `"count"`, `"mean"` and `"median"`).
         * This property is required in cases where the sort field and the data reference field do
         * not match.
         * The input data objects will be aggregated, grouped by the encoded data field.
         *
         * For a full list of operations, please see the documentation for
         * [aggregate](aggregate.html#ops).
         */
        const AggregateOp & get_op() const { return op; }
        AggregateOp & get_mutable_op() { return op; }
        void set_op(const AggregateOp & value) { this->op = value; }

        /**
         * The sort order. One of `"ascending"` (default) or `"descending"`.
         */
        std::optional<SortEnum> get_order() const { return order; }
        void set_order(std::optional<SortEnum> value) { this->order = value; }
    };

    using SortUnion = std::optional<std::variant<SortField, SortEnum>>;

    /**
     * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
     * `"nominal"`).
     * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
     * [geographic projection](projection.html) is applied.
     *
     * Constants and utilities for data type
     * Data type based on level of measurement
     */
    enum class Type : int { QUANTITATIVE, ORDINAL, TEMPORAL, NOMINAL, LATITUDE, LONGITUDE, GEOJSON };

    class ConditionalPredicateMarkPropFieldDefClass {
        public:
        ConditionalPredicateMarkPropFieldDefClass() = default;
        virtual ~ConditionalPredicateMarkPropFieldDefClass() = default;

        private:
        std::shared_ptr<LogicalOperandPredicate> test;
        std::optional<ConditionalValueDefValue> value;
        std::shared_ptr<SelectionOperand> selection;
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<Field> field;
        std::optional<Legend> legend;
        std::optional<Scale> scale;
        SortUnion sort;
        std::optional<TimeUnit> time_unit;
        std::optional<Type> type;

        public:
        const std::shared_ptr<LogicalOperandPredicate> & get_test() const { return test; }
        std::shared_ptr<LogicalOperandPredicate> & get_mutable_test() { return test; }
        void set_test(const std::shared_ptr<LogicalOperandPredicate> & value) { this->test = value; }

        /**
         * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
         * `0` to `1` for opacity).
         */
        const std::optional<ConditionalValueDefValue> & get_value() const { return value; }
        std::optional<ConditionalValueDefValue> & get_mutable_value() { return value; }
        void set_value(const std::optional<ConditionalValueDefValue> & value) { this->value = value; }

        /**
         * A [selection name](selection.html), or a series of [composed
         * selections](selection.html#compose).
         */
        const std::shared_ptr<SelectionOperand> & get_selection() const { return selection; }
        std::shared_ptr<SelectionOperand> & get_mutable_selection() { return selection; }
        void set_selection(const std::shared_ptr<SelectionOperand> & value) { this->selection = value; }

        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * An object defining properties of the legend.
         * If `null`, the legend for the encoding channel will be removed.
         *
         * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
         */
        std::optional<Legend> get_legend() const { return legend; }
        void set_legend(std::optional<Legend> value) { this->legend = value; }

        /**
         * An object defining properties of the channel's scale, which is the function that
         * transforms values in the data domain (numbers, dates, strings, etc) to visual values
         * (pixels, colors, sizes) of the encoding channels.
         *
         * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
         */
        const std::optional<Scale> & get_scale() const { return scale; }
        std::optional<Scale> & get_mutable_scale() { return scale; }
        void set_scale(const std::optional<Scale> & value) { this->scale = value; }

        /**
         * Sort order for the encoded field.
         * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
         * For fields with discrete domains, `sort` can also be a [sort field definition
         * object](sort.html#sort-field).
         *
         * __Default value:__ `"ascending"`
         */
        SortUnion get_sort() const { return sort; }
        void set_sort(SortUnion value) { this->sort = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const std::optional<Type> & get_type() const { return type; }
        std::optional<Type> & get_mutable_type() { return type; }
        void set_type(const std::optional<Type> & value) { this->type = value; }
    };

    using ColorCondition = std::variant<std::vector<ConditionalValueDef>, ConditionalPredicateMarkPropFieldDefClass>;

    /**
     * Color of the marks – either fill or stroke color based on mark type.
     * By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
     * `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
     *
     * __Default value:__ If undefined, the default color depends on [mark
     * config](config.html#mark)'s `color` property.
     *
     * _Note:_ See the scale documentation for more information about customizing [color
     * scheme](scale.html#scheme).
     *
     * Opacity of the marks – either can be a value or a range.
     *
     * __Default value:__ If undefined, the default opacity depends on [mark
     * config](config.html#mark)'s `opacity` property.
     *
     * For `point` marks the supported values are
     * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
     * or `"triangle-down"`, or else a custom SVG path string.
     * For `geoshape` marks it should be a field definition of the geojson data
     *
     * __Default value:__ If undefined, the default shape depends on [mark
     * config](config.html#point-config)'s `shape` property.
     *
     * Size of the mark.
     * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
     * - For `"bar"` and `"tick"` – the bar and tick's size.
     * - For `"text"` – the text's font size.
     * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
     *
     * A FieldDef with Condition<ValueDef>
     * {
     * condition: {value: ...},
     * field: ...,
     * ...
     * }
     *
     * A ValueDef with Condition<ValueDef | FieldDef>
     * {
     * condition: {field: ...} | {value: ...},
     * value: ...,
     * }
     */
    class MarkPropDefWithCondition {
        public:
        MarkPropDefWithCondition() = default;
        virtual ~MarkPropDefWithCondition() = default;

        private:
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<ColorCondition> condition;
        std::optional<Field> field;
        std::optional<Legend> legend;
        std::optional<Scale> scale;
        SortUnion sort;
        std::optional<TimeUnit> time_unit;
        std::optional<Type> type;
        std::optional<ConditionalValueDefValue> value;

        public:
        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * One or more value definition(s) with a selection predicate.
         *
         * __Note:__ A field definition's `condition` property can only contain [value
         * definitions](encoding.html#value-def)
         * since Vega-Lite only allows at most one encoded field per encoding channel.
         *
         * A field definition or one or more value definition(s) with a selection predicate.
         */
        const std::optional<ColorCondition> & get_condition() const { return condition; }
        std::optional<ColorCondition> & get_mutable_condition() { return condition; }
        void set_condition(const std::optional<ColorCondition> & value) { this->condition = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * An object defining properties of the legend.
         * If `null`, the legend for the encoding channel will be removed.
         *
         * __Default value:__ If undefined, default [legend properties](legend.html) are applied.
         */
        std::optional<Legend> get_legend() const { return legend; }
        void set_legend(std::optional<Legend> value) { this->legend = value; }

        /**
         * An object defining properties of the channel's scale, which is the function that
         * transforms values in the data domain (numbers, dates, strings, etc) to visual values
         * (pixels, colors, sizes) of the encoding channels.
         *
         * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
         */
        const std::optional<Scale> & get_scale() const { return scale; }
        std::optional<Scale> & get_mutable_scale() { return scale; }
        void set_scale(const std::optional<Scale> & value) { this->scale = value; }

        /**
         * Sort order for the encoded field.
         * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
         * For fields with discrete domains, `sort` can also be a [sort field definition
         * object](sort.html#sort-field).
         *
         * __Default value:__ `"ascending"`
         */
        SortUnion get_sort() const { return sort; }
        void set_sort(SortUnion value) { this->sort = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const std::optional<Type> & get_type() const { return type; }
        std::optional<Type> & get_mutable_type() { return type; }
        void set_type(const std::optional<Type> & value) { this->type = value; }

        /**
         * A constant value in visual domain.
         */
        const std::optional<ConditionalValueDefValue> & get_value() const { return value; }
        std::optional<ConditionalValueDefValue> & get_mutable_value() { return value; }
        void set_value(const std::optional<ConditionalValueDefValue> & value) { this->value = value; }
    };

    /**
     * An object defining properties of a facet's header.
     *
     * Headers of row / column channels for faceted plots.
     */
    class Header {
        public:
        Header() :
            label_angle_constraint(std::nullopt, std::nullopt, -360, 360, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~Header() = default;

        private:
        std::optional<std::string> format;
        std::optional<double> label_angle;
        ClassMemberConstraints label_angle_constraint;
        std::optional<std::string> title;

        public:
        /**
         * The formatting pattern for labels. This is D3's [number format
         * pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
         * [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
         * field.
         *
         * See the [format documentation](format.html) for more information.
         *
         * __Default value:__  derived from [numberFormat](config.html#format) config for
         * quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
         */
        const std::optional<std::string> & get_format() const { return format; }
        std::optional<std::string> & get_mutable_format() { return format; }
        void set_format(const std::optional<std::string> & value) { this->format = value; }

        /**
         * The rotation angle of the header labels.
         *
         * __Default value:__ `0`.
         */
        const std::optional<double> & get_label_angle() const { return label_angle; }
        std::optional<double> & get_mutable_label_angle() { return label_angle; }
        void set_label_angle(const std::optional<double> & value) { CheckConstraint("label_angle", label_angle_constraint, value); this->label_angle = value; }

        /**
         * A title for the field. If `null`, the title will be removed.
         *
         * __Default value:__  derived from the field's name and transformation function
         * (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
         * function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
         * binned or has a time unit applied, the applied function will be denoted in parentheses
         * (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
         * simply the field name.
         *
         * __Note__: You can customize the default field title format by providing the [`fieldTitle`
         * property in the [config](config.html) or [`fieldTitle` function via the `compile`
         * function's options](compile.html#field-title).
         */
        std::optional<std::string> get_title() const { return title; }
        void set_title(std::optional<std::string> value) { this->title = value; }
    };

    /**
     * Horizontal facets for trellis plots.
     *
     * Vertical facets for trellis plots.
     */
    class FacetFieldDef {
        public:
        FacetFieldDef() = default;
        virtual ~FacetFieldDef() = default;

        private:
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<Field> field;
        std::optional<Header> header;
        std::optional<SortEnum> sort;
        std::optional<TimeUnit> time_unit;
        Type type;

        public:
        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * An object defining properties of a facet's header.
         */
        const std::optional<Header> & get_header() const { return header; }
        std::optional<Header> & get_mutable_header() { return header; }
        void set_header(const std::optional<Header> & value) { this->header = value; }

        /**
         * Sort order for a facet field.
         * This can be `"ascending"`, `"descending"`.
         */
        std::optional<SortEnum> get_sort() const { return sort; }
        void set_sort(std::optional<SortEnum> value) { this->sort = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };

    /**
     * Definition object for a data field, its type and transformation of an encoding channel.
     */
    class FieldDef {
        public:
        FieldDef() = default;
        virtual ~FieldDef() = default;

        private:
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<Field> field;
        std::optional<TimeUnit> time_unit;
        Type type;

        public:
        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };

    using Detail = std::variant<std::vector<FieldDef>, FieldDef>;

    class ConditionalPredicateFieldDefClass {
        public:
        ConditionalPredicateFieldDefClass() = default;
        virtual ~ConditionalPredicateFieldDefClass() = default;

        private:
        std::shared_ptr<LogicalOperandPredicate> test;
        std::optional<ConditionalValueDefValue> value;
        std::shared_ptr<SelectionOperand> selection;
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<Field> field;
        std::optional<TimeUnit> time_unit;
        std::optional<Type> type;

        public:
        const std::shared_ptr<LogicalOperandPredicate> & get_test() const { return test; }
        std::shared_ptr<LogicalOperandPredicate> & get_mutable_test() { return test; }
        void set_test(const std::shared_ptr<LogicalOperandPredicate> & value) { this->test = value; }

        /**
         * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
         * `0` to `1` for opacity).
         */
        const std::optional<ConditionalValueDefValue> & get_value() const { return value; }
        std::optional<ConditionalValueDefValue> & get_mutable_value() { return value; }
        void set_value(const std::optional<ConditionalValueDefValue> & value) { this->value = value; }

        /**
         * A [selection name](selection.html), or a series of [composed
         * selections](selection.html#compose).
         */
        const std::shared_ptr<SelectionOperand> & get_selection() const { return selection; }
        std::shared_ptr<SelectionOperand> & get_mutable_selection() { return selection; }
        void set_selection(const std::shared_ptr<SelectionOperand> & value) { this->selection = value; }

        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const std::optional<Type> & get_type() const { return type; }
        std::optional<Type> & get_mutable_type() { return type; }
        void set_type(const std::optional<Type> & value) { this->type = value; }
    };

    using HrefCondition = std::variant<std::vector<ConditionalValueDef>, ConditionalPredicateFieldDefClass>;

    /**
     * A URL to load upon mouse click.
     *
     * A FieldDef with Condition<ValueDef>
     * {
     * condition: {value: ...},
     * field: ...,
     * ...
     * }
     *
     * A ValueDef with Condition<ValueDef | FieldDef>
     * {
     * condition: {field: ...} | {value: ...},
     * value: ...,
     * }
     */
    class DefWithCondition {
        public:
        DefWithCondition() = default;
        virtual ~DefWithCondition() = default;

        private:
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<HrefCondition> condition;
        std::optional<Field> field;
        std::optional<TimeUnit> time_unit;
        std::optional<Type> type;
        std::optional<ConditionalValueDefValue> value;

        public:
        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * One or more value definition(s) with a selection predicate.
         *
         * __Note:__ A field definition's `condition` property can only contain [value
         * definitions](encoding.html#value-def)
         * since Vega-Lite only allows at most one encoded field per encoding channel.
         *
         * A field definition or one or more value definition(s) with a selection predicate.
         */
        const std::optional<HrefCondition> & get_condition() const { return condition; }
        std::optional<HrefCondition> & get_mutable_condition() { return condition; }
        void set_condition(const std::optional<HrefCondition> & value) { this->condition = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const std::optional<Type> & get_type() const { return type; }
        std::optional<Type> & get_mutable_type() { return type; }
        void set_type(const std::optional<Type> & value) { this->type = value; }

        /**
         * A constant value in visual domain.
         */
        const std::optional<ConditionalValueDefValue> & get_value() const { return value; }
        std::optional<ConditionalValueDefValue> & get_mutable_value() { return value; }
        void set_value(const std::optional<ConditionalValueDefValue> & value) { this->value = value; }
    };

    class OrderFieldDef {
        public:
        OrderFieldDef() = default;
        virtual ~OrderFieldDef() = default;

        private:
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<Field> field;
        std::optional<SortEnum> sort;
        std::optional<TimeUnit> time_unit;
        Type type;

        public:
        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * The sort order. One of `"ascending"` (default) or `"descending"`.
         */
        std::optional<SortEnum> get_sort() const { return sort; }
        void set_sort(std::optional<SortEnum> value) { this->sort = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const Type & get_type() const { return type; }
        Type & get_mutable_type() { return type; }
        void set_type(const Type & value) { this->type = value; }
    };

    using Order = std::variant<std::vector<OrderFieldDef>, OrderFieldDef>;

    class ConditionalPredicateTextFieldDefClass {
        public:
        ConditionalPredicateTextFieldDefClass() = default;
        virtual ~ConditionalPredicateTextFieldDefClass() = default;

        private:
        std::shared_ptr<LogicalOperandPredicate> test;
        std::optional<ConditionalValueDefValue> value;
        std::shared_ptr<SelectionOperand> selection;
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<Field> field;
        std::optional<std::string> format;
        std::optional<TimeUnit> time_unit;
        std::optional<Type> type;

        public:
        const std::shared_ptr<LogicalOperandPredicate> & get_test() const { return test; }
        std::shared_ptr<LogicalOperandPredicate> & get_mutable_test() { return test; }
        void set_test(const std::shared_ptr<LogicalOperandPredicate> & value) { this->test = value; }

        /**
         * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
         * `0` to `1` for opacity).
         */
        const std::optional<ConditionalValueDefValue> & get_value() const { return value; }
        std::optional<ConditionalValueDefValue> & get_mutable_value() { return value; }
        void set_value(const std::optional<ConditionalValueDefValue> & value) { this->value = value; }

        /**
         * A [selection name](selection.html), or a series of [composed
         * selections](selection.html#compose).
         */
        const std::shared_ptr<SelectionOperand> & get_selection() const { return selection; }
        std::shared_ptr<SelectionOperand> & get_mutable_selection() { return selection; }
        void set_selection(const std::shared_ptr<SelectionOperand> & value) { this->selection = value; }

        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * The [formatting pattern](format.html) for a text field. If not defined, this will be
         * determined automatically.
         */
        const std::optional<std::string> & get_format() const { return format; }
        std::optional<std::string> & get_mutable_format() { return format; }
        void set_format(const std::optional<std::string> & value) { this->format = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const std::optional<Type> & get_type() const { return type; }
        std::optional<Type> & get_mutable_type() { return type; }
        void set_type(const std::optional<Type> & value) { this->type = value; }
    };

    using TextCondition = std::variant<std::vector<ConditionalValueDef>, ConditionalPredicateTextFieldDefClass>;

    /**
     * Text of the `text` mark.
     *
     * The tooltip text to show upon mouse hover.
     *
     * A FieldDef with Condition<ValueDef>
     * {
     * condition: {value: ...},
     * field: ...,
     * ...
     * }
     *
     * A ValueDef with Condition<ValueDef | FieldDef>
     * {
     * condition: {field: ...} | {value: ...},
     * value: ...,
     * }
     */
    class TextDefWithCondition {
        public:
        TextDefWithCondition() = default;
        virtual ~TextDefWithCondition() = default;

        private:
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<TextCondition> condition;
        std::optional<Field> field;
        std::optional<std::string> format;
        std::optional<TimeUnit> time_unit;
        std::optional<Type> type;
        std::optional<ConditionalValueDefValue> value;

        public:
        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * One or more value definition(s) with a selection predicate.
         *
         * __Note:__ A field definition's `condition` property can only contain [value
         * definitions](encoding.html#value-def)
         * since Vega-Lite only allows at most one encoded field per encoding channel.
         *
         * A field definition or one or more value definition(s) with a selection predicate.
         */
        const std::optional<TextCondition> & get_condition() const { return condition; }
        std::optional<TextCondition> & get_mutable_condition() { return condition; }
        void set_condition(const std::optional<TextCondition> & value) { this->condition = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * The [formatting pattern](format.html) for a text field. If not defined, this will be
         * determined automatically.
         */
        const std::optional<std::string> & get_format() const { return format; }
        std::optional<std::string> & get_mutable_format() { return format; }
        void set_format(const std::optional<std::string> & value) { this->format = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const std::optional<Type> & get_type() const { return type; }
        std::optional<Type> & get_mutable_type() { return type; }
        void set_type(const std::optional<Type> & value) { this->type = value; }

        /**
         * A constant value in visual domain.
         */
        const std::optional<ConditionalValueDefValue> & get_value() const { return value; }
        std::optional<ConditionalValueDefValue> & get_mutable_value() { return value; }
        void set_value(const std::optional<ConditionalValueDefValue> & value) { this->value = value; }
    };

    using AxisValue = std::variant<DateTime, double>;

    class Axis {
        public:
        Axis() :
            label_angle_constraint(std::nullopt, std::nullopt, -360, 360, std::nullopt, std::nullopt, std::nullopt),
            tick_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            zindex_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~Axis() = default;

        private:
        std::optional<bool> domain;
        std::optional<std::string> format;
        std::optional<bool> grid;
        std::optional<double> label_angle;
        ClassMemberConstraints label_angle_constraint;
        std::optional<Label> label_bound;
        std::optional<Label> label_flush;
        std::optional<LabelOverlapUnion> label_overlap;
        std::optional<double> label_padding;
        std::optional<bool> labels;
        std::optional<double> max_extent;
        std::optional<double> min_extent;
        std::optional<double> offset;
        std::optional<TitleOrient> orient;
        std::optional<double> position;
        std::optional<double> tick_count;
        std::optional<bool> ticks;
        std::optional<double> tick_size;
        ClassMemberConstraints tick_size_constraint;
        std::optional<std::string> title;
        std::optional<double> title_max_length;
        std::optional<double> title_padding;
        std::optional<std::vector<AxisValue>> values;
        std::optional<double> zindex;
        ClassMemberConstraints zindex_constraint;

        public:
        /**
         * A boolean flag indicating if the domain (the axis baseline) should be included as part of
         * the axis.
         *
         * __Default value:__ `true`
         */
        const std::optional<bool> & get_domain() const { return domain; }
        std::optional<bool> & get_mutable_domain() { return domain; }
        void set_domain(const std::optional<bool> & value) { this->domain = value; }

        /**
         * The formatting pattern for labels. This is D3's [number format
         * pattern](https://github.com/d3/d3-format#locale_format) for quantitative fields and D3's
         * [time format pattern](https://github.com/d3/d3-time-format#locale_format) for time
         * field.
         *
         * See the [format documentation](format.html) for more information.
         *
         * __Default value:__  derived from [numberFormat](config.html#format) config for
         * quantitative fields and from [timeFormat](config.html#format) config for temporal fields.
         */
        const std::optional<std::string> & get_format() const { return format; }
        std::optional<std::string> & get_mutable_format() { return format; }
        void set_format(const std::optional<std::string> & value) { this->format = value; }

        /**
         * A boolean flag indicating if grid lines should be included as part of the axis
         *
         * __Default value:__ `true` for [continuous scales](scale.html#continuous) that are not
         * binned; otherwise, `false`.
         */
        const std::optional<bool> & get_grid() const { return grid; }
        std::optional<bool> & get_mutable_grid() { return grid; }
        void set_grid(const std::optional<bool> & value) { this->grid = value; }

        /**
         * The rotation angle of the axis labels.
         *
         * __Default value:__ `-90` for nominal and ordinal fields; `0` otherwise.
         */
        const std::optional<double> & get_label_angle() const { return label_angle; }
        std::optional<double> & get_mutable_label_angle() { return label_angle; }
        void set_label_angle(const std::optional<double> & value) { CheckConstraint("label_angle", label_angle_constraint, value); this->label_angle = value; }

        /**
         * Indicates if labels should be hidden if they exceed the axis range. If `false `(the
         * default) no bounds overlap analysis is performed. If `true`, labels will be hidden if
         * they exceed the axis range by more than 1 pixel. If this property is a number, it
         * specifies the pixel tolerance: the maximum amount by which a label bounding box may
         * exceed the axis range.
         *
         * __Default value:__ `false`.
         */
        const std::optional<Label> & get_label_bound() const { return label_bound; }
        std::optional<Label> & get_mutable_label_bound() { return label_bound; }
        void set_label_bound(const std::optional<Label> & value) { this->label_bound = value; }

        /**
         * Indicates if the first and last axis labels should be aligned flush with the scale range.
         * Flush alignment for a horizontal axis will left-align the first label and right-align the
         * last label. For vertical axes, bottom and top text baselines are applied instead. If this
         * property is a number, it also indicates the number of pixels by which to offset the first
         * and last labels; for example, a value of 2 will flush-align the first and last labels and
         * also push them 2 pixels outward from the center of the axis. The additional adjustment
         * can sometimes help the labels better visually group with corresponding axis ticks.
         *
         * __Default value:__ `true` for axis of a continuous x-scale. Otherwise, `false`.
         */
        const std::optional<Label> & get_label_flush() const { return label_flush; }
        std::optional<Label> & get_mutable_label_flush() { return label_flush; }
        void set_label_flush(const std::optional<Label> & value) { this->label_flush = value; }

        /**
         * The strategy to use for resolving overlap of axis labels. If `false` (the default), no
         * overlap reduction is attempted. If set to `true` or `"parity"`, a strategy of removing
         * every other label is used (this works well for standard linear axes). If set to
         * `"greedy"`, a linear scan of the labels is performed, removing any labels that overlaps
         * with the last visible label (this often works better for log-scaled axes).
         *
         * __Default value:__ `true` for non-nominal fields with non-log scales; `"greedy"` for log
         * scales; otherwise `false`.
         */
        const std::optional<LabelOverlapUnion> & get_label_overlap() const { return label_overlap; }
        std::optional<LabelOverlapUnion> & get_mutable_label_overlap() { return label_overlap; }
        void set_label_overlap(const std::optional<LabelOverlapUnion> & value) { this->label_overlap = value; }

        /**
         * The padding, in pixels, between axis and text labels.
         */
        const std::optional<double> & get_label_padding() const { return label_padding; }
        std::optional<double> & get_mutable_label_padding() { return label_padding; }
        void set_label_padding(const std::optional<double> & value) { this->label_padding = value; }

        /**
         * A boolean flag indicating if labels should be included as part of the axis.
         *
         * __Default value:__  `true`.
         */
        const std::optional<bool> & get_labels() const { return labels; }
        std::optional<bool> & get_mutable_labels() { return labels; }
        void set_labels(const std::optional<bool> & value) { this->labels = value; }

        /**
         * The maximum extent in pixels that axis ticks and labels should use. This determines a
         * maximum offset value for axis titles.
         *
         * __Default value:__ `undefined`.
         */
        const std::optional<double> & get_max_extent() const { return max_extent; }
        std::optional<double> & get_mutable_max_extent() { return max_extent; }
        void set_max_extent(const std::optional<double> & value) { this->max_extent = value; }

        /**
         * The minimum extent in pixels that axis ticks and labels should use. This determines a
         * minimum offset value for axis titles.
         *
         * __Default value:__ `30` for y-axis; `undefined` for x-axis.
         */
        const std::optional<double> & get_min_extent() const { return min_extent; }
        std::optional<double> & get_mutable_min_extent() { return min_extent; }
        void set_min_extent(const std::optional<double> & value) { this->min_extent = value; }

        /**
         * The offset, in pixels, by which to displace the axis from the edge of the enclosing group
         * or data rectangle.
         *
         * __Default value:__ derived from the [axis config](config.html#facet-scale-config)'s
         * `offset` (`0` by default)
         */
        const std::optional<double> & get_offset() const { return offset; }
        std::optional<double> & get_mutable_offset() { return offset; }
        void set_offset(const std::optional<double> & value) { this->offset = value; }

        /**
         * The orientation of the axis. One of `"top"`, `"bottom"`, `"left"` or `"right"`. The
         * orientation can be used to further specialize the axis type (e.g., a y axis oriented for
         * the right edge of the chart).
         *
         * __Default value:__ `"bottom"` for x-axes and `"left"` for y-axes.
         */
        const std::optional<TitleOrient> & get_orient() const { return orient; }
        std::optional<TitleOrient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<TitleOrient> & value) { this->orient = value; }

        /**
         * The anchor position of the axis in pixels. For x-axis with top or bottom orientation,
         * this sets the axis group x coordinate. For y-axis with left or right orientation, this
         * sets the axis group y coordinate.
         *
         * __Default value__: `0`
         */
        const std::optional<double> & get_position() const { return position; }
        std::optional<double> & get_mutable_position() { return position; }
        void set_position(const std::optional<double> & value) { this->position = value; }

        /**
         * A desired number of ticks, for axes visualizing quantitative scales. The resulting number
         * may be different so that values are "nice" (multiples of 2, 5, 10) and lie within the
         * underlying scale's range.
         */
        const std::optional<double> & get_tick_count() const { return tick_count; }
        std::optional<double> & get_mutable_tick_count() { return tick_count; }
        void set_tick_count(const std::optional<double> & value) { this->tick_count = value; }

        /**
         * Boolean value that determines whether the axis should include ticks.
         */
        const std::optional<bool> & get_ticks() const { return ticks; }
        std::optional<bool> & get_mutable_ticks() { return ticks; }
        void set_ticks(const std::optional<bool> & value) { this->ticks = value; }

        /**
         * The size in pixels of axis ticks.
         */
        const std::optional<double> & get_tick_size() const { return tick_size; }
        std::optional<double> & get_mutable_tick_size() { return tick_size; }
        void set_tick_size(const std::optional<double> & value) { CheckConstraint("tick_size", tick_size_constraint, value); this->tick_size = value; }

        /**
         * A title for the field. If `null`, the title will be removed.
         *
         * __Default value:__  derived from the field's name and transformation function
         * (`aggregate`, `bin` and `timeUnit`).  If the field has an aggregate function, the
         * function is displayed as a part of the title (e.g., `"Sum of Profit"`). If the field is
         * binned or has a time unit applied, the applied function will be denoted in parentheses
         * (e.g., `"Profit (binned)"`, `"Transaction Date (year-month)"`).  Otherwise, the title is
         * simply the field name.
         *
         * __Note__: You can customize the default field title format by providing the [`fieldTitle`
         * property in the [config](config.html) or [`fieldTitle` function via the `compile`
         * function's options](compile.html#field-title).
         */
        std::optional<std::string> get_title() const { return title; }
        void set_title(std::optional<std::string> value) { this->title = value; }

        /**
         * Max length for axis title if the title is automatically generated from the field's
         * description.
         */
        const std::optional<double> & get_title_max_length() const { return title_max_length; }
        std::optional<double> & get_mutable_title_max_length() { return title_max_length; }
        void set_title_max_length(const std::optional<double> & value) { this->title_max_length = value; }

        /**
         * The padding, in pixels, between title and axis.
         */
        const std::optional<double> & get_title_padding() const { return title_padding; }
        std::optional<double> & get_mutable_title_padding() { return title_padding; }
        void set_title_padding(const std::optional<double> & value) { this->title_padding = value; }

        /**
         * Explicitly set the visible axis tick values.
         */
        const std::optional<std::vector<AxisValue>> & get_values() const { return values; }
        std::optional<std::vector<AxisValue>> & get_mutable_values() { return values; }
        void set_values(const std::optional<std::vector<AxisValue>> & value) { this->values = value; }

        /**
         * A non-positive integer indicating z-index of the axis.
         * If zindex is 0, axes should be drawn behind all chart elements.
         * To put them in front, use `"zindex = 1"`.
         *
         * __Default value:__ `1` (in front of the marks) for actual axis and `0` (behind the marks)
         * for grids.
         */
        const std::optional<double> & get_zindex() const { return zindex; }
        std::optional<double> & get_mutable_zindex() { return zindex; }
        void set_zindex(const std::optional<double> & value) { CheckConstraint("zindex", zindex_constraint, value); this->zindex = value; }
    };

    /**
     * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
     *
     * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
     *
     * Definition object for a constant value of an encoding channel.
     */
    class XClass {
        public:
        XClass() = default;
        virtual ~XClass() = default;

        private:
        std::optional<AggregateOp> aggregate;
        std::optional<Axis> axis;
        std::optional<Bin> bin;
        std::optional<Field> field;
        std::optional<Scale> scale;
        SortUnion sort;
        std::optional<StackOffset> stack;
        std::optional<TimeUnit> time_unit;
        std::optional<Type> type;
        std::optional<ConditionalValueDefValue> value;

        public:
        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * An object defining properties of axis's gridlines, ticks and labels.
         * If `null`, the axis for the encoding channel will be removed.
         *
         * __Default value:__ If undefined, default [axis properties](axis.html) are applied.
         */
        std::optional<Axis> get_axis() const { return axis; }
        void set_axis(std::optional<Axis> value) { this->axis = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * An object defining properties of the channel's scale, which is the function that
         * transforms values in the data domain (numbers, dates, strings, etc) to visual values
         * (pixels, colors, sizes) of the encoding channels.
         *
         * __Default value:__ If undefined, default [scale properties](scale.html) are applied.
         */
        const std::optional<Scale> & get_scale() const { return scale; }
        std::optional<Scale> & get_mutable_scale() { return scale; }
        void set_scale(const std::optional<Scale> & value) { this->scale = value; }

        /**
         * Sort order for the encoded field.
         * Supported `sort` values include `"ascending"`, `"descending"` and `null` (no sorting).
         * For fields with discrete domains, `sort` can also be a [sort field definition
         * object](sort.html#sort-field).
         *
         * __Default value:__ `"ascending"`
         */
        SortUnion get_sort() const { return sort; }
        void set_sort(SortUnion value) { this->sort = value; }

        /**
         * Type of stacking offset if the field should be stacked.
         * `stack` is only applicable for `x` and `y` channels with continuous domains.
         * For example, `stack` of `y` can be used to customize stacking for a vertical bar chart.
         *
         * `stack` can be one of the following values:
         *
         * - `"zero"`: stacking with baseline offset at zero value of the scale (for creating
         * typical stacked [bar](stack.html#bar) and [area](stack.html#area) chart).
         * - `"normalize"` - stacking with normalized domain (for creating [normalized stacked bar
         * and area charts](stack.html#normalized). <br/>
         * - `"center"` - stacking with center baseline (for [streamgraph](stack.html#streamgraph)).
         * - `null` - No-stacking. This will produce layered [bar](stack.html#layered-bar-chart) and
         * area chart.
         *
         * __Default value:__ `zero` for plots with all of the following conditions are true:
         *
         * 1. The mark is `bar` or `area`;
         * 2. The stacked measure channel (x or y) has a linear scale;
         * 3. At least one of non-position channels mapped to an unaggregated field that is
         * different from x and y.  Otherwise, `null` by default.
         */
        std::optional<StackOffset> get_stack() const { return stack; }
        void set_stack(std::optional<StackOffset> value) { this->stack = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const std::optional<Type> & get_type() const { return type; }
        std::optional<Type> & get_mutable_type() { return type; }
        void set_type(const std::optional<Type> & value) { this->type = value; }

        /**
         * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
         * `0` to `1` for opacity).
         */
        const std::optional<ConditionalValueDefValue> & get_value() const { return value; }
        std::optional<ConditionalValueDefValue> & get_mutable_value() { return value; }
        void set_value(const std::optional<ConditionalValueDefValue> & value) { this->value = value; }
    };

    /**
     * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     *
     * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
     *
     * Definition object for a data field, its type and transformation of an encoding channel.
     *
     * Definition object for a constant value of an encoding channel.
     */
    class X2Class {
        public:
        X2Class() = default;
        virtual ~X2Class() = default;

        private:
        std::optional<AggregateOp> aggregate;
        std::optional<Bin> bin;
        std::optional<Field> field;
        std::optional<TimeUnit> time_unit;
        std::optional<Type> type;
        std::optional<ConditionalValueDefValue> value;

        public:
        /**
         * Aggregation function for the field
         * (e.g., `mean`, `sum`, `median`, `min`, `max`, `count`).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<AggregateOp> & get_aggregate() const { return aggregate; }
        std::optional<AggregateOp> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<AggregateOp> & value) { this->aggregate = value; }

        /**
         * A flag for binning a `quantitative` field, or [an object defining binning
         * parameters](bin.html#params).
         * If `true`, default [binning parameters](bin.html) will be applied.
         *
         * __Default value:__ `false`
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * __Required.__ A string defining the name of the field from which to pull a data value
         * or an object defining iterated values from the [`repeat`](repeat.html) operator.
         *
         * __Note:__ Dots (`.`) and brackets (`[` and `]`) can be used to access nested objects
         * (e.g., `"field": "foo.bar"` and `"field": "foo['bar']"`).
         * If field names contain dots or brackets but are not nested, you can use `\\` to escape
         * dots and brackets (e.g., `"a\\.b"` and `"a\\[0\\]"`).
         * See more details about escaping in the [field documentation](field.html).
         *
         * __Note:__ `field` is not required if `aggregate` is `count`.
         */
        const std::optional<Field> & get_field() const { return field; }
        std::optional<Field> & get_mutable_field() { return field; }
        void set_field(const std::optional<Field> & value) { this->field = value; }

        /**
         * Time unit (e.g., `year`, `yearmonth`, `month`, `hours`) for a temporal field.
         * or [a temporal field that gets casted as ordinal](type.html#cast).
         *
         * __Default value:__ `undefined` (None)
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * The encoded field's type of measurement (`"quantitative"`, `"temporal"`, `"ordinal"`, or
         * `"nominal"`).
         * It can also be a geo type (`"latitude"`, `"longitude"`, and `"geojson"`) when a
         * [geographic projection](projection.html) is applied.
         */
        const std::optional<Type> & get_type() const { return type; }
        std::optional<Type> & get_mutable_type() { return type; }
        void set_type(const std::optional<Type> & value) { this->type = value; }

        /**
         * A constant value in visual domain (e.g., `"red"` / "#0099ff" for color, values between
         * `0` to `1` for opacity).
         */
        const std::optional<ConditionalValueDefValue> & get_value() const { return value; }
        std::optional<ConditionalValueDefValue> & get_mutable_value() { return value; }
        void set_value(const std::optional<ConditionalValueDefValue> & value) { this->value = value; }
    };

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    class EncodingWithFacet {
        public:
        EncodingWithFacet() = default;
        virtual ~EncodingWithFacet() = default;

        private:
        std::optional<MarkPropDefWithCondition> color;
        std::optional<FacetFieldDef> column;
        std::optional<Detail> detail;
        std::optional<DefWithCondition> href;
        std::optional<MarkPropDefWithCondition> opacity;
        std::optional<Order> order;
        std::optional<FacetFieldDef> row;
        std::optional<MarkPropDefWithCondition> shape;
        std::optional<MarkPropDefWithCondition> size;
        std::optional<TextDefWithCondition> text;
        std::optional<TextDefWithCondition> tooltip;
        std::optional<XClass> x;
        std::optional<X2Class> x2;
        std::optional<XClass> y;
        std::optional<X2Class> y2;

        public:
        /**
         * Color of the marks – either fill or stroke color based on mark type.
         * By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
         * `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
         *
         * __Default value:__ If undefined, the default color depends on [mark
         * config](config.html#mark)'s `color` property.
         *
         * _Note:_ See the scale documentation for more information about customizing [color
         * scheme](scale.html#scheme).
         */
        const std::optional<MarkPropDefWithCondition> & get_color() const { return color; }
        std::optional<MarkPropDefWithCondition> & get_mutable_color() { return color; }
        void set_color(const std::optional<MarkPropDefWithCondition> & value) { this->color = value; }

        /**
         * Horizontal facets for trellis plots.
         */
        const std::optional<FacetFieldDef> & get_column() const { return column; }
        std::optional<FacetFieldDef> & get_mutable_column() { return column; }
        void set_column(const std::optional<FacetFieldDef> & value) { this->column = value; }

        /**
         * Additional levels of detail for grouping data in aggregate views and
         * in line and area marks without mapping data to a specific visual channel.
         */
        const std::optional<Detail> & get_detail() const { return detail; }
        std::optional<Detail> & get_mutable_detail() { return detail; }
        void set_detail(const std::optional<Detail> & value) { this->detail = value; }

        /**
         * A URL to load upon mouse click.
         */
        const std::optional<DefWithCondition> & get_href() const { return href; }
        std::optional<DefWithCondition> & get_mutable_href() { return href; }
        void set_href(const std::optional<DefWithCondition> & value) { this->href = value; }

        /**
         * Opacity of the marks – either can be a value or a range.
         *
         * __Default value:__ If undefined, the default opacity depends on [mark
         * config](config.html#mark)'s `opacity` property.
         */
        const std::optional<MarkPropDefWithCondition> & get_opacity() const { return opacity; }
        std::optional<MarkPropDefWithCondition> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<MarkPropDefWithCondition> & value) { this->opacity = value; }

        /**
         * Stack order for stacked marks or order of data points in line marks for connected scatter
         * plots.
         *
         * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
         * additional aggregation grouping.
         */
        const std::optional<Order> & get_order() const { return order; }
        std::optional<Order> & get_mutable_order() { return order; }
        void set_order(const std::optional<Order> & value) { this->order = value; }

        /**
         * Vertical facets for trellis plots.
         */
        const std::optional<FacetFieldDef> & get_row() const { return row; }
        std::optional<FacetFieldDef> & get_mutable_row() { return row; }
        void set_row(const std::optional<FacetFieldDef> & value) { this->row = value; }

        /**
         * For `point` marks the supported values are
         * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
         * or `"triangle-down"`, or else a custom SVG path string.
         * For `geoshape` marks it should be a field definition of the geojson data
         *
         * __Default value:__ If undefined, the default shape depends on [mark
         * config](config.html#point-config)'s `shape` property.
         */
        const std::optional<MarkPropDefWithCondition> & get_shape() const { return shape; }
        std::optional<MarkPropDefWithCondition> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<MarkPropDefWithCondition> & value) { this->shape = value; }

        /**
         * Size of the mark.
         * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
         * - For `"bar"` and `"tick"` – the bar and tick's size.
         * - For `"text"` – the text's font size.
         * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
         */
        const std::optional<MarkPropDefWithCondition> & get_size() const { return size; }
        std::optional<MarkPropDefWithCondition> & get_mutable_size() { return size; }
        void set_size(const std::optional<MarkPropDefWithCondition> & value) { this->size = value; }

        /**
         * Text of the `text` mark.
         */
        const std::optional<TextDefWithCondition> & get_text() const { return text; }
        std::optional<TextDefWithCondition> & get_mutable_text() { return text; }
        void set_text(const std::optional<TextDefWithCondition> & value) { this->text = value; }

        /**
         * The tooltip text to show upon mouse hover.
         */
        const std::optional<TextDefWithCondition> & get_tooltip() const { return tooltip; }
        std::optional<TextDefWithCondition> & get_mutable_tooltip() { return tooltip; }
        void set_tooltip(const std::optional<TextDefWithCondition> & value) { this->tooltip = value; }

        /**
         * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
         */
        const std::optional<XClass> & get_x() const { return x; }
        std::optional<XClass> & get_mutable_x() { return x; }
        void set_x(const std::optional<XClass> & value) { this->x = value; }

        /**
         * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
         */
        const std::optional<X2Class> & get_x2() const { return x2; }
        std::optional<X2Class> & get_mutable_x2() { return x2; }
        void set_x2(const std::optional<X2Class> & value) { this->x2 = value; }

        /**
         * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
         */
        const std::optional<XClass> & get_y() const { return y; }
        std::optional<XClass> & get_mutable_y() { return y; }
        void set_y(const std::optional<XClass> & value) { this->y = value; }

        /**
         * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
         */
        const std::optional<X2Class> & get_y2() const { return y2; }
        std::optional<X2Class> & get_mutable_y2() { return y2; }
        void set_y2(const std::optional<X2Class> & value) { this->y2 = value; }
    };

    /**
     * An object that describes mappings between `row` and `column` channels and their field
     * definitions.
     */
    class FacetMapping {
        public:
        FacetMapping() = default;
        virtual ~FacetMapping() = default;

        private:
        std::optional<FacetFieldDef> column;
        std::optional<FacetFieldDef> row;

        public:
        /**
         * Horizontal facets for trellis plots.
         */
        const std::optional<FacetFieldDef> & get_column() const { return column; }
        std::optional<FacetFieldDef> & get_mutable_column() { return column; }
        void set_column(const std::optional<FacetFieldDef> & value) { this->column = value; }

        /**
         * Vertical facets for trellis plots.
         */
        const std::optional<FacetFieldDef> & get_row() const { return row; }
        std::optional<FacetFieldDef> & get_mutable_row() { return row; }
        void set_row(const std::optional<FacetFieldDef> & value) { this->row = value; }
    };

    /**
     * A key-value mapping between encoding channels and definition of fields.
     */
    class Encoding {
        public:
        Encoding() = default;
        virtual ~Encoding() = default;

        private:
        std::optional<MarkPropDefWithCondition> color;
        std::optional<Detail> detail;
        std::optional<DefWithCondition> href;
        std::optional<MarkPropDefWithCondition> opacity;
        std::optional<Order> order;
        std::optional<MarkPropDefWithCondition> shape;
        std::optional<MarkPropDefWithCondition> size;
        std::optional<TextDefWithCondition> text;
        std::optional<TextDefWithCondition> tooltip;
        std::optional<XClass> x;
        std::optional<X2Class> x2;
        std::optional<XClass> y;
        std::optional<X2Class> y2;

        public:
        /**
         * Color of the marks – either fill or stroke color based on mark type.
         * By default, `color` represents fill color for `"area"`, `"bar"`, `"tick"`,
         * `"text"`, `"circle"`, and `"square"` / stroke color for `"line"` and `"point"`.
         *
         * __Default value:__ If undefined, the default color depends on [mark
         * config](config.html#mark)'s `color` property.
         *
         * _Note:_ See the scale documentation for more information about customizing [color
         * scheme](scale.html#scheme).
         */
        const std::optional<MarkPropDefWithCondition> & get_color() const { return color; }
        std::optional<MarkPropDefWithCondition> & get_mutable_color() { return color; }
        void set_color(const std::optional<MarkPropDefWithCondition> & value) { this->color = value; }

        /**
         * Additional levels of detail for grouping data in aggregate views and
         * in line and area marks without mapping data to a specific visual channel.
         */
        const std::optional<Detail> & get_detail() const { return detail; }
        std::optional<Detail> & get_mutable_detail() { return detail; }
        void set_detail(const std::optional<Detail> & value) { this->detail = value; }

        /**
         * A URL to load upon mouse click.
         */
        const std::optional<DefWithCondition> & get_href() const { return href; }
        std::optional<DefWithCondition> & get_mutable_href() { return href; }
        void set_href(const std::optional<DefWithCondition> & value) { this->href = value; }

        /**
         * Opacity of the marks – either can be a value or a range.
         *
         * __Default value:__ If undefined, the default opacity depends on [mark
         * config](config.html#mark)'s `opacity` property.
         */
        const std::optional<MarkPropDefWithCondition> & get_opacity() const { return opacity; }
        std::optional<MarkPropDefWithCondition> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<MarkPropDefWithCondition> & value) { this->opacity = value; }

        /**
         * Stack order for stacked marks or order of data points in line marks for connected scatter
         * plots.
         *
         * __Note__: In aggregate plots, `order` field should be `aggregate`d to avoid creating
         * additional aggregation grouping.
         */
        const std::optional<Order> & get_order() const { return order; }
        std::optional<Order> & get_mutable_order() { return order; }
        void set_order(const std::optional<Order> & value) { this->order = value; }

        /**
         * For `point` marks the supported values are
         * `"circle"` (default), `"square"`, `"cross"`, `"diamond"`, `"triangle-up"`,
         * or `"triangle-down"`, or else a custom SVG path string.
         * For `geoshape` marks it should be a field definition of the geojson data
         *
         * __Default value:__ If undefined, the default shape depends on [mark
         * config](config.html#point-config)'s `shape` property.
         */
        const std::optional<MarkPropDefWithCondition> & get_shape() const { return shape; }
        std::optional<MarkPropDefWithCondition> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<MarkPropDefWithCondition> & value) { this->shape = value; }

        /**
         * Size of the mark.
         * - For `"point"`, `"square"` and `"circle"`, – the symbol size, or pixel area of the mark.
         * - For `"bar"` and `"tick"` – the bar and tick's size.
         * - For `"text"` – the text's font size.
         * - Size is currently unsupported for `"line"`, `"area"`, and `"rect"`.
         */
        const std::optional<MarkPropDefWithCondition> & get_size() const { return size; }
        std::optional<MarkPropDefWithCondition> & get_mutable_size() { return size; }
        void set_size(const std::optional<MarkPropDefWithCondition> & value) { this->size = value; }

        /**
         * Text of the `text` mark.
         */
        const std::optional<TextDefWithCondition> & get_text() const { return text; }
        std::optional<TextDefWithCondition> & get_mutable_text() { return text; }
        void set_text(const std::optional<TextDefWithCondition> & value) { this->text = value; }

        /**
         * The tooltip text to show upon mouse hover.
         */
        const std::optional<TextDefWithCondition> & get_tooltip() const { return tooltip; }
        std::optional<TextDefWithCondition> & get_mutable_tooltip() { return tooltip; }
        void set_tooltip(const std::optional<TextDefWithCondition> & value) { this->tooltip = value; }

        /**
         * X coordinates of the marks, or width of horizontal `"bar"` and `"area"`.
         */
        const std::optional<XClass> & get_x() const { return x; }
        std::optional<XClass> & get_mutable_x() { return x; }
        void set_x(const std::optional<XClass> & value) { this->x = value; }

        /**
         * X2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
         */
        const std::optional<X2Class> & get_x2() const { return x2; }
        std::optional<X2Class> & get_mutable_x2() { return x2; }
        void set_x2(const std::optional<X2Class> & value) { this->x2 = value; }

        /**
         * Y coordinates of the marks, or height of vertical `"bar"` and `"area"`.
         */
        const std::optional<XClass> & get_y() const { return y; }
        std::optional<XClass> & get_mutable_y() { return y; }
        void set_y(const std::optional<XClass> & value) { this->y = value; }

        /**
         * Y2 coordinates for ranged  `"area"`, `"bar"`, `"rect"`, and  `"rule"`.
         */
        const std::optional<X2Class> & get_y2() const { return y2; }
        std::optional<X2Class> & get_mutable_y2() { return y2; }
        void set_y2(const std::optional<X2Class> & value) { this->y2 = value; }
    };

    using Style = std::variant<std::vector<std::string>, std::string>;

    /**
     * All types of primitive marks.
     *
     * The mark type.
     * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
     * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
     */
    enum class Mark : int { AREA, BAR, LINE, POINT, TEXT, TICK, RECT, RULE, CIRCLE, SQUARE, GEOSHAPE };

    class MarkDef {
        public:
        MarkDef() :
            angle_constraint(std::nullopt, std::nullopt, 0, 360, std::nullopt, std::nullopt, std::nullopt),
            fill_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            font_size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            radius_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            size_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            stroke_opacity_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt),
            stroke_width_constraint(std::nullopt, std::nullopt, 0, std::nullopt, std::nullopt, std::nullopt, std::nullopt),
            tension_constraint(std::nullopt, std::nullopt, 0, 1, std::nullopt, std::nullopt, std::nullopt)
        {}
        virtual ~MarkDef() = default;

        private:
        std::optional<HorizontalAlign> align;
        std::optional<double> angle;
        ClassMemberConstraints angle_constraint;
        std::optional<VerticalAlign> baseline;
        std::optional<bool> clip;
        std::optional<std::string> color;
        std::optional<Cursor> cursor;
        std::optional<double> dx;
        std::optional<double> dy;
        std::optional<std::string> fill;
        std::optional<bool> filled;
        std::optional<double> fill_opacity;
        ClassMemberConstraints fill_opacity_constraint;
        std::optional<std::string> font;
        std::optional<double> font_size;
        ClassMemberConstraints font_size_constraint;
        std::optional<FontStyle> font_style;
        std::optional<FontWeightUnion> font_weight;
        std::optional<std::string> href;
        std::optional<Interpolate> interpolate;
        std::optional<double> limit;
        std::optional<double> opacity;
        ClassMemberConstraints opacity_constraint;
        std::optional<Orient> orient;
        std::optional<double> radius;
        ClassMemberConstraints radius_constraint;
        std::optional<std::string> shape;
        std::optional<double> size;
        ClassMemberConstraints size_constraint;
        std::optional<std::string> stroke;
        std::optional<std::vector<double>> stroke_dash;
        std::optional<double> stroke_dash_offset;
        std::optional<double> stroke_opacity;
        ClassMemberConstraints stroke_opacity_constraint;
        std::optional<double> stroke_width;
        ClassMemberConstraints stroke_width_constraint;
        std::optional<Style> style;
        std::optional<double> tension;
        ClassMemberConstraints tension_constraint;
        std::optional<std::string> text;
        std::optional<double> theta;
        Mark type;

        public:
        /**
         * The horizontal alignment of the text. One of `"left"`, `"right"`, `"center"`.
         */
        const std::optional<HorizontalAlign> & get_align() const { return align; }
        std::optional<HorizontalAlign> & get_mutable_align() { return align; }
        void set_align(const std::optional<HorizontalAlign> & value) { this->align = value; }

        /**
         * The rotation angle of the text, in degrees.
         */
        const std::optional<double> & get_angle() const { return angle; }
        std::optional<double> & get_mutable_angle() { return angle; }
        void set_angle(const std::optional<double> & value) { CheckConstraint("angle", angle_constraint, value); this->angle = value; }

        /**
         * The vertical alignment of the text. One of `"top"`, `"middle"`, `"bottom"`.
         *
         * __Default value:__ `"middle"`
         */
        const std::optional<VerticalAlign> & get_baseline() const { return baseline; }
        std::optional<VerticalAlign> & get_mutable_baseline() { return baseline; }
        void set_baseline(const std::optional<VerticalAlign> & value) { this->baseline = value; }

        /**
         * Whether a mark be clipped to the enclosing group’s width and height.
         */
        const std::optional<bool> & get_clip() const { return clip; }
        std::optional<bool> & get_mutable_clip() { return clip; }
        void set_clip(const std::optional<bool> & value) { this->clip = value; }

        /**
         * Default color.  Note that `fill` and `stroke` have higher precedence than `color` and
         * will override `color`.
         *
         * __Default value:__ <span style="color: #4682b4;">&#9632;</span> `"#4682b4"`
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<std::string> & get_color() const { return color; }
        std::optional<std::string> & get_mutable_color() { return color; }
        void set_color(const std::optional<std::string> & value) { this->color = value; }

        /**
         * The mouse cursor used over the mark. Any valid [CSS cursor
         * type](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Values) can be used.
         */
        const std::optional<Cursor> & get_cursor() const { return cursor; }
        std::optional<Cursor> & get_mutable_cursor() { return cursor; }
        void set_cursor(const std::optional<Cursor> & value) { this->cursor = value; }

        /**
         * The horizontal offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dx() const { return dx; }
        std::optional<double> & get_mutable_dx() { return dx; }
        void set_dx(const std::optional<double> & value) { this->dx = value; }

        /**
         * The vertical offset, in pixels, between the text label and its anchor point. The offset
         * is applied after rotation by the _angle_ property.
         */
        const std::optional<double> & get_dy() const { return dy; }
        std::optional<double> & get_mutable_dy() { return dy; }
        void set_dy(const std::optional<double> & value) { this->dy = value; }

        /**
         * Default Fill Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_fill() const { return fill; }
        std::optional<std::string> & get_mutable_fill() { return fill; }
        void set_fill(const std::optional<std::string> & value) { this->fill = value; }

        /**
         * Whether the mark's color should be used as fill color instead of stroke color.
         *
         * __Default value:__ `true` for all marks except `point` and `false` for `point`.
         *
         * __Applicable for:__ `bar`, `point`, `circle`, `square`, and `area` marks.
         *
         * __Note:__ This property cannot be used in a [style config](mark.html#style-config).
         */
        const std::optional<bool> & get_filled() const { return filled; }
        std::optional<bool> & get_mutable_filled() { return filled; }
        void set_filled(const std::optional<bool> & value) { this->filled = value; }

        /**
         * The fill opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_fill_opacity() const { return fill_opacity; }
        std::optional<double> & get_mutable_fill_opacity() { return fill_opacity; }
        void set_fill_opacity(const std::optional<double> & value) { CheckConstraint("fill_opacity", fill_opacity_constraint, value); this->fill_opacity = value; }

        /**
         * The typeface to set the text in (e.g., `"Helvetica Neue"`).
         */
        const std::optional<std::string> & get_font() const { return font; }
        std::optional<std::string> & get_mutable_font() { return font; }
        void set_font(const std::optional<std::string> & value) { this->font = value; }

        /**
         * The font size, in pixels.
         */
        const std::optional<double> & get_font_size() const { return font_size; }
        std::optional<double> & get_mutable_font_size() { return font_size; }
        void set_font_size(const std::optional<double> & value) { CheckConstraint("font_size", font_size_constraint, value); this->font_size = value; }

        /**
         * The font style (e.g., `"italic"`).
         */
        const std::optional<FontStyle> & get_font_style() const { return font_style; }
        std::optional<FontStyle> & get_mutable_font_style() { return font_style; }
        void set_font_style(const std::optional<FontStyle> & value) { this->font_style = value; }

        /**
         * The font weight (e.g., `"bold"`).
         */
        const std::optional<FontWeightUnion> & get_font_weight() const { return font_weight; }
        std::optional<FontWeightUnion> & get_mutable_font_weight() { return font_weight; }
        void set_font_weight(const std::optional<FontWeightUnion> & value) { this->font_weight = value; }

        /**
         * A URL to load upon mouse click. If defined, the mark acts as a hyperlink.
         */
        const std::optional<std::string> & get_href() const { return href; }
        std::optional<std::string> & get_mutable_href() { return href; }
        void set_href(const std::optional<std::string> & value) { this->href = value; }

        /**
         * The line interpolation method to use for line and area marks. One of the following:
         * - `"linear"`: piecewise linear segments, as in a polyline.
         * - `"linear-closed"`: close the linear segments to form a polygon.
         * - `"step"`: alternate between horizontal and vertical segments, as in a step function.
         * - `"step-before"`: alternate between vertical and horizontal segments, as in a step
         * function.
         * - `"step-after"`: alternate between horizontal and vertical segments, as in a step
         * function.
         * - `"basis"`: a B-spline, with control point duplication on the ends.
         * - `"basis-open"`: an open B-spline; may not intersect the start or end.
         * - `"basis-closed"`: a closed B-spline, as in a loop.
         * - `"cardinal"`: a Cardinal spline, with control point duplication on the ends.
         * - `"cardinal-open"`: an open Cardinal spline; may not intersect the start or end, but
         * will intersect other control points.
         * - `"cardinal-closed"`: a closed Cardinal spline, as in a loop.
         * - `"bundle"`: equivalent to basis, except the tension parameter is used to straighten the
         * spline.
         * - `"monotone"`: cubic interpolation that preserves monotonicity in y.
         */
        const std::optional<Interpolate> & get_interpolate() const { return interpolate; }
        std::optional<Interpolate> & get_mutable_interpolate() { return interpolate; }
        void set_interpolate(const std::optional<Interpolate> & value) { this->interpolate = value; }

        /**
         * The maximum length of the text mark in pixels (default 0, indicating no limit). The text
         * value will be automatically truncated if the rendered size exceeds the limit.
         */
        const std::optional<double> & get_limit() const { return limit; }
        std::optional<double> & get_mutable_limit() { return limit; }
        void set_limit(const std::optional<double> & value) { this->limit = value; }

        /**
         * The overall opacity (value between [0,1]).
         *
         * __Default value:__ `0.7` for non-aggregate plots with `point`, `tick`, `circle`, or
         * `square` marks or layered `bar` charts and `1` otherwise.
         */
        const std::optional<double> & get_opacity() const { return opacity; }
        std::optional<double> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<double> & value) { CheckConstraint("opacity", opacity_constraint, value); this->opacity = value; }

        /**
         * The orientation of a non-stacked bar, tick, area, and line charts.
         * The value is either horizontal (default) or vertical.
         * - For bar, rule and tick, this determines whether the size of the bar and tick
         * should be applied to x or y dimension.
         * - For area, this property determines the orient property of the Vega output.
         * - For line, this property determines the sort order of the points in the line
         * if `config.sortLineBy` is not specified.
         * For stacked charts, this is always determined by the orientation of the stack;
         * therefore explicitly specified value will be ignored.
         */
        const std::optional<Orient> & get_orient() const { return orient; }
        std::optional<Orient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<Orient> & value) { this->orient = value; }

        /**
         * Polar coordinate radial offset, in pixels, of the text label from the origin determined
         * by the `x` and `y` properties.
         */
        const std::optional<double> & get_radius() const { return radius; }
        std::optional<double> & get_mutable_radius() { return radius; }
        void set_radius(const std::optional<double> & value) { CheckConstraint("radius", radius_constraint, value); this->radius = value; }

        /**
         * The default symbol shape to use. One of: `"circle"` (default), `"square"`, `"cross"`,
         * `"diamond"`, `"triangle-up"`, or `"triangle-down"`, or a custom SVG path.
         *
         * __Default value:__ `"circle"`
         */
        const std::optional<std::string> & get_shape() const { return shape; }
        std::optional<std::string> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<std::string> & value) { this->shape = value; }

        /**
         * The pixel area each the point/circle/square.
         * For example: in the case of circles, the radius is determined in part by the square root
         * of the size value.
         *
         * __Default value:__ `30`
         */
        const std::optional<double> & get_size() const { return size; }
        std::optional<double> & get_mutable_size() { return size; }
        void set_size(const std::optional<double> & value) { CheckConstraint("size", size_constraint, value); this->size = value; }

        /**
         * Default Stroke Color.  This has higher precedence than config.color
         *
         * __Default value:__ (None)
         */
        const std::optional<std::string> & get_stroke() const { return stroke; }
        std::optional<std::string> & get_mutable_stroke() { return stroke; }
        void set_stroke(const std::optional<std::string> & value) { this->stroke = value; }

        /**
         * An array of alternating stroke, space lengths for creating dashed or dotted lines.
         */
        const std::optional<std::vector<double>> & get_stroke_dash() const { return stroke_dash; }
        std::optional<std::vector<double>> & get_mutable_stroke_dash() { return stroke_dash; }
        void set_stroke_dash(const std::optional<std::vector<double>> & value) { this->stroke_dash = value; }

        /**
         * The offset (in pixels) into which to begin drawing with the stroke dash array.
         */
        const std::optional<double> & get_stroke_dash_offset() const { return stroke_dash_offset; }
        std::optional<double> & get_mutable_stroke_dash_offset() { return stroke_dash_offset; }
        void set_stroke_dash_offset(const std::optional<double> & value) { this->stroke_dash_offset = value; }

        /**
         * The stroke opacity (value between [0,1]).
         *
         * __Default value:__ `1`
         */
        const std::optional<double> & get_stroke_opacity() const { return stroke_opacity; }
        std::optional<double> & get_mutable_stroke_opacity() { return stroke_opacity; }
        void set_stroke_opacity(const std::optional<double> & value) { CheckConstraint("stroke_opacity", stroke_opacity_constraint, value); this->stroke_opacity = value; }

        /**
         * The stroke width, in pixels.
         */
        const std::optional<double> & get_stroke_width() const { return stroke_width; }
        std::optional<double> & get_mutable_stroke_width() { return stroke_width; }
        void set_stroke_width(const std::optional<double> & value) { CheckConstraint("stroke_width", stroke_width_constraint, value); this->stroke_width = value; }

        /**
         * A string or array of strings indicating the name of custom styles to apply to the mark. A
         * style is a named collection of mark property defaults defined within the [style
         * configuration](mark.html#style-config). If style is an array, later styles will override
         * earlier styles. Any [mark properties](encoding.html#mark-prop) explicitly defined within
         * the `encoding` will override a style default.
         *
         * __Default value:__ The mark's name.  For example, a bar mark will have style `"bar"` by
         * default.
         * __Note:__ Any specified style will augment the default style. For example, a bar mark
         * with `"style": "foo"` will receive from `config.style.bar` and `config.style.foo` (the
         * specified style `"foo"` has higher precedence).
         */
        const std::optional<Style> & get_style() const { return style; }
        std::optional<Style> & get_mutable_style() { return style; }
        void set_style(const std::optional<Style> & value) { this->style = value; }

        /**
         * Depending on the interpolation type, sets the tension parameter (for line and area marks).
         */
        const std::optional<double> & get_tension() const { return tension; }
        std::optional<double> & get_mutable_tension() { return tension; }
        void set_tension(const std::optional<double> & value) { CheckConstraint("tension", tension_constraint, value); this->tension = value; }

        /**
         * Placeholder text if the `text` channel is not specified
         */
        const std::optional<std::string> & get_text() const { return text; }
        std::optional<std::string> & get_mutable_text() { return text; }
        void set_text(const std::optional<std::string> & value) { this->text = value; }

        /**
         * Polar coordinate angle, in radians, of the text label from the origin determined by the
         * `x` and `y` properties. Values for `theta` follow the same convention of `arc` mark
         * `startAngle` and `endAngle` properties: angles are measured in radians, with `0`
         * indicating "north".
         */
        const std::optional<double> & get_theta() const { return theta; }
        std::optional<double> & get_mutable_theta() { return theta; }
        void set_theta(const std::optional<double> & value) { this->theta = value; }

        /**
         * The mark type.
         * One of `"bar"`, `"circle"`, `"square"`, `"tick"`, `"line"`,
         * `"area"`, `"point"`, `"geoshape"`, `"rule"`, and `"text"`.
         */
        const Mark & get_type() const { return type; }
        Mark & get_mutable_type() { return type; }
        void set_type(const Mark & value) { this->type = value; }
    };

    using AnyMark = std::variant<MarkDef, Mark>;

    /**
     * An object defining properties of geographic projection.
     *
     * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
     * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
     */
    class Projection {
        public:
        Projection() = default;
        virtual ~Projection() = default;

        private:
        std::optional<std::vector<double>> center;
        std::optional<double> clip_angle;
        std::optional<std::vector<std::vector<double>>> clip_extent;
        std::optional<double> coefficient;
        std::optional<double> distance;
        std::optional<double> fraction;
        std::optional<double> lobes;
        std::optional<double> parallel;
        std::optional<std::map<std::string, TitleFontWeight>> precision;
        std::optional<double> radius;
        std::optional<double> ratio;
        std::optional<std::vector<double>> rotate;
        std::optional<double> spacing;
        std::optional<double> tilt;
        std::optional<VgProjectionType> type;

        public:
        /**
         * Sets the projection’s center to the specified center, a two-element array of longitude
         * and latitude in degrees.
         *
         * __Default value:__ `[0, 0]`
         */
        const std::optional<std::vector<double>> & get_center() const { return center; }
        std::optional<std::vector<double>> & get_mutable_center() { return center; }
        void set_center(const std::optional<std::vector<double>> & value) { this->center = value; }

        /**
         * Sets the projection’s clipping circle radius to the specified angle in degrees. If
         * `null`, switches to [antimeridian](http://bl.ocks.org/mbostock/3788999) cutting rather
         * than small-circle clipping.
         */
        const std::optional<double> & get_clip_angle() const { return clip_angle; }
        std::optional<double> & get_mutable_clip_angle() { return clip_angle; }
        void set_clip_angle(const std::optional<double> & value) { this->clip_angle = value; }

        /**
         * Sets the projection’s viewport clip extent to the specified bounds in pixels. The extent
         * bounds are specified as an array `[[x0, y0], [x1, y1]]`, where `x0` is the left-side of
         * the viewport, `y0` is the top, `x1` is the right and `y1` is the bottom. If `null`, no
         * viewport clipping is performed.
         */
        const std::optional<std::vector<std::vector<double>>> & get_clip_extent() const { return clip_extent; }
        std::optional<std::vector<std::vector<double>>> & get_mutable_clip_extent() { return clip_extent; }
        void set_clip_extent(const std::optional<std::vector<std::vector<double>>> & value) { this->clip_extent = value; }

        const std::optional<double> & get_coefficient() const { return coefficient; }
        std::optional<double> & get_mutable_coefficient() { return coefficient; }
        void set_coefficient(const std::optional<double> & value) { this->coefficient = value; }

        const std::optional<double> & get_distance() const { return distance; }
        std::optional<double> & get_mutable_distance() { return distance; }
        void set_distance(const std::optional<double> & value) { this->distance = value; }

        const std::optional<double> & get_fraction() const { return fraction; }
        std::optional<double> & get_mutable_fraction() { return fraction; }
        void set_fraction(const std::optional<double> & value) { this->fraction = value; }

        const std::optional<double> & get_lobes() const { return lobes; }
        std::optional<double> & get_mutable_lobes() { return lobes; }
        void set_lobes(const std::optional<double> & value) { this->lobes = value; }

        const std::optional<double> & get_parallel() const { return parallel; }
        std::optional<double> & get_mutable_parallel() { return parallel; }
        void set_parallel(const std::optional<double> & value) { this->parallel = value; }

        /**
         * Sets the threshold for the projection’s [adaptive
         * resampling](http://bl.ocks.org/mbostock/3795544) to the specified value in pixels. This
         * value corresponds to the [Douglas–Peucker
         * distance](http://en.wikipedia.org/wiki/Ramer%E2%80%93Douglas%E2%80%93Peucker_algorithm).
         * If precision is not specified, returns the projection’s current resampling precision
         * which defaults to `√0.5 ≅ 0.70710…`.
         */
        const std::optional<std::map<std::string, TitleFontWeight>> & get_precision() const { return precision; }
        std::optional<std::map<std::string, TitleFontWeight>> & get_mutable_precision() { return precision; }
        void set_precision(const std::optional<std::map<std::string, TitleFontWeight>> & value) { this->precision = value; }

        const std::optional<double> & get_radius() const { return radius; }
        std::optional<double> & get_mutable_radius() { return radius; }
        void set_radius(const std::optional<double> & value) { this->radius = value; }

        const std::optional<double> & get_ratio() const { return ratio; }
        std::optional<double> & get_mutable_ratio() { return ratio; }
        void set_ratio(const std::optional<double> & value) { this->ratio = value; }

        /**
         * Sets the projection’s three-axis rotation to the specified angles, which must be a two-
         * or three-element array of numbers [`lambda`, `phi`, `gamma`] specifying the rotation
         * angles in degrees about each spherical axis. (These correspond to yaw, pitch and roll.)
         *
         * __Default value:__ `[0, 0, 0]`
         */
        const std::optional<std::vector<double>> & get_rotate() const { return rotate; }
        std::optional<std::vector<double>> & get_mutable_rotate() { return rotate; }
        void set_rotate(const std::optional<std::vector<double>> & value) { this->rotate = value; }

        const std::optional<double> & get_spacing() const { return spacing; }
        std::optional<double> & get_mutable_spacing() { return spacing; }
        void set_spacing(const std::optional<double> & value) { this->spacing = value; }

        const std::optional<double> & get_tilt() const { return tilt; }
        std::optional<double> & get_mutable_tilt() { return tilt; }
        void set_tilt(const std::optional<double> & value) { this->tilt = value; }

        /**
         * The cartographic projection to use. This value is case-insensitive, for example
         * `"albers"` and `"Albers"` indicate the same projection type. You can find all valid
         * projection types [in the
         * documentation](https://vega.github.io/vega-lite/docs/projection.html#projection-types).
         *
         * __Default value:__ `mercator`
         */
        const std::optional<VgProjectionType> & get_type() const { return type; }
        std::optional<VgProjectionType> & get_mutable_type() { return type; }
        void set_type(const std::optional<VgProjectionType> & value) { this->type = value; }
    };

    enum class ResolveMode : int { INDEPENDENT, SHARED };

    class AxisResolveMap {
        public:
        AxisResolveMap() = default;
        virtual ~AxisResolveMap() = default;

        private:
        std::optional<ResolveMode> x;
        std::optional<ResolveMode> y;

        public:
        const std::optional<ResolveMode> & get_x() const { return x; }
        std::optional<ResolveMode> & get_mutable_x() { return x; }
        void set_x(const std::optional<ResolveMode> & value) { this->x = value; }

        const std::optional<ResolveMode> & get_y() const { return y; }
        std::optional<ResolveMode> & get_mutable_y() { return y; }
        void set_y(const std::optional<ResolveMode> & value) { this->y = value; }
    };

    class LegendResolveMap {
        public:
        LegendResolveMap() = default;
        virtual ~LegendResolveMap() = default;

        private:
        std::optional<ResolveMode> color;
        std::optional<ResolveMode> opacity;
        std::optional<ResolveMode> shape;
        std::optional<ResolveMode> size;

        public:
        const std::optional<ResolveMode> & get_color() const { return color; }
        std::optional<ResolveMode> & get_mutable_color() { return color; }
        void set_color(const std::optional<ResolveMode> & value) { this->color = value; }

        const std::optional<ResolveMode> & get_opacity() const { return opacity; }
        std::optional<ResolveMode> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<ResolveMode> & value) { this->opacity = value; }

        const std::optional<ResolveMode> & get_shape() const { return shape; }
        std::optional<ResolveMode> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<ResolveMode> & value) { this->shape = value; }

        const std::optional<ResolveMode> & get_size() const { return size; }
        std::optional<ResolveMode> & get_mutable_size() { return size; }
        void set_size(const std::optional<ResolveMode> & value) { this->size = value; }
    };

    class ScaleResolveMap {
        public:
        ScaleResolveMap() = default;
        virtual ~ScaleResolveMap() = default;

        private:
        std::optional<ResolveMode> color;
        std::optional<ResolveMode> opacity;
        std::optional<ResolveMode> shape;
        std::optional<ResolveMode> size;
        std::optional<ResolveMode> x;
        std::optional<ResolveMode> y;

        public:
        const std::optional<ResolveMode> & get_color() const { return color; }
        std::optional<ResolveMode> & get_mutable_color() { return color; }
        void set_color(const std::optional<ResolveMode> & value) { this->color = value; }

        const std::optional<ResolveMode> & get_opacity() const { return opacity; }
        std::optional<ResolveMode> & get_mutable_opacity() { return opacity; }
        void set_opacity(const std::optional<ResolveMode> & value) { this->opacity = value; }

        const std::optional<ResolveMode> & get_shape() const { return shape; }
        std::optional<ResolveMode> & get_mutable_shape() { return shape; }
        void set_shape(const std::optional<ResolveMode> & value) { this->shape = value; }

        const std::optional<ResolveMode> & get_size() const { return size; }
        std::optional<ResolveMode> & get_mutable_size() { return size; }
        void set_size(const std::optional<ResolveMode> & value) { this->size = value; }

        const std::optional<ResolveMode> & get_x() const { return x; }
        std::optional<ResolveMode> & get_mutable_x() { return x; }
        void set_x(const std::optional<ResolveMode> & value) { this->x = value; }

        const std::optional<ResolveMode> & get_y() const { return y; }
        std::optional<ResolveMode> & get_mutable_y() { return y; }
        void set_y(const std::optional<ResolveMode> & value) { this->y = value; }
    };

    /**
     * Scale, axis, and legend resolutions for layers.
     *
     * Defines how scales, axes, and legends from different specs should be combined. Resolve is
     * a mapping from `scale`, `axis`, and `legend` to a mapping from channels to resolutions.
     *
     * Scale, axis, and legend resolutions for facets.
     *
     * Scale and legend resolutions for repeated charts.
     *
     * Scale, axis, and legend resolutions for vertically concatenated charts.
     *
     * Scale, axis, and legend resolutions for horizontally concatenated charts.
     */
    class Resolve {
        public:
        Resolve() = default;
        virtual ~Resolve() = default;

        private:
        std::optional<AxisResolveMap> axis;
        std::optional<LegendResolveMap> legend;
        std::optional<ScaleResolveMap> scale;

        public:
        const std::optional<AxisResolveMap> & get_axis() const { return axis; }
        std::optional<AxisResolveMap> & get_mutable_axis() { return axis; }
        void set_axis(const std::optional<AxisResolveMap> & value) { this->axis = value; }

        const std::optional<LegendResolveMap> & get_legend() const { return legend; }
        std::optional<LegendResolveMap> & get_mutable_legend() { return legend; }
        void set_legend(const std::optional<LegendResolveMap> & value) { this->legend = value; }

        const std::optional<ScaleResolveMap> & get_scale() const { return scale; }
        std::optional<ScaleResolveMap> & get_mutable_scale() { return scale; }
        void set_scale(const std::optional<ScaleResolveMap> & value) { this->scale = value; }
    };

    using BindUnion = std::variant<BindEnum, std::map<std::string, VgBinding>>;

    enum class SelectionDefType : int { SINGLE, MULTI, INTERVAL };

    class SelectionDef {
        public:
        SelectionDef() = default;
        virtual ~SelectionDef() = default;

        private:
        std::optional<BindUnion> bind;
        std::optional<Empty> empty;
        std::optional<std::vector<SingleDefChannel>> encodings;
        std::optional<std::vector<std::string>> fields;
        std::optional<bool> nearest;
        nlohmann::json on;
        std::optional<SelectionResolution> resolve;
        SelectionDefType type;
        std::optional<Translate> toggle;
        std::optional<BrushConfig> mark;
        std::optional<Translate> translate;
        std::optional<Translate> zoom;

        public:
        /**
         * Establish a two-way binding between a single selection and input elements
         * (also known as dynamic query widgets). A binding takes the form of
         * Vega's [input element binding definition](https://vega.github.io/vega/docs/signals/#bind)
         * or can be a mapping between projected field/encodings and binding definitions.
         *
         * See the [bind transform](bind.html) documentation for more information.
         *
         * Establishes a two-way binding between the interval selection and the scales
         * used within the same view. This allows a user to interactively pan and
         * zoom the view.
         */
        const std::optional<BindUnion> & get_bind() const { return bind; }
        std::optional<BindUnion> & get_mutable_bind() { return bind; }
        void set_bind(const std::optional<BindUnion> & value) { this->bind = value; }

        /**
         * By default, all data values are considered to lie within an empty selection.
         * When set to `none`, empty selections contain no data values.
         */
        const std::optional<Empty> & get_empty() const { return empty; }
        std::optional<Empty> & get_mutable_empty() { return empty; }
        void set_empty(const std::optional<Empty> & value) { this->empty = value; }

        /**
         * An array of encoding channels. The corresponding data field values
         * must match for a data tuple to fall within the selection.
         */
        const std::optional<std::vector<SingleDefChannel>> & get_encodings() const { return encodings; }
        std::optional<std::vector<SingleDefChannel>> & get_mutable_encodings() { return encodings; }
        void set_encodings(const std::optional<std::vector<SingleDefChannel>> & value) { this->encodings = value; }

        /**
         * An array of field names whose values must match for a data tuple to
         * fall within the selection.
         */
        const std::optional<std::vector<std::string>> & get_fields() const { return fields; }
        std::optional<std::vector<std::string>> & get_mutable_fields() { return fields; }
        void set_fields(const std::optional<std::vector<std::string>> & value) { this->fields = value; }

        /**
         * When true, an invisible voronoi diagram is computed to accelerate discrete
         * selection. The data value _nearest_ the mouse cursor is added to the selection.
         *
         * See the [nearest transform](nearest.html) documentation for more information.
         */
        const std::optional<bool> & get_nearest() const { return nearest; }
        std::optional<bool> & get_mutable_nearest() { return nearest; }
        void set_nearest(const std::optional<bool> & value) { this->nearest = value; }

        /**
         * A [Vega event stream](https://vega.github.io/vega/docs/event-streams/) (object or
         * selector) that triggers the selection.
         * For interval selections, the event stream must specify a [start and
         * end](https://vega.github.io/vega/docs/event-streams/#between-filters).
         */
        const nlohmann::json & get_on() const { return on; }
        nlohmann::json & get_mutable_on() { return on; }
        void set_on(const nlohmann::json & value) { this->on = value; }

        /**
         * With layered and multi-view displays, a strategy that determines how
         * selections' data queries are resolved when applied in a filter transform,
         * conditional encoding rule, or scale domain.
         */
        const std::optional<SelectionResolution> & get_resolve() const { return resolve; }
        std::optional<SelectionResolution> & get_mutable_resolve() { return resolve; }
        void set_resolve(const std::optional<SelectionResolution> & value) { this->resolve = value; }

        const SelectionDefType & get_type() const { return type; }
        SelectionDefType & get_mutable_type() { return type; }
        void set_type(const SelectionDefType & value) { this->type = value; }

        /**
         * Controls whether data values should be toggled or only ever inserted into
         * multi selections. Can be `true`, `false` (for insertion only), or a
         * [Vega expression](https://vega.github.io/vega/docs/expressions/).
         *
         * __Default value:__ `true`, which corresponds to `event.shiftKey` (i.e.,
         * data values are toggled when a user interacts with the shift-key pressed).
         *
         * See the [toggle transform](toggle.html) documentation for more information.
         */
        const std::optional<Translate> & get_toggle() const { return toggle; }
        std::optional<Translate> & get_mutable_toggle() { return toggle; }
        void set_toggle(const std::optional<Translate> & value) { this->toggle = value; }

        /**
         * An interval selection also adds a rectangle mark to depict the
         * extents of the interval. The `mark` property can be used to customize the
         * appearance of the mark.
         */
        const std::optional<BrushConfig> & get_mark() const { return mark; }
        std::optional<BrushConfig> & get_mutable_mark() { return mark; }
        void set_mark(const std::optional<BrushConfig> & value) { this->mark = value; }

        /**
         * When truthy, allows a user to interactively move an interval selection
         * back-and-forth. Can be `true`, `false` (to disable panning), or a
         * [Vega event stream definition](https://vega.github.io/vega/docs/event-streams/)
         * which must include a start and end event to trigger continuous panning.
         *
         * __Default value:__ `true`, which corresponds to
         * `[mousedown, window:mouseup] > window:mousemove!` which corresponds to
         * clicks and dragging within an interval selection to reposition it.
         */
        const std::optional<Translate> & get_translate() const { return translate; }
        std::optional<Translate> & get_mutable_translate() { return translate; }
        void set_translate(const std::optional<Translate> & value) { this->translate = value; }

        /**
         * When truthy, allows a user to interactively resize an interval selection.
         * Can be `true`, `false` (to disable zooming), or a [Vega event stream
         * definition](https://vega.github.io/vega/docs/event-streams/). Currently,
         * only `wheel` events are supported.
         *
         *
         * __Default value:__ `true`, which corresponds to `wheel!`.
         */
        const std::optional<Translate> & get_zoom() const { return zoom; }
        std::optional<Translate> & get_mutable_zoom() { return zoom; }
        void set_zoom(const std::optional<Translate> & value) { this->zoom = value; }
    };

    class TitleParams {
        public:
        TitleParams() = default;
        virtual ~TitleParams() = default;

        private:
        std::optional<Anchor> anchor;
        std::optional<double> offset;
        std::optional<TitleOrient> orient;
        std::optional<Style> style;
        std::string text;

        public:
        /**
         * The anchor position for placing the title. One of `"start"`, `"middle"`, or `"end"`. For
         * example, with an orientation of top these anchor positions map to a left-, center-, or
         * right-aligned title.
         *
         * __Default value:__ `"middle"` for [single](spec.html) and [layered](layer.html) views.
         * `"start"` for other composite views.
         *
         * __Note:__ [For now](https://github.com/vega/vega-lite/issues/2875), `anchor` is only
         * customizable only for [single](spec.html) and [layered](layer.html) views.  For other
         * composite views, `anchor` is always `"start"`.
         */
        const std::optional<Anchor> & get_anchor() const { return anchor; }
        std::optional<Anchor> & get_mutable_anchor() { return anchor; }
        void set_anchor(const std::optional<Anchor> & value) { this->anchor = value; }

        /**
         * The orthogonal offset in pixels by which to displace the title from its position along
         * the edge of the chart.
         */
        const std::optional<double> & get_offset() const { return offset; }
        std::optional<double> & get_mutable_offset() { return offset; }
        void set_offset(const std::optional<double> & value) { this->offset = value; }

        /**
         * The orientation of the title relative to the chart. One of `"top"` (the default),
         * `"bottom"`, `"left"`, or `"right"`.
         */
        const std::optional<TitleOrient> & get_orient() const { return orient; }
        std::optional<TitleOrient> & get_mutable_orient() { return orient; }
        void set_orient(const std::optional<TitleOrient> & value) { this->orient = value; }

        /**
         * A [mark style property](config.html#style) to apply to the title text mark.
         *
         * __Default value:__ `"group-title"`.
         */
        const std::optional<Style> & get_style() const { return style; }
        std::optional<Style> & get_mutable_style() { return style; }
        void set_style(const std::optional<Style> & value) { this->style = value; }

        /**
         * The title text.
         */
        const std::string & get_text() const { return text; }
        std::string & get_mutable_text() { return text; }
        void set_text(const std::string & value) { this->text = value; }
    };

    using Title = std::variant<TitleParams, std::string>;

    class AggregatedFieldDef {
        public:
        AggregatedFieldDef() = default;
        virtual ~AggregatedFieldDef() = default;

        private:
        std::string as;
        std::string field;
        AggregateOp op;

        public:
        /**
         * The output field names to use for each aggregated field.
         */
        const std::string & get_as() const { return as; }
        std::string & get_mutable_as() { return as; }
        void set_as(const std::string & value) { this->as = value; }

        /**
         * The data field for which to compute aggregate function.
         */
        const std::string & get_field() const { return field; }
        std::string & get_mutable_field() { return field; }
        void set_field(const std::string & value) { this->field = value; }

        /**
         * The aggregation operations to apply to the fields, such as sum, average or count.
         * See the [full list of supported aggregation
         * operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops)
         * for more information.
         */
        const AggregateOp & get_op() const { return op; }
        AggregateOp & get_mutable_op() { return op; }
        void set_op(const AggregateOp & value) { this->op = value; }
    };

    /**
     * Secondary data reference.
     */
    class LookupData {
        public:
        LookupData() = default;
        virtual ~LookupData() = default;

        private:
        Data data;
        std::optional<std::vector<std::string>> fields;
        std::string key;

        public:
        /**
         * Secondary data source to lookup in.
         */
        const Data & get_data() const { return data; }
        Data & get_mutable_data() { return data; }
        void set_data(const Data & value) { this->data = value; }

        /**
         * Fields in foreign data to lookup.
         * If not specified, the entire object is queried.
         */
        const std::optional<std::vector<std::string>> & get_fields() const { return fields; }
        std::optional<std::vector<std::string>> & get_mutable_fields() { return fields; }
        void set_fields(const std::optional<std::vector<std::string>> & value) { this->fields = value; }

        /**
         * Key in data to lookup.
         */
        const std::string & get_key() const { return key; }
        std::string & get_mutable_key() { return key; }
        void set_key(const std::string & value) { this->key = value; }
    };

    class Transform {
        public:
        Transform() = default;
        virtual ~Transform() = default;

        private:
        std::shared_ptr<LogicalOperandPredicate> filter;
        std::optional<Style> as;
        std::optional<std::string> calculate;
        std::optional<std::string> transform_default;
        std::optional<LookupData> from;
        std::optional<std::string> lookup;
        std::optional<Bin> bin;
        std::optional<std::string> field;
        std::optional<TimeUnit> time_unit;
        std::optional<std::vector<AggregatedFieldDef>> aggregate;
        std::optional<std::vector<std::string>> groupby;

        public:
        /**
         * The `filter` property must be one of the predicate definitions:
         * (1) an [expression](types.html#expression) string,
         * where `datum` can be used to refer to the current data object;
         * (2) one of the field predicates: [equal predicate](filter.html#equal-predicate);
         * [range predicate](filter.html#range-predicate), [one-of
         * predicate](filter.html#one-of-predicate);
         * (3) a [selection predicate](filter.html#selection-predicate);
         * or (4) a logical operand that combines (1), (2), or (3).
         */
        const std::shared_ptr<LogicalOperandPredicate> & get_filter() const { return filter; }
        std::shared_ptr<LogicalOperandPredicate> & get_mutable_filter() { return filter; }
        void set_filter(const std::shared_ptr<LogicalOperandPredicate> & value) { this->filter = value; }

        /**
         * The field for storing the computed formula value.
         *
         * The field or fields for storing the computed formula value.
         * If `from.fields` is specified, the transform will use the same names for `as`.
         * If `from.fields` is not specified, `as` has to be a string and we put the whole object
         * into the data under the specified name.
         *
         * The output fields at which to write the start and end bin values.
         *
         * The output field to write the timeUnit value.
         */
        const std::optional<Style> & get_as() const { return as; }
        std::optional<Style> & get_mutable_as() { return as; }
        void set_as(const std::optional<Style> & value) { this->as = value; }

        /**
         * A [expression](types.html#expression) string. Use the variable `datum` to refer to the
         * current data object.
         */
        const std::optional<std::string> & get_calculate() const { return calculate; }
        std::optional<std::string> & get_mutable_calculate() { return calculate; }
        void set_calculate(const std::optional<std::string> & value) { this->calculate = value; }

        /**
         * The default value to use if lookup fails.
         *
         * __Default value:__ `null`
         */
        const std::optional<std::string> & get_transform_default() const { return transform_default; }
        std::optional<std::string> & get_mutable_transform_default() { return transform_default; }
        void set_transform_default(const std::optional<std::string> & value) { this->transform_default = value; }

        /**
         * Secondary data reference.
         */
        const std::optional<LookupData> & get_from() const { return from; }
        std::optional<LookupData> & get_mutable_from() { return from; }
        void set_from(const std::optional<LookupData> & value) { this->from = value; }

        /**
         * Key in primary data source.
         */
        const std::optional<std::string> & get_lookup() const { return lookup; }
        std::optional<std::string> & get_mutable_lookup() { return lookup; }
        void set_lookup(const std::optional<std::string> & value) { this->lookup = value; }

        /**
         * An object indicating bin properties, or simply `true` for using default bin parameters.
         */
        const std::optional<Bin> & get_bin() const { return bin; }
        std::optional<Bin> & get_mutable_bin() { return bin; }
        void set_bin(const std::optional<Bin> & value) { this->bin = value; }

        /**
         * The data field to bin.
         *
         * The data field to apply time unit.
         */
        const std::optional<std::string> & get_field() const { return field; }
        std::optional<std::string> & get_mutable_field() { return field; }
        void set_field(const std::optional<std::string> & value) { this->field = value; }

        /**
         * The timeUnit.
         */
        const std::optional<TimeUnit> & get_time_unit() const { return time_unit; }
        std::optional<TimeUnit> & get_mutable_time_unit() { return time_unit; }
        void set_time_unit(const std::optional<TimeUnit> & value) { this->time_unit = value; }

        /**
         * Array of objects that define fields to aggregate.
         */
        const std::optional<std::vector<AggregatedFieldDef>> & get_aggregate() const { return aggregate; }
        std::optional<std::vector<AggregatedFieldDef>> & get_mutable_aggregate() { return aggregate; }
        void set_aggregate(const std::optional<std::vector<AggregatedFieldDef>> & value) { this->aggregate = value; }

        /**
         * The data fields to group by. If not specified, a single group containing all data objects
         * will be used.
         */
        const std::optional<std::vector<std::string>> & get_groupby() const { return groupby; }
        std::optional<std::vector<std::string>> & get_mutable_groupby() { return groupby; }
        void set_groupby(const std::optional<std::vector<std::string>> & value) { this->groupby = value; }
    };

    /**
     * Unit spec that can have a composite mark.
     */
    class LayerSpec {
        public:
        LayerSpec() = default;
        virtual ~LayerSpec() = default;

        private:
        std::optional<Data> data;
        std::optional<std::string> description;
        std::optional<double> height;
        std::optional<std::vector<LayerSpec>> layer;
        std::optional<std::string> name;
        std::optional<Resolve> resolve;
        std::optional<Title> title;
        std::optional<std::vector<Transform>> transform;
        std::optional<double> width;
        std::optional<Encoding> encoding;
        std::optional<AnyMark> mark;
        std::optional<Projection> projection;
        std::optional<std::map<std::string, SelectionDef>> selection;

        public:
        /**
         * An object describing the data source
         */
        const std::optional<Data> & get_data() const { return data; }
        std::optional<Data> & get_mutable_data() { return data; }
        void set_data(const std::optional<Data> & value) { this->data = value; }

        /**
         * Description of this mark for commenting purpose.
         */
        const std::optional<std::string> & get_description() const { return description; }
        std::optional<std::string> & get_mutable_description() { return description; }
        void set_description(const std::optional<std::string> & value) { this->description = value; }

        /**
         * The height of a visualization.
         *
         * __Default value:__
         * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
         * [continuous scale](scale.html#continuous), the height will be the value of
         * [`config.view.height`](spec.html#config).
         * - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
         * value or unspecified, the height is [determined by the range step, paddings, and the
         * cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
         * `rangeStep` is `null`, the height will be the value of
         * [`config.view.height`](spec.html#config).
         * - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
         *
         * __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
         * represents the height of a single view.
         *
         * __See also:__ The documentation for [width and height](size.html) contains more examples.
         */
        const std::optional<double> & get_height() const { return height; }
        std::optional<double> & get_mutable_height() { return height; }
        void set_height(const std::optional<double> & value) { this->height = value; }

        /**
         * Layer or single view specifications to be layered.
         *
         * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
         * layering facet specifications is not allowed.
         */
        const std::optional<std::vector<LayerSpec>> & get_layer() const { return layer; }
        std::optional<std::vector<LayerSpec>> & get_mutable_layer() { return layer; }
        void set_layer(const std::optional<std::vector<LayerSpec>> & value) { this->layer = value; }

        /**
         * Name of the visualization for later reference.
         */
        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        /**
         * Scale, axis, and legend resolutions for layers.
         */
        const std::optional<Resolve> & get_resolve() const { return resolve; }
        std::optional<Resolve> & get_mutable_resolve() { return resolve; }
        void set_resolve(const std::optional<Resolve> & value) { this->resolve = value; }

        /**
         * Title for the plot.
         */
        const std::optional<Title> & get_title() const { return title; }
        std::optional<Title> & get_mutable_title() { return title; }
        void set_title(const std::optional<Title> & value) { this->title = value; }

        /**
         * An array of data transformations such as filter and new field calculation.
         */
        const std::optional<std::vector<Transform>> & get_transform() const { return transform; }
        std::optional<std::vector<Transform>> & get_mutable_transform() { return transform; }
        void set_transform(const std::optional<std::vector<Transform>> & value) { this->transform = value; }

        /**
         * The width of a visualization.
         *
         * __Default value:__ This will be determined by the following rules:
         *
         * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
         * [continuous scale](scale.html#continuous), the width will be the value of
         * [`config.view.width`](spec.html#config).
         * - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
         * value or unspecified, the width is [determined by the range step, paddings, and the
         * cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
         * `rangeStep` is `null`, the width will be the value of
         * [`config.view.width`](spec.html#config).
         * - If no field is mapped to `x` channel, the `width` will be the value of
         * [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
         * the value of `rangeStep` for other marks.
         *
         * __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
         * represents the width of a single view.
         *
         * __See also:__ The documentation for [width and height](size.html) contains more examples.
         */
        const std::optional<double> & get_width() const { return width; }
        std::optional<double> & get_mutable_width() { return width; }
        void set_width(const std::optional<double> & value) { this->width = value; }

        /**
         * A key-value mapping between encoding channels and definition of fields.
         */
        const std::optional<Encoding> & get_encoding() const { return encoding; }
        std::optional<Encoding> & get_mutable_encoding() { return encoding; }
        void set_encoding(const std::optional<Encoding> & value) { this->encoding = value; }

        /**
         * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
         * `"line"`,
         * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
         * object](mark.html#mark-def).
         */
        const std::optional<AnyMark> & get_mark() const { return mark; }
        std::optional<AnyMark> & get_mutable_mark() { return mark; }
        void set_mark(const std::optional<AnyMark> & value) { this->mark = value; }

        /**
         * An object defining properties of geographic projection.
         *
         * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
         * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
         */
        const std::optional<Projection> & get_projection() const { return projection; }
        std::optional<Projection> & get_mutable_projection() { return projection; }
        void set_projection(const std::optional<Projection> & value) { this->projection = value; }

        /**
         * A key-value mapping between selection names and definitions.
         */
        const std::optional<std::map<std::string, SelectionDef>> & get_selection() const { return selection; }
        std::optional<std::map<std::string, SelectionDef>> & get_mutable_selection() { return selection; }
        void set_selection(const std::optional<std::map<std::string, SelectionDef>> & value) { this->selection = value; }
    };

    /**
     * An object that describes what fields should be repeated into views that are laid out as a
     * `row` or `column`.
     */
    class Repeat {
        public:
        Repeat() = default;
        virtual ~Repeat() = default;

        private:
        std::optional<std::vector<std::string>> column;
        std::optional<std::vector<std::string>> row;

        public:
        /**
         * Horizontal repeated views.
         */
        const std::optional<std::vector<std::string>> & get_column() const { return column; }
        std::optional<std::vector<std::string>> & get_mutable_column() { return column; }
        void set_column(const std::optional<std::vector<std::string>> & value) { this->column = value; }

        /**
         * Vertical repeated views.
         */
        const std::optional<std::vector<std::string>> & get_row() const { return row; }
        std::optional<std::vector<std::string>> & get_mutable_row() { return row; }
        void set_row(const std::optional<std::vector<std::string>> & value) { this->row = value; }
    };

    /**
     * Unit spec that can have a composite mark.
     */
    class Spec {
        public:
        Spec() = default;
        virtual ~Spec() = default;

        private:
        std::optional<Data> data;
        std::optional<std::string> description;
        std::optional<double> height;
        std::optional<std::vector<LayerSpec>> layer;
        std::optional<std::string> name;
        std::optional<Resolve> resolve;
        std::optional<Title> title;
        std::optional<std::vector<Transform>> transform;
        std::optional<double> width;
        std::optional<Encoding> encoding;
        std::optional<AnyMark> mark;
        std::optional<Projection> projection;
        std::optional<std::map<std::string, SelectionDef>> selection;
        std::optional<FacetMapping> facet;
        std::shared_ptr<Spec> spec;
        std::optional<Repeat> repeat;
        std::optional<std::vector<Spec>> vconcat;
        std::optional<std::vector<Spec>> hconcat;

        public:
        /**
         * An object describing the data source
         */
        const std::optional<Data> & get_data() const { return data; }
        std::optional<Data> & get_mutable_data() { return data; }
        void set_data(const std::optional<Data> & value) { this->data = value; }

        /**
         * Description of this mark for commenting purpose.
         */
        const std::optional<std::string> & get_description() const { return description; }
        std::optional<std::string> & get_mutable_description() { return description; }
        void set_description(const std::optional<std::string> & value) { this->description = value; }

        /**
         * The height of a visualization.
         *
         * __Default value:__
         * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
         * [continuous scale](scale.html#continuous), the height will be the value of
         * [`config.view.height`](spec.html#config).
         * - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
         * value or unspecified, the height is [determined by the range step, paddings, and the
         * cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
         * `rangeStep` is `null`, the height will be the value of
         * [`config.view.height`](spec.html#config).
         * - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
         *
         * __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
         * represents the height of a single view.
         *
         * __See also:__ The documentation for [width and height](size.html) contains more examples.
         */
        const std::optional<double> & get_height() const { return height; }
        std::optional<double> & get_mutable_height() { return height; }
        void set_height(const std::optional<double> & value) { this->height = value; }

        /**
         * Layer or single view specifications to be layered.
         *
         * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
         * layering facet specifications is not allowed.
         */
        const std::optional<std::vector<LayerSpec>> & get_layer() const { return layer; }
        std::optional<std::vector<LayerSpec>> & get_mutable_layer() { return layer; }
        void set_layer(const std::optional<std::vector<LayerSpec>> & value) { this->layer = value; }

        /**
         * Name of the visualization for later reference.
         */
        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        /**
         * Scale, axis, and legend resolutions for layers.
         *
         * Scale, axis, and legend resolutions for facets.
         *
         * Scale and legend resolutions for repeated charts.
         *
         * Scale, axis, and legend resolutions for vertically concatenated charts.
         *
         * Scale, axis, and legend resolutions for horizontally concatenated charts.
         */
        const std::optional<Resolve> & get_resolve() const { return resolve; }
        std::optional<Resolve> & get_mutable_resolve() { return resolve; }
        void set_resolve(const std::optional<Resolve> & value) { this->resolve = value; }

        /**
         * Title for the plot.
         */
        const std::optional<Title> & get_title() const { return title; }
        std::optional<Title> & get_mutable_title() { return title; }
        void set_title(const std::optional<Title> & value) { this->title = value; }

        /**
         * An array of data transformations such as filter and new field calculation.
         */
        const std::optional<std::vector<Transform>> & get_transform() const { return transform; }
        std::optional<std::vector<Transform>> & get_mutable_transform() { return transform; }
        void set_transform(const std::optional<std::vector<Transform>> & value) { this->transform = value; }

        /**
         * The width of a visualization.
         *
         * __Default value:__ This will be determined by the following rules:
         *
         * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
         * [continuous scale](scale.html#continuous), the width will be the value of
         * [`config.view.width`](spec.html#config).
         * - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
         * value or unspecified, the width is [determined by the range step, paddings, and the
         * cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
         * `rangeStep` is `null`, the width will be the value of
         * [`config.view.width`](spec.html#config).
         * - If no field is mapped to `x` channel, the `width` will be the value of
         * [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
         * the value of `rangeStep` for other marks.
         *
         * __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
         * represents the width of a single view.
         *
         * __See also:__ The documentation for [width and height](size.html) contains more examples.
         */
        const std::optional<double> & get_width() const { return width; }
        std::optional<double> & get_mutable_width() { return width; }
        void set_width(const std::optional<double> & value) { this->width = value; }

        /**
         * A key-value mapping between encoding channels and definition of fields.
         */
        const std::optional<Encoding> & get_encoding() const { return encoding; }
        std::optional<Encoding> & get_mutable_encoding() { return encoding; }
        void set_encoding(const std::optional<Encoding> & value) { this->encoding = value; }

        /**
         * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
         * `"line"`,
         * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
         * object](mark.html#mark-def).
         */
        const std::optional<AnyMark> & get_mark() const { return mark; }
        std::optional<AnyMark> & get_mutable_mark() { return mark; }
        void set_mark(const std::optional<AnyMark> & value) { this->mark = value; }

        /**
         * An object defining properties of geographic projection.
         *
         * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
         * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
         */
        const std::optional<Projection> & get_projection() const { return projection; }
        std::optional<Projection> & get_mutable_projection() { return projection; }
        void set_projection(const std::optional<Projection> & value) { this->projection = value; }

        /**
         * A key-value mapping between selection names and definitions.
         */
        const std::optional<std::map<std::string, SelectionDef>> & get_selection() const { return selection; }
        std::optional<std::map<std::string, SelectionDef>> & get_mutable_selection() { return selection; }
        void set_selection(const std::optional<std::map<std::string, SelectionDef>> & value) { this->selection = value; }

        /**
         * An object that describes mappings between `row` and `column` channels and their field
         * definitions.
         */
        const std::optional<FacetMapping> & get_facet() const { return facet; }
        std::optional<FacetMapping> & get_mutable_facet() { return facet; }
        void set_facet(const std::optional<FacetMapping> & value) { this->facet = value; }

        /**
         * A specification of the view that gets faceted.
         */
        const std::shared_ptr<Spec> & get_spec() const { return spec; }
        std::shared_ptr<Spec> & get_mutable_spec() { return spec; }
        void set_spec(const std::shared_ptr<Spec> & value) { this->spec = value; }

        /**
         * An object that describes what fields should be repeated into views that are laid out as a
         * `row` or `column`.
         */
        const std::optional<Repeat> & get_repeat() const { return repeat; }
        std::optional<Repeat> & get_mutable_repeat() { return repeat; }
        void set_repeat(const std::optional<Repeat> & value) { this->repeat = value; }

        /**
         * A list of views that should be concatenated and put into a column.
         */
        const std::optional<std::vector<Spec>> & get_vconcat() const { return vconcat; }
        std::optional<std::vector<Spec>> & get_mutable_vconcat() { return vconcat; }
        void set_vconcat(const std::optional<std::vector<Spec>> & value) { this->vconcat = value; }

        /**
         * A list of views that should be concatenated and put into a row.
         */
        const std::optional<std::vector<Spec>> & get_hconcat() const { return hconcat; }
        std::optional<std::vector<Spec>> & get_mutable_hconcat() { return hconcat; }
        void set_hconcat(const std::optional<std::vector<Spec>> & value) { this->hconcat = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::optional<std::string> schema;
        std::optional<Autosize> autosize;
        std::optional<std::string> background;
        std::optional<Config> config;
        std::optional<Data> data;
        std::optional<std::string> description;
        std::optional<EncodingWithFacet> encoding;
        std::optional<double> height;
        std::optional<AnyMark> mark;
        std::optional<std::string> name;
        std::optional<Padding> padding;
        std::optional<Projection> projection;
        std::optional<std::map<std::string, SelectionDef>> selection;
        std::optional<Title> title;
        std::optional<std::vector<Transform>> transform;
        std::optional<double> width;
        std::optional<std::vector<LayerSpec>> layer;
        std::optional<Resolve> resolve;
        std::optional<FacetMapping> facet;
        std::shared_ptr<Spec> spec;
        std::optional<Repeat> repeat;
        std::optional<std::vector<Spec>> vconcat;
        std::optional<std::vector<Spec>> hconcat;

        public:
        /**
         * URL to [JSON schema](http://json-schema.org/) for a Vega-Lite specification. Unless you
         * have a reason to change this, use `https://vega.github.io/schema/vega-lite/v2.json`.
         * Setting the `$schema` property allows automatic validation and autocomplete in editors
         * that support JSON schema.
         */
        const std::optional<std::string> & get_schema() const { return schema; }
        std::optional<std::string> & get_mutable_schema() { return schema; }
        void set_schema(const std::optional<std::string> & value) { this->schema = value; }

        /**
         * Sets how the visualization size should be determined. If a string, should be one of
         * `"pad"`, `"fit"` or `"none"`.
         * Object values can additionally specify parameters for content sizing and automatic
         * resizing.
         * `"fit"` is only supported for single and layered views that don't use `rangeStep`.
         *
         * __Default value__: `pad`
         */
        const std::optional<Autosize> & get_autosize() const { return autosize; }
        std::optional<Autosize> & get_mutable_autosize() { return autosize; }
        void set_autosize(const std::optional<Autosize> & value) { this->autosize = value; }

        /**
         * CSS color property to use as the background of visualization.
         *
         * __Default value:__ none (transparent)
         */
        const std::optional<std::string> & get_background() const { return background; }
        std::optional<std::string> & get_mutable_background() { return background; }
        void set_background(const std::optional<std::string> & value) { this->background = value; }

        /**
         * Vega-Lite configuration object.  This property can only be defined at the top-level of a
         * specification.
         */
        const std::optional<Config> & get_config() const { return config; }
        std::optional<Config> & get_mutable_config() { return config; }
        void set_config(const std::optional<Config> & value) { this->config = value; }

        /**
         * An object describing the data source
         */
        const std::optional<Data> & get_data() const { return data; }
        std::optional<Data> & get_mutable_data() { return data; }
        void set_data(const std::optional<Data> & value) { this->data = value; }

        /**
         * Description of this mark for commenting purpose.
         */
        const std::optional<std::string> & get_description() const { return description; }
        std::optional<std::string> & get_mutable_description() { return description; }
        void set_description(const std::optional<std::string> & value) { this->description = value; }

        /**
         * A key-value mapping between encoding channels and definition of fields.
         */
        const std::optional<EncodingWithFacet> & get_encoding() const { return encoding; }
        std::optional<EncodingWithFacet> & get_mutable_encoding() { return encoding; }
        void set_encoding(const std::optional<EncodingWithFacet> & value) { this->encoding = value; }

        /**
         * The height of a visualization.
         *
         * __Default value:__
         * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its y-channel has a
         * [continuous scale](scale.html#continuous), the height will be the value of
         * [`config.view.height`](spec.html#config).
         * - For y-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
         * value or unspecified, the height is [determined by the range step, paddings, and the
         * cardinality of the field mapped to y-channel](scale.html#band). Otherwise, if the
         * `rangeStep` is `null`, the height will be the value of
         * [`config.view.height`](spec.html#config).
         * - If no field is mapped to `y` channel, the `height` will be the value of `rangeStep`.
         *
         * __Note__: For plots with [`row` and `column` channels](encoding.html#facet), this
         * represents the height of a single view.
         *
         * __See also:__ The documentation for [width and height](size.html) contains more examples.
         */
        const std::optional<double> & get_height() const { return height; }
        std::optional<double> & get_mutable_height() { return height; }
        void set_height(const std::optional<double> & value) { this->height = value; }

        /**
         * A string describing the mark type (one of `"bar"`, `"circle"`, `"square"`, `"tick"`,
         * `"line"`,
         * * `"area"`, `"point"`, `"rule"`, `"geoshape"`, and `"text"`) or a [mark definition
         * object](mark.html#mark-def).
         */
        const std::optional<AnyMark> & get_mark() const { return mark; }
        std::optional<AnyMark> & get_mutable_mark() { return mark; }
        void set_mark(const std::optional<AnyMark> & value) { this->mark = value; }

        /**
         * Name of the visualization for later reference.
         */
        const std::optional<std::string> & get_name() const { return name; }
        std::optional<std::string> & get_mutable_name() { return name; }
        void set_name(const std::optional<std::string> & value) { this->name = value; }

        /**
         * The default visualization padding, in pixels, from the edge of the visualization canvas
         * to the data rectangle.  If a number, specifies padding for all sides.
         * If an object, the value should have the format `{"left": 5, "top": 5, "right": 5,
         * "bottom": 5}` to specify padding for each side of the visualization.
         *
         * __Default value__: `5`
         */
        const std::optional<Padding> & get_padding() const { return padding; }
        std::optional<Padding> & get_mutable_padding() { return padding; }
        void set_padding(const std::optional<Padding> & value) { this->padding = value; }

        /**
         * An object defining properties of geographic projection.
         *
         * Works with `"geoshape"` marks and `"point"` or `"line"` marks that have a channel (one or
         * more of `"X"`, `"X2"`, `"Y"`, `"Y2"`) with type `"latitude"`, or `"longitude"`.
         */
        const std::optional<Projection> & get_projection() const { return projection; }
        std::optional<Projection> & get_mutable_projection() { return projection; }
        void set_projection(const std::optional<Projection> & value) { this->projection = value; }

        /**
         * A key-value mapping between selection names and definitions.
         */
        const std::optional<std::map<std::string, SelectionDef>> & get_selection() const { return selection; }
        std::optional<std::map<std::string, SelectionDef>> & get_mutable_selection() { return selection; }
        void set_selection(const std::optional<std::map<std::string, SelectionDef>> & value) { this->selection = value; }

        /**
         * Title for the plot.
         */
        const std::optional<Title> & get_title() const { return title; }
        std::optional<Title> & get_mutable_title() { return title; }
        void set_title(const std::optional<Title> & value) { this->title = value; }

        /**
         * An array of data transformations such as filter and new field calculation.
         */
        const std::optional<std::vector<Transform>> & get_transform() const { return transform; }
        std::optional<std::vector<Transform>> & get_mutable_transform() { return transform; }
        void set_transform(const std::optional<std::vector<Transform>> & value) { this->transform = value; }

        /**
         * The width of a visualization.
         *
         * __Default value:__ This will be determined by the following rules:
         *
         * - If a view's [`autosize`](size.html#autosize) type is `"fit"` or its x-channel has a
         * [continuous scale](scale.html#continuous), the width will be the value of
         * [`config.view.width`](spec.html#config).
         * - For x-axis with a band or point scale: if [`rangeStep`](scale.html#band) is a numeric
         * value or unspecified, the width is [determined by the range step, paddings, and the
         * cardinality of the field mapped to x-channel](scale.html#band).   Otherwise, if the
         * `rangeStep` is `null`, the width will be the value of
         * [`config.view.width`](spec.html#config).
         * - If no field is mapped to `x` channel, the `width` will be the value of
         * [`config.scale.textXRangeStep`](size.html#default-width-and-height) for `text` mark and
         * the value of `rangeStep` for other marks.
         *
         * __Note:__ For plots with [`row` and `column` channels](encoding.html#facet), this
         * represents the width of a single view.
         *
         * __See also:__ The documentation for [width and height](size.html) contains more examples.
         */
        const std::optional<double> & get_width() const { return width; }
        std::optional<double> & get_mutable_width() { return width; }
        void set_width(const std::optional<double> & value) { this->width = value; }

        /**
         * Layer or single view specifications to be layered.
         *
         * __Note__: Specifications inside `layer` cannot use `row` and `column` channels as
         * layering facet specifications is not allowed.
         */
        const std::optional<std::vector<LayerSpec>> & get_layer() const { return layer; }
        std::optional<std::vector<LayerSpec>> & get_mutable_layer() { return layer; }
        void set_layer(const std::optional<std::vector<LayerSpec>> & value) { this->layer = value; }

        /**
         * Scale, axis, and legend resolutions for layers.
         *
         * Scale, axis, and legend resolutions for facets.
         *
         * Scale and legend resolutions for repeated charts.
         *
         * Scale, axis, and legend resolutions for vertically concatenated charts.
         *
         * Scale, axis, and legend resolutions for horizontally concatenated charts.
         */
        const std::optional<Resolve> & get_resolve() const { return resolve; }
        std::optional<Resolve> & get_mutable_resolve() { return resolve; }
        void set_resolve(const std::optional<Resolve> & value) { this->resolve = value; }

        /**
         * An object that describes mappings between `row` and `column` channels and their field
         * definitions.
         */
        const std::optional<FacetMapping> & get_facet() const { return facet; }
        std::optional<FacetMapping> & get_mutable_facet() { return facet; }
        void set_facet(const std::optional<FacetMapping> & value) { this->facet = value; }

        /**
         * A specification of the view that gets faceted.
         */
        const std::shared_ptr<Spec> & get_spec() const { return spec; }
        std::shared_ptr<Spec> & get_mutable_spec() { return spec; }
        void set_spec(const std::shared_ptr<Spec> & value) { this->spec = value; }

        /**
         * An object that describes what fields should be repeated into views that are laid out as a
         * `row` or `column`.
         */
        const std::optional<Repeat> & get_repeat() const { return repeat; }
        std::optional<Repeat> & get_mutable_repeat() { return repeat; }
        void set_repeat(const std::optional<Repeat> & value) { this->repeat = value; }

        /**
         * A list of views that should be concatenated and put into a column.
         */
        const std::optional<std::vector<Spec>> & get_vconcat() const { return vconcat; }
        std::optional<std::vector<Spec>> & get_mutable_vconcat() { return vconcat; }
        void set_vconcat(const std::optional<std::vector<Spec>> & value) { this->vconcat = value; }

        /**
         * A list of views that should be concatenated and put into a row.
         */
        const std::optional<std::vector<Spec>> & get_hconcat() const { return hconcat; }
        std::optional<std::vector<Spec>> & get_mutable_hconcat() { return hconcat; }
        void set_hconcat(const std::optional<std::vector<Spec>> & value) { this->hconcat = value; }
    };
}

namespace quicktype {
void from_json(const json & j, AutoSizeParams & x);
void to_json(json & j, const AutoSizeParams & x);

void from_json(const json & j, MarkConfig & x);
void to_json(json & j, const MarkConfig & x);

void from_json(const json & j, AxisConfig & x);
void to_json(json & j, const AxisConfig & x);

void from_json(const json & j, VgAxisConfig & x);
void to_json(json & j, const VgAxisConfig & x);

void from_json(const json & j, BarConfig & x);
void to_json(json & j, const BarConfig & x);

void from_json(const json & j, LegendConfig & x);
void to_json(json & j, const LegendConfig & x);

void from_json(const json & j, PaddingClass & x);
void to_json(json & j, const PaddingClass & x);

void from_json(const json & j, ProjectionConfig & x);
void to_json(json & j, const ProjectionConfig & x);

void from_json(const json & j, VgScheme & x);
void to_json(json & j, const VgScheme & x);

void from_json(const json & j, ScaleConfig & x);
void to_json(json & j, const ScaleConfig & x);

void from_json(const json & j, BrushConfig & x);
void to_json(json & j, const BrushConfig & x);

void from_json(const json & j, IntervalSelectionConfig & x);
void to_json(json & j, const IntervalSelectionConfig & x);

void from_json(const json & j, MultiSelectionConfig & x);
void to_json(json & j, const MultiSelectionConfig & x);

void from_json(const json & j, VgBinding & x);
void to_json(json & j, const VgBinding & x);

void from_json(const json & j, SingleSelectionConfig & x);
void to_json(json & j, const SingleSelectionConfig & x);

void from_json(const json & j, SelectionConfig & x);
void to_json(json & j, const SelectionConfig & x);

void from_json(const json & j, VgMarkConfig & x);
void to_json(json & j, const VgMarkConfig & x);

void from_json(const json & j, TextConfig & x);
void to_json(json & j, const TextConfig & x);

void from_json(const json & j, TickConfig & x);
void to_json(json & j, const TickConfig & x);

void from_json(const json & j, VgTitleConfig & x);
void to_json(json & j, const VgTitleConfig & x);

void from_json(const json & j, ViewConfig & x);
void to_json(json & j, const ViewConfig & x);

void from_json(const json & j, Config & x);
void to_json(json & j, const Config & x);

void from_json(const json & j, DataFormat & x);
void to_json(json & j, const DataFormat & x);

void from_json(const json & j, Data & x);
void to_json(json & j, const Data & x);

void from_json(const json & j, BinParams & x);
void to_json(json & j, const BinParams & x);

void from_json(const json & j, Selection & x);
void to_json(json & j, const Selection & x);

void from_json(const json & j, DateTime & x);
void to_json(json & j, const DateTime & x);

void from_json(const json & j, Predicate & x);
void to_json(json & j, const Predicate & x);

void from_json(const json & j, ConditionalValueDef & x);
void to_json(json & j, const ConditionalValueDef & x);

void from_json(const json & j, RepeatRef & x);
void to_json(json & j, const RepeatRef & x);

void from_json(const json & j, Legend & x);
void to_json(json & j, const Legend & x);

void from_json(const json & j, DomainClass & x);
void to_json(json & j, const DomainClass & x);

void from_json(const json & j, InterpolateParams & x);
void to_json(json & j, const InterpolateParams & x);

void from_json(const json & j, NiceClass & x);
void to_json(json & j, const NiceClass & x);

void from_json(const json & j, SchemeParams & x);
void to_json(json & j, const SchemeParams & x);

void from_json(const json & j, Scale & x);
void to_json(json & j, const Scale & x);

void from_json(const json & j, SortField & x);
void to_json(json & j, const SortField & x);

void from_json(const json & j, ConditionalPredicateMarkPropFieldDefClass & x);
void to_json(json & j, const ConditionalPredicateMarkPropFieldDefClass & x);

void from_json(const json & j, MarkPropDefWithCondition & x);
void to_json(json & j, const MarkPropDefWithCondition & x);

void from_json(const json & j, Header & x);
void to_json(json & j, const Header & x);

void from_json(const json & j, FacetFieldDef & x);
void to_json(json & j, const FacetFieldDef & x);

void from_json(const json & j, FieldDef & x);
void to_json(json & j, const FieldDef & x);

void from_json(const json & j, ConditionalPredicateFieldDefClass & x);
void to_json(json & j, const ConditionalPredicateFieldDefClass & x);

void from_json(const json & j, DefWithCondition & x);
void to_json(json & j, const DefWithCondition & x);

void from_json(const json & j, OrderFieldDef & x);
void to_json(json & j, const OrderFieldDef & x);

void from_json(const json & j, ConditionalPredicateTextFieldDefClass & x);
void to_json(json & j, const ConditionalPredicateTextFieldDefClass & x);

void from_json(const json & j, TextDefWithCondition & x);
void to_json(json & j, const TextDefWithCondition & x);

void from_json(const json & j, Axis & x);
void to_json(json & j, const Axis & x);

void from_json(const json & j, XClass & x);
void to_json(json & j, const XClass & x);

void from_json(const json & j, X2Class & x);
void to_json(json & j, const X2Class & x);

void from_json(const json & j, EncodingWithFacet & x);
void to_json(json & j, const EncodingWithFacet & x);

void from_json(const json & j, FacetMapping & x);
void to_json(json & j, const FacetMapping & x);

void from_json(const json & j, Encoding & x);
void to_json(json & j, const Encoding & x);

void from_json(const json & j, MarkDef & x);
void to_json(json & j, const MarkDef & x);

void from_json(const json & j, Projection & x);
void to_json(json & j, const Projection & x);

void from_json(const json & j, AxisResolveMap & x);
void to_json(json & j, const AxisResolveMap & x);

void from_json(const json & j, LegendResolveMap & x);
void to_json(json & j, const LegendResolveMap & x);

void from_json(const json & j, ScaleResolveMap & x);
void to_json(json & j, const ScaleResolveMap & x);

void from_json(const json & j, Resolve & x);
void to_json(json & j, const Resolve & x);

void from_json(const json & j, SelectionDef & x);
void to_json(json & j, const SelectionDef & x);

void from_json(const json & j, TitleParams & x);
void to_json(json & j, const TitleParams & x);

void from_json(const json & j, AggregatedFieldDef & x);
void to_json(json & j, const AggregatedFieldDef & x);

void from_json(const json & j, LookupData & x);
void to_json(json & j, const LookupData & x);

void from_json(const json & j, Transform & x);
void to_json(json & j, const Transform & x);

void from_json(const json & j, LayerSpec & x);
void to_json(json & j, const LayerSpec & x);

void from_json(const json & j, Repeat & x);
void to_json(json & j, const Repeat & x);

void from_json(const json & j, Spec & x);
void to_json(json & j, const Spec & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);

void from_json(const json & j, Contains & x);
void to_json(json & j, const Contains & x);

void from_json(const json & j, AutosizeType & x);
void to_json(json & j, const AutosizeType & x);

void from_json(const json & j, HorizontalAlign & x);
void to_json(json & j, const HorizontalAlign & x);

void from_json(const json & j, VerticalAlign & x);
void to_json(json & j, const VerticalAlign & x);

void from_json(const json & j, Cursor & x);
void to_json(json & j, const Cursor & x);

void from_json(const json & j, FontStyle & x);
void to_json(json & j, const FontStyle & x);

void from_json(const json & j, FontWeight & x);
void to_json(json & j, const FontWeight & x);

void from_json(const json & j, Interpolate & x);
void to_json(json & j, const Interpolate & x);

void from_json(const json & j, Orient & x);
void to_json(json & j, const Orient & x);

void from_json(const json & j, LabelOverlapEnum & x);
void to_json(json & j, const LabelOverlapEnum & x);

void from_json(const json & j, FieldTitle & x);
void to_json(json & j, const FieldTitle & x);

void from_json(const json & j, InvalidValues & x);
void to_json(json & j, const InvalidValues & x);

void from_json(const json & j, LegendOrient & x);
void to_json(json & j, const LegendOrient & x);

void from_json(const json & j, VgProjectionType & x);
void to_json(json & j, const VgProjectionType & x);

void from_json(const json & j, BindEnum & x);
void to_json(json & j, const BindEnum & x);

void from_json(const json & j, Empty & x);
void to_json(json & j, const Empty & x);

void from_json(const json & j, SingleDefChannel & x);
void to_json(json & j, const SingleDefChannel & x);

void from_json(const json & j, SelectionResolution & x);
void to_json(json & j, const SelectionResolution & x);

void from_json(const json & j, StackOffset & x);
void to_json(json & j, const StackOffset & x);

void from_json(const json & j, Anchor & x);
void to_json(json & j, const Anchor & x);

void from_json(const json & j, TitleOrient & x);
void to_json(json & j, const TitleOrient & x);

void from_json(const json & j, ParseEnum & x);
void to_json(json & j, const ParseEnum & x);

void from_json(const json & j, DataFormatType & x);
void to_json(json & j, const DataFormatType & x);

void from_json(const json & j, AggregateOp & x);
void to_json(json & j, const AggregateOp & x);

void from_json(const json & j, TimeUnit & x);
void to_json(json & j, const TimeUnit & x);

void from_json(const json & j, RepeatEnum & x);
void to_json(json & j, const RepeatEnum & x);

void from_json(const json & j, LegendType & x);
void to_json(json & j, const LegendType & x);

void from_json(const json & j, Domain & x);
void to_json(json & j, const Domain & x);

void from_json(const json & j, InterpolateParamsType & x);
void to_json(json & j, const InterpolateParamsType & x);

void from_json(const json & j, NiceTime & x);
void to_json(json & j, const NiceTime & x);

void from_json(const json & j, ScaleType & x);
void to_json(json & j, const ScaleType & x);

void from_json(const json & j, SortEnum & x);
void to_json(json & j, const SortEnum & x);

void from_json(const json & j, Type & x);
void to_json(json & j, const Type & x);

void from_json(const json & j, Mark & x);
void to_json(json & j, const Mark & x);

void from_json(const json & j, ResolveMode & x);
void to_json(json & j, const ResolveMode & x);

void from_json(const json & j, SelectionDefType & x);
void to_json(json & j, const SelectionDefType & x);

void from_json(const json & j, SelectionOperand & x);
void to_json(json & j, const SelectionOperand & x);

void from_json(const json & j, LogicalOperandPredicate & x);
void to_json(json & j, const LogicalOperandPredicate & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::AutoSizeParams, quicktype::AutosizeType>> {
    static void from_json(const json & j, std::variant<quicktype::AutoSizeParams, quicktype::AutosizeType> & x);
    static void to_json(json & j, const std::variant<quicktype::AutoSizeParams, quicktype::AutosizeType> & x);
};

template <>
struct adl_serializer<std::variant<double, quicktype::FontWeight>> {
    static void from_json(const json & j, std::variant<double, quicktype::FontWeight> & x);
    static void to_json(json & j, const std::variant<double, quicktype::FontWeight> & x);
};

template <>
struct adl_serializer<std::variant<bool, double>> {
    static void from_json(const json & j, std::variant<bool, double> & x);
    static void to_json(json & j, const std::variant<bool, double> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::LabelOverlapEnum>> {
    static void from_json(const json & j, std::variant<bool, quicktype::LabelOverlapEnum> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::LabelOverlapEnum> & x);
};

template <>
struct adl_serializer<std::variant<double, std::string>> {
    static void from_json(const json & j, std::variant<double, std::string> & x);
    static void to_json(json & j, const std::variant<double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::PaddingClass, double>> {
    static void from_json(const json & j, std::variant<quicktype::PaddingClass, double> & x);
    static void to_json(json & j, const std::variant<quicktype::PaddingClass, double> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::TitleFontWeight>, quicktype::VgScheme>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::TitleFontWeight>, quicktype::VgScheme> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::TitleFontWeight>, quicktype::VgScheme> & x);
};

template <>
struct adl_serializer<std::variant<bool, std::string>> {
    static void from_json(const json & j, std::variant<bool, std::string> & x);
    static void to_json(json & j, const std::variant<bool, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::ParseEnum, std::map<std::string, json>>> {
    static void from_json(const json & j, std::variant<quicktype::ParseEnum, std::map<std::string, json>> & x);
    static void to_json(json & j, const std::variant<quicktype::ParseEnum, std::map<std::string, json>> & x);
};

template <>
struct adl_serializer<std::variant<bool, double, std::map<std::string, json>, std::string>> {
    static void from_json(const json & j, std::variant<bool, double, std::map<std::string, json>, std::string> & x);
    static void to_json(json & j, const std::variant<bool, double, std::map<std::string, json>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::ValuesValue>, std::map<std::string, json>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::ValuesValue>, std::map<std::string, json>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::ValuesValue>, std::map<std::string, json>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::BinParams>> {
    static void from_json(const json & j, std::variant<bool, quicktype::BinParams> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::BinParams> & x);
};

template <>
struct adl_serializer<std::variant<std::shared_ptr<quicktype::Selection>, std::string>> {
    static void from_json(const json & j, std::variant<std::shared_ptr<quicktype::Selection>, std::string> & x);
    static void to_json(json & j, const std::variant<std::shared_ptr<quicktype::Selection>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::DateTime, double, std::string>> {
    static void from_json(const json & j, std::variant<bool, quicktype::DateTime, double, std::string> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::DateTime, double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DateTime, double>> {
    static void from_json(const json & j, std::variant<quicktype::DateTime, double> & x);
    static void to_json(json & j, const std::variant<quicktype::DateTime, double> & x);
};

template <>
struct adl_serializer<std::variant<std::shared_ptr<quicktype::Predicate>, std::string>> {
    static void from_json(const json & j, std::variant<std::shared_ptr<quicktype::Predicate>, std::string> & x);
    static void to_json(json & j, const std::variant<std::shared_ptr<quicktype::Predicate>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<bool, double, std::string>> {
    static void from_json(const json & j, std::variant<bool, double, std::string> & x);
    static void to_json(json & j, const std::variant<bool, double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::RepeatRef, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::RepeatRef, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::RepeatRef, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::DateTime, double, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::DateTime, double, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::DateTime, double, std::string> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::Equal>, quicktype::DomainClass, quicktype::Domain>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::Equal>, quicktype::DomainClass, quicktype::Domain> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::Equal>, quicktype::DomainClass, quicktype::Domain> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::InterpolateParams, quicktype::Interpolate>> {
    static void from_json(const json & j, std::variant<quicktype::InterpolateParams, quicktype::Interpolate> & x);
    static void to_json(json & j, const std::variant<quicktype::InterpolateParams, quicktype::Interpolate> & x);
};

template <>
struct adl_serializer<std::variant<bool, quicktype::NiceClass, double, quicktype::NiceTime>> {
    static void from_json(const json & j, std::variant<bool, quicktype::NiceClass, double, quicktype::NiceTime> & x);
    static void to_json(json & j, const std::variant<bool, quicktype::NiceClass, double, quicktype::NiceTime> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::TitleFontWeight>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::TitleFontWeight>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::TitleFontWeight>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SchemeParams, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::SchemeParams, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::SchemeParams, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::SortField, quicktype::SortEnum>> {
    static void from_json(const json & j, std::variant<quicktype::SortField, quicktype::SortEnum> & x);
    static void to_json(json & j, const std::variant<quicktype::SortField, quicktype::SortEnum> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateMarkPropFieldDefClass>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateMarkPropFieldDefClass> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateMarkPropFieldDefClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::FieldDef>, quicktype::FieldDef>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::FieldDef>, quicktype::FieldDef> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::FieldDef>, quicktype::FieldDef> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateFieldDefClass>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateFieldDefClass> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateFieldDefClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::OrderFieldDef>, quicktype::OrderFieldDef>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::OrderFieldDef>, quicktype::OrderFieldDef> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::OrderFieldDef>, quicktype::OrderFieldDef> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateTextFieldDefClass>> {
    static void from_json(const json & j, std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateTextFieldDefClass> & x);
    static void to_json(json & j, const std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateTextFieldDefClass> & x);
};

template <>
struct adl_serializer<std::variant<std::vector<std::string>, std::string>> {
    static void from_json(const json & j, std::variant<std::vector<std::string>, std::string> & x);
    static void to_json(json & j, const std::variant<std::vector<std::string>, std::string> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::MarkDef, quicktype::Mark>> {
    static void from_json(const json & j, std::variant<quicktype::MarkDef, quicktype::Mark> & x);
    static void to_json(json & j, const std::variant<quicktype::MarkDef, quicktype::Mark> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::BindEnum, std::map<std::string, quicktype::VgBinding>>> {
    static void from_json(const json & j, std::variant<quicktype::BindEnum, std::map<std::string, quicktype::VgBinding>> & x);
    static void to_json(json & j, const std::variant<quicktype::BindEnum, std::map<std::string, quicktype::VgBinding>> & x);
};

template <>
struct adl_serializer<std::variant<quicktype::TitleParams, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::TitleParams, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::TitleParams, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, AutoSizeParams& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("contains") != j.end() && j.at("contains").is_null()) throw std::runtime_error("Unexpected null");
        x.set_contains(get_stack_optional<Contains>(j, "contains"));
        if (j.find("resize") != j.end() && j.at("resize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resize(get_stack_optional<bool>(j, "resize"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<AutosizeType>(j, "type"));
    }

    inline void to_json(json & j, const AutoSizeParams & x) {
        j = json::object();
        j["contains"] = x.get_contains();
        j["resize"] = x.get_resize();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, MarkConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("align") != j.end() && j.at("align").is_null()) throw std::runtime_error("Unexpected null");
        x.set_align(get_stack_optional<HorizontalAlign>(j, "align"));
        if (j.find("angle") != j.end() && j.at("angle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_angle(get_stack_optional<double>(j, "angle"));
        if (j.find("baseline") != j.end() && j.at("baseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_baseline(get_stack_optional<VerticalAlign>(j, "baseline"));
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<std::string>(j, "color"));
        if (j.find("cursor") != j.end() && j.at("cursor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cursor(get_stack_optional<Cursor>(j, "cursor"));
        if (j.find("dx") != j.end() && j.at("dx").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dx(get_stack_optional<double>(j, "dx"));
        if (j.find("dy") != j.end() && j.at("dy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dy(get_stack_optional<double>(j, "dy"));
        if (j.find("fill") != j.end() && j.at("fill").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill(get_stack_optional<std::string>(j, "fill"));
        if (j.find("filled") != j.end() && j.at("filled").is_null()) throw std::runtime_error("Unexpected null");
        x.set_filled(get_stack_optional<bool>(j, "filled"));
        if (j.find("fillOpacity") != j.end() && j.at("fillOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_opacity(get_stack_optional<double>(j, "fillOpacity"));
        if (j.find("font") != j.end() && j.at("font").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font(get_stack_optional<std::string>(j, "font"));
        if (j.find("fontSize") != j.end() && j.at("fontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_size(get_stack_optional<double>(j, "fontSize"));
        if (j.find("fontStyle") != j.end() && j.at("fontStyle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_style(get_stack_optional<FontStyle>(j, "fontStyle"));
        if (j.find("fontWeight") != j.end() && j.at("fontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_weight(get_stack_optional<std::variant<double, FontWeight>>(j, "fontWeight"));
        if (j.find("href") != j.end() && j.at("href").is_null()) throw std::runtime_error("Unexpected null");
        x.set_href(get_stack_optional<std::string>(j, "href"));
        if (j.find("interpolate") != j.end() && j.at("interpolate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interpolate(get_stack_optional<Interpolate>(j, "interpolate"));
        if (j.find("limit") != j.end() && j.at("limit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_limit(get_stack_optional<double>(j, "limit"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<double>(j, "opacity"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<Orient>(j, "orient"));
        if (j.find("radius") != j.end() && j.at("radius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_radius(get_stack_optional<double>(j, "radius"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<std::string>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<double>(j, "size"));
        if (j.find("stroke") != j.end() && j.at("stroke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke(get_stack_optional<std::string>(j, "stroke"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeDashOffset") != j.end() && j.at("strokeDashOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash_offset(get_stack_optional<double>(j, "strokeDashOffset"));
        if (j.find("strokeOpacity") != j.end() && j.at("strokeOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_opacity(get_stack_optional<double>(j, "strokeOpacity"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
        if (j.find("tension") != j.end() && j.at("tension").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tension(get_stack_optional<double>(j, "tension"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
        if (j.find("theta") != j.end() && j.at("theta").is_null()) throw std::runtime_error("Unexpected null");
        x.set_theta(get_stack_optional<double>(j, "theta"));
    }

    inline void to_json(json & j, const MarkConfig & x) {
        j = json::object();
        j["align"] = x.get_align();
        j["angle"] = x.get_angle();
        j["baseline"] = x.get_baseline();
        j["color"] = x.get_color();
        j["cursor"] = x.get_cursor();
        j["dx"] = x.get_dx();
        j["dy"] = x.get_dy();
        j["fill"] = x.get_fill();
        j["filled"] = x.get_filled();
        j["fillOpacity"] = x.get_fill_opacity();
        j["font"] = x.get_font();
        j["fontSize"] = x.get_font_size();
        j["fontStyle"] = x.get_font_style();
        j["fontWeight"] = x.get_font_weight();
        j["href"] = x.get_href();
        j["interpolate"] = x.get_interpolate();
        j["limit"] = x.get_limit();
        j["opacity"] = x.get_opacity();
        j["orient"] = x.get_orient();
        j["radius"] = x.get_radius();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
        j["stroke"] = x.get_stroke();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeDashOffset"] = x.get_stroke_dash_offset();
        j["strokeOpacity"] = x.get_stroke_opacity();
        j["strokeWidth"] = x.get_stroke_width();
        j["tension"] = x.get_tension();
        j["text"] = x.get_text();
        j["theta"] = x.get_theta();
    }

    inline void from_json(const json & j, AxisConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bandPosition") != j.end() && j.at("bandPosition").is_null()) throw std::runtime_error("Unexpected null");
        x.set_band_position(get_stack_optional<double>(j, "bandPosition"));
        if (j.find("domain") != j.end() && j.at("domain").is_null()) throw std::runtime_error("Unexpected null");
        x.set_domain(get_stack_optional<bool>(j, "domain"));
        if (j.find("domainColor") != j.end() && j.at("domainColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_domain_color(get_stack_optional<std::string>(j, "domainColor"));
        if (j.find("domainWidth") != j.end() && j.at("domainWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_domain_width(get_stack_optional<double>(j, "domainWidth"));
        if (j.find("grid") != j.end() && j.at("grid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid(get_stack_optional<bool>(j, "grid"));
        if (j.find("gridColor") != j.end() && j.at("gridColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid_color(get_stack_optional<std::string>(j, "gridColor"));
        if (j.find("gridDash") != j.end() && j.at("gridDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid_dash(get_stack_optional<std::vector<double>>(j, "gridDash"));
        if (j.find("gridOpacity") != j.end() && j.at("gridOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid_opacity(get_stack_optional<double>(j, "gridOpacity"));
        if (j.find("gridWidth") != j.end() && j.at("gridWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid_width(get_stack_optional<double>(j, "gridWidth"));
        if (j.find("labelAngle") != j.end() && j.at("labelAngle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_angle(get_stack_optional<double>(j, "labelAngle"));
        if (j.find("labelBound") != j.end() && j.at("labelBound").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_bound(get_stack_optional<std::variant<bool, double>>(j, "labelBound"));
        if (j.find("labelColor") != j.end() && j.at("labelColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_color(get_stack_optional<std::string>(j, "labelColor"));
        if (j.find("labelFlush") != j.end() && j.at("labelFlush").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_flush(get_stack_optional<std::variant<bool, double>>(j, "labelFlush"));
        if (j.find("labelFont") != j.end() && j.at("labelFont").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_font(get_stack_optional<std::string>(j, "labelFont"));
        if (j.find("labelFontSize") != j.end() && j.at("labelFontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_font_size(get_stack_optional<double>(j, "labelFontSize"));
        if (j.find("labelLimit") != j.end() && j.at("labelLimit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_limit(get_stack_optional<double>(j, "labelLimit"));
        if (j.find("labelOverlap") != j.end() && j.at("labelOverlap").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_overlap(get_stack_optional<std::variant<bool, LabelOverlapEnum>>(j, "labelOverlap"));
        if (j.find("labelPadding") != j.end() && j.at("labelPadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_padding(get_stack_optional<double>(j, "labelPadding"));
        if (j.find("labels") != j.end() && j.at("labels").is_null()) throw std::runtime_error("Unexpected null");
        x.set_labels(get_stack_optional<bool>(j, "labels"));
        if (j.find("maxExtent") != j.end() && j.at("maxExtent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max_extent(get_stack_optional<double>(j, "maxExtent"));
        if (j.find("minExtent") != j.end() && j.at("minExtent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min_extent(get_stack_optional<double>(j, "minExtent"));
        if (j.find("shortTimeLabels") != j.end() && j.at("shortTimeLabels").is_null()) throw std::runtime_error("Unexpected null");
        x.set_short_time_labels(get_stack_optional<bool>(j, "shortTimeLabels"));
        if (j.find("tickColor") != j.end() && j.at("tickColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_color(get_stack_optional<std::string>(j, "tickColor"));
        if (j.find("tickRound") != j.end() && j.at("tickRound").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_round(get_stack_optional<bool>(j, "tickRound"));
        if (j.find("ticks") != j.end() && j.at("ticks").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ticks(get_stack_optional<bool>(j, "ticks"));
        if (j.find("tickSize") != j.end() && j.at("tickSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_size(get_stack_optional<double>(j, "tickSize"));
        if (j.find("tickWidth") != j.end() && j.at("tickWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_width(get_stack_optional<double>(j, "tickWidth"));
        if (j.find("titleAlign") != j.end() && j.at("titleAlign").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_align(get_stack_optional<std::string>(j, "titleAlign"));
        if (j.find("titleAngle") != j.end() && j.at("titleAngle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_angle(get_stack_optional<double>(j, "titleAngle"));
        if (j.find("titleBaseline") != j.end() && j.at("titleBaseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_baseline(get_stack_optional<std::string>(j, "titleBaseline"));
        if (j.find("titleColor") != j.end() && j.at("titleColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_color(get_stack_optional<std::string>(j, "titleColor"));
        if (j.find("titleFont") != j.end() && j.at("titleFont").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font(get_stack_optional<std::string>(j, "titleFont"));
        if (j.find("titleFontSize") != j.end() && j.at("titleFontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font_size(get_stack_optional<double>(j, "titleFontSize"));
        if (j.find("titleFontWeight") != j.end() && j.at("titleFontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font_weight(get_stack_optional<std::variant<double, std::string>>(j, "titleFontWeight"));
        if (j.find("titleLimit") != j.end() && j.at("titleLimit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_limit(get_stack_optional<double>(j, "titleLimit"));
        if (j.find("titleMaxLength") != j.end() && j.at("titleMaxLength").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_max_length(get_stack_optional<double>(j, "titleMaxLength"));
        if (j.find("titlePadding") != j.end() && j.at("titlePadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_padding(get_stack_optional<double>(j, "titlePadding"));
        if (j.find("titleX") != j.end() && j.at("titleX").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_x(get_stack_optional<double>(j, "titleX"));
        if (j.find("titleY") != j.end() && j.at("titleY").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_y(get_stack_optional<double>(j, "titleY"));
    }

    inline void to_json(json & j, const AxisConfig & x) {
        j = json::object();
        j["bandPosition"] = x.get_band_position();
        j["domain"] = x.get_domain();
        j["domainColor"] = x.get_domain_color();
        j["domainWidth"] = x.get_domain_width();
        j["grid"] = x.get_grid();
        j["gridColor"] = x.get_grid_color();
        j["gridDash"] = x.get_grid_dash();
        j["gridOpacity"] = x.get_grid_opacity();
        j["gridWidth"] = x.get_grid_width();
        j["labelAngle"] = x.get_label_angle();
        j["labelBound"] = x.get_label_bound();
        j["labelColor"] = x.get_label_color();
        j["labelFlush"] = x.get_label_flush();
        j["labelFont"] = x.get_label_font();
        j["labelFontSize"] = x.get_label_font_size();
        j["labelLimit"] = x.get_label_limit();
        j["labelOverlap"] = x.get_label_overlap();
        j["labelPadding"] = x.get_label_padding();
        j["labels"] = x.get_labels();
        j["maxExtent"] = x.get_max_extent();
        j["minExtent"] = x.get_min_extent();
        j["shortTimeLabels"] = x.get_short_time_labels();
        j["tickColor"] = x.get_tick_color();
        j["tickRound"] = x.get_tick_round();
        j["ticks"] = x.get_ticks();
        j["tickSize"] = x.get_tick_size();
        j["tickWidth"] = x.get_tick_width();
        j["titleAlign"] = x.get_title_align();
        j["titleAngle"] = x.get_title_angle();
        j["titleBaseline"] = x.get_title_baseline();
        j["titleColor"] = x.get_title_color();
        j["titleFont"] = x.get_title_font();
        j["titleFontSize"] = x.get_title_font_size();
        j["titleFontWeight"] = x.get_title_font_weight();
        j["titleLimit"] = x.get_title_limit();
        j["titleMaxLength"] = x.get_title_max_length();
        j["titlePadding"] = x.get_title_padding();
        j["titleX"] = x.get_title_x();
        j["titleY"] = x.get_title_y();
    }

    inline void from_json(const json & j, VgAxisConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bandPosition") != j.end() && j.at("bandPosition").is_null()) throw std::runtime_error("Unexpected null");
        x.set_band_position(get_stack_optional<double>(j, "bandPosition"));
        if (j.find("domain") != j.end() && j.at("domain").is_null()) throw std::runtime_error("Unexpected null");
        x.set_domain(get_stack_optional<bool>(j, "domain"));
        if (j.find("domainColor") != j.end() && j.at("domainColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_domain_color(get_stack_optional<std::string>(j, "domainColor"));
        if (j.find("domainWidth") != j.end() && j.at("domainWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_domain_width(get_stack_optional<double>(j, "domainWidth"));
        if (j.find("grid") != j.end() && j.at("grid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid(get_stack_optional<bool>(j, "grid"));
        if (j.find("gridColor") != j.end() && j.at("gridColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid_color(get_stack_optional<std::string>(j, "gridColor"));
        if (j.find("gridDash") != j.end() && j.at("gridDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid_dash(get_stack_optional<std::vector<double>>(j, "gridDash"));
        if (j.find("gridOpacity") != j.end() && j.at("gridOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid_opacity(get_stack_optional<double>(j, "gridOpacity"));
        if (j.find("gridWidth") != j.end() && j.at("gridWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid_width(get_stack_optional<double>(j, "gridWidth"));
        if (j.find("labelAngle") != j.end() && j.at("labelAngle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_angle(get_stack_optional<double>(j, "labelAngle"));
        if (j.find("labelBound") != j.end() && j.at("labelBound").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_bound(get_stack_optional<std::variant<bool, double>>(j, "labelBound"));
        if (j.find("labelColor") != j.end() && j.at("labelColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_color(get_stack_optional<std::string>(j, "labelColor"));
        if (j.find("labelFlush") != j.end() && j.at("labelFlush").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_flush(get_stack_optional<std::variant<bool, double>>(j, "labelFlush"));
        if (j.find("labelFont") != j.end() && j.at("labelFont").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_font(get_stack_optional<std::string>(j, "labelFont"));
        if (j.find("labelFontSize") != j.end() && j.at("labelFontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_font_size(get_stack_optional<double>(j, "labelFontSize"));
        if (j.find("labelLimit") != j.end() && j.at("labelLimit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_limit(get_stack_optional<double>(j, "labelLimit"));
        if (j.find("labelOverlap") != j.end() && j.at("labelOverlap").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_overlap(get_stack_optional<std::variant<bool, LabelOverlapEnum>>(j, "labelOverlap"));
        if (j.find("labelPadding") != j.end() && j.at("labelPadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_padding(get_stack_optional<double>(j, "labelPadding"));
        if (j.find("labels") != j.end() && j.at("labels").is_null()) throw std::runtime_error("Unexpected null");
        x.set_labels(get_stack_optional<bool>(j, "labels"));
        if (j.find("maxExtent") != j.end() && j.at("maxExtent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max_extent(get_stack_optional<double>(j, "maxExtent"));
        if (j.find("minExtent") != j.end() && j.at("minExtent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min_extent(get_stack_optional<double>(j, "minExtent"));
        if (j.find("tickColor") != j.end() && j.at("tickColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_color(get_stack_optional<std::string>(j, "tickColor"));
        if (j.find("tickRound") != j.end() && j.at("tickRound").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_round(get_stack_optional<bool>(j, "tickRound"));
        if (j.find("ticks") != j.end() && j.at("ticks").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ticks(get_stack_optional<bool>(j, "ticks"));
        if (j.find("tickSize") != j.end() && j.at("tickSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_size(get_stack_optional<double>(j, "tickSize"));
        if (j.find("tickWidth") != j.end() && j.at("tickWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_width(get_stack_optional<double>(j, "tickWidth"));
        if (j.find("titleAlign") != j.end() && j.at("titleAlign").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_align(get_stack_optional<std::string>(j, "titleAlign"));
        if (j.find("titleAngle") != j.end() && j.at("titleAngle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_angle(get_stack_optional<double>(j, "titleAngle"));
        if (j.find("titleBaseline") != j.end() && j.at("titleBaseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_baseline(get_stack_optional<std::string>(j, "titleBaseline"));
        if (j.find("titleColor") != j.end() && j.at("titleColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_color(get_stack_optional<std::string>(j, "titleColor"));
        if (j.find("titleFont") != j.end() && j.at("titleFont").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font(get_stack_optional<std::string>(j, "titleFont"));
        if (j.find("titleFontSize") != j.end() && j.at("titleFontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font_size(get_stack_optional<double>(j, "titleFontSize"));
        if (j.find("titleFontWeight") != j.end() && j.at("titleFontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font_weight(get_stack_optional<std::variant<double, std::string>>(j, "titleFontWeight"));
        if (j.find("titleLimit") != j.end() && j.at("titleLimit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_limit(get_stack_optional<double>(j, "titleLimit"));
        if (j.find("titleMaxLength") != j.end() && j.at("titleMaxLength").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_max_length(get_stack_optional<double>(j, "titleMaxLength"));
        if (j.find("titlePadding") != j.end() && j.at("titlePadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_padding(get_stack_optional<double>(j, "titlePadding"));
        if (j.find("titleX") != j.end() && j.at("titleX").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_x(get_stack_optional<double>(j, "titleX"));
        if (j.find("titleY") != j.end() && j.at("titleY").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_y(get_stack_optional<double>(j, "titleY"));
    }

    inline void to_json(json & j, const VgAxisConfig & x) {
        j = json::object();
        j["bandPosition"] = x.get_band_position();
        j["domain"] = x.get_domain();
        j["domainColor"] = x.get_domain_color();
        j["domainWidth"] = x.get_domain_width();
        j["grid"] = x.get_grid();
        j["gridColor"] = x.get_grid_color();
        j["gridDash"] = x.get_grid_dash();
        j["gridOpacity"] = x.get_grid_opacity();
        j["gridWidth"] = x.get_grid_width();
        j["labelAngle"] = x.get_label_angle();
        j["labelBound"] = x.get_label_bound();
        j["labelColor"] = x.get_label_color();
        j["labelFlush"] = x.get_label_flush();
        j["labelFont"] = x.get_label_font();
        j["labelFontSize"] = x.get_label_font_size();
        j["labelLimit"] = x.get_label_limit();
        j["labelOverlap"] = x.get_label_overlap();
        j["labelPadding"] = x.get_label_padding();
        j["labels"] = x.get_labels();
        j["maxExtent"] = x.get_max_extent();
        j["minExtent"] = x.get_min_extent();
        j["tickColor"] = x.get_tick_color();
        j["tickRound"] = x.get_tick_round();
        j["ticks"] = x.get_ticks();
        j["tickSize"] = x.get_tick_size();
        j["tickWidth"] = x.get_tick_width();
        j["titleAlign"] = x.get_title_align();
        j["titleAngle"] = x.get_title_angle();
        j["titleBaseline"] = x.get_title_baseline();
        j["titleColor"] = x.get_title_color();
        j["titleFont"] = x.get_title_font();
        j["titleFontSize"] = x.get_title_font_size();
        j["titleFontWeight"] = x.get_title_font_weight();
        j["titleLimit"] = x.get_title_limit();
        j["titleMaxLength"] = x.get_title_max_length();
        j["titlePadding"] = x.get_title_padding();
        j["titleX"] = x.get_title_x();
        j["titleY"] = x.get_title_y();
    }

    inline void from_json(const json & j, BarConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("align") != j.end() && j.at("align").is_null()) throw std::runtime_error("Unexpected null");
        x.set_align(get_stack_optional<HorizontalAlign>(j, "align"));
        if (j.find("angle") != j.end() && j.at("angle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_angle(get_stack_optional<double>(j, "angle"));
        if (j.find("baseline") != j.end() && j.at("baseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_baseline(get_stack_optional<VerticalAlign>(j, "baseline"));
        if (j.find("binSpacing") != j.end() && j.at("binSpacing").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin_spacing(get_stack_optional<double>(j, "binSpacing"));
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<std::string>(j, "color"));
        if (j.find("continuousBandSize") != j.end() && j.at("continuousBandSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_continuous_band_size(get_stack_optional<double>(j, "continuousBandSize"));
        if (j.find("cursor") != j.end() && j.at("cursor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cursor(get_stack_optional<Cursor>(j, "cursor"));
        if (j.find("discreteBandSize") != j.end() && j.at("discreteBandSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_discrete_band_size(get_stack_optional<double>(j, "discreteBandSize"));
        if (j.find("dx") != j.end() && j.at("dx").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dx(get_stack_optional<double>(j, "dx"));
        if (j.find("dy") != j.end() && j.at("dy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dy(get_stack_optional<double>(j, "dy"));
        if (j.find("fill") != j.end() && j.at("fill").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill(get_stack_optional<std::string>(j, "fill"));
        if (j.find("filled") != j.end() && j.at("filled").is_null()) throw std::runtime_error("Unexpected null");
        x.set_filled(get_stack_optional<bool>(j, "filled"));
        if (j.find("fillOpacity") != j.end() && j.at("fillOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_opacity(get_stack_optional<double>(j, "fillOpacity"));
        if (j.find("font") != j.end() && j.at("font").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font(get_stack_optional<std::string>(j, "font"));
        if (j.find("fontSize") != j.end() && j.at("fontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_size(get_stack_optional<double>(j, "fontSize"));
        if (j.find("fontStyle") != j.end() && j.at("fontStyle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_style(get_stack_optional<FontStyle>(j, "fontStyle"));
        if (j.find("fontWeight") != j.end() && j.at("fontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_weight(get_stack_optional<std::variant<double, FontWeight>>(j, "fontWeight"));
        if (j.find("href") != j.end() && j.at("href").is_null()) throw std::runtime_error("Unexpected null");
        x.set_href(get_stack_optional<std::string>(j, "href"));
        if (j.find("interpolate") != j.end() && j.at("interpolate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interpolate(get_stack_optional<Interpolate>(j, "interpolate"));
        if (j.find("limit") != j.end() && j.at("limit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_limit(get_stack_optional<double>(j, "limit"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<double>(j, "opacity"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<Orient>(j, "orient"));
        if (j.find("radius") != j.end() && j.at("radius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_radius(get_stack_optional<double>(j, "radius"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<std::string>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<double>(j, "size"));
        if (j.find("stroke") != j.end() && j.at("stroke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke(get_stack_optional<std::string>(j, "stroke"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeDashOffset") != j.end() && j.at("strokeDashOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash_offset(get_stack_optional<double>(j, "strokeDashOffset"));
        if (j.find("strokeOpacity") != j.end() && j.at("strokeOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_opacity(get_stack_optional<double>(j, "strokeOpacity"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
        if (j.find("tension") != j.end() && j.at("tension").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tension(get_stack_optional<double>(j, "tension"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
        if (j.find("theta") != j.end() && j.at("theta").is_null()) throw std::runtime_error("Unexpected null");
        x.set_theta(get_stack_optional<double>(j, "theta"));
    }

    inline void to_json(json & j, const BarConfig & x) {
        j = json::object();
        j["align"] = x.get_align();
        j["angle"] = x.get_angle();
        j["baseline"] = x.get_baseline();
        j["binSpacing"] = x.get_bin_spacing();
        j["color"] = x.get_color();
        j["continuousBandSize"] = x.get_continuous_band_size();
        j["cursor"] = x.get_cursor();
        j["discreteBandSize"] = x.get_discrete_band_size();
        j["dx"] = x.get_dx();
        j["dy"] = x.get_dy();
        j["fill"] = x.get_fill();
        j["filled"] = x.get_filled();
        j["fillOpacity"] = x.get_fill_opacity();
        j["font"] = x.get_font();
        j["fontSize"] = x.get_font_size();
        j["fontStyle"] = x.get_font_style();
        j["fontWeight"] = x.get_font_weight();
        j["href"] = x.get_href();
        j["interpolate"] = x.get_interpolate();
        j["limit"] = x.get_limit();
        j["opacity"] = x.get_opacity();
        j["orient"] = x.get_orient();
        j["radius"] = x.get_radius();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
        j["stroke"] = x.get_stroke();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeDashOffset"] = x.get_stroke_dash_offset();
        j["strokeOpacity"] = x.get_stroke_opacity();
        j["strokeWidth"] = x.get_stroke_width();
        j["tension"] = x.get_tension();
        j["text"] = x.get_text();
        j["theta"] = x.get_theta();
    }

    inline void from_json(const json & j, LegendConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("cornerRadius") != j.end() && j.at("cornerRadius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_corner_radius(get_stack_optional<double>(j, "cornerRadius"));
        if (j.find("entryPadding") != j.end() && j.at("entryPadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_entry_padding(get_stack_optional<double>(j, "entryPadding"));
        if (j.find("fillColor") != j.end() && j.at("fillColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_color(get_stack_optional<std::string>(j, "fillColor"));
        if (j.find("gradientHeight") != j.end() && j.at("gradientHeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gradient_height(get_stack_optional<double>(j, "gradientHeight"));
        if (j.find("gradientLabelBaseline") != j.end() && j.at("gradientLabelBaseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gradient_label_baseline(get_stack_optional<std::string>(j, "gradientLabelBaseline"));
        if (j.find("gradientLabelLimit") != j.end() && j.at("gradientLabelLimit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gradient_label_limit(get_stack_optional<double>(j, "gradientLabelLimit"));
        if (j.find("gradientLabelOffset") != j.end() && j.at("gradientLabelOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gradient_label_offset(get_stack_optional<double>(j, "gradientLabelOffset"));
        if (j.find("gradientStrokeColor") != j.end() && j.at("gradientStrokeColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gradient_stroke_color(get_stack_optional<std::string>(j, "gradientStrokeColor"));
        if (j.find("gradientStrokeWidth") != j.end() && j.at("gradientStrokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gradient_stroke_width(get_stack_optional<double>(j, "gradientStrokeWidth"));
        if (j.find("gradientWidth") != j.end() && j.at("gradientWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gradient_width(get_stack_optional<double>(j, "gradientWidth"));
        if (j.find("labelAlign") != j.end() && j.at("labelAlign").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_align(get_stack_optional<std::string>(j, "labelAlign"));
        if (j.find("labelBaseline") != j.end() && j.at("labelBaseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_baseline(get_stack_optional<std::string>(j, "labelBaseline"));
        if (j.find("labelColor") != j.end() && j.at("labelColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_color(get_stack_optional<std::string>(j, "labelColor"));
        if (j.find("labelFont") != j.end() && j.at("labelFont").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_font(get_stack_optional<std::string>(j, "labelFont"));
        if (j.find("labelFontSize") != j.end() && j.at("labelFontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_font_size(get_stack_optional<double>(j, "labelFontSize"));
        if (j.find("labelLimit") != j.end() && j.at("labelLimit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_limit(get_stack_optional<double>(j, "labelLimit"));
        if (j.find("labelOffset") != j.end() && j.at("labelOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_offset(get_stack_optional<double>(j, "labelOffset"));
        if (j.find("offset") != j.end() && j.at("offset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_offset(get_stack_optional<double>(j, "offset"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<LegendOrient>(j, "orient"));
        if (j.find("padding") != j.end() && j.at("padding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_padding(get_stack_optional<double>(j, "padding"));
        if (j.find("shortTimeLabels") != j.end() && j.at("shortTimeLabels").is_null()) throw std::runtime_error("Unexpected null");
        x.set_short_time_labels(get_stack_optional<bool>(j, "shortTimeLabels"));
        if (j.find("strokeColor") != j.end() && j.at("strokeColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_color(get_stack_optional<std::string>(j, "strokeColor"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
        if (j.find("symbolColor") != j.end() && j.at("symbolColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_symbol_color(get_stack_optional<std::string>(j, "symbolColor"));
        if (j.find("symbolSize") != j.end() && j.at("symbolSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_symbol_size(get_stack_optional<double>(j, "symbolSize"));
        if (j.find("symbolStrokeWidth") != j.end() && j.at("symbolStrokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_symbol_stroke_width(get_stack_optional<double>(j, "symbolStrokeWidth"));
        if (j.find("symbolType") != j.end() && j.at("symbolType").is_null()) throw std::runtime_error("Unexpected null");
        x.set_symbol_type(get_stack_optional<std::string>(j, "symbolType"));
        if (j.find("titleAlign") != j.end() && j.at("titleAlign").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_align(get_stack_optional<std::string>(j, "titleAlign"));
        if (j.find("titleBaseline") != j.end() && j.at("titleBaseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_baseline(get_stack_optional<std::string>(j, "titleBaseline"));
        if (j.find("titleColor") != j.end() && j.at("titleColor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_color(get_stack_optional<std::string>(j, "titleColor"));
        if (j.find("titleFont") != j.end() && j.at("titleFont").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font(get_stack_optional<std::string>(j, "titleFont"));
        if (j.find("titleFontSize") != j.end() && j.at("titleFontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font_size(get_stack_optional<double>(j, "titleFontSize"));
        if (j.find("titleFontWeight") != j.end() && j.at("titleFontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_font_weight(get_stack_optional<std::variant<double, std::string>>(j, "titleFontWeight"));
        if (j.find("titleLimit") != j.end() && j.at("titleLimit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_limit(get_stack_optional<double>(j, "titleLimit"));
        if (j.find("titlePadding") != j.end() && j.at("titlePadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_padding(get_stack_optional<double>(j, "titlePadding"));
    }

    inline void to_json(json & j, const LegendConfig & x) {
        j = json::object();
        j["cornerRadius"] = x.get_corner_radius();
        j["entryPadding"] = x.get_entry_padding();
        j["fillColor"] = x.get_fill_color();
        j["gradientHeight"] = x.get_gradient_height();
        j["gradientLabelBaseline"] = x.get_gradient_label_baseline();
        j["gradientLabelLimit"] = x.get_gradient_label_limit();
        j["gradientLabelOffset"] = x.get_gradient_label_offset();
        j["gradientStrokeColor"] = x.get_gradient_stroke_color();
        j["gradientStrokeWidth"] = x.get_gradient_stroke_width();
        j["gradientWidth"] = x.get_gradient_width();
        j["labelAlign"] = x.get_label_align();
        j["labelBaseline"] = x.get_label_baseline();
        j["labelColor"] = x.get_label_color();
        j["labelFont"] = x.get_label_font();
        j["labelFontSize"] = x.get_label_font_size();
        j["labelLimit"] = x.get_label_limit();
        j["labelOffset"] = x.get_label_offset();
        j["offset"] = x.get_offset();
        j["orient"] = x.get_orient();
        j["padding"] = x.get_padding();
        j["shortTimeLabels"] = x.get_short_time_labels();
        j["strokeColor"] = x.get_stroke_color();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeWidth"] = x.get_stroke_width();
        j["symbolColor"] = x.get_symbol_color();
        j["symbolSize"] = x.get_symbol_size();
        j["symbolStrokeWidth"] = x.get_symbol_stroke_width();
        j["symbolType"] = x.get_symbol_type();
        j["titleAlign"] = x.get_title_align();
        j["titleBaseline"] = x.get_title_baseline();
        j["titleColor"] = x.get_title_color();
        j["titleFont"] = x.get_title_font();
        j["titleFontSize"] = x.get_title_font_size();
        j["titleFontWeight"] = x.get_title_font_weight();
        j["titleLimit"] = x.get_title_limit();
        j["titlePadding"] = x.get_title_padding();
    }

    inline void from_json(const json & j, PaddingClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bottom") != j.end() && j.at("bottom").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bottom(get_stack_optional<double>(j, "bottom"));
        if (j.find("left") != j.end() && j.at("left").is_null()) throw std::runtime_error("Unexpected null");
        x.set_left(get_stack_optional<double>(j, "left"));
        if (j.find("right") != j.end() && j.at("right").is_null()) throw std::runtime_error("Unexpected null");
        x.set_right(get_stack_optional<double>(j, "right"));
        if (j.find("top") != j.end() && j.at("top").is_null()) throw std::runtime_error("Unexpected null");
        x.set_top(get_stack_optional<double>(j, "top"));
    }

    inline void to_json(json & j, const PaddingClass & x) {
        j = json::object();
        j["bottom"] = x.get_bottom();
        j["left"] = x.get_left();
        j["right"] = x.get_right();
        j["top"] = x.get_top();
    }

    inline void from_json(const json & j, ProjectionConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("center") != j.end() && j.at("center").is_null()) throw std::runtime_error("Unexpected null");
        x.set_center(get_stack_optional<std::vector<double>>(j, "center"));
        if (j.find("clipAngle") != j.end() && j.at("clipAngle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clip_angle(get_stack_optional<double>(j, "clipAngle"));
        if (j.find("clipExtent") != j.end() && j.at("clipExtent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clip_extent(get_stack_optional<std::vector<std::vector<double>>>(j, "clipExtent"));
        if (j.find("coefficient") != j.end() && j.at("coefficient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_coefficient(get_stack_optional<double>(j, "coefficient"));
        if (j.find("distance") != j.end() && j.at("distance").is_null()) throw std::runtime_error("Unexpected null");
        x.set_distance(get_stack_optional<double>(j, "distance"));
        if (j.find("fraction") != j.end() && j.at("fraction").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fraction(get_stack_optional<double>(j, "fraction"));
        if (j.find("lobes") != j.end() && j.at("lobes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lobes(get_stack_optional<double>(j, "lobes"));
        if (j.find("parallel") != j.end() && j.at("parallel").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parallel(get_stack_optional<double>(j, "parallel"));
        if (j.find("precision") != j.end() && j.at("precision").is_null()) throw std::runtime_error("Unexpected null");
        x.set_precision(get_stack_optional<std::map<std::string, TitleFontWeight>>(j, "precision"));
        if (j.find("radius") != j.end() && j.at("radius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_radius(get_stack_optional<double>(j, "radius"));
        if (j.find("ratio") != j.end() && j.at("ratio").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ratio(get_stack_optional<double>(j, "ratio"));
        if (j.find("rotate") != j.end() && j.at("rotate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rotate(get_stack_optional<std::vector<double>>(j, "rotate"));
        if (j.find("spacing") != j.end() && j.at("spacing").is_null()) throw std::runtime_error("Unexpected null");
        x.set_spacing(get_stack_optional<double>(j, "spacing"));
        if (j.find("tilt") != j.end() && j.at("tilt").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tilt(get_stack_optional<double>(j, "tilt"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<VgProjectionType>(j, "type"));
    }

    inline void to_json(json & j, const ProjectionConfig & x) {
        j = json::object();
        j["center"] = x.get_center();
        j["clipAngle"] = x.get_clip_angle();
        j["clipExtent"] = x.get_clip_extent();
        j["coefficient"] = x.get_coefficient();
        j["distance"] = x.get_distance();
        j["fraction"] = x.get_fraction();
        j["lobes"] = x.get_lobes();
        j["parallel"] = x.get_parallel();
        j["precision"] = x.get_precision();
        j["radius"] = x.get_radius();
        j["ratio"] = x.get_ratio();
        j["rotate"] = x.get_rotate();
        j["spacing"] = x.get_spacing();
        j["tilt"] = x.get_tilt();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, VgScheme& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("count") != j.end() && j.at("count").is_null()) throw std::runtime_error("Unexpected null");
        x.set_count(get_stack_optional<double>(j, "count"));
        if (j.find("extent") != j.end() && j.at("extent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_extent(get_stack_optional<std::vector<double>>(j, "extent"));
        if (j.find("scheme") != j.end() && j.at("scheme").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scheme(get_stack_optional<std::string>(j, "scheme"));
        if (j.find("step") != j.end() && j.at("step").is_null()) throw std::runtime_error("Unexpected null");
        x.set_step(get_stack_optional<double>(j, "step"));
    }

    inline void to_json(json & j, const VgScheme & x) {
        j = json::object();
        j["count"] = x.get_count();
        j["extent"] = x.get_extent();
        j["scheme"] = x.get_scheme();
        j["step"] = x.get_step();
    }

    inline void from_json(const json & j, ScaleConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bandPaddingInner") != j.end() && j.at("bandPaddingInner").is_null()) throw std::runtime_error("Unexpected null");
        x.set_band_padding_inner(get_stack_optional<double>(j, "bandPaddingInner"));
        if (j.find("bandPaddingOuter") != j.end() && j.at("bandPaddingOuter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_band_padding_outer(get_stack_optional<double>(j, "bandPaddingOuter"));
        if (j.find("clamp") != j.end() && j.at("clamp").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clamp(get_stack_optional<bool>(j, "clamp"));
        if (j.find("continuousPadding") != j.end() && j.at("continuousPadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_continuous_padding(get_stack_optional<double>(j, "continuousPadding"));
        if (j.find("maxBandSize") != j.end() && j.at("maxBandSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max_band_size(get_stack_optional<double>(j, "maxBandSize"));
        if (j.find("maxFontSize") != j.end() && j.at("maxFontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max_font_size(get_stack_optional<double>(j, "maxFontSize"));
        if (j.find("maxOpacity") != j.end() && j.at("maxOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max_opacity(get_stack_optional<double>(j, "maxOpacity"));
        if (j.find("maxSize") != j.end() && j.at("maxSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max_size(get_stack_optional<double>(j, "maxSize"));
        if (j.find("maxStrokeWidth") != j.end() && j.at("maxStrokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max_stroke_width(get_stack_optional<double>(j, "maxStrokeWidth"));
        if (j.find("minBandSize") != j.end() && j.at("minBandSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min_band_size(get_stack_optional<double>(j, "minBandSize"));
        if (j.find("minFontSize") != j.end() && j.at("minFontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min_font_size(get_stack_optional<double>(j, "minFontSize"));
        if (j.find("minOpacity") != j.end() && j.at("minOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min_opacity(get_stack_optional<double>(j, "minOpacity"));
        if (j.find("minSize") != j.end() && j.at("minSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min_size(get_stack_optional<double>(j, "minSize"));
        if (j.find("minStrokeWidth") != j.end() && j.at("minStrokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min_stroke_width(get_stack_optional<double>(j, "minStrokeWidth"));
        if (j.find("pointPadding") != j.end() && j.at("pointPadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_point_padding(get_stack_optional<double>(j, "pointPadding"));
        x.set_range_step(get_stack_optional<double>(j, "rangeStep"));
        if (j.find("round") != j.end() && j.at("round").is_null()) throw std::runtime_error("Unexpected null");
        x.set_round(get_stack_optional<bool>(j, "round"));
        if (j.find("textXRangeStep") != j.end() && j.at("textXRangeStep").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text_x_range_step(get_stack_optional<double>(j, "textXRangeStep"));
        if (j.find("useUnaggregatedDomain") != j.end() && j.at("useUnaggregatedDomain").is_null()) throw std::runtime_error("Unexpected null");
        x.set_use_unaggregated_domain(get_stack_optional<bool>(j, "useUnaggregatedDomain"));
    }

    inline void to_json(json & j, const ScaleConfig & x) {
        j = json::object();
        j["bandPaddingInner"] = x.get_band_padding_inner();
        j["bandPaddingOuter"] = x.get_band_padding_outer();
        j["clamp"] = x.get_clamp();
        j["continuousPadding"] = x.get_continuous_padding();
        j["maxBandSize"] = x.get_max_band_size();
        j["maxFontSize"] = x.get_max_font_size();
        j["maxOpacity"] = x.get_max_opacity();
        j["maxSize"] = x.get_max_size();
        j["maxStrokeWidth"] = x.get_max_stroke_width();
        j["minBandSize"] = x.get_min_band_size();
        j["minFontSize"] = x.get_min_font_size();
        j["minOpacity"] = x.get_min_opacity();
        j["minSize"] = x.get_min_size();
        j["minStrokeWidth"] = x.get_min_stroke_width();
        j["pointPadding"] = x.get_point_padding();
        j["rangeStep"] = x.get_range_step();
        j["round"] = x.get_round();
        j["textXRangeStep"] = x.get_text_x_range_step();
        j["useUnaggregatedDomain"] = x.get_use_unaggregated_domain();
    }

    inline void from_json(const json & j, BrushConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("fill") != j.end() && j.at("fill").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill(get_stack_optional<std::string>(j, "fill"));
        if (j.find("fillOpacity") != j.end() && j.at("fillOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_opacity(get_stack_optional<double>(j, "fillOpacity"));
        if (j.find("stroke") != j.end() && j.at("stroke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke(get_stack_optional<std::string>(j, "stroke"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeDashOffset") != j.end() && j.at("strokeDashOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash_offset(get_stack_optional<double>(j, "strokeDashOffset"));
        if (j.find("strokeOpacity") != j.end() && j.at("strokeOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_opacity(get_stack_optional<double>(j, "strokeOpacity"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
    }

    inline void to_json(json & j, const BrushConfig & x) {
        j = json::object();
        j["fill"] = x.get_fill();
        j["fillOpacity"] = x.get_fill_opacity();
        j["stroke"] = x.get_stroke();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeDashOffset"] = x.get_stroke_dash_offset();
        j["strokeOpacity"] = x.get_stroke_opacity();
        j["strokeWidth"] = x.get_stroke_width();
    }

    inline void from_json(const json & j, IntervalSelectionConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bind") != j.end() && j.at("bind").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bind(get_stack_optional<BindEnum>(j, "bind"));
        if (j.find("empty") != j.end() && j.at("empty").is_null()) throw std::runtime_error("Unexpected null");
        x.set_empty(get_stack_optional<Empty>(j, "empty"));
        if (j.find("encodings") != j.end() && j.at("encodings").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encodings(get_stack_optional<std::vector<SingleDefChannel>>(j, "encodings"));
        if (j.find("fields") != j.end() && j.at("fields").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fields(get_stack_optional<std::vector<std::string>>(j, "fields"));
        if (j.find("mark") != j.end() && j.at("mark").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mark(get_stack_optional<BrushConfig>(j, "mark"));
        x.set_on(get_untyped(j, "on"));
        if (j.find("resolve") != j.end() && j.at("resolve").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resolve(get_stack_optional<SelectionResolution>(j, "resolve"));
        if (j.find("translate") != j.end() && j.at("translate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_translate(get_stack_optional<std::variant<bool, std::string>>(j, "translate"));
        if (j.find("zoom") != j.end() && j.at("zoom").is_null()) throw std::runtime_error("Unexpected null");
        x.set_zoom(get_stack_optional<std::variant<bool, std::string>>(j, "zoom"));
    }

    inline void to_json(json & j, const IntervalSelectionConfig & x) {
        j = json::object();
        j["bind"] = x.get_bind();
        j["empty"] = x.get_empty();
        j["encodings"] = x.get_encodings();
        j["fields"] = x.get_fields();
        j["mark"] = x.get_mark();
        j["on"] = x.get_on();
        j["resolve"] = x.get_resolve();
        j["translate"] = x.get_translate();
        j["zoom"] = x.get_zoom();
    }

    inline void from_json(const json & j, MultiSelectionConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("empty") != j.end() && j.at("empty").is_null()) throw std::runtime_error("Unexpected null");
        x.set_empty(get_stack_optional<Empty>(j, "empty"));
        if (j.find("encodings") != j.end() && j.at("encodings").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encodings(get_stack_optional<std::vector<SingleDefChannel>>(j, "encodings"));
        if (j.find("fields") != j.end() && j.at("fields").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fields(get_stack_optional<std::vector<std::string>>(j, "fields"));
        if (j.find("nearest") != j.end() && j.at("nearest").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nearest(get_stack_optional<bool>(j, "nearest"));
        x.set_on(get_untyped(j, "on"));
        if (j.find("resolve") != j.end() && j.at("resolve").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resolve(get_stack_optional<SelectionResolution>(j, "resolve"));
        if (j.find("toggle") != j.end() && j.at("toggle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_toggle(get_stack_optional<std::variant<bool, std::string>>(j, "toggle"));
    }

    inline void to_json(json & j, const MultiSelectionConfig & x) {
        j = json::object();
        j["empty"] = x.get_empty();
        j["encodings"] = x.get_encodings();
        j["fields"] = x.get_fields();
        j["nearest"] = x.get_nearest();
        j["on"] = x.get_on();
        j["resolve"] = x.get_resolve();
        j["toggle"] = x.get_toggle();
    }

    inline void from_json(const json & j, VgBinding& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("element") != j.end() && j.at("element").is_null()) throw std::runtime_error("Unexpected null");
        x.set_element(get_stack_optional<std::string>(j, "element"));
        x.set_input(j.at("input").get<std::string>());
        if (j.find("options") != j.end() && j.at("options").is_null()) throw std::runtime_error("Unexpected null");
        x.set_options(get_stack_optional<std::vector<std::string>>(j, "options"));
        if (j.find("max") != j.end() && j.at("max").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max(get_stack_optional<double>(j, "max"));
        if (j.find("min") != j.end() && j.at("min").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min(get_stack_optional<double>(j, "min"));
        if (j.find("step") != j.end() && j.at("step").is_null()) throw std::runtime_error("Unexpected null");
        x.set_step(get_stack_optional<double>(j, "step"));
    }

    inline void to_json(json & j, const VgBinding & x) {
        j = json::object();
        j["element"] = x.get_element();
        j["input"] = x.get_input();
        j["options"] = x.get_options();
        j["max"] = x.get_max();
        j["min"] = x.get_min();
        j["step"] = x.get_step();
    }

    inline void from_json(const json & j, SingleSelectionConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bind") != j.end() && j.at("bind").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bind(get_stack_optional<std::map<std::string, VgBinding>>(j, "bind"));
        if (j.find("empty") != j.end() && j.at("empty").is_null()) throw std::runtime_error("Unexpected null");
        x.set_empty(get_stack_optional<Empty>(j, "empty"));
        if (j.find("encodings") != j.end() && j.at("encodings").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encodings(get_stack_optional<std::vector<SingleDefChannel>>(j, "encodings"));
        if (j.find("fields") != j.end() && j.at("fields").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fields(get_stack_optional<std::vector<std::string>>(j, "fields"));
        if (j.find("nearest") != j.end() && j.at("nearest").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nearest(get_stack_optional<bool>(j, "nearest"));
        x.set_on(get_untyped(j, "on"));
        if (j.find("resolve") != j.end() && j.at("resolve").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resolve(get_stack_optional<SelectionResolution>(j, "resolve"));
    }

    inline void to_json(json & j, const SingleSelectionConfig & x) {
        j = json::object();
        j["bind"] = x.get_bind();
        j["empty"] = x.get_empty();
        j["encodings"] = x.get_encodings();
        j["fields"] = x.get_fields();
        j["nearest"] = x.get_nearest();
        j["on"] = x.get_on();
        j["resolve"] = x.get_resolve();
    }

    inline void from_json(const json & j, SelectionConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("interval") != j.end() && j.at("interval").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interval(get_stack_optional<IntervalSelectionConfig>(j, "interval"));
        if (j.find("multi") != j.end() && j.at("multi").is_null()) throw std::runtime_error("Unexpected null");
        x.set_multi(get_stack_optional<MultiSelectionConfig>(j, "multi"));
        if (j.find("single") != j.end() && j.at("single").is_null()) throw std::runtime_error("Unexpected null");
        x.set_single(get_stack_optional<SingleSelectionConfig>(j, "single"));
    }

    inline void to_json(json & j, const SelectionConfig & x) {
        j = json::object();
        j["interval"] = x.get_interval();
        j["multi"] = x.get_multi();
        j["single"] = x.get_single();
    }

    inline void from_json(const json & j, VgMarkConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("align") != j.end() && j.at("align").is_null()) throw std::runtime_error("Unexpected null");
        x.set_align(get_stack_optional<HorizontalAlign>(j, "align"));
        if (j.find("angle") != j.end() && j.at("angle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_angle(get_stack_optional<double>(j, "angle"));
        if (j.find("baseline") != j.end() && j.at("baseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_baseline(get_stack_optional<VerticalAlign>(j, "baseline"));
        if (j.find("cursor") != j.end() && j.at("cursor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cursor(get_stack_optional<Cursor>(j, "cursor"));
        if (j.find("dx") != j.end() && j.at("dx").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dx(get_stack_optional<double>(j, "dx"));
        if (j.find("dy") != j.end() && j.at("dy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dy(get_stack_optional<double>(j, "dy"));
        if (j.find("fill") != j.end() && j.at("fill").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill(get_stack_optional<std::string>(j, "fill"));
        if (j.find("fillOpacity") != j.end() && j.at("fillOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_opacity(get_stack_optional<double>(j, "fillOpacity"));
        if (j.find("font") != j.end() && j.at("font").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font(get_stack_optional<std::string>(j, "font"));
        if (j.find("fontSize") != j.end() && j.at("fontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_size(get_stack_optional<double>(j, "fontSize"));
        if (j.find("fontStyle") != j.end() && j.at("fontStyle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_style(get_stack_optional<FontStyle>(j, "fontStyle"));
        if (j.find("fontWeight") != j.end() && j.at("fontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_weight(get_stack_optional<std::variant<double, FontWeight>>(j, "fontWeight"));
        if (j.find("href") != j.end() && j.at("href").is_null()) throw std::runtime_error("Unexpected null");
        x.set_href(get_stack_optional<std::string>(j, "href"));
        if (j.find("interpolate") != j.end() && j.at("interpolate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interpolate(get_stack_optional<Interpolate>(j, "interpolate"));
        if (j.find("limit") != j.end() && j.at("limit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_limit(get_stack_optional<double>(j, "limit"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<double>(j, "opacity"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<Orient>(j, "orient"));
        if (j.find("radius") != j.end() && j.at("radius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_radius(get_stack_optional<double>(j, "radius"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<std::string>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<double>(j, "size"));
        if (j.find("stroke") != j.end() && j.at("stroke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke(get_stack_optional<std::string>(j, "stroke"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeDashOffset") != j.end() && j.at("strokeDashOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash_offset(get_stack_optional<double>(j, "strokeDashOffset"));
        if (j.find("strokeOpacity") != j.end() && j.at("strokeOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_opacity(get_stack_optional<double>(j, "strokeOpacity"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
        if (j.find("tension") != j.end() && j.at("tension").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tension(get_stack_optional<double>(j, "tension"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
        if (j.find("theta") != j.end() && j.at("theta").is_null()) throw std::runtime_error("Unexpected null");
        x.set_theta(get_stack_optional<double>(j, "theta"));
    }

    inline void to_json(json & j, const VgMarkConfig & x) {
        j = json::object();
        j["align"] = x.get_align();
        j["angle"] = x.get_angle();
        j["baseline"] = x.get_baseline();
        j["cursor"] = x.get_cursor();
        j["dx"] = x.get_dx();
        j["dy"] = x.get_dy();
        j["fill"] = x.get_fill();
        j["fillOpacity"] = x.get_fill_opacity();
        j["font"] = x.get_font();
        j["fontSize"] = x.get_font_size();
        j["fontStyle"] = x.get_font_style();
        j["fontWeight"] = x.get_font_weight();
        j["href"] = x.get_href();
        j["interpolate"] = x.get_interpolate();
        j["limit"] = x.get_limit();
        j["opacity"] = x.get_opacity();
        j["orient"] = x.get_orient();
        j["radius"] = x.get_radius();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
        j["stroke"] = x.get_stroke();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeDashOffset"] = x.get_stroke_dash_offset();
        j["strokeOpacity"] = x.get_stroke_opacity();
        j["strokeWidth"] = x.get_stroke_width();
        j["tension"] = x.get_tension();
        j["text"] = x.get_text();
        j["theta"] = x.get_theta();
    }

    inline void from_json(const json & j, TextConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("align") != j.end() && j.at("align").is_null()) throw std::runtime_error("Unexpected null");
        x.set_align(get_stack_optional<HorizontalAlign>(j, "align"));
        if (j.find("angle") != j.end() && j.at("angle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_angle(get_stack_optional<double>(j, "angle"));
        if (j.find("baseline") != j.end() && j.at("baseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_baseline(get_stack_optional<VerticalAlign>(j, "baseline"));
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<std::string>(j, "color"));
        if (j.find("cursor") != j.end() && j.at("cursor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cursor(get_stack_optional<Cursor>(j, "cursor"));
        if (j.find("dx") != j.end() && j.at("dx").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dx(get_stack_optional<double>(j, "dx"));
        if (j.find("dy") != j.end() && j.at("dy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dy(get_stack_optional<double>(j, "dy"));
        if (j.find("fill") != j.end() && j.at("fill").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill(get_stack_optional<std::string>(j, "fill"));
        if (j.find("filled") != j.end() && j.at("filled").is_null()) throw std::runtime_error("Unexpected null");
        x.set_filled(get_stack_optional<bool>(j, "filled"));
        if (j.find("fillOpacity") != j.end() && j.at("fillOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_opacity(get_stack_optional<double>(j, "fillOpacity"));
        if (j.find("font") != j.end() && j.at("font").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font(get_stack_optional<std::string>(j, "font"));
        if (j.find("fontSize") != j.end() && j.at("fontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_size(get_stack_optional<double>(j, "fontSize"));
        if (j.find("fontStyle") != j.end() && j.at("fontStyle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_style(get_stack_optional<FontStyle>(j, "fontStyle"));
        if (j.find("fontWeight") != j.end() && j.at("fontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_weight(get_stack_optional<std::variant<double, FontWeight>>(j, "fontWeight"));
        if (j.find("href") != j.end() && j.at("href").is_null()) throw std::runtime_error("Unexpected null");
        x.set_href(get_stack_optional<std::string>(j, "href"));
        if (j.find("interpolate") != j.end() && j.at("interpolate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interpolate(get_stack_optional<Interpolate>(j, "interpolate"));
        if (j.find("limit") != j.end() && j.at("limit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_limit(get_stack_optional<double>(j, "limit"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<double>(j, "opacity"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<Orient>(j, "orient"));
        if (j.find("radius") != j.end() && j.at("radius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_radius(get_stack_optional<double>(j, "radius"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<std::string>(j, "shape"));
        if (j.find("shortTimeLabels") != j.end() && j.at("shortTimeLabels").is_null()) throw std::runtime_error("Unexpected null");
        x.set_short_time_labels(get_stack_optional<bool>(j, "shortTimeLabels"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<double>(j, "size"));
        if (j.find("stroke") != j.end() && j.at("stroke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke(get_stack_optional<std::string>(j, "stroke"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeDashOffset") != j.end() && j.at("strokeDashOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash_offset(get_stack_optional<double>(j, "strokeDashOffset"));
        if (j.find("strokeOpacity") != j.end() && j.at("strokeOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_opacity(get_stack_optional<double>(j, "strokeOpacity"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
        if (j.find("tension") != j.end() && j.at("tension").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tension(get_stack_optional<double>(j, "tension"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
        if (j.find("theta") != j.end() && j.at("theta").is_null()) throw std::runtime_error("Unexpected null");
        x.set_theta(get_stack_optional<double>(j, "theta"));
    }

    inline void to_json(json & j, const TextConfig & x) {
        j = json::object();
        j["align"] = x.get_align();
        j["angle"] = x.get_angle();
        j["baseline"] = x.get_baseline();
        j["color"] = x.get_color();
        j["cursor"] = x.get_cursor();
        j["dx"] = x.get_dx();
        j["dy"] = x.get_dy();
        j["fill"] = x.get_fill();
        j["filled"] = x.get_filled();
        j["fillOpacity"] = x.get_fill_opacity();
        j["font"] = x.get_font();
        j["fontSize"] = x.get_font_size();
        j["fontStyle"] = x.get_font_style();
        j["fontWeight"] = x.get_font_weight();
        j["href"] = x.get_href();
        j["interpolate"] = x.get_interpolate();
        j["limit"] = x.get_limit();
        j["opacity"] = x.get_opacity();
        j["orient"] = x.get_orient();
        j["radius"] = x.get_radius();
        j["shape"] = x.get_shape();
        j["shortTimeLabels"] = x.get_short_time_labels();
        j["size"] = x.get_size();
        j["stroke"] = x.get_stroke();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeDashOffset"] = x.get_stroke_dash_offset();
        j["strokeOpacity"] = x.get_stroke_opacity();
        j["strokeWidth"] = x.get_stroke_width();
        j["tension"] = x.get_tension();
        j["text"] = x.get_text();
        j["theta"] = x.get_theta();
    }

    inline void from_json(const json & j, TickConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("align") != j.end() && j.at("align").is_null()) throw std::runtime_error("Unexpected null");
        x.set_align(get_stack_optional<HorizontalAlign>(j, "align"));
        if (j.find("angle") != j.end() && j.at("angle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_angle(get_stack_optional<double>(j, "angle"));
        if (j.find("bandSize") != j.end() && j.at("bandSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_band_size(get_stack_optional<double>(j, "bandSize"));
        if (j.find("baseline") != j.end() && j.at("baseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_baseline(get_stack_optional<VerticalAlign>(j, "baseline"));
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<std::string>(j, "color"));
        if (j.find("cursor") != j.end() && j.at("cursor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cursor(get_stack_optional<Cursor>(j, "cursor"));
        if (j.find("dx") != j.end() && j.at("dx").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dx(get_stack_optional<double>(j, "dx"));
        if (j.find("dy") != j.end() && j.at("dy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dy(get_stack_optional<double>(j, "dy"));
        if (j.find("fill") != j.end() && j.at("fill").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill(get_stack_optional<std::string>(j, "fill"));
        if (j.find("filled") != j.end() && j.at("filled").is_null()) throw std::runtime_error("Unexpected null");
        x.set_filled(get_stack_optional<bool>(j, "filled"));
        if (j.find("fillOpacity") != j.end() && j.at("fillOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_opacity(get_stack_optional<double>(j, "fillOpacity"));
        if (j.find("font") != j.end() && j.at("font").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font(get_stack_optional<std::string>(j, "font"));
        if (j.find("fontSize") != j.end() && j.at("fontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_size(get_stack_optional<double>(j, "fontSize"));
        if (j.find("fontStyle") != j.end() && j.at("fontStyle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_style(get_stack_optional<FontStyle>(j, "fontStyle"));
        if (j.find("fontWeight") != j.end() && j.at("fontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_weight(get_stack_optional<std::variant<double, FontWeight>>(j, "fontWeight"));
        if (j.find("href") != j.end() && j.at("href").is_null()) throw std::runtime_error("Unexpected null");
        x.set_href(get_stack_optional<std::string>(j, "href"));
        if (j.find("interpolate") != j.end() && j.at("interpolate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interpolate(get_stack_optional<Interpolate>(j, "interpolate"));
        if (j.find("limit") != j.end() && j.at("limit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_limit(get_stack_optional<double>(j, "limit"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<double>(j, "opacity"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<Orient>(j, "orient"));
        if (j.find("radius") != j.end() && j.at("radius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_radius(get_stack_optional<double>(j, "radius"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<std::string>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<double>(j, "size"));
        if (j.find("stroke") != j.end() && j.at("stroke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke(get_stack_optional<std::string>(j, "stroke"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeDashOffset") != j.end() && j.at("strokeDashOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash_offset(get_stack_optional<double>(j, "strokeDashOffset"));
        if (j.find("strokeOpacity") != j.end() && j.at("strokeOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_opacity(get_stack_optional<double>(j, "strokeOpacity"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
        if (j.find("tension") != j.end() && j.at("tension").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tension(get_stack_optional<double>(j, "tension"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
        if (j.find("theta") != j.end() && j.at("theta").is_null()) throw std::runtime_error("Unexpected null");
        x.set_theta(get_stack_optional<double>(j, "theta"));
        if (j.find("thickness") != j.end() && j.at("thickness").is_null()) throw std::runtime_error("Unexpected null");
        x.set_thickness(get_stack_optional<double>(j, "thickness"));
    }

    inline void to_json(json & j, const TickConfig & x) {
        j = json::object();
        j["align"] = x.get_align();
        j["angle"] = x.get_angle();
        j["bandSize"] = x.get_band_size();
        j["baseline"] = x.get_baseline();
        j["color"] = x.get_color();
        j["cursor"] = x.get_cursor();
        j["dx"] = x.get_dx();
        j["dy"] = x.get_dy();
        j["fill"] = x.get_fill();
        j["filled"] = x.get_filled();
        j["fillOpacity"] = x.get_fill_opacity();
        j["font"] = x.get_font();
        j["fontSize"] = x.get_font_size();
        j["fontStyle"] = x.get_font_style();
        j["fontWeight"] = x.get_font_weight();
        j["href"] = x.get_href();
        j["interpolate"] = x.get_interpolate();
        j["limit"] = x.get_limit();
        j["opacity"] = x.get_opacity();
        j["orient"] = x.get_orient();
        j["radius"] = x.get_radius();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
        j["stroke"] = x.get_stroke();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeDashOffset"] = x.get_stroke_dash_offset();
        j["strokeOpacity"] = x.get_stroke_opacity();
        j["strokeWidth"] = x.get_stroke_width();
        j["tension"] = x.get_tension();
        j["text"] = x.get_text();
        j["theta"] = x.get_theta();
        j["thickness"] = x.get_thickness();
    }

    inline void from_json(const json & j, VgTitleConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("anchor") != j.end() && j.at("anchor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_anchor(get_stack_optional<Anchor>(j, "anchor"));
        if (j.find("angle") != j.end() && j.at("angle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_angle(get_stack_optional<double>(j, "angle"));
        if (j.find("baseline") != j.end() && j.at("baseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_baseline(get_stack_optional<VerticalAlign>(j, "baseline"));
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<std::string>(j, "color"));
        if (j.find("font") != j.end() && j.at("font").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font(get_stack_optional<std::string>(j, "font"));
        if (j.find("fontSize") != j.end() && j.at("fontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_size(get_stack_optional<double>(j, "fontSize"));
        if (j.find("fontWeight") != j.end() && j.at("fontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_weight(get_stack_optional<std::variant<double, FontWeight>>(j, "fontWeight"));
        if (j.find("limit") != j.end() && j.at("limit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_limit(get_stack_optional<double>(j, "limit"));
        if (j.find("offset") != j.end() && j.at("offset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_offset(get_stack_optional<double>(j, "offset"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<TitleOrient>(j, "orient"));
    }

    inline void to_json(json & j, const VgTitleConfig & x) {
        j = json::object();
        j["anchor"] = x.get_anchor();
        j["angle"] = x.get_angle();
        j["baseline"] = x.get_baseline();
        j["color"] = x.get_color();
        j["font"] = x.get_font();
        j["fontSize"] = x.get_font_size();
        j["fontWeight"] = x.get_font_weight();
        j["limit"] = x.get_limit();
        j["offset"] = x.get_offset();
        j["orient"] = x.get_orient();
    }

    inline void from_json(const json & j, ViewConfig& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("clip") != j.end() && j.at("clip").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clip(get_stack_optional<bool>(j, "clip"));
        if (j.find("fill") != j.end() && j.at("fill").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill(get_stack_optional<std::string>(j, "fill"));
        if (j.find("fillOpacity") != j.end() && j.at("fillOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_opacity(get_stack_optional<double>(j, "fillOpacity"));
        if (j.find("height") != j.end() && j.at("height").is_null()) throw std::runtime_error("Unexpected null");
        x.set_height(get_stack_optional<double>(j, "height"));
        if (j.find("stroke") != j.end() && j.at("stroke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke(get_stack_optional<std::string>(j, "stroke"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeDashOffset") != j.end() && j.at("strokeDashOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash_offset(get_stack_optional<double>(j, "strokeDashOffset"));
        if (j.find("strokeOpacity") != j.end() && j.at("strokeOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_opacity(get_stack_optional<double>(j, "strokeOpacity"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
        if (j.find("width") != j.end() && j.at("width").is_null()) throw std::runtime_error("Unexpected null");
        x.set_width(get_stack_optional<double>(j, "width"));
    }

    inline void to_json(json & j, const ViewConfig & x) {
        j = json::object();
        j["clip"] = x.get_clip();
        j["fill"] = x.get_fill();
        j["fillOpacity"] = x.get_fill_opacity();
        j["height"] = x.get_height();
        j["stroke"] = x.get_stroke();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeDashOffset"] = x.get_stroke_dash_offset();
        j["strokeOpacity"] = x.get_stroke_opacity();
        j["strokeWidth"] = x.get_stroke_width();
        j["width"] = x.get_width();
    }

    inline void from_json(const json & j, Config& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("area") != j.end() && j.at("area").is_null()) throw std::runtime_error("Unexpected null");
        x.set_area(get_stack_optional<MarkConfig>(j, "area"));
        if (j.find("autosize") != j.end() && j.at("autosize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_autosize(get_stack_optional<std::variant<AutoSizeParams, AutosizeType>>(j, "autosize"));
        if (j.find("axis") != j.end() && j.at("axis").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis(get_stack_optional<AxisConfig>(j, "axis"));
        if (j.find("axisBand") != j.end() && j.at("axisBand").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis_band(get_stack_optional<VgAxisConfig>(j, "axisBand"));
        if (j.find("axisBottom") != j.end() && j.at("axisBottom").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis_bottom(get_stack_optional<VgAxisConfig>(j, "axisBottom"));
        if (j.find("axisLeft") != j.end() && j.at("axisLeft").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis_left(get_stack_optional<VgAxisConfig>(j, "axisLeft"));
        if (j.find("axisRight") != j.end() && j.at("axisRight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis_right(get_stack_optional<VgAxisConfig>(j, "axisRight"));
        if (j.find("axisTop") != j.end() && j.at("axisTop").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis_top(get_stack_optional<VgAxisConfig>(j, "axisTop"));
        if (j.find("axisX") != j.end() && j.at("axisX").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis_x(get_stack_optional<VgAxisConfig>(j, "axisX"));
        if (j.find("axisY") != j.end() && j.at("axisY").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis_y(get_stack_optional<VgAxisConfig>(j, "axisY"));
        if (j.find("background") != j.end() && j.at("background").is_null()) throw std::runtime_error("Unexpected null");
        x.set_background(get_stack_optional<std::string>(j, "background"));
        if (j.find("bar") != j.end() && j.at("bar").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bar(get_stack_optional<BarConfig>(j, "bar"));
        if (j.find("circle") != j.end() && j.at("circle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_circle(get_stack_optional<MarkConfig>(j, "circle"));
        if (j.find("countTitle") != j.end() && j.at("countTitle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_count_title(get_stack_optional<std::string>(j, "countTitle"));
        if (j.find("fieldTitle") != j.end() && j.at("fieldTitle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field_title(get_stack_optional<FieldTitle>(j, "fieldTitle"));
        if (j.find("geoshape") != j.end() && j.at("geoshape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_geoshape(get_stack_optional<MarkConfig>(j, "geoshape"));
        if (j.find("invalidValues") != j.end() && j.at("invalidValues").is_null()) throw std::runtime_error("Unexpected null");
        x.set_invalid_values(get_stack_optional<InvalidValues>(j, "invalidValues"));
        if (j.find("legend") != j.end() && j.at("legend").is_null()) throw std::runtime_error("Unexpected null");
        x.set_legend(get_stack_optional<LegendConfig>(j, "legend"));
        if (j.find("line") != j.end() && j.at("line").is_null()) throw std::runtime_error("Unexpected null");
        x.set_line(get_stack_optional<MarkConfig>(j, "line"));
        if (j.find("mark") != j.end() && j.at("mark").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mark(get_stack_optional<MarkConfig>(j, "mark"));
        if (j.find("numberFormat") != j.end() && j.at("numberFormat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_number_format(get_stack_optional<std::string>(j, "numberFormat"));
        if (j.find("padding") != j.end() && j.at("padding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_padding(get_stack_optional<std::variant<PaddingClass, double>>(j, "padding"));
        if (j.find("point") != j.end() && j.at("point").is_null()) throw std::runtime_error("Unexpected null");
        x.set_point(get_stack_optional<MarkConfig>(j, "point"));
        if (j.find("projection") != j.end() && j.at("projection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_projection(get_stack_optional<ProjectionConfig>(j, "projection"));
        if (j.find("range") != j.end() && j.at("range").is_null()) throw std::runtime_error("Unexpected null");
        x.set_range(get_stack_optional<std::map<std::string, RangeConfigValue>>(j, "range"));
        if (j.find("rect") != j.end() && j.at("rect").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rect(get_stack_optional<MarkConfig>(j, "rect"));
        if (j.find("rule") != j.end() && j.at("rule").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rule(get_stack_optional<MarkConfig>(j, "rule"));
        if (j.find("scale") != j.end() && j.at("scale").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scale(get_stack_optional<ScaleConfig>(j, "scale"));
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_stack_optional<SelectionConfig>(j, "selection"));
        if (j.find("square") != j.end() && j.at("square").is_null()) throw std::runtime_error("Unexpected null");
        x.set_square(get_stack_optional<MarkConfig>(j, "square"));
        if (j.find("stack") != j.end() && j.at("stack").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stack(get_stack_optional<StackOffset>(j, "stack"));
        if (j.find("style") != j.end() && j.at("style").is_null()) throw std::runtime_error("Unexpected null");
        x.set_style(get_stack_optional<std::map<std::string, VgMarkConfig>>(j, "style"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<TextConfig>(j, "text"));
        if (j.find("tick") != j.end() && j.at("tick").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick(get_stack_optional<TickConfig>(j, "tick"));
        if (j.find("timeFormat") != j.end() && j.at("timeFormat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_format(get_stack_optional<std::string>(j, "timeFormat"));
        if (j.find("title") != j.end() && j.at("title").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title(get_stack_optional<VgTitleConfig>(j, "title"));
        if (j.find("view") != j.end() && j.at("view").is_null()) throw std::runtime_error("Unexpected null");
        x.set_view(get_stack_optional<ViewConfig>(j, "view"));
    }

    inline void to_json(json & j, const Config & x) {
        j = json::object();
        j["area"] = x.get_area();
        j["autosize"] = x.get_autosize();
        j["axis"] = x.get_axis();
        j["axisBand"] = x.get_axis_band();
        j["axisBottom"] = x.get_axis_bottom();
        j["axisLeft"] = x.get_axis_left();
        j["axisRight"] = x.get_axis_right();
        j["axisTop"] = x.get_axis_top();
        j["axisX"] = x.get_axis_x();
        j["axisY"] = x.get_axis_y();
        j["background"] = x.get_background();
        j["bar"] = x.get_bar();
        j["circle"] = x.get_circle();
        j["countTitle"] = x.get_count_title();
        j["fieldTitle"] = x.get_field_title();
        j["geoshape"] = x.get_geoshape();
        j["invalidValues"] = x.get_invalid_values();
        j["legend"] = x.get_legend();
        j["line"] = x.get_line();
        j["mark"] = x.get_mark();
        j["numberFormat"] = x.get_number_format();
        j["padding"] = x.get_padding();
        j["point"] = x.get_point();
        j["projection"] = x.get_projection();
        j["range"] = x.get_range();
        j["rect"] = x.get_rect();
        j["rule"] = x.get_rule();
        j["scale"] = x.get_scale();
        j["selection"] = x.get_selection();
        j["square"] = x.get_square();
        j["stack"] = x.get_stack();
        j["style"] = x.get_style();
        j["text"] = x.get_text();
        j["tick"] = x.get_tick();
        j["timeFormat"] = x.get_time_format();
        j["title"] = x.get_title();
        j["view"] = x.get_view();
    }

    inline void from_json(const json & j, DataFormat& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("parse") != j.end() && j.at("parse").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parse(get_stack_optional<std::variant<ParseEnum, std::map<std::string, nlohmann::json>>>(j, "parse"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<DataFormatType>(j, "type"));
        if (j.find("property") != j.end() && j.at("property").is_null()) throw std::runtime_error("Unexpected null");
        x.set_property(get_stack_optional<std::string>(j, "property"));
        if (j.find("feature") != j.end() && j.at("feature").is_null()) throw std::runtime_error("Unexpected null");
        x.set_feature(get_stack_optional<std::string>(j, "feature"));
        if (j.find("mesh") != j.end() && j.at("mesh").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mesh(get_stack_optional<std::string>(j, "mesh"));
    }

    inline void to_json(json & j, const DataFormat & x) {
        j = json::object();
        j["parse"] = x.get_parse();
        j["type"] = x.get_type();
        j["property"] = x.get_property();
        j["feature"] = x.get_feature();
        j["mesh"] = x.get_mesh();
    }

    inline void from_json(const json & j, Data& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("format") != j.end() && j.at("format").is_null()) throw std::runtime_error("Unexpected null");
        x.set_format(get_stack_optional<DataFormat>(j, "format"));
        if (j.find("url") != j.end() && j.at("url").is_null()) throw std::runtime_error("Unexpected null");
        x.set_url(get_stack_optional<std::string>(j, "url"));
        if (j.find("values") != j.end() && j.at("values").is_null()) throw std::runtime_error("Unexpected null");
        x.set_values(get_stack_optional<std::variant<std::vector<ValuesValue>, std::map<std::string, nlohmann::json>, std::string>>(j, "values"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
    }

    inline void to_json(json & j, const Data & x) {
        j = json::object();
        j["format"] = x.get_format();
        j["url"] = x.get_url();
        j["values"] = x.get_values();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, BinParams& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("base") != j.end() && j.at("base").is_null()) throw std::runtime_error("Unexpected null");
        x.set_base(get_stack_optional<double>(j, "base"));
        if (j.at("divide").size() < 1) throw std::runtime_error("Too few items");
        if (j.find("divide") != j.end() && j.at("divide").is_null()) throw std::runtime_error("Unexpected null");
        x.set_divide(get_stack_optional<std::vector<double>>(j, "divide"));
        if (j.at("extent").size() < 2) throw std::runtime_error("Too few items");
        if (j.at("extent").size() > 2) throw std::runtime_error("Too many items");
        if (j.find("extent") != j.end() && j.at("extent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_extent(get_stack_optional<std::vector<double>>(j, "extent"));
        if (j.find("maxbins") != j.end() && j.at("maxbins").is_null()) throw std::runtime_error("Unexpected null");
        x.set_maxbins(get_stack_optional<double>(j, "maxbins"));
        if (j.find("minstep") != j.end() && j.at("minstep").is_null()) throw std::runtime_error("Unexpected null");
        x.set_minstep(get_stack_optional<double>(j, "minstep"));
        if (j.find("nice") != j.end() && j.at("nice").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nice(get_stack_optional<bool>(j, "nice"));
        if (j.find("step") != j.end() && j.at("step").is_null()) throw std::runtime_error("Unexpected null");
        x.set_step(get_stack_optional<double>(j, "step"));
        if (j.at("steps").size() < 1) throw std::runtime_error("Too few items");
        if (j.find("steps") != j.end() && j.at("steps").is_null()) throw std::runtime_error("Unexpected null");
        x.set_steps(get_stack_optional<std::vector<double>>(j, "steps"));
    }

    inline void to_json(json & j, const BinParams & x) {
        j = json::object();
        j["base"] = x.get_base();
        j["divide"] = x.get_divide();
        j["extent"] = x.get_extent();
        j["maxbins"] = x.get_maxbins();
        j["minstep"] = x.get_minstep();
        j["nice"] = x.get_nice();
        j["step"] = x.get_step();
        j["steps"] = x.get_steps();
    }

    inline void from_json(const json & j, Selection& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("not") != j.end() && j.at("not").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection_not(get_heap_optional<SelectionOperand>(j, "not"));
        if (j.find("and") != j.end() && j.at("and").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection_and(get_stack_optional<std::vector<SelectionOperand>>(j, "and"));
        if (j.find("or") != j.end() && j.at("or").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection_or(get_stack_optional<std::vector<SelectionOperand>>(j, "or"));
    }

    inline void to_json(json & j, const Selection & x) {
        j = json::object();
        j["not"] = x.get_selection_not();
        j["and"] = x.get_selection_and();
        j["or"] = x.get_selection_or();
    }

    inline void from_json(const json & j, DateTime& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("date") != j.end() && j.at("date").is_null()) throw std::runtime_error("Unexpected null");
        x.set_date(get_stack_optional<double>(j, "date"));
        if (j.find("day") != j.end() && j.at("day").is_null()) throw std::runtime_error("Unexpected null");
        x.set_day(get_stack_optional<std::variant<double, std::string>>(j, "day"));
        if (j.find("hours") != j.end() && j.at("hours").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hours(get_stack_optional<double>(j, "hours"));
        if (j.find("milliseconds") != j.end() && j.at("milliseconds").is_null()) throw std::runtime_error("Unexpected null");
        x.set_milliseconds(get_stack_optional<double>(j, "milliseconds"));
        if (j.find("minutes") != j.end() && j.at("minutes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_minutes(get_stack_optional<double>(j, "minutes"));
        if (j.find("month") != j.end() && j.at("month").is_null()) throw std::runtime_error("Unexpected null");
        x.set_month(get_stack_optional<std::variant<double, std::string>>(j, "month"));
        if (j.find("quarter") != j.end() && j.at("quarter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_quarter(get_stack_optional<double>(j, "quarter"));
        if (j.find("seconds") != j.end() && j.at("seconds").is_null()) throw std::runtime_error("Unexpected null");
        x.set_seconds(get_stack_optional<double>(j, "seconds"));
        if (j.find("utc") != j.end() && j.at("utc").is_null()) throw std::runtime_error("Unexpected null");
        x.set_utc(get_stack_optional<bool>(j, "utc"));
        if (j.find("year") != j.end() && j.at("year").is_null()) throw std::runtime_error("Unexpected null");
        x.set_year(get_stack_optional<double>(j, "year"));
    }

    inline void to_json(json & j, const DateTime & x) {
        j = json::object();
        j["date"] = x.get_date();
        j["day"] = x.get_day();
        j["hours"] = x.get_hours();
        j["milliseconds"] = x.get_milliseconds();
        j["minutes"] = x.get_minutes();
        j["month"] = x.get_month();
        j["quarter"] = x.get_quarter();
        j["seconds"] = x.get_seconds();
        j["utc"] = x.get_utc();
        j["year"] = x.get_year();
    }

    inline void from_json(const json & j, Predicate& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("not") != j.end() && j.at("not").is_null()) throw std::runtime_error("Unexpected null");
        x.set_predicate_not(get_heap_optional<LogicalOperandPredicate>(j, "not"));
        if (j.find("and") != j.end() && j.at("and").is_null()) throw std::runtime_error("Unexpected null");
        x.set_predicate_and(get_stack_optional<std::vector<LogicalOperandPredicate>>(j, "and"));
        if (j.find("or") != j.end() && j.at("or").is_null()) throw std::runtime_error("Unexpected null");
        x.set_predicate_or(get_stack_optional<std::vector<LogicalOperandPredicate>>(j, "or"));
        if (j.find("equal") != j.end() && j.at("equal").is_null()) throw std::runtime_error("Unexpected null");
        x.set_equal(get_stack_optional<std::variant<bool, DateTime, double, std::string>>(j, "equal"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::string>(j, "field"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.at("range").size() < 2) throw std::runtime_error("Too few items");
        if (j.at("range").size() > 2) throw std::runtime_error("Too many items");
        if (j.find("range") != j.end() && j.at("range").is_null()) throw std::runtime_error("Unexpected null");
        x.set_range(get_stack_optional<std::vector<RangeElement>>(j, "range"));
        if (j.find("oneOf") != j.end() && j.at("oneOf").is_null()) throw std::runtime_error("Unexpected null");
        x.set_one_of(get_stack_optional<std::vector<Equal>>(j, "oneOf"));
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_heap_optional<SelectionOperand>(j, "selection"));
    }

    inline void to_json(json & j, const Predicate & x) {
        j = json::object();
        j["not"] = x.get_predicate_not();
        j["and"] = x.get_predicate_and();
        j["or"] = x.get_predicate_or();
        j["equal"] = x.get_equal();
        j["field"] = x.get_field();
        j["timeUnit"] = x.get_time_unit();
        j["range"] = x.get_range();
        j["oneOf"] = x.get_one_of();
        j["selection"] = x.get_selection();
    }

    inline void from_json(const json & j, ConditionalValueDef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("test") != j.end() && j.at("test").is_null()) throw std::runtime_error("Unexpected null");
        x.set_test(get_heap_optional<LogicalOperandPredicate>(j, "test"));
        x.set_value(j.at("value").get<ConditionalValueDefValue>());
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_heap_optional<SelectionOperand>(j, "selection"));
    }

    inline void to_json(json & j, const ConditionalValueDef & x) {
        j = json::object();
        j["test"] = x.get_test();
        j["value"] = x.get_value();
        j["selection"] = x.get_selection();
    }

    inline void from_json(const json & j, RepeatRef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_repeat(j.at("repeat").get<RepeatEnum>());
    }

    inline void to_json(json & j, const RepeatRef & x) {
        j = json::object();
        j["repeat"] = x.get_repeat();
    }

    inline void from_json(const json & j, Legend& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("entryPadding") != j.end() && j.at("entryPadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_entry_padding(get_stack_optional<double>(j, "entryPadding"));
        if (j.find("format") != j.end() && j.at("format").is_null()) throw std::runtime_error("Unexpected null");
        x.set_format(get_stack_optional<std::string>(j, "format"));
        if (j.find("offset") != j.end() && j.at("offset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_offset(get_stack_optional<double>(j, "offset"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<LegendOrient>(j, "orient"));
        if (j.find("padding") != j.end() && j.at("padding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_padding(get_stack_optional<double>(j, "padding"));
        if (j.find("tickCount") != j.end() && j.at("tickCount").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_count(get_stack_optional<double>(j, "tickCount"));
        x.set_title(get_stack_optional<std::string>(j, "title"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<LegendType>(j, "type"));
        if (j.find("values") != j.end() && j.at("values").is_null()) throw std::runtime_error("Unexpected null");
        x.set_values(get_stack_optional<std::vector<LegendValue>>(j, "values"));
        if (j.find("zindex") != j.end() && j.at("zindex").is_null()) throw std::runtime_error("Unexpected null");
        x.set_zindex(get_stack_optional<double>(j, "zindex"));
    }

    inline void to_json(json & j, const Legend & x) {
        j = json::object();
        j["entryPadding"] = x.get_entry_padding();
        j["format"] = x.get_format();
        j["offset"] = x.get_offset();
        j["orient"] = x.get_orient();
        j["padding"] = x.get_padding();
        j["tickCount"] = x.get_tick_count();
        j["title"] = x.get_title();
        j["type"] = x.get_type();
        j["values"] = x.get_values();
        j["zindex"] = x.get_zindex();
    }

    inline void from_json(const json & j, DomainClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::string>(j, "field"));
        x.set_selection(j.at("selection").get<std::string>());
        if (j.find("encoding") != j.end() && j.at("encoding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encoding(get_stack_optional<std::string>(j, "encoding"));
    }

    inline void to_json(json & j, const DomainClass & x) {
        j = json::object();
        j["field"] = x.get_field();
        j["selection"] = x.get_selection();
        j["encoding"] = x.get_encoding();
    }

    inline void from_json(const json & j, InterpolateParams& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("gamma") != j.end() && j.at("gamma").is_null()) throw std::runtime_error("Unexpected null");
        x.set_gamma(get_stack_optional<double>(j, "gamma"));
        x.set_type(j.at("type").get<InterpolateParamsType>());
    }

    inline void to_json(json & j, const InterpolateParams & x) {
        j = json::object();
        j["gamma"] = x.get_gamma();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, NiceClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_interval(j.at("interval").get<std::string>());
        x.set_step(j.at("step").get<double>());
    }

    inline void to_json(json & j, const NiceClass & x) {
        j = json::object();
        j["interval"] = x.get_interval();
        j["step"] = x.get_step();
    }

    inline void from_json(const json & j, SchemeParams& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("extent") != j.end() && j.at("extent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_extent(get_stack_optional<std::vector<double>>(j, "extent"));
        x.set_name(j.at("name").get<std::string>());
    }

    inline void to_json(json & j, const SchemeParams & x) {
        j = json::object();
        j["extent"] = x.get_extent();
        j["name"] = x.get_name();
    }

    inline void from_json(const json & j, Scale& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("base") != j.end() && j.at("base").is_null()) throw std::runtime_error("Unexpected null");
        x.set_base(get_stack_optional<double>(j, "base"));
        if (j.find("clamp") != j.end() && j.at("clamp").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clamp(get_stack_optional<bool>(j, "clamp"));
        if (j.find("domain") != j.end() && j.at("domain").is_null()) throw std::runtime_error("Unexpected null");
        x.set_domain(get_stack_optional<std::variant<std::vector<Equal>, DomainClass, Domain>>(j, "domain"));
        if (j.find("exponent") != j.end() && j.at("exponent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_exponent(get_stack_optional<double>(j, "exponent"));
        if (j.find("interpolate") != j.end() && j.at("interpolate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interpolate(get_stack_optional<std::variant<InterpolateParams, Interpolate>>(j, "interpolate"));
        if (j.find("nice") != j.end() && j.at("nice").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nice(get_stack_optional<std::variant<bool, NiceClass, double, NiceTime>>(j, "nice"));
        if (j.find("padding") != j.end() && j.at("padding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_padding(get_stack_optional<double>(j, "padding"));
        if (j.find("paddingInner") != j.end() && j.at("paddingInner").is_null()) throw std::runtime_error("Unexpected null");
        x.set_padding_inner(get_stack_optional<double>(j, "paddingInner"));
        if (j.find("paddingOuter") != j.end() && j.at("paddingOuter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_padding_outer(get_stack_optional<double>(j, "paddingOuter"));
        if (j.find("range") != j.end() && j.at("range").is_null()) throw std::runtime_error("Unexpected null");
        x.set_range(get_stack_optional<std::variant<std::vector<TitleFontWeight>, std::string>>(j, "range"));
        x.set_range_step(get_stack_optional<double>(j, "rangeStep"));
        if (j.find("round") != j.end() && j.at("round").is_null()) throw std::runtime_error("Unexpected null");
        x.set_round(get_stack_optional<bool>(j, "round"));
        if (j.find("scheme") != j.end() && j.at("scheme").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scheme(get_stack_optional<std::variant<SchemeParams, std::string>>(j, "scheme"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<ScaleType>(j, "type"));
        if (j.find("zero") != j.end() && j.at("zero").is_null()) throw std::runtime_error("Unexpected null");
        x.set_zero(get_stack_optional<bool>(j, "zero"));
    }

    inline void to_json(json & j, const Scale & x) {
        j = json::object();
        j["base"] = x.get_base();
        j["clamp"] = x.get_clamp();
        j["domain"] = x.get_domain();
        j["exponent"] = x.get_exponent();
        j["interpolate"] = x.get_interpolate();
        j["nice"] = x.get_nice();
        j["padding"] = x.get_padding();
        j["paddingInner"] = x.get_padding_inner();
        j["paddingOuter"] = x.get_padding_outer();
        j["range"] = x.get_range();
        j["rangeStep"] = x.get_range_step();
        j["round"] = x.get_round();
        j["scheme"] = x.get_scheme();
        j["type"] = x.get_type();
        j["zero"] = x.get_zero();
    }

    inline void from_json(const json & j, SortField& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        x.set_op(j.at("op").get<AggregateOp>());
        x.set_order(get_stack_optional<SortEnum>(j, "order"));
    }

    inline void to_json(json & j, const SortField & x) {
        j = json::object();
        j["field"] = x.get_field();
        j["op"] = x.get_op();
        j["order"] = x.get_order();
    }

    inline void from_json(const json & j, ConditionalPredicateMarkPropFieldDefClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("test") != j.end() && j.at("test").is_null()) throw std::runtime_error("Unexpected null");
        x.set_test(get_heap_optional<LogicalOperandPredicate>(j, "test"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::variant<bool, double, std::string>>(j, "value"));
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_heap_optional<SelectionOperand>(j, "selection"));
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        x.set_legend(get_stack_optional<Legend>(j, "legend"));
        if (j.find("scale") != j.end() && j.at("scale").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scale(get_stack_optional<Scale>(j, "scale"));
        x.set_sort(get_stack_optional<std::variant<SortField, SortEnum>>(j, "sort"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<Type>(j, "type"));
    }

    inline void to_json(json & j, const ConditionalPredicateMarkPropFieldDefClass & x) {
        j = json::object();
        j["test"] = x.get_test();
        j["value"] = x.get_value();
        j["selection"] = x.get_selection();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["legend"] = x.get_legend();
        j["scale"] = x.get_scale();
        j["sort"] = x.get_sort();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, MarkPropDefWithCondition& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("condition") != j.end() && j.at("condition").is_null()) throw std::runtime_error("Unexpected null");
        x.set_condition(get_stack_optional<std::variant<std::vector<ConditionalValueDef>, ConditionalPredicateMarkPropFieldDefClass>>(j, "condition"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        x.set_legend(get_stack_optional<Legend>(j, "legend"));
        if (j.find("scale") != j.end() && j.at("scale").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scale(get_stack_optional<Scale>(j, "scale"));
        x.set_sort(get_stack_optional<std::variant<SortField, SortEnum>>(j, "sort"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<Type>(j, "type"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::variant<bool, double, std::string>>(j, "value"));
    }

    inline void to_json(json & j, const MarkPropDefWithCondition & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["condition"] = x.get_condition();
        j["field"] = x.get_field();
        j["legend"] = x.get_legend();
        j["scale"] = x.get_scale();
        j["sort"] = x.get_sort();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, Header& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("format") != j.end() && j.at("format").is_null()) throw std::runtime_error("Unexpected null");
        x.set_format(get_stack_optional<std::string>(j, "format"));
        if (j.find("labelAngle") != j.end() && j.at("labelAngle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_angle(get_stack_optional<double>(j, "labelAngle"));
        x.set_title(get_stack_optional<std::string>(j, "title"));
    }

    inline void to_json(json & j, const Header & x) {
        j = json::object();
        j["format"] = x.get_format();
        j["labelAngle"] = x.get_label_angle();
        j["title"] = x.get_title();
    }

    inline void from_json(const json & j, FacetFieldDef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        if (j.find("header") != j.end() && j.at("header").is_null()) throw std::runtime_error("Unexpected null");
        x.set_header(get_stack_optional<Header>(j, "header"));
        x.set_sort(get_stack_optional<SortEnum>(j, "sort"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        x.set_type(j.at("type").get<Type>());
    }

    inline void to_json(json & j, const FacetFieldDef & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["header"] = x.get_header();
        j["sort"] = x.get_sort();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, FieldDef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        x.set_type(j.at("type").get<Type>());
    }

    inline void to_json(json & j, const FieldDef & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, ConditionalPredicateFieldDefClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("test") != j.end() && j.at("test").is_null()) throw std::runtime_error("Unexpected null");
        x.set_test(get_heap_optional<LogicalOperandPredicate>(j, "test"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::variant<bool, double, std::string>>(j, "value"));
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_heap_optional<SelectionOperand>(j, "selection"));
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<Type>(j, "type"));
    }

    inline void to_json(json & j, const ConditionalPredicateFieldDefClass & x) {
        j = json::object();
        j["test"] = x.get_test();
        j["value"] = x.get_value();
        j["selection"] = x.get_selection();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, DefWithCondition& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("condition") != j.end() && j.at("condition").is_null()) throw std::runtime_error("Unexpected null");
        x.set_condition(get_stack_optional<std::variant<std::vector<ConditionalValueDef>, ConditionalPredicateFieldDefClass>>(j, "condition"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<Type>(j, "type"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::variant<bool, double, std::string>>(j, "value"));
    }

    inline void to_json(json & j, const DefWithCondition & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["condition"] = x.get_condition();
        j["field"] = x.get_field();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, OrderFieldDef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        x.set_sort(get_stack_optional<SortEnum>(j, "sort"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        x.set_type(j.at("type").get<Type>());
    }

    inline void to_json(json & j, const OrderFieldDef & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["sort"] = x.get_sort();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, ConditionalPredicateTextFieldDefClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("test") != j.end() && j.at("test").is_null()) throw std::runtime_error("Unexpected null");
        x.set_test(get_heap_optional<LogicalOperandPredicate>(j, "test"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::variant<bool, double, std::string>>(j, "value"));
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_heap_optional<SelectionOperand>(j, "selection"));
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        if (j.find("format") != j.end() && j.at("format").is_null()) throw std::runtime_error("Unexpected null");
        x.set_format(get_stack_optional<std::string>(j, "format"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<Type>(j, "type"));
    }

    inline void to_json(json & j, const ConditionalPredicateTextFieldDefClass & x) {
        j = json::object();
        j["test"] = x.get_test();
        j["value"] = x.get_value();
        j["selection"] = x.get_selection();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["format"] = x.get_format();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, TextDefWithCondition& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("condition") != j.end() && j.at("condition").is_null()) throw std::runtime_error("Unexpected null");
        x.set_condition(get_stack_optional<std::variant<std::vector<ConditionalValueDef>, ConditionalPredicateTextFieldDefClass>>(j, "condition"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        if (j.find("format") != j.end() && j.at("format").is_null()) throw std::runtime_error("Unexpected null");
        x.set_format(get_stack_optional<std::string>(j, "format"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<Type>(j, "type"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::variant<bool, double, std::string>>(j, "value"));
    }

    inline void to_json(json & j, const TextDefWithCondition & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["condition"] = x.get_condition();
        j["field"] = x.get_field();
        j["format"] = x.get_format();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, Axis& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("domain") != j.end() && j.at("domain").is_null()) throw std::runtime_error("Unexpected null");
        x.set_domain(get_stack_optional<bool>(j, "domain"));
        if (j.find("format") != j.end() && j.at("format").is_null()) throw std::runtime_error("Unexpected null");
        x.set_format(get_stack_optional<std::string>(j, "format"));
        if (j.find("grid") != j.end() && j.at("grid").is_null()) throw std::runtime_error("Unexpected null");
        x.set_grid(get_stack_optional<bool>(j, "grid"));
        if (j.find("labelAngle") != j.end() && j.at("labelAngle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_angle(get_stack_optional<double>(j, "labelAngle"));
        if (j.find("labelBound") != j.end() && j.at("labelBound").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_bound(get_stack_optional<std::variant<bool, double>>(j, "labelBound"));
        if (j.find("labelFlush") != j.end() && j.at("labelFlush").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_flush(get_stack_optional<std::variant<bool, double>>(j, "labelFlush"));
        if (j.find("labelOverlap") != j.end() && j.at("labelOverlap").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_overlap(get_stack_optional<std::variant<bool, LabelOverlapEnum>>(j, "labelOverlap"));
        if (j.find("labelPadding") != j.end() && j.at("labelPadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_label_padding(get_stack_optional<double>(j, "labelPadding"));
        if (j.find("labels") != j.end() && j.at("labels").is_null()) throw std::runtime_error("Unexpected null");
        x.set_labels(get_stack_optional<bool>(j, "labels"));
        if (j.find("maxExtent") != j.end() && j.at("maxExtent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_max_extent(get_stack_optional<double>(j, "maxExtent"));
        if (j.find("minExtent") != j.end() && j.at("minExtent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_min_extent(get_stack_optional<double>(j, "minExtent"));
        if (j.find("offset") != j.end() && j.at("offset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_offset(get_stack_optional<double>(j, "offset"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<TitleOrient>(j, "orient"));
        if (j.find("position") != j.end() && j.at("position").is_null()) throw std::runtime_error("Unexpected null");
        x.set_position(get_stack_optional<double>(j, "position"));
        if (j.find("tickCount") != j.end() && j.at("tickCount").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_count(get_stack_optional<double>(j, "tickCount"));
        if (j.find("ticks") != j.end() && j.at("ticks").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ticks(get_stack_optional<bool>(j, "ticks"));
        if (j.find("tickSize") != j.end() && j.at("tickSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tick_size(get_stack_optional<double>(j, "tickSize"));
        x.set_title(get_stack_optional<std::string>(j, "title"));
        if (j.find("titleMaxLength") != j.end() && j.at("titleMaxLength").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_max_length(get_stack_optional<double>(j, "titleMaxLength"));
        if (j.find("titlePadding") != j.end() && j.at("titlePadding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title_padding(get_stack_optional<double>(j, "titlePadding"));
        if (j.find("values") != j.end() && j.at("values").is_null()) throw std::runtime_error("Unexpected null");
        x.set_values(get_stack_optional<std::vector<AxisValue>>(j, "values"));
        if (j.find("zindex") != j.end() && j.at("zindex").is_null()) throw std::runtime_error("Unexpected null");
        x.set_zindex(get_stack_optional<double>(j, "zindex"));
    }

    inline void to_json(json & j, const Axis & x) {
        j = json::object();
        j["domain"] = x.get_domain();
        j["format"] = x.get_format();
        j["grid"] = x.get_grid();
        j["labelAngle"] = x.get_label_angle();
        j["labelBound"] = x.get_label_bound();
        j["labelFlush"] = x.get_label_flush();
        j["labelOverlap"] = x.get_label_overlap();
        j["labelPadding"] = x.get_label_padding();
        j["labels"] = x.get_labels();
        j["maxExtent"] = x.get_max_extent();
        j["minExtent"] = x.get_min_extent();
        j["offset"] = x.get_offset();
        j["orient"] = x.get_orient();
        j["position"] = x.get_position();
        j["tickCount"] = x.get_tick_count();
        j["ticks"] = x.get_ticks();
        j["tickSize"] = x.get_tick_size();
        j["title"] = x.get_title();
        j["titleMaxLength"] = x.get_title_max_length();
        j["titlePadding"] = x.get_title_padding();
        j["values"] = x.get_values();
        j["zindex"] = x.get_zindex();
    }

    inline void from_json(const json & j, XClass& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        x.set_axis(get_stack_optional<Axis>(j, "axis"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        if (j.find("scale") != j.end() && j.at("scale").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scale(get_stack_optional<Scale>(j, "scale"));
        x.set_sort(get_stack_optional<std::variant<SortField, SortEnum>>(j, "sort"));
        x.set_stack(get_stack_optional<StackOffset>(j, "stack"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<Type>(j, "type"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::variant<bool, double, std::string>>(j, "value"));
    }

    inline void to_json(json & j, const XClass & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["axis"] = x.get_axis();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["scale"] = x.get_scale();
        j["sort"] = x.get_sort();
        j["stack"] = x.get_stack();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, X2Class& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<AggregateOp>(j, "aggregate"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::variant<RepeatRef, std::string>>(j, "field"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<Type>(j, "type"));
        if (j.find("value") != j.end() && j.at("value").is_null()) throw std::runtime_error("Unexpected null");
        x.set_value(get_stack_optional<std::variant<bool, double, std::string>>(j, "value"));
    }

    inline void to_json(json & j, const X2Class & x) {
        j = json::object();
        j["aggregate"] = x.get_aggregate();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["timeUnit"] = x.get_time_unit();
        j["type"] = x.get_type();
        j["value"] = x.get_value();
    }

    inline void from_json(const json & j, EncodingWithFacet& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<MarkPropDefWithCondition>(j, "color"));
        if (j.find("column") != j.end() && j.at("column").is_null()) throw std::runtime_error("Unexpected null");
        x.set_column(get_stack_optional<FacetFieldDef>(j, "column"));
        if (j.find("detail") != j.end() && j.at("detail").is_null()) throw std::runtime_error("Unexpected null");
        x.set_detail(get_stack_optional<std::variant<std::vector<FieldDef>, FieldDef>>(j, "detail"));
        if (j.find("href") != j.end() && j.at("href").is_null()) throw std::runtime_error("Unexpected null");
        x.set_href(get_stack_optional<DefWithCondition>(j, "href"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<MarkPropDefWithCondition>(j, "opacity"));
        if (j.find("order") != j.end() && j.at("order").is_null()) throw std::runtime_error("Unexpected null");
        x.set_order(get_stack_optional<std::variant<std::vector<OrderFieldDef>, OrderFieldDef>>(j, "order"));
        if (j.find("row") != j.end() && j.at("row").is_null()) throw std::runtime_error("Unexpected null");
        x.set_row(get_stack_optional<FacetFieldDef>(j, "row"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<MarkPropDefWithCondition>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<MarkPropDefWithCondition>(j, "size"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<TextDefWithCondition>(j, "text"));
        if (j.find("tooltip") != j.end() && j.at("tooltip").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tooltip(get_stack_optional<TextDefWithCondition>(j, "tooltip"));
        if (j.find("x") != j.end() && j.at("x").is_null()) throw std::runtime_error("Unexpected null");
        x.set_x(get_stack_optional<XClass>(j, "x"));
        if (j.find("x2") != j.end() && j.at("x2").is_null()) throw std::runtime_error("Unexpected null");
        x.set_x2(get_stack_optional<X2Class>(j, "x2"));
        if (j.find("y") != j.end() && j.at("y").is_null()) throw std::runtime_error("Unexpected null");
        x.set_y(get_stack_optional<XClass>(j, "y"));
        if (j.find("y2") != j.end() && j.at("y2").is_null()) throw std::runtime_error("Unexpected null");
        x.set_y2(get_stack_optional<X2Class>(j, "y2"));
    }

    inline void to_json(json & j, const EncodingWithFacet & x) {
        j = json::object();
        j["color"] = x.get_color();
        j["column"] = x.get_column();
        j["detail"] = x.get_detail();
        j["href"] = x.get_href();
        j["opacity"] = x.get_opacity();
        j["order"] = x.get_order();
        j["row"] = x.get_row();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
        j["text"] = x.get_text();
        j["tooltip"] = x.get_tooltip();
        j["x"] = x.get_x();
        j["x2"] = x.get_x2();
        j["y"] = x.get_y();
        j["y2"] = x.get_y2();
    }

    inline void from_json(const json & j, FacetMapping& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("column") != j.end() && j.at("column").is_null()) throw std::runtime_error("Unexpected null");
        x.set_column(get_stack_optional<FacetFieldDef>(j, "column"));
        if (j.find("row") != j.end() && j.at("row").is_null()) throw std::runtime_error("Unexpected null");
        x.set_row(get_stack_optional<FacetFieldDef>(j, "row"));
    }

    inline void to_json(json & j, const FacetMapping & x) {
        j = json::object();
        j["column"] = x.get_column();
        j["row"] = x.get_row();
    }

    inline void from_json(const json & j, Encoding& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<MarkPropDefWithCondition>(j, "color"));
        if (j.find("detail") != j.end() && j.at("detail").is_null()) throw std::runtime_error("Unexpected null");
        x.set_detail(get_stack_optional<std::variant<std::vector<FieldDef>, FieldDef>>(j, "detail"));
        if (j.find("href") != j.end() && j.at("href").is_null()) throw std::runtime_error("Unexpected null");
        x.set_href(get_stack_optional<DefWithCondition>(j, "href"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<MarkPropDefWithCondition>(j, "opacity"));
        if (j.find("order") != j.end() && j.at("order").is_null()) throw std::runtime_error("Unexpected null");
        x.set_order(get_stack_optional<std::variant<std::vector<OrderFieldDef>, OrderFieldDef>>(j, "order"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<MarkPropDefWithCondition>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<MarkPropDefWithCondition>(j, "size"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<TextDefWithCondition>(j, "text"));
        if (j.find("tooltip") != j.end() && j.at("tooltip").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tooltip(get_stack_optional<TextDefWithCondition>(j, "tooltip"));
        if (j.find("x") != j.end() && j.at("x").is_null()) throw std::runtime_error("Unexpected null");
        x.set_x(get_stack_optional<XClass>(j, "x"));
        if (j.find("x2") != j.end() && j.at("x2").is_null()) throw std::runtime_error("Unexpected null");
        x.set_x2(get_stack_optional<X2Class>(j, "x2"));
        if (j.find("y") != j.end() && j.at("y").is_null()) throw std::runtime_error("Unexpected null");
        x.set_y(get_stack_optional<XClass>(j, "y"));
        if (j.find("y2") != j.end() && j.at("y2").is_null()) throw std::runtime_error("Unexpected null");
        x.set_y2(get_stack_optional<X2Class>(j, "y2"));
    }

    inline void to_json(json & j, const Encoding & x) {
        j = json::object();
        j["color"] = x.get_color();
        j["detail"] = x.get_detail();
        j["href"] = x.get_href();
        j["opacity"] = x.get_opacity();
        j["order"] = x.get_order();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
        j["text"] = x.get_text();
        j["tooltip"] = x.get_tooltip();
        j["x"] = x.get_x();
        j["x2"] = x.get_x2();
        j["y"] = x.get_y();
        j["y2"] = x.get_y2();
    }

    inline void from_json(const json & j, MarkDef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("align") != j.end() && j.at("align").is_null()) throw std::runtime_error("Unexpected null");
        x.set_align(get_stack_optional<HorizontalAlign>(j, "align"));
        if (j.find("angle") != j.end() && j.at("angle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_angle(get_stack_optional<double>(j, "angle"));
        if (j.find("baseline") != j.end() && j.at("baseline").is_null()) throw std::runtime_error("Unexpected null");
        x.set_baseline(get_stack_optional<VerticalAlign>(j, "baseline"));
        if (j.find("clip") != j.end() && j.at("clip").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clip(get_stack_optional<bool>(j, "clip"));
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<std::string>(j, "color"));
        if (j.find("cursor") != j.end() && j.at("cursor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_cursor(get_stack_optional<Cursor>(j, "cursor"));
        if (j.find("dx") != j.end() && j.at("dx").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dx(get_stack_optional<double>(j, "dx"));
        if (j.find("dy") != j.end() && j.at("dy").is_null()) throw std::runtime_error("Unexpected null");
        x.set_dy(get_stack_optional<double>(j, "dy"));
        if (j.find("fill") != j.end() && j.at("fill").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill(get_stack_optional<std::string>(j, "fill"));
        if (j.find("filled") != j.end() && j.at("filled").is_null()) throw std::runtime_error("Unexpected null");
        x.set_filled(get_stack_optional<bool>(j, "filled"));
        if (j.find("fillOpacity") != j.end() && j.at("fillOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fill_opacity(get_stack_optional<double>(j, "fillOpacity"));
        if (j.find("font") != j.end() && j.at("font").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font(get_stack_optional<std::string>(j, "font"));
        if (j.find("fontSize") != j.end() && j.at("fontSize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_size(get_stack_optional<double>(j, "fontSize"));
        if (j.find("fontStyle") != j.end() && j.at("fontStyle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_style(get_stack_optional<FontStyle>(j, "fontStyle"));
        if (j.find("fontWeight") != j.end() && j.at("fontWeight").is_null()) throw std::runtime_error("Unexpected null");
        x.set_font_weight(get_stack_optional<std::variant<double, FontWeight>>(j, "fontWeight"));
        if (j.find("href") != j.end() && j.at("href").is_null()) throw std::runtime_error("Unexpected null");
        x.set_href(get_stack_optional<std::string>(j, "href"));
        if (j.find("interpolate") != j.end() && j.at("interpolate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_interpolate(get_stack_optional<Interpolate>(j, "interpolate"));
        if (j.find("limit") != j.end() && j.at("limit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_limit(get_stack_optional<double>(j, "limit"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<double>(j, "opacity"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<Orient>(j, "orient"));
        if (j.find("radius") != j.end() && j.at("radius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_radius(get_stack_optional<double>(j, "radius"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<std::string>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<double>(j, "size"));
        if (j.find("stroke") != j.end() && j.at("stroke").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke(get_stack_optional<std::string>(j, "stroke"));
        if (j.find("strokeDash") != j.end() && j.at("strokeDash").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash(get_stack_optional<std::vector<double>>(j, "strokeDash"));
        if (j.find("strokeDashOffset") != j.end() && j.at("strokeDashOffset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_dash_offset(get_stack_optional<double>(j, "strokeDashOffset"));
        if (j.find("strokeOpacity") != j.end() && j.at("strokeOpacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_opacity(get_stack_optional<double>(j, "strokeOpacity"));
        if (j.find("strokeWidth") != j.end() && j.at("strokeWidth").is_null()) throw std::runtime_error("Unexpected null");
        x.set_stroke_width(get_stack_optional<double>(j, "strokeWidth"));
        if (j.find("style") != j.end() && j.at("style").is_null()) throw std::runtime_error("Unexpected null");
        x.set_style(get_stack_optional<std::variant<std::vector<std::string>, std::string>>(j, "style"));
        if (j.find("tension") != j.end() && j.at("tension").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tension(get_stack_optional<double>(j, "tension"));
        if (j.find("text") != j.end() && j.at("text").is_null()) throw std::runtime_error("Unexpected null");
        x.set_text(get_stack_optional<std::string>(j, "text"));
        if (j.find("theta") != j.end() && j.at("theta").is_null()) throw std::runtime_error("Unexpected null");
        x.set_theta(get_stack_optional<double>(j, "theta"));
        x.set_type(j.at("type").get<Mark>());
    }

    inline void to_json(json & j, const MarkDef & x) {
        j = json::object();
        j["align"] = x.get_align();
        j["angle"] = x.get_angle();
        j["baseline"] = x.get_baseline();
        j["clip"] = x.get_clip();
        j["color"] = x.get_color();
        j["cursor"] = x.get_cursor();
        j["dx"] = x.get_dx();
        j["dy"] = x.get_dy();
        j["fill"] = x.get_fill();
        j["filled"] = x.get_filled();
        j["fillOpacity"] = x.get_fill_opacity();
        j["font"] = x.get_font();
        j["fontSize"] = x.get_font_size();
        j["fontStyle"] = x.get_font_style();
        j["fontWeight"] = x.get_font_weight();
        j["href"] = x.get_href();
        j["interpolate"] = x.get_interpolate();
        j["limit"] = x.get_limit();
        j["opacity"] = x.get_opacity();
        j["orient"] = x.get_orient();
        j["radius"] = x.get_radius();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
        j["stroke"] = x.get_stroke();
        j["strokeDash"] = x.get_stroke_dash();
        j["strokeDashOffset"] = x.get_stroke_dash_offset();
        j["strokeOpacity"] = x.get_stroke_opacity();
        j["strokeWidth"] = x.get_stroke_width();
        j["style"] = x.get_style();
        j["tension"] = x.get_tension();
        j["text"] = x.get_text();
        j["theta"] = x.get_theta();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, Projection& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("center") != j.end() && j.at("center").is_null()) throw std::runtime_error("Unexpected null");
        x.set_center(get_stack_optional<std::vector<double>>(j, "center"));
        if (j.find("clipAngle") != j.end() && j.at("clipAngle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clip_angle(get_stack_optional<double>(j, "clipAngle"));
        if (j.find("clipExtent") != j.end() && j.at("clipExtent").is_null()) throw std::runtime_error("Unexpected null");
        x.set_clip_extent(get_stack_optional<std::vector<std::vector<double>>>(j, "clipExtent"));
        if (j.find("coefficient") != j.end() && j.at("coefficient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_coefficient(get_stack_optional<double>(j, "coefficient"));
        if (j.find("distance") != j.end() && j.at("distance").is_null()) throw std::runtime_error("Unexpected null");
        x.set_distance(get_stack_optional<double>(j, "distance"));
        if (j.find("fraction") != j.end() && j.at("fraction").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fraction(get_stack_optional<double>(j, "fraction"));
        if (j.find("lobes") != j.end() && j.at("lobes").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lobes(get_stack_optional<double>(j, "lobes"));
        if (j.find("parallel") != j.end() && j.at("parallel").is_null()) throw std::runtime_error("Unexpected null");
        x.set_parallel(get_stack_optional<double>(j, "parallel"));
        if (j.find("precision") != j.end() && j.at("precision").is_null()) throw std::runtime_error("Unexpected null");
        x.set_precision(get_stack_optional<std::map<std::string, TitleFontWeight>>(j, "precision"));
        if (j.find("radius") != j.end() && j.at("radius").is_null()) throw std::runtime_error("Unexpected null");
        x.set_radius(get_stack_optional<double>(j, "radius"));
        if (j.find("ratio") != j.end() && j.at("ratio").is_null()) throw std::runtime_error("Unexpected null");
        x.set_ratio(get_stack_optional<double>(j, "ratio"));
        if (j.find("rotate") != j.end() && j.at("rotate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_rotate(get_stack_optional<std::vector<double>>(j, "rotate"));
        if (j.find("spacing") != j.end() && j.at("spacing").is_null()) throw std::runtime_error("Unexpected null");
        x.set_spacing(get_stack_optional<double>(j, "spacing"));
        if (j.find("tilt") != j.end() && j.at("tilt").is_null()) throw std::runtime_error("Unexpected null");
        x.set_tilt(get_stack_optional<double>(j, "tilt"));
        if (j.find("type") != j.end() && j.at("type").is_null()) throw std::runtime_error("Unexpected null");
        x.set_type(get_stack_optional<VgProjectionType>(j, "type"));
    }

    inline void to_json(json & j, const Projection & x) {
        j = json::object();
        j["center"] = x.get_center();
        j["clipAngle"] = x.get_clip_angle();
        j["clipExtent"] = x.get_clip_extent();
        j["coefficient"] = x.get_coefficient();
        j["distance"] = x.get_distance();
        j["fraction"] = x.get_fraction();
        j["lobes"] = x.get_lobes();
        j["parallel"] = x.get_parallel();
        j["precision"] = x.get_precision();
        j["radius"] = x.get_radius();
        j["ratio"] = x.get_ratio();
        j["rotate"] = x.get_rotate();
        j["spacing"] = x.get_spacing();
        j["tilt"] = x.get_tilt();
        j["type"] = x.get_type();
    }

    inline void from_json(const json & j, AxisResolveMap& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("x") != j.end() && j.at("x").is_null()) throw std::runtime_error("Unexpected null");
        x.set_x(get_stack_optional<ResolveMode>(j, "x"));
        if (j.find("y") != j.end() && j.at("y").is_null()) throw std::runtime_error("Unexpected null");
        x.set_y(get_stack_optional<ResolveMode>(j, "y"));
    }

    inline void to_json(json & j, const AxisResolveMap & x) {
        j = json::object();
        j["x"] = x.get_x();
        j["y"] = x.get_y();
    }

    inline void from_json(const json & j, LegendResolveMap& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<ResolveMode>(j, "color"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<ResolveMode>(j, "opacity"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<ResolveMode>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<ResolveMode>(j, "size"));
    }

    inline void to_json(json & j, const LegendResolveMap & x) {
        j = json::object();
        j["color"] = x.get_color();
        j["opacity"] = x.get_opacity();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
    }

    inline void from_json(const json & j, ScaleResolveMap& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("color") != j.end() && j.at("color").is_null()) throw std::runtime_error("Unexpected null");
        x.set_color(get_stack_optional<ResolveMode>(j, "color"));
        if (j.find("opacity") != j.end() && j.at("opacity").is_null()) throw std::runtime_error("Unexpected null");
        x.set_opacity(get_stack_optional<ResolveMode>(j, "opacity"));
        if (j.find("shape") != j.end() && j.at("shape").is_null()) throw std::runtime_error("Unexpected null");
        x.set_shape(get_stack_optional<ResolveMode>(j, "shape"));
        if (j.find("size") != j.end() && j.at("size").is_null()) throw std::runtime_error("Unexpected null");
        x.set_size(get_stack_optional<ResolveMode>(j, "size"));
        if (j.find("x") != j.end() && j.at("x").is_null()) throw std::runtime_error("Unexpected null");
        x.set_x(get_stack_optional<ResolveMode>(j, "x"));
        if (j.find("y") != j.end() && j.at("y").is_null()) throw std::runtime_error("Unexpected null");
        x.set_y(get_stack_optional<ResolveMode>(j, "y"));
    }

    inline void to_json(json & j, const ScaleResolveMap & x) {
        j = json::object();
        j["color"] = x.get_color();
        j["opacity"] = x.get_opacity();
        j["shape"] = x.get_shape();
        j["size"] = x.get_size();
        j["x"] = x.get_x();
        j["y"] = x.get_y();
    }

    inline void from_json(const json & j, Resolve& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("axis") != j.end() && j.at("axis").is_null()) throw std::runtime_error("Unexpected null");
        x.set_axis(get_stack_optional<AxisResolveMap>(j, "axis"));
        if (j.find("legend") != j.end() && j.at("legend").is_null()) throw std::runtime_error("Unexpected null");
        x.set_legend(get_stack_optional<LegendResolveMap>(j, "legend"));
        if (j.find("scale") != j.end() && j.at("scale").is_null()) throw std::runtime_error("Unexpected null");
        x.set_scale(get_stack_optional<ScaleResolveMap>(j, "scale"));
    }

    inline void to_json(json & j, const Resolve & x) {
        j = json::object();
        j["axis"] = x.get_axis();
        j["legend"] = x.get_legend();
        j["scale"] = x.get_scale();
    }

    inline void from_json(const json & j, SelectionDef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("bind") != j.end() && j.at("bind").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bind(get_stack_optional<std::variant<BindEnum, std::map<std::string, VgBinding>>>(j, "bind"));
        if (j.find("empty") != j.end() && j.at("empty").is_null()) throw std::runtime_error("Unexpected null");
        x.set_empty(get_stack_optional<Empty>(j, "empty"));
        if (j.find("encodings") != j.end() && j.at("encodings").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encodings(get_stack_optional<std::vector<SingleDefChannel>>(j, "encodings"));
        if (j.find("fields") != j.end() && j.at("fields").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fields(get_stack_optional<std::vector<std::string>>(j, "fields"));
        if (j.find("nearest") != j.end() && j.at("nearest").is_null()) throw std::runtime_error("Unexpected null");
        x.set_nearest(get_stack_optional<bool>(j, "nearest"));
        x.set_on(get_untyped(j, "on"));
        if (j.find("resolve") != j.end() && j.at("resolve").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resolve(get_stack_optional<SelectionResolution>(j, "resolve"));
        x.set_type(j.at("type").get<SelectionDefType>());
        if (j.find("toggle") != j.end() && j.at("toggle").is_null()) throw std::runtime_error("Unexpected null");
        x.set_toggle(get_stack_optional<std::variant<bool, std::string>>(j, "toggle"));
        if (j.find("mark") != j.end() && j.at("mark").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mark(get_stack_optional<BrushConfig>(j, "mark"));
        if (j.find("translate") != j.end() && j.at("translate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_translate(get_stack_optional<std::variant<bool, std::string>>(j, "translate"));
        if (j.find("zoom") != j.end() && j.at("zoom").is_null()) throw std::runtime_error("Unexpected null");
        x.set_zoom(get_stack_optional<std::variant<bool, std::string>>(j, "zoom"));
    }

    inline void to_json(json & j, const SelectionDef & x) {
        j = json::object();
        j["bind"] = x.get_bind();
        j["empty"] = x.get_empty();
        j["encodings"] = x.get_encodings();
        j["fields"] = x.get_fields();
        j["nearest"] = x.get_nearest();
        j["on"] = x.get_on();
        j["resolve"] = x.get_resolve();
        j["type"] = x.get_type();
        j["toggle"] = x.get_toggle();
        j["mark"] = x.get_mark();
        j["translate"] = x.get_translate();
        j["zoom"] = x.get_zoom();
    }

    inline void from_json(const json & j, TitleParams& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("anchor") != j.end() && j.at("anchor").is_null()) throw std::runtime_error("Unexpected null");
        x.set_anchor(get_stack_optional<Anchor>(j, "anchor"));
        if (j.find("offset") != j.end() && j.at("offset").is_null()) throw std::runtime_error("Unexpected null");
        x.set_offset(get_stack_optional<double>(j, "offset"));
        if (j.find("orient") != j.end() && j.at("orient").is_null()) throw std::runtime_error("Unexpected null");
        x.set_orient(get_stack_optional<TitleOrient>(j, "orient"));
        if (j.find("style") != j.end() && j.at("style").is_null()) throw std::runtime_error("Unexpected null");
        x.set_style(get_stack_optional<std::variant<std::vector<std::string>, std::string>>(j, "style"));
        x.set_text(j.at("text").get<std::string>());
    }

    inline void to_json(json & j, const TitleParams & x) {
        j = json::object();
        j["anchor"] = x.get_anchor();
        j["offset"] = x.get_offset();
        j["orient"] = x.get_orient();
        j["style"] = x.get_style();
        j["text"] = x.get_text();
    }

    inline void from_json(const json & j, AggregatedFieldDef& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_as(j.at("as").get<std::string>());
        x.set_field(j.at("field").get<std::string>());
        x.set_op(j.at("op").get<AggregateOp>());
    }

    inline void to_json(json & j, const AggregatedFieldDef & x) {
        j = json::object();
        j["as"] = x.get_as();
        j["field"] = x.get_field();
        j["op"] = x.get_op();
    }

    inline void from_json(const json & j, LookupData& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_data(j.at("data").get<Data>());
        if (j.find("fields") != j.end() && j.at("fields").is_null()) throw std::runtime_error("Unexpected null");
        x.set_fields(get_stack_optional<std::vector<std::string>>(j, "fields"));
        x.set_key(j.at("key").get<std::string>());
    }

    inline void to_json(json & j, const LookupData & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["fields"] = x.get_fields();
        j["key"] = x.get_key();
    }

    inline void from_json(const json & j, Transform& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("filter") != j.end() && j.at("filter").is_null()) throw std::runtime_error("Unexpected null");
        x.set_filter(get_heap_optional<LogicalOperandPredicate>(j, "filter"));
        if (j.find("as") != j.end() && j.at("as").is_null()) throw std::runtime_error("Unexpected null");
        x.set_as(get_stack_optional<std::variant<std::vector<std::string>, std::string>>(j, "as"));
        if (j.find("calculate") != j.end() && j.at("calculate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_calculate(get_stack_optional<std::string>(j, "calculate"));
        if (j.find("default") != j.end() && j.at("default").is_null()) throw std::runtime_error("Unexpected null");
        x.set_transform_default(get_stack_optional<std::string>(j, "default"));
        if (j.find("from") != j.end() && j.at("from").is_null()) throw std::runtime_error("Unexpected null");
        x.set_from(get_stack_optional<LookupData>(j, "from"));
        if (j.find("lookup") != j.end() && j.at("lookup").is_null()) throw std::runtime_error("Unexpected null");
        x.set_lookup(get_stack_optional<std::string>(j, "lookup"));
        if (j.find("bin") != j.end() && j.at("bin").is_null()) throw std::runtime_error("Unexpected null");
        x.set_bin(get_stack_optional<std::variant<bool, BinParams>>(j, "bin"));
        if (j.find("field") != j.end() && j.at("field").is_null()) throw std::runtime_error("Unexpected null");
        x.set_field(get_stack_optional<std::string>(j, "field"));
        if (j.find("timeUnit") != j.end() && j.at("timeUnit").is_null()) throw std::runtime_error("Unexpected null");
        x.set_time_unit(get_stack_optional<TimeUnit>(j, "timeUnit"));
        if (j.find("aggregate") != j.end() && j.at("aggregate").is_null()) throw std::runtime_error("Unexpected null");
        x.set_aggregate(get_stack_optional<std::vector<AggregatedFieldDef>>(j, "aggregate"));
        if (j.find("groupby") != j.end() && j.at("groupby").is_null()) throw std::runtime_error("Unexpected null");
        x.set_groupby(get_stack_optional<std::vector<std::string>>(j, "groupby"));
    }

    inline void to_json(json & j, const Transform & x) {
        j = json::object();
        j["filter"] = x.get_filter();
        j["as"] = x.get_as();
        j["calculate"] = x.get_calculate();
        j["default"] = x.get_transform_default();
        j["from"] = x.get_from();
        j["lookup"] = x.get_lookup();
        j["bin"] = x.get_bin();
        j["field"] = x.get_field();
        j["timeUnit"] = x.get_time_unit();
        j["aggregate"] = x.get_aggregate();
        j["groupby"] = x.get_groupby();
    }

    inline void from_json(const json & j, LayerSpec& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("data") != j.end() && j.at("data").is_null()) throw std::runtime_error("Unexpected null");
        x.set_data(get_stack_optional<Data>(j, "data"));
        if (j.find("description") != j.end() && j.at("description").is_null()) throw std::runtime_error("Unexpected null");
        x.set_description(get_stack_optional<std::string>(j, "description"));
        if (j.find("height") != j.end() && j.at("height").is_null()) throw std::runtime_error("Unexpected null");
        x.set_height(get_stack_optional<double>(j, "height"));
        if (j.find("layer") != j.end() && j.at("layer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_layer(get_stack_optional<std::vector<LayerSpec>>(j, "layer"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        if (j.find("resolve") != j.end() && j.at("resolve").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resolve(get_stack_optional<Resolve>(j, "resolve"));
        if (j.find("title") != j.end() && j.at("title").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title(get_stack_optional<std::variant<TitleParams, std::string>>(j, "title"));
        if (j.find("transform") != j.end() && j.at("transform").is_null()) throw std::runtime_error("Unexpected null");
        x.set_transform(get_stack_optional<std::vector<Transform>>(j, "transform"));
        if (j.find("width") != j.end() && j.at("width").is_null()) throw std::runtime_error("Unexpected null");
        x.set_width(get_stack_optional<double>(j, "width"));
        if (j.find("encoding") != j.end() && j.at("encoding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encoding(get_stack_optional<Encoding>(j, "encoding"));
        if (j.find("mark") != j.end() && j.at("mark").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mark(get_stack_optional<std::variant<MarkDef, Mark>>(j, "mark"));
        if (j.find("projection") != j.end() && j.at("projection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_projection(get_stack_optional<Projection>(j, "projection"));
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_stack_optional<std::map<std::string, SelectionDef>>(j, "selection"));
    }

    inline void to_json(json & j, const LayerSpec & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["description"] = x.get_description();
        j["height"] = x.get_height();
        j["layer"] = x.get_layer();
        j["name"] = x.get_name();
        j["resolve"] = x.get_resolve();
        j["title"] = x.get_title();
        j["transform"] = x.get_transform();
        j["width"] = x.get_width();
        j["encoding"] = x.get_encoding();
        j["mark"] = x.get_mark();
        j["projection"] = x.get_projection();
        j["selection"] = x.get_selection();
    }

    inline void from_json(const json & j, Repeat& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("column") != j.end() && j.at("column").is_null()) throw std::runtime_error("Unexpected null");
        x.set_column(get_stack_optional<std::vector<std::string>>(j, "column"));
        if (j.find("row") != j.end() && j.at("row").is_null()) throw std::runtime_error("Unexpected null");
        x.set_row(get_stack_optional<std::vector<std::string>>(j, "row"));
    }

    inline void to_json(json & j, const Repeat & x) {
        j = json::object();
        j["column"] = x.get_column();
        j["row"] = x.get_row();
    }

    inline void from_json(const json & j, Spec& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("data") != j.end() && j.at("data").is_null()) throw std::runtime_error("Unexpected null");
        x.set_data(get_stack_optional<Data>(j, "data"));
        if (j.find("description") != j.end() && j.at("description").is_null()) throw std::runtime_error("Unexpected null");
        x.set_description(get_stack_optional<std::string>(j, "description"));
        if (j.find("height") != j.end() && j.at("height").is_null()) throw std::runtime_error("Unexpected null");
        x.set_height(get_stack_optional<double>(j, "height"));
        if (j.find("layer") != j.end() && j.at("layer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_layer(get_stack_optional<std::vector<LayerSpec>>(j, "layer"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        if (j.find("resolve") != j.end() && j.at("resolve").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resolve(get_stack_optional<Resolve>(j, "resolve"));
        if (j.find("title") != j.end() && j.at("title").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title(get_stack_optional<std::variant<TitleParams, std::string>>(j, "title"));
        if (j.find("transform") != j.end() && j.at("transform").is_null()) throw std::runtime_error("Unexpected null");
        x.set_transform(get_stack_optional<std::vector<Transform>>(j, "transform"));
        if (j.find("width") != j.end() && j.at("width").is_null()) throw std::runtime_error("Unexpected null");
        x.set_width(get_stack_optional<double>(j, "width"));
        if (j.find("encoding") != j.end() && j.at("encoding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encoding(get_stack_optional<Encoding>(j, "encoding"));
        if (j.find("mark") != j.end() && j.at("mark").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mark(get_stack_optional<std::variant<MarkDef, Mark>>(j, "mark"));
        if (j.find("projection") != j.end() && j.at("projection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_projection(get_stack_optional<Projection>(j, "projection"));
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_stack_optional<std::map<std::string, SelectionDef>>(j, "selection"));
        if (j.find("facet") != j.end() && j.at("facet").is_null()) throw std::runtime_error("Unexpected null");
        x.set_facet(get_stack_optional<FacetMapping>(j, "facet"));
        if (j.find("spec") != j.end() && j.at("spec").is_null()) throw std::runtime_error("Unexpected null");
        x.set_spec(get_heap_optional<Spec>(j, "spec"));
        if (j.find("repeat") != j.end() && j.at("repeat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_repeat(get_stack_optional<Repeat>(j, "repeat"));
        if (j.find("vconcat") != j.end() && j.at("vconcat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_vconcat(get_stack_optional<std::vector<Spec>>(j, "vconcat"));
        if (j.find("hconcat") != j.end() && j.at("hconcat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hconcat(get_stack_optional<std::vector<Spec>>(j, "hconcat"));
    }

    inline void to_json(json & j, const Spec & x) {
        j = json::object();
        j["data"] = x.get_data();
        j["description"] = x.get_description();
        j["height"] = x.get_height();
        j["layer"] = x.get_layer();
        j["name"] = x.get_name();
        j["resolve"] = x.get_resolve();
        j["title"] = x.get_title();
        j["transform"] = x.get_transform();
        j["width"] = x.get_width();
        j["encoding"] = x.get_encoding();
        j["mark"] = x.get_mark();
        j["projection"] = x.get_projection();
        j["selection"] = x.get_selection();
        j["facet"] = x.get_facet();
        j["spec"] = x.get_spec();
        j["repeat"] = x.get_repeat();
        j["vconcat"] = x.get_vconcat();
        j["hconcat"] = x.get_hconcat();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("$schema") != j.end() && j.at("$schema").is_null()) throw std::runtime_error("Unexpected null");
        x.set_schema(get_stack_optional<std::string>(j, "$schema"));
        if (j.find("autosize") != j.end() && j.at("autosize").is_null()) throw std::runtime_error("Unexpected null");
        x.set_autosize(get_stack_optional<std::variant<AutoSizeParams, AutosizeType>>(j, "autosize"));
        if (j.find("background") != j.end() && j.at("background").is_null()) throw std::runtime_error("Unexpected null");
        x.set_background(get_stack_optional<std::string>(j, "background"));
        if (j.find("config") != j.end() && j.at("config").is_null()) throw std::runtime_error("Unexpected null");
        x.set_config(get_stack_optional<Config>(j, "config"));
        if (j.find("data") != j.end() && j.at("data").is_null()) throw std::runtime_error("Unexpected null");
        x.set_data(get_stack_optional<Data>(j, "data"));
        if (j.find("description") != j.end() && j.at("description").is_null()) throw std::runtime_error("Unexpected null");
        x.set_description(get_stack_optional<std::string>(j, "description"));
        if (j.find("encoding") != j.end() && j.at("encoding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_encoding(get_stack_optional<EncodingWithFacet>(j, "encoding"));
        if (j.find("height") != j.end() && j.at("height").is_null()) throw std::runtime_error("Unexpected null");
        x.set_height(get_stack_optional<double>(j, "height"));
        if (j.find("mark") != j.end() && j.at("mark").is_null()) throw std::runtime_error("Unexpected null");
        x.set_mark(get_stack_optional<std::variant<MarkDef, Mark>>(j, "mark"));
        if (j.find("name") != j.end() && j.at("name").is_null()) throw std::runtime_error("Unexpected null");
        x.set_name(get_stack_optional<std::string>(j, "name"));
        if (j.find("padding") != j.end() && j.at("padding").is_null()) throw std::runtime_error("Unexpected null");
        x.set_padding(get_stack_optional<std::variant<PaddingClass, double>>(j, "padding"));
        if (j.find("projection") != j.end() && j.at("projection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_projection(get_stack_optional<Projection>(j, "projection"));
        if (j.find("selection") != j.end() && j.at("selection").is_null()) throw std::runtime_error("Unexpected null");
        x.set_selection(get_stack_optional<std::map<std::string, SelectionDef>>(j, "selection"));
        if (j.find("title") != j.end() && j.at("title").is_null()) throw std::runtime_error("Unexpected null");
        x.set_title(get_stack_optional<std::variant<TitleParams, std::string>>(j, "title"));
        if (j.find("transform") != j.end() && j.at("transform").is_null()) throw std::runtime_error("Unexpected null");
        x.set_transform(get_stack_optional<std::vector<Transform>>(j, "transform"));
        if (j.find("width") != j.end() && j.at("width").is_null()) throw std::runtime_error("Unexpected null");
        x.set_width(get_stack_optional<double>(j, "width"));
        if (j.find("layer") != j.end() && j.at("layer").is_null()) throw std::runtime_error("Unexpected null");
        x.set_layer(get_stack_optional<std::vector<LayerSpec>>(j, "layer"));
        if (j.find("resolve") != j.end() && j.at("resolve").is_null()) throw std::runtime_error("Unexpected null");
        x.set_resolve(get_stack_optional<Resolve>(j, "resolve"));
        if (j.find("facet") != j.end() && j.at("facet").is_null()) throw std::runtime_error("Unexpected null");
        x.set_facet(get_stack_optional<FacetMapping>(j, "facet"));
        if (j.find("spec") != j.end() && j.at("spec").is_null()) throw std::runtime_error("Unexpected null");
        x.set_spec(get_heap_optional<Spec>(j, "spec"));
        if (j.find("repeat") != j.end() && j.at("repeat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_repeat(get_stack_optional<Repeat>(j, "repeat"));
        if (j.find("vconcat") != j.end() && j.at("vconcat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_vconcat(get_stack_optional<std::vector<Spec>>(j, "vconcat"));
        if (j.find("hconcat") != j.end() && j.at("hconcat").is_null()) throw std::runtime_error("Unexpected null");
        x.set_hconcat(get_stack_optional<std::vector<Spec>>(j, "hconcat"));
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["$schema"] = x.get_schema();
        j["autosize"] = x.get_autosize();
        j["background"] = x.get_background();
        j["config"] = x.get_config();
        j["data"] = x.get_data();
        j["description"] = x.get_description();
        j["encoding"] = x.get_encoding();
        j["height"] = x.get_height();
        j["mark"] = x.get_mark();
        j["name"] = x.get_name();
        j["padding"] = x.get_padding();
        j["projection"] = x.get_projection();
        j["selection"] = x.get_selection();
        j["title"] = x.get_title();
        j["transform"] = x.get_transform();
        j["width"] = x.get_width();
        j["layer"] = x.get_layer();
        j["resolve"] = x.get_resolve();
        j["facet"] = x.get_facet();
        j["spec"] = x.get_spec();
        j["repeat"] = x.get_repeat();
        j["vconcat"] = x.get_vconcat();
        j["hconcat"] = x.get_hconcat();
    }

    inline void from_json(const json & j, Contains & x) {
        if (j == "content") x = Contains::CONTENT;
        else if (j == "padding") x = Contains::PADDING;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Contains\""); }
    }

    inline void to_json(json & j, const Contains & x) {
        switch (x) {
            case Contains::CONTENT: j = "content"; break;
            case Contains::PADDING: j = "padding"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Contains\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, AutosizeType & x) {
        if (j == "pad") x = AutosizeType::PAD;
        else if (j == "fit") x = AutosizeType::FIT;
        else if (j == "none") x = AutosizeType::NONE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"AutosizeType\""); }
    }

    inline void to_json(json & j, const AutosizeType & x) {
        switch (x) {
            case AutosizeType::PAD: j = "pad"; break;
            case AutosizeType::FIT: j = "fit"; break;
            case AutosizeType::NONE: j = "none"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"AutosizeType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, HorizontalAlign & x) {
        if (j == "left") x = HorizontalAlign::LEFT;
        else if (j == "right") x = HorizontalAlign::RIGHT;
        else if (j == "center") x = HorizontalAlign::CENTER;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"HorizontalAlign\""); }
    }

    inline void to_json(json & j, const HorizontalAlign & x) {
        switch (x) {
            case HorizontalAlign::LEFT: j = "left"; break;
            case HorizontalAlign::RIGHT: j = "right"; break;
            case HorizontalAlign::CENTER: j = "center"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"HorizontalAlign\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, VerticalAlign & x) {
        if (j == "top") x = VerticalAlign::TOP;
        else if (j == "middle") x = VerticalAlign::MIDDLE;
        else if (j == "bottom") x = VerticalAlign::BOTTOM;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"VerticalAlign\""); }
    }

    inline void to_json(json & j, const VerticalAlign & x) {
        switch (x) {
            case VerticalAlign::TOP: j = "top"; break;
            case VerticalAlign::MIDDLE: j = "middle"; break;
            case VerticalAlign::BOTTOM: j = "bottom"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"VerticalAlign\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Cursor & x) {
        static std::unordered_map<std::string, Cursor> enumValues {
            {"auto", Cursor::AUTO},
            {"default", Cursor::DEFAULT},
            {"none", Cursor::NONE},
            {"context-menu", Cursor::CONTEXT_MENU},
            {"help", Cursor::HELP},
            {"pointer", Cursor::POINTER},
            {"progress", Cursor::PROGRESS},
            {"wait", Cursor::WAIT},
            {"cell", Cursor::CELL},
            {"crosshair", Cursor::CROSSHAIR},
            {"text", Cursor::TEXT},
            {"vertical-text", Cursor::VERTICAL_TEXT},
            {"alias", Cursor::ALIAS},
            {"copy", Cursor::COPY},
            {"move", Cursor::MOVE},
            {"no-drop", Cursor::NO_DROP},
            {"not-allowed", Cursor::NOT_ALLOWED},
            {"e-resize", Cursor::E_RESIZE},
            {"n-resize", Cursor::N_RESIZE},
            {"ne-resize", Cursor::NE_RESIZE},
            {"nw-resize", Cursor::NW_RESIZE},
            {"s-resize", Cursor::S_RESIZE},
            {"se-resize", Cursor::SE_RESIZE},
            {"sw-resize", Cursor::SW_RESIZE},
            {"w-resize", Cursor::W_RESIZE},
            {"ew-resize", Cursor::EW_RESIZE},
            {"ns-resize", Cursor::NS_RESIZE},
            {"nesw-resize", Cursor::NESW_RESIZE},
            {"nwse-resize", Cursor::NWSE_RESIZE},
            {"col-resize", Cursor::COL_RESIZE},
            {"row-resize", Cursor::ROW_RESIZE},
            {"all-scroll", Cursor::ALL_SCROLL},
            {"zoom-in", Cursor::ZOOM_IN},
            {"zoom-out", Cursor::ZOOM_OUT},
            {"grab", Cursor::GRAB},
            {"grabbing", Cursor::GRABBING},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Cursor\""); }
    }

    inline void to_json(json & j, const Cursor & x) {
        switch (x) {
            case Cursor::AUTO: j = "auto"; break;
            case Cursor::DEFAULT: j = "default"; break;
            case Cursor::NONE: j = "none"; break;
            case Cursor::CONTEXT_MENU: j = "context-menu"; break;
            case Cursor::HELP: j = "help"; break;
            case Cursor::POINTER: j = "pointer"; break;
            case Cursor::PROGRESS: j = "progress"; break;
            case Cursor::WAIT: j = "wait"; break;
            case Cursor::CELL: j = "cell"; break;
            case Cursor::CROSSHAIR: j = "crosshair"; break;
            case Cursor::TEXT: j = "text"; break;
            case Cursor::VERTICAL_TEXT: j = "vertical-text"; break;
            case Cursor::ALIAS: j = "alias"; break;
            case Cursor::COPY: j = "copy"; break;
            case Cursor::MOVE: j = "move"; break;
            case Cursor::NO_DROP: j = "no-drop"; break;
            case Cursor::NOT_ALLOWED: j = "not-allowed"; break;
            case Cursor::E_RESIZE: j = "e-resize"; break;
            case Cursor::N_RESIZE: j = "n-resize"; break;
            case Cursor::NE_RESIZE: j = "ne-resize"; break;
            case Cursor::NW_RESIZE: j = "nw-resize"; break;
            case Cursor::S_RESIZE: j = "s-resize"; break;
            case Cursor::SE_RESIZE: j = "se-resize"; break;
            case Cursor::SW_RESIZE: j = "sw-resize"; break;
            case Cursor::W_RESIZE: j = "w-resize"; break;
            case Cursor::EW_RESIZE: j = "ew-resize"; break;
            case Cursor::NS_RESIZE: j = "ns-resize"; break;
            case Cursor::NESW_RESIZE: j = "nesw-resize"; break;
            case Cursor::NWSE_RESIZE: j = "nwse-resize"; break;
            case Cursor::COL_RESIZE: j = "col-resize"; break;
            case Cursor::ROW_RESIZE: j = "row-resize"; break;
            case Cursor::ALL_SCROLL: j = "all-scroll"; break;
            case Cursor::ZOOM_IN: j = "zoom-in"; break;
            case Cursor::ZOOM_OUT: j = "zoom-out"; break;
            case Cursor::GRAB: j = "grab"; break;
            case Cursor::GRABBING: j = "grabbing"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Cursor\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FontStyle & x) {
        if (j == "normal") x = FontStyle::NORMAL;
        else if (j == "italic") x = FontStyle::ITALIC;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FontStyle\""); }
    }

    inline void to_json(json & j, const FontStyle & x) {
        switch (x) {
            case FontStyle::NORMAL: j = "normal"; break;
            case FontStyle::ITALIC: j = "italic"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FontStyle\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FontWeight & x) {
        if (j == "normal") x = FontWeight::NORMAL;
        else if (j == "bold") x = FontWeight::BOLD;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FontWeight\""); }
    }

    inline void to_json(json & j, const FontWeight & x) {
        switch (x) {
            case FontWeight::NORMAL: j = "normal"; break;
            case FontWeight::BOLD: j = "bold"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FontWeight\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Interpolate & x) {
        if (j == "linear") x = Interpolate::LINEAR;
        else if (j == "linear-closed") x = Interpolate::LINEAR_CLOSED;
        else if (j == "step") x = Interpolate::STEP;
        else if (j == "step-before") x = Interpolate::STEP_BEFORE;
        else if (j == "step-after") x = Interpolate::STEP_AFTER;
        else if (j == "basis") x = Interpolate::BASIS;
        else if (j == "basis-open") x = Interpolate::BASIS_OPEN;
        else if (j == "basis-closed") x = Interpolate::BASIS_CLOSED;
        else if (j == "cardinal") x = Interpolate::CARDINAL;
        else if (j == "cardinal-open") x = Interpolate::CARDINAL_OPEN;
        else if (j == "cardinal-closed") x = Interpolate::CARDINAL_CLOSED;
        else if (j == "bundle") x = Interpolate::BUNDLE;
        else if (j == "monotone") x = Interpolate::MONOTONE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Interpolate\""); }
    }

    inline void to_json(json & j, const Interpolate & x) {
        switch (x) {
            case Interpolate::LINEAR: j = "linear"; break;
            case Interpolate::LINEAR_CLOSED: j = "linear-closed"; break;
            case Interpolate::STEP: j = "step"; break;
            case Interpolate::STEP_BEFORE: j = "step-before"; break;
            case Interpolate::STEP_AFTER: j = "step-after"; break;
            case Interpolate::BASIS: j = "basis"; break;
            case Interpolate::BASIS_OPEN: j = "basis-open"; break;
            case Interpolate::BASIS_CLOSED: j = "basis-closed"; break;
            case Interpolate::CARDINAL: j = "cardinal"; break;
            case Interpolate::CARDINAL_OPEN: j = "cardinal-open"; break;
            case Interpolate::CARDINAL_CLOSED: j = "cardinal-closed"; break;
            case Interpolate::BUNDLE: j = "bundle"; break;
            case Interpolate::MONOTONE: j = "monotone"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Interpolate\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Orient & x) {
        if (j == "horizontal") x = Orient::HORIZONTAL;
        else if (j == "vertical") x = Orient::VERTICAL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Orient\""); }
    }

    inline void to_json(json & j, const Orient & x) {
        switch (x) {
            case Orient::HORIZONTAL: j = "horizontal"; break;
            case Orient::VERTICAL: j = "vertical"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Orient\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, LabelOverlapEnum & x) {
        if (j == "parity") x = LabelOverlapEnum::PARITY;
        else if (j == "greedy") x = LabelOverlapEnum::GREEDY;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"LabelOverlapEnum\""); }
    }

    inline void to_json(json & j, const LabelOverlapEnum & x) {
        switch (x) {
            case LabelOverlapEnum::PARITY: j = "parity"; break;
            case LabelOverlapEnum::GREEDY: j = "greedy"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"LabelOverlapEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, FieldTitle & x) {
        if (j == "verbal") x = FieldTitle::VERBAL;
        else if (j == "functional") x = FieldTitle::FUNCTIONAL;
        else if (j == "plain") x = FieldTitle::PLAIN;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"FieldTitle\""); }
    }

    inline void to_json(json & j, const FieldTitle & x) {
        switch (x) {
            case FieldTitle::VERBAL: j = "verbal"; break;
            case FieldTitle::FUNCTIONAL: j = "functional"; break;
            case FieldTitle::PLAIN: j = "plain"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"FieldTitle\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, InvalidValues & x) {
        if (j == "filter") x = InvalidValues::FILTER;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"InvalidValues\""); }
    }

    inline void to_json(json & j, const InvalidValues & x) {
        switch (x) {
            case InvalidValues::FILTER: j = "filter"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"InvalidValues\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, LegendOrient & x) {
        if (j == "left") x = LegendOrient::LEFT;
        else if (j == "right") x = LegendOrient::RIGHT;
        else if (j == "top-left") x = LegendOrient::TOP_LEFT;
        else if (j == "top-right") x = LegendOrient::TOP_RIGHT;
        else if (j == "bottom-left") x = LegendOrient::BOTTOM_LEFT;
        else if (j == "bottom-right") x = LegendOrient::BOTTOM_RIGHT;
        else if (j == "none") x = LegendOrient::NONE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"LegendOrient\""); }
    }

    inline void to_json(json & j, const LegendOrient & x) {
        switch (x) {
            case LegendOrient::LEFT: j = "left"; break;
            case LegendOrient::RIGHT: j = "right"; break;
            case LegendOrient::TOP_LEFT: j = "top-left"; break;
            case LegendOrient::TOP_RIGHT: j = "top-right"; break;
            case LegendOrient::BOTTOM_LEFT: j = "bottom-left"; break;
            case LegendOrient::BOTTOM_RIGHT: j = "bottom-right"; break;
            case LegendOrient::NONE: j = "none"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"LegendOrient\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, VgProjectionType & x) {
        if (j == "albers") x = VgProjectionType::ALBERS;
        else if (j == "albersUsa") x = VgProjectionType::ALBERS_USA;
        else if (j == "azimuthalEqualArea") x = VgProjectionType::AZIMUTHAL_EQUAL_AREA;
        else if (j == "azimuthalEquidistant") x = VgProjectionType::AZIMUTHAL_EQUIDISTANT;
        else if (j == "conicConformal") x = VgProjectionType::CONIC_CONFORMAL;
        else if (j == "conicEqualArea") x = VgProjectionType::CONIC_EQUAL_AREA;
        else if (j == "conicEquidistant") x = VgProjectionType::CONIC_EQUIDISTANT;
        else if (j == "equirectangular") x = VgProjectionType::EQUIRECTANGULAR;
        else if (j == "gnomonic") x = VgProjectionType::GNOMONIC;
        else if (j == "mercator") x = VgProjectionType::MERCATOR;
        else if (j == "orthographic") x = VgProjectionType::ORTHOGRAPHIC;
        else if (j == "stereographic") x = VgProjectionType::STEREOGRAPHIC;
        else if (j == "transverseMercator") x = VgProjectionType::TRANSVERSE_MERCATOR;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"VgProjectionType\""); }
    }

    inline void to_json(json & j, const VgProjectionType & x) {
        switch (x) {
            case VgProjectionType::ALBERS: j = "albers"; break;
            case VgProjectionType::ALBERS_USA: j = "albersUsa"; break;
            case VgProjectionType::AZIMUTHAL_EQUAL_AREA: j = "azimuthalEqualArea"; break;
            case VgProjectionType::AZIMUTHAL_EQUIDISTANT: j = "azimuthalEquidistant"; break;
            case VgProjectionType::CONIC_CONFORMAL: j = "conicConformal"; break;
            case VgProjectionType::CONIC_EQUAL_AREA: j = "conicEqualArea"; break;
            case VgProjectionType::CONIC_EQUIDISTANT: j = "conicEquidistant"; break;
            case VgProjectionType::EQUIRECTANGULAR: j = "equirectangular"; break;
            case VgProjectionType::GNOMONIC: j = "gnomonic"; break;
            case VgProjectionType::MERCATOR: j = "mercator"; break;
            case VgProjectionType::ORTHOGRAPHIC: j = "orthographic"; break;
            case VgProjectionType::STEREOGRAPHIC: j = "stereographic"; break;
            case VgProjectionType::TRANSVERSE_MERCATOR: j = "transverseMercator"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"VgProjectionType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, BindEnum & x) {
        if (j == "scales") x = BindEnum::SCALES;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"BindEnum\""); }
    }

    inline void to_json(json & j, const BindEnum & x) {
        switch (x) {
            case BindEnum::SCALES: j = "scales"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"BindEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Empty & x) {
        if (j == "all") x = Empty::ALL;
        else if (j == "none") x = Empty::NONE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Empty\""); }
    }

    inline void to_json(json & j, const Empty & x) {
        switch (x) {
            case Empty::ALL: j = "all"; break;
            case Empty::NONE: j = "none"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Empty\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SingleDefChannel & x) {
        if (j == "x") x = SingleDefChannel::X;
        else if (j == "y") x = SingleDefChannel::Y;
        else if (j == "x2") x = SingleDefChannel::X2;
        else if (j == "y2") x = SingleDefChannel::Y2;
        else if (j == "row") x = SingleDefChannel::ROW;
        else if (j == "column") x = SingleDefChannel::COLUMN;
        else if (j == "size") x = SingleDefChannel::SIZE;
        else if (j == "shape") x = SingleDefChannel::SHAPE;
        else if (j == "color") x = SingleDefChannel::COLOR;
        else if (j == "opacity") x = SingleDefChannel::OPACITY;
        else if (j == "text") x = SingleDefChannel::TEXT;
        else if (j == "tooltip") x = SingleDefChannel::TOOLTIP;
        else if (j == "href") x = SingleDefChannel::HREF;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SingleDefChannel\""); }
    }

    inline void to_json(json & j, const SingleDefChannel & x) {
        switch (x) {
            case SingleDefChannel::X: j = "x"; break;
            case SingleDefChannel::Y: j = "y"; break;
            case SingleDefChannel::X2: j = "x2"; break;
            case SingleDefChannel::Y2: j = "y2"; break;
            case SingleDefChannel::ROW: j = "row"; break;
            case SingleDefChannel::COLUMN: j = "column"; break;
            case SingleDefChannel::SIZE: j = "size"; break;
            case SingleDefChannel::SHAPE: j = "shape"; break;
            case SingleDefChannel::COLOR: j = "color"; break;
            case SingleDefChannel::OPACITY: j = "opacity"; break;
            case SingleDefChannel::TEXT: j = "text"; break;
            case SingleDefChannel::TOOLTIP: j = "tooltip"; break;
            case SingleDefChannel::HREF: j = "href"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SingleDefChannel\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SelectionResolution & x) {
        if (j == "global") x = SelectionResolution::GLOBAL;
        else if (j == "union") x = SelectionResolution::UNION;
        else if (j == "intersect") x = SelectionResolution::INTERSECT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SelectionResolution\""); }
    }

    inline void to_json(json & j, const SelectionResolution & x) {
        switch (x) {
            case SelectionResolution::GLOBAL: j = "global"; break;
            case SelectionResolution::UNION: j = "union"; break;
            case SelectionResolution::INTERSECT: j = "intersect"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SelectionResolution\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, StackOffset & x) {
        if (j == "zero") x = StackOffset::ZERO;
        else if (j == "center") x = StackOffset::CENTER;
        else if (j == "normalize") x = StackOffset::NORMALIZE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"StackOffset\""); }
    }

    inline void to_json(json & j, const StackOffset & x) {
        switch (x) {
            case StackOffset::ZERO: j = "zero"; break;
            case StackOffset::CENTER: j = "center"; break;
            case StackOffset::NORMALIZE: j = "normalize"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"StackOffset\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Anchor & x) {
        if (j == "start") x = Anchor::START;
        else if (j == "middle") x = Anchor::MIDDLE;
        else if (j == "end") x = Anchor::END;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Anchor\""); }
    }

    inline void to_json(json & j, const Anchor & x) {
        switch (x) {
            case Anchor::START: j = "start"; break;
            case Anchor::MIDDLE: j = "middle"; break;
            case Anchor::END: j = "end"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Anchor\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, TitleOrient & x) {
        if (j == "top") x = TitleOrient::TOP;
        else if (j == "bottom") x = TitleOrient::BOTTOM;
        else if (j == "left") x = TitleOrient::LEFT;
        else if (j == "right") x = TitleOrient::RIGHT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"TitleOrient\""); }
    }

    inline void to_json(json & j, const TitleOrient & x) {
        switch (x) {
            case TitleOrient::TOP: j = "top"; break;
            case TitleOrient::BOTTOM: j = "bottom"; break;
            case TitleOrient::LEFT: j = "left"; break;
            case TitleOrient::RIGHT: j = "right"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"TitleOrient\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ParseEnum & x) {
        if (j == "auto") x = ParseEnum::AUTO;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ParseEnum\""); }
    }

    inline void to_json(json & j, const ParseEnum & x) {
        switch (x) {
            case ParseEnum::AUTO: j = "auto"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ParseEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, DataFormatType & x) {
        if (j == "csv") x = DataFormatType::CSV;
        else if (j == "tsv") x = DataFormatType::TSV;
        else if (j == "json") x = DataFormatType::JSON;
        else if (j == "topojson") x = DataFormatType::TOPOJSON;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"DataFormatType\""); }
    }

    inline void to_json(json & j, const DataFormatType & x) {
        switch (x) {
            case DataFormatType::CSV: j = "csv"; break;
            case DataFormatType::TSV: j = "tsv"; break;
            case DataFormatType::JSON: j = "json"; break;
            case DataFormatType::TOPOJSON: j = "topojson"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"DataFormatType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, AggregateOp & x) {
        static std::unordered_map<std::string, AggregateOp> enumValues {
            {"argmax", AggregateOp::ARGMAX},
            {"argmin", AggregateOp::ARGMIN},
            {"average", AggregateOp::AVERAGE},
            {"count", AggregateOp::COUNT},
            {"distinct", AggregateOp::DISTINCT},
            {"max", AggregateOp::MAX},
            {"mean", AggregateOp::MEAN},
            {"median", AggregateOp::MEDIAN},
            {"min", AggregateOp::MIN},
            {"missing", AggregateOp::MISSING},
            {"q1", AggregateOp::Q1},
            {"q3", AggregateOp::Q3},
            {"ci0", AggregateOp::CI0},
            {"ci1", AggregateOp::CI1},
            {"stdev", AggregateOp::STDEV},
            {"stdevp", AggregateOp::STDEVP},
            {"sum", AggregateOp::SUM},
            {"valid", AggregateOp::VALID},
            {"values", AggregateOp::VALUES},
            {"variance", AggregateOp::VARIANCE},
            {"variancep", AggregateOp::VARIANCEP},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"AggregateOp\""); }
    }

    inline void to_json(json & j, const AggregateOp & x) {
        switch (x) {
            case AggregateOp::ARGMAX: j = "argmax"; break;
            case AggregateOp::ARGMIN: j = "argmin"; break;
            case AggregateOp::AVERAGE: j = "average"; break;
            case AggregateOp::COUNT: j = "count"; break;
            case AggregateOp::DISTINCT: j = "distinct"; break;
            case AggregateOp::MAX: j = "max"; break;
            case AggregateOp::MEAN: j = "mean"; break;
            case AggregateOp::MEDIAN: j = "median"; break;
            case AggregateOp::MIN: j = "min"; break;
            case AggregateOp::MISSING: j = "missing"; break;
            case AggregateOp::Q1: j = "q1"; break;
            case AggregateOp::Q3: j = "q3"; break;
            case AggregateOp::CI0: j = "ci0"; break;
            case AggregateOp::CI1: j = "ci1"; break;
            case AggregateOp::STDEV: j = "stdev"; break;
            case AggregateOp::STDEVP: j = "stdevp"; break;
            case AggregateOp::SUM: j = "sum"; break;
            case AggregateOp::VALID: j = "valid"; break;
            case AggregateOp::VALUES: j = "values"; break;
            case AggregateOp::VARIANCE: j = "variance"; break;
            case AggregateOp::VARIANCEP: j = "variancep"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"AggregateOp\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, TimeUnit & x) {
        static std::unordered_map<std::string, TimeUnit> enumValues {
            {"year", TimeUnit::YEAR},
            {"quarter", TimeUnit::QUARTER},
            {"month", TimeUnit::MONTH},
            {"day", TimeUnit::DAY},
            {"date", TimeUnit::DATE},
            {"hours", TimeUnit::HOURS},
            {"minutes", TimeUnit::MINUTES},
            {"seconds", TimeUnit::SECONDS},
            {"milliseconds", TimeUnit::MILLISECONDS},
            {"utcyear", TimeUnit::UTCYEAR},
            {"utcquarter", TimeUnit::UTCQUARTER},
            {"utcmonth", TimeUnit::UTCMONTH},
            {"utcday", TimeUnit::UTCDAY},
            {"utcdate", TimeUnit::UTCDATE},
            {"utchours", TimeUnit::UTCHOURS},
            {"utcminutes", TimeUnit::UTCMINUTES},
            {"utcseconds", TimeUnit::UTCSECONDS},
            {"utcmilliseconds", TimeUnit::UTCMILLISECONDS},
            {"yearquarter", TimeUnit::YEARQUARTER},
            {"yearquartermonth", TimeUnit::YEARQUARTERMONTH},
            {"yearmonth", TimeUnit::YEARMONTH},
            {"yearmonthdate", TimeUnit::YEARMONTHDATE},
            {"yearmonthdatehours", TimeUnit::YEARMONTHDATEHOURS},
            {"yearmonthdatehoursminutes", TimeUnit::YEARMONTHDATEHOURSMINUTES},
            {"yearmonthdatehoursminutesseconds", TimeUnit::YEARMONTHDATEHOURSMINUTESSECONDS},
            {"quartermonth", TimeUnit::QUARTERMONTH},
            {"monthdate", TimeUnit::MONTHDATE},
            {"hoursminutes", TimeUnit::HOURSMINUTES},
            {"hoursminutesseconds", TimeUnit::HOURSMINUTESSECONDS},
            {"minutesseconds", TimeUnit::MINUTESSECONDS},
            {"secondsmilliseconds", TimeUnit::SECONDSMILLISECONDS},
            {"utcyearquarter", TimeUnit::UTCYEARQUARTER},
            {"utcyearquartermonth", TimeUnit::UTCYEARQUARTERMONTH},
            {"utcyearmonth", TimeUnit::UTCYEARMONTH},
            {"utcyearmonthdate", TimeUnit::UTCYEARMONTHDATE},
            {"utcyearmonthdatehours", TimeUnit::UTCYEARMONTHDATEHOURS},
            {"utcyearmonthdatehoursminutes", TimeUnit::UTCYEARMONTHDATEHOURSMINUTES},
            {"utcyearmonthdatehoursminutesseconds", TimeUnit::UTCYEARMONTHDATEHOURSMINUTESSECONDS},
            {"utcquartermonth", TimeUnit::UTCQUARTERMONTH},
            {"utcmonthdate", TimeUnit::UTCMONTHDATE},
            {"utchoursminutes", TimeUnit::UTCHOURSMINUTES},
            {"utchoursminutesseconds", TimeUnit::UTCHOURSMINUTESSECONDS},
            {"utcminutesseconds", TimeUnit::UTCMINUTESSECONDS},
            {"utcsecondsmilliseconds", TimeUnit::UTCSECONDSMILLISECONDS},
        };
        auto iter = enumValues.find(j.get<std::string>());
        if (iter != enumValues.end()) {
            x = iter->second;
        }
        else { throw std::runtime_error("Cannot deserialize to enumeration \"TimeUnit\""); }
    }

    inline void to_json(json & j, const TimeUnit & x) {
        switch (x) {
            case TimeUnit::YEAR: j = "year"; break;
            case TimeUnit::QUARTER: j = "quarter"; break;
            case TimeUnit::MONTH: j = "month"; break;
            case TimeUnit::DAY: j = "day"; break;
            case TimeUnit::DATE: j = "date"; break;
            case TimeUnit::HOURS: j = "hours"; break;
            case TimeUnit::MINUTES: j = "minutes"; break;
            case TimeUnit::SECONDS: j = "seconds"; break;
            case TimeUnit::MILLISECONDS: j = "milliseconds"; break;
            case TimeUnit::UTCYEAR: j = "utcyear"; break;
            case TimeUnit::UTCQUARTER: j = "utcquarter"; break;
            case TimeUnit::UTCMONTH: j = "utcmonth"; break;
            case TimeUnit::UTCDAY: j = "utcday"; break;
            case TimeUnit::UTCDATE: j = "utcdate"; break;
            case TimeUnit::UTCHOURS: j = "utchours"; break;
            case TimeUnit::UTCMINUTES: j = "utcminutes"; break;
            case TimeUnit::UTCSECONDS: j = "utcseconds"; break;
            case TimeUnit::UTCMILLISECONDS: j = "utcmilliseconds"; break;
            case TimeUnit::YEARQUARTER: j = "yearquarter"; break;
            case TimeUnit::YEARQUARTERMONTH: j = "yearquartermonth"; break;
            case TimeUnit::YEARMONTH: j = "yearmonth"; break;
            case TimeUnit::YEARMONTHDATE: j = "yearmonthdate"; break;
            case TimeUnit::YEARMONTHDATEHOURS: j = "yearmonthdatehours"; break;
            case TimeUnit::YEARMONTHDATEHOURSMINUTES: j = "yearmonthdatehoursminutes"; break;
            case TimeUnit::YEARMONTHDATEHOURSMINUTESSECONDS: j = "yearmonthdatehoursminutesseconds"; break;
            case TimeUnit::QUARTERMONTH: j = "quartermonth"; break;
            case TimeUnit::MONTHDATE: j = "monthdate"; break;
            case TimeUnit::HOURSMINUTES: j = "hoursminutes"; break;
            case TimeUnit::HOURSMINUTESSECONDS: j = "hoursminutesseconds"; break;
            case TimeUnit::MINUTESSECONDS: j = "minutesseconds"; break;
            case TimeUnit::SECONDSMILLISECONDS: j = "secondsmilliseconds"; break;
            case TimeUnit::UTCYEARQUARTER: j = "utcyearquarter"; break;
            case TimeUnit::UTCYEARQUARTERMONTH: j = "utcyearquartermonth"; break;
            case TimeUnit::UTCYEARMONTH: j = "utcyearmonth"; break;
            case TimeUnit::UTCYEARMONTHDATE: j = "utcyearmonthdate"; break;
            case TimeUnit::UTCYEARMONTHDATEHOURS: j = "utcyearmonthdatehours"; break;
            case TimeUnit::UTCYEARMONTHDATEHOURSMINUTES: j = "utcyearmonthdatehoursminutes"; break;
            case TimeUnit::UTCYEARMONTHDATEHOURSMINUTESSECONDS: j = "utcyearmonthdatehoursminutesseconds"; break;
            case TimeUnit::UTCQUARTERMONTH: j = "utcquartermonth"; break;
            case TimeUnit::UTCMONTHDATE: j = "utcmonthdate"; break;
            case TimeUnit::UTCHOURSMINUTES: j = "utchoursminutes"; break;
            case TimeUnit::UTCHOURSMINUTESSECONDS: j = "utchoursminutesseconds"; break;
            case TimeUnit::UTCMINUTESSECONDS: j = "utcminutesseconds"; break;
            case TimeUnit::UTCSECONDSMILLISECONDS: j = "utcsecondsmilliseconds"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"TimeUnit\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, RepeatEnum & x) {
        if (j == "row") x = RepeatEnum::ROW;
        else if (j == "column") x = RepeatEnum::COLUMN;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"RepeatEnum\""); }
    }

    inline void to_json(json & j, const RepeatEnum & x) {
        switch (x) {
            case RepeatEnum::ROW: j = "row"; break;
            case RepeatEnum::COLUMN: j = "column"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"RepeatEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, LegendType & x) {
        if (j == "symbol") x = LegendType::SYMBOL;
        else if (j == "gradient") x = LegendType::GRADIENT;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"LegendType\""); }
    }

    inline void to_json(json & j, const LegendType & x) {
        switch (x) {
            case LegendType::SYMBOL: j = "symbol"; break;
            case LegendType::GRADIENT: j = "gradient"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"LegendType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Domain & x) {
        if (j == "unaggregated") x = Domain::UNAGGREGATED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Domain\""); }
    }

    inline void to_json(json & j, const Domain & x) {
        switch (x) {
            case Domain::UNAGGREGATED: j = "unaggregated"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Domain\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, InterpolateParamsType & x) {
        if (j == "rgb") x = InterpolateParamsType::RGB;
        else if (j == "cubehelix") x = InterpolateParamsType::CUBEHELIX;
        else if (j == "cubehelix-long") x = InterpolateParamsType::CUBEHELIX_LONG;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"InterpolateParamsType\""); }
    }

    inline void to_json(json & j, const InterpolateParamsType & x) {
        switch (x) {
            case InterpolateParamsType::RGB: j = "rgb"; break;
            case InterpolateParamsType::CUBEHELIX: j = "cubehelix"; break;
            case InterpolateParamsType::CUBEHELIX_LONG: j = "cubehelix-long"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"InterpolateParamsType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, NiceTime & x) {
        if (j == "second") x = NiceTime::SECOND;
        else if (j == "minute") x = NiceTime::MINUTE;
        else if (j == "hour") x = NiceTime::HOUR;
        else if (j == "day") x = NiceTime::DAY;
        else if (j == "week") x = NiceTime::WEEK;
        else if (j == "month") x = NiceTime::MONTH;
        else if (j == "year") x = NiceTime::YEAR;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"NiceTime\""); }
    }

    inline void to_json(json & j, const NiceTime & x) {
        switch (x) {
            case NiceTime::SECOND: j = "second"; break;
            case NiceTime::MINUTE: j = "minute"; break;
            case NiceTime::HOUR: j = "hour"; break;
            case NiceTime::DAY: j = "day"; break;
            case NiceTime::WEEK: j = "week"; break;
            case NiceTime::MONTH: j = "month"; break;
            case NiceTime::YEAR: j = "year"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"NiceTime\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ScaleType & x) {
        if (j == "linear") x = ScaleType::LINEAR;
        else if (j == "bin-linear") x = ScaleType::BIN_LINEAR;
        else if (j == "log") x = ScaleType::LOG;
        else if (j == "pow") x = ScaleType::POW;
        else if (j == "sqrt") x = ScaleType::SQRT;
        else if (j == "time") x = ScaleType::TIME;
        else if (j == "utc") x = ScaleType::UTC;
        else if (j == "sequential") x = ScaleType::SEQUENTIAL;
        else if (j == "ordinal") x = ScaleType::ORDINAL;
        else if (j == "bin-ordinal") x = ScaleType::BIN_ORDINAL;
        else if (j == "point") x = ScaleType::POINT;
        else if (j == "band") x = ScaleType::BAND;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ScaleType\""); }
    }

    inline void to_json(json & j, const ScaleType & x) {
        switch (x) {
            case ScaleType::LINEAR: j = "linear"; break;
            case ScaleType::BIN_LINEAR: j = "bin-linear"; break;
            case ScaleType::LOG: j = "log"; break;
            case ScaleType::POW: j = "pow"; break;
            case ScaleType::SQRT: j = "sqrt"; break;
            case ScaleType::TIME: j = "time"; break;
            case ScaleType::UTC: j = "utc"; break;
            case ScaleType::SEQUENTIAL: j = "sequential"; break;
            case ScaleType::ORDINAL: j = "ordinal"; break;
            case ScaleType::BIN_ORDINAL: j = "bin-ordinal"; break;
            case ScaleType::POINT: j = "point"; break;
            case ScaleType::BAND: j = "band"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ScaleType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SortEnum & x) {
        if (j == "ascending") x = SortEnum::ASCENDING;
        else if (j == "descending") x = SortEnum::DESCENDING;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SortEnum\""); }
    }

    inline void to_json(json & j, const SortEnum & x) {
        switch (x) {
            case SortEnum::ASCENDING: j = "ascending"; break;
            case SortEnum::DESCENDING: j = "descending"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SortEnum\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Type & x) {
        if (j == "quantitative") x = Type::QUANTITATIVE;
        else if (j == "ordinal") x = Type::ORDINAL;
        else if (j == "temporal") x = Type::TEMPORAL;
        else if (j == "nominal") x = Type::NOMINAL;
        else if (j == "latitude") x = Type::LATITUDE;
        else if (j == "longitude") x = Type::LONGITUDE;
        else if (j == "geojson") x = Type::GEOJSON;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Type\""); }
    }

    inline void to_json(json & j, const Type & x) {
        switch (x) {
            case Type::QUANTITATIVE: j = "quantitative"; break;
            case Type::ORDINAL: j = "ordinal"; break;
            case Type::TEMPORAL: j = "temporal"; break;
            case Type::NOMINAL: j = "nominal"; break;
            case Type::LATITUDE: j = "latitude"; break;
            case Type::LONGITUDE: j = "longitude"; break;
            case Type::GEOJSON: j = "geojson"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Type\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, Mark & x) {
        if (j == "area") x = Mark::AREA;
        else if (j == "bar") x = Mark::BAR;
        else if (j == "line") x = Mark::LINE;
        else if (j == "point") x = Mark::POINT;
        else if (j == "text") x = Mark::TEXT;
        else if (j == "tick") x = Mark::TICK;
        else if (j == "rect") x = Mark::RECT;
        else if (j == "rule") x = Mark::RULE;
        else if (j == "circle") x = Mark::CIRCLE;
        else if (j == "square") x = Mark::SQUARE;
        else if (j == "geoshape") x = Mark::GEOSHAPE;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"Mark\""); }
    }

    inline void to_json(json & j, const Mark & x) {
        switch (x) {
            case Mark::AREA: j = "area"; break;
            case Mark::BAR: j = "bar"; break;
            case Mark::LINE: j = "line"; break;
            case Mark::POINT: j = "point"; break;
            case Mark::TEXT: j = "text"; break;
            case Mark::TICK: j = "tick"; break;
            case Mark::RECT: j = "rect"; break;
            case Mark::RULE: j = "rule"; break;
            case Mark::CIRCLE: j = "circle"; break;
            case Mark::SQUARE: j = "square"; break;
            case Mark::GEOSHAPE: j = "geoshape"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"Mark\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, ResolveMode & x) {
        if (j == "independent") x = ResolveMode::INDEPENDENT;
        else if (j == "shared") x = ResolveMode::SHARED;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"ResolveMode\""); }
    }

    inline void to_json(json & j, const ResolveMode & x) {
        switch (x) {
            case ResolveMode::INDEPENDENT: j = "independent"; break;
            case ResolveMode::SHARED: j = "shared"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"ResolveMode\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SelectionDefType & x) {
        if (j == "single") x = SelectionDefType::SINGLE;
        else if (j == "multi") x = SelectionDefType::MULTI;
        else if (j == "interval") x = SelectionDefType::INTERVAL;
        else { throw std::runtime_error("Cannot deserialize to enumeration \"SelectionDefType\""); }
    }

    inline void to_json(json & j, const SelectionDefType & x) {
        switch (x) {
            case SelectionDefType::SINGLE: j = "single"; break;
            case SelectionDefType::MULTI: j = "multi"; break;
            case SelectionDefType::INTERVAL: j = "interval"; break;
            default: throw std::runtime_error("Unexpected value in enumeration \"SelectionDefType\": " + std::to_string(static_cast<int>(x)));
        }
    }

    inline void from_json(const json & j, SelectionOperand & x) {
        x = j.get<SelectionOperand::base>();
    }

    inline void to_json(json & j, const SelectionOperand & x) {
        j = static_cast<const SelectionOperand::base &>(x);
    }

    inline void from_json(const json & j, LogicalOperandPredicate & x) {
        x = j.get<LogicalOperandPredicate::base>();
    }

    inline void to_json(json & j, const LogicalOperandPredicate & x) {
        j = static_cast<const LogicalOperandPredicate::base &>(x);
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::AutoSizeParams, quicktype::AutosizeType>>::from_json(const json & j, std::variant<quicktype::AutoSizeParams, quicktype::AutosizeType> & x) {
        if (j.is_object())
            x = j.get<quicktype::AutoSizeParams>();
        else if (j.is_string())
            x = j.get<quicktype::AutosizeType>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::AutoSizeParams, quicktype::AutosizeType>>::to_json(json & j, const std::variant<quicktype::AutoSizeParams, quicktype::AutosizeType> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::AutoSizeParams>(x);
                break;
            case 1:
                j = std::get<quicktype::AutosizeType>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<double, quicktype::FontWeight>>::from_json(const json & j, std::variant<double, quicktype::FontWeight> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<quicktype::FontWeight>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<double, quicktype::FontWeight>>::to_json(json & j, const std::variant<double, quicktype::FontWeight> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<double>(x);
                break;
            case 1:
                j = std::get<quicktype::FontWeight>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, double>>::from_json(const json & j, std::variant<bool, double> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double>>::to_json(json & j, const std::variant<bool, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::LabelOverlapEnum>>::from_json(const json & j, std::variant<bool, quicktype::LabelOverlapEnum> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<quicktype::LabelOverlapEnum>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::LabelOverlapEnum>>::to_json(json & j, const std::variant<bool, quicktype::LabelOverlapEnum> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::LabelOverlapEnum>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

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

    inline void adl_serializer<std::variant<quicktype::PaddingClass, double>>::from_json(const json & j, std::variant<quicktype::PaddingClass, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::PaddingClass>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::PaddingClass, double>>::to_json(json & j, const std::variant<quicktype::PaddingClass, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::PaddingClass>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::TitleFontWeight>, quicktype::VgScheme>>::from_json(const json & j, std::variant<std::vector<quicktype::TitleFontWeight>, quicktype::VgScheme> & x) {
        if (j.is_object())
            x = j.get<quicktype::VgScheme>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::TitleFontWeight>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::TitleFontWeight>, quicktype::VgScheme>>::to_json(json & j, const std::variant<std::vector<quicktype::TitleFontWeight>, quicktype::VgScheme> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::TitleFontWeight>>(x);
                break;
            case 1:
                j = std::get<quicktype::VgScheme>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, std::string>>::from_json(const json & j, std::variant<bool, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, std::string>>::to_json(json & j, const std::variant<bool, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::ParseEnum, std::map<std::string, json>>>::from_json(const json & j, std::variant<quicktype::ParseEnum, std::map<std::string, json>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, json>>();
        else if (j.is_string())
            x = j.get<quicktype::ParseEnum>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::ParseEnum, std::map<std::string, json>>>::to_json(json & j, const std::variant<quicktype::ParseEnum, std::map<std::string, json>> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::ParseEnum>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, json>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, double, std::map<std::string, json>, std::string>>::from_json(const json & j, std::variant<bool, double, std::map<std::string, json>, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, json>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double, std::map<std::string, json>, std::string>>::to_json(json & j, const std::variant<bool, double, std::map<std::string, json>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            case 2:
                j = std::get<std::map<std::string, json>>(x);
                break;
            case 3:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::ValuesValue>, std::map<std::string, json>, std::string>>::from_json(const json & j, std::variant<std::vector<quicktype::ValuesValue>, std::map<std::string, json>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::map<std::string, json>>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::ValuesValue>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::ValuesValue>, std::map<std::string, json>, std::string>>::to_json(json & j, const std::variant<std::vector<quicktype::ValuesValue>, std::map<std::string, json>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::ValuesValue>>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, json>>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::BinParams>>::from_json(const json & j, std::variant<bool, quicktype::BinParams> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_object())
            x = j.get<quicktype::BinParams>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::BinParams>>::to_json(json & j, const std::variant<bool, quicktype::BinParams> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::BinParams>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::shared_ptr<quicktype::Selection>, std::string>>::from_json(const json & j, std::variant<std::shared_ptr<quicktype::Selection>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::shared_ptr<quicktype::Selection>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::shared_ptr<quicktype::Selection>, std::string>>::to_json(json & j, const std::variant<std::shared_ptr<quicktype::Selection>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::shared_ptr<quicktype::Selection>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::DateTime, double, std::string>>::from_json(const json & j, std::variant<bool, quicktype::DateTime, double, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::DateTime>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::DateTime, double, std::string>>::to_json(json & j, const std::variant<bool, quicktype::DateTime, double, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::DateTime>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            case 3:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DateTime, double>>::from_json(const json & j, std::variant<quicktype::DateTime, double> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::DateTime>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DateTime, double>>::to_json(json & j, const std::variant<quicktype::DateTime, double> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DateTime>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::shared_ptr<quicktype::Predicate>, std::string>>::from_json(const json & j, std::variant<std::shared_ptr<quicktype::Predicate>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<std::shared_ptr<quicktype::Predicate>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::shared_ptr<quicktype::Predicate>, std::string>>::to_json(json & j, const std::variant<std::shared_ptr<quicktype::Predicate>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::shared_ptr<quicktype::Predicate>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, double, std::string>>::from_json(const json & j, std::variant<bool, double, std::string> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, double, std::string>>::to_json(json & j, const std::variant<bool, double, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::RepeatRef, std::string>>::from_json(const json & j, std::variant<quicktype::RepeatRef, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::RepeatRef>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::RepeatRef, std::string>>::to_json(json & j, const std::variant<quicktype::RepeatRef, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::RepeatRef>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::DateTime, double, std::string>>::from_json(const json & j, std::variant<quicktype::DateTime, double, std::string> & x) {
        if (j.is_number())
            x = j.get<double>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::DateTime>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::DateTime, double, std::string>>::to_json(json & j, const std::variant<quicktype::DateTime, double, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::DateTime>(x);
                break;
            case 1:
                j = std::get<double>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::Equal>, quicktype::DomainClass, quicktype::Domain>>::from_json(const json & j, std::variant<std::vector<quicktype::Equal>, quicktype::DomainClass, quicktype::Domain> & x) {
        if (j.is_object())
            x = j.get<quicktype::DomainClass>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::Equal>>();
        else if (j.is_string())
            x = j.get<quicktype::Domain>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::Equal>, quicktype::DomainClass, quicktype::Domain>>::to_json(json & j, const std::variant<std::vector<quicktype::Equal>, quicktype::DomainClass, quicktype::Domain> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::Equal>>(x);
                break;
            case 1:
                j = std::get<quicktype::DomainClass>(x);
                break;
            case 2:
                j = std::get<quicktype::Domain>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::InterpolateParams, quicktype::Interpolate>>::from_json(const json & j, std::variant<quicktype::InterpolateParams, quicktype::Interpolate> & x) {
        if (j.is_object())
            x = j.get<quicktype::InterpolateParams>();
        else if (j.is_string())
            x = j.get<quicktype::Interpolate>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::InterpolateParams, quicktype::Interpolate>>::to_json(json & j, const std::variant<quicktype::InterpolateParams, quicktype::Interpolate> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::InterpolateParams>(x);
                break;
            case 1:
                j = std::get<quicktype::Interpolate>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<bool, quicktype::NiceClass, double, quicktype::NiceTime>>::from_json(const json & j, std::variant<bool, quicktype::NiceClass, double, quicktype::NiceTime> & x) {
        if (j.is_boolean())
            x = j.get<bool>();
        else if (j.is_number())
            x = j.get<double>();
        else if (j.is_object())
            x = j.get<quicktype::NiceClass>();
        else if (j.is_string())
            x = j.get<quicktype::NiceTime>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<bool, quicktype::NiceClass, double, quicktype::NiceTime>>::to_json(json & j, const std::variant<bool, quicktype::NiceClass, double, quicktype::NiceTime> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<bool>(x);
                break;
            case 1:
                j = std::get<quicktype::NiceClass>(x);
                break;
            case 2:
                j = std::get<double>(x);
                break;
            case 3:
                j = std::get<quicktype::NiceTime>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::TitleFontWeight>, std::string>>::from_json(const json & j, std::variant<std::vector<quicktype::TitleFontWeight>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::TitleFontWeight>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::TitleFontWeight>, std::string>>::to_json(json & j, const std::variant<std::vector<quicktype::TitleFontWeight>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::TitleFontWeight>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SchemeParams, std::string>>::from_json(const json & j, std::variant<quicktype::SchemeParams, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::SchemeParams>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SchemeParams, std::string>>::to_json(json & j, const std::variant<quicktype::SchemeParams, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SchemeParams>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::SortField, quicktype::SortEnum>>::from_json(const json & j, std::variant<quicktype::SortField, quicktype::SortEnum> & x) {
        if (j.is_object())
            x = j.get<quicktype::SortField>();
        else if (j.is_string())
            x = j.get<quicktype::SortEnum>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::SortField, quicktype::SortEnum>>::to_json(json & j, const std::variant<quicktype::SortField, quicktype::SortEnum> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::SortField>(x);
                break;
            case 1:
                j = std::get<quicktype::SortEnum>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateMarkPropFieldDefClass>>::from_json(const json & j, std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateMarkPropFieldDefClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::ConditionalPredicateMarkPropFieldDefClass>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::ConditionalValueDef>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateMarkPropFieldDefClass>>::to_json(json & j, const std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateMarkPropFieldDefClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::ConditionalValueDef>>(x);
                break;
            case 1:
                j = std::get<quicktype::ConditionalPredicateMarkPropFieldDefClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::FieldDef>, quicktype::FieldDef>>::from_json(const json & j, std::variant<std::vector<quicktype::FieldDef>, quicktype::FieldDef> & x) {
        if (j.is_object())
            x = j.get<quicktype::FieldDef>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::FieldDef>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::FieldDef>, quicktype::FieldDef>>::to_json(json & j, const std::variant<std::vector<quicktype::FieldDef>, quicktype::FieldDef> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::FieldDef>>(x);
                break;
            case 1:
                j = std::get<quicktype::FieldDef>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateFieldDefClass>>::from_json(const json & j, std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateFieldDefClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::ConditionalPredicateFieldDefClass>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::ConditionalValueDef>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateFieldDefClass>>::to_json(json & j, const std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateFieldDefClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::ConditionalValueDef>>(x);
                break;
            case 1:
                j = std::get<quicktype::ConditionalPredicateFieldDefClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::OrderFieldDef>, quicktype::OrderFieldDef>>::from_json(const json & j, std::variant<std::vector<quicktype::OrderFieldDef>, quicktype::OrderFieldDef> & x) {
        if (j.is_object())
            x = j.get<quicktype::OrderFieldDef>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::OrderFieldDef>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::OrderFieldDef>, quicktype::OrderFieldDef>>::to_json(json & j, const std::variant<std::vector<quicktype::OrderFieldDef>, quicktype::OrderFieldDef> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::OrderFieldDef>>(x);
                break;
            case 1:
                j = std::get<quicktype::OrderFieldDef>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateTextFieldDefClass>>::from_json(const json & j, std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateTextFieldDefClass> & x) {
        if (j.is_object())
            x = j.get<quicktype::ConditionalPredicateTextFieldDefClass>();
        else if (j.is_array())
            x = j.get<std::vector<quicktype::ConditionalValueDef>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateTextFieldDefClass>>::to_json(json & j, const std::variant<std::vector<quicktype::ConditionalValueDef>, quicktype::ConditionalPredicateTextFieldDefClass> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<quicktype::ConditionalValueDef>>(x);
                break;
            case 1:
                j = std::get<quicktype::ConditionalPredicateTextFieldDefClass>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<std::vector<std::string>, std::string>>::from_json(const json & j, std::variant<std::vector<std::string>, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_array())
            x = j.get<std::vector<std::string>>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<std::vector<std::string>, std::string>>::to_json(json & j, const std::variant<std::vector<std::string>, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<std::vector<std::string>>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::MarkDef, quicktype::Mark>>::from_json(const json & j, std::variant<quicktype::MarkDef, quicktype::Mark> & x) {
        if (j.is_object())
            x = j.get<quicktype::MarkDef>();
        else if (j.is_string())
            x = j.get<quicktype::Mark>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::MarkDef, quicktype::Mark>>::to_json(json & j, const std::variant<quicktype::MarkDef, quicktype::Mark> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::MarkDef>(x);
                break;
            case 1:
                j = std::get<quicktype::Mark>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::BindEnum, std::map<std::string, quicktype::VgBinding>>>::from_json(const json & j, std::variant<quicktype::BindEnum, std::map<std::string, quicktype::VgBinding>> & x) {
        if (j.is_object())
            x = j.get<std::map<std::string, quicktype::VgBinding>>();
        else if (j.is_string())
            x = j.get<quicktype::BindEnum>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::BindEnum, std::map<std::string, quicktype::VgBinding>>>::to_json(json & j, const std::variant<quicktype::BindEnum, std::map<std::string, quicktype::VgBinding>> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::BindEnum>(x);
                break;
            case 1:
                j = std::get<std::map<std::string, quicktype::VgBinding>>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }

    inline void adl_serializer<std::variant<quicktype::TitleParams, std::string>>::from_json(const json & j, std::variant<quicktype::TitleParams, std::string> & x) {
        if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::TitleParams>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::TitleParams, std::string>>::to_json(json & j, const std::variant<quicktype::TitleParams, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::TitleParams>(x);
                break;
            case 1:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
