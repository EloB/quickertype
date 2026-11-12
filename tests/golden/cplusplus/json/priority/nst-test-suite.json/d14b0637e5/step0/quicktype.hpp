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

    class Json {
        public:
        Json() = default;
        virtual ~Json() = default;

        private:

        public:
    };

    using YArrayHeterogeneousJson = std::optional<std::variant<Json, int64_t, std::string>>;

    class YObjectBasicJson {
        public:
        YObjectBasicJson() = default;
        virtual ~YObjectBasicJson() = default;

        private:
        std::string asd;

        public:
        const std::string & get_asd() const { return asd; }
        std::string & get_mutable_asd() { return asd; }
        void set_asd(const std::string & value) { this->asd = value; }
    };

    class YObjectEmptyKeyJson {
        public:
        YObjectEmptyKeyJson() = default;
        virtual ~YObjectEmptyKeyJson() = default;

        private:
        int64_t empty;

        public:
        const int64_t & get_empty() const { return empty; }
        int64_t & get_mutable_empty() { return empty; }
        void set_empty(const int64_t & value) { this->empty = value; }
    };

    class YObjectEscapedNullInKeyJson {
        public:
        YObjectEscapedNullInKeyJson() = default;
        virtual ~YObjectEscapedNullInKeyJson() = default;

        private:
        int64_t foo_bar;

        public:
        const int64_t & get_foo_bar() const { return foo_bar; }
        int64_t & get_mutable_foo_bar() { return foo_bar; }
        void set_foo_bar(const int64_t & value) { this->foo_bar = value; }
    };

    class YObjectExtremeNumbersJson {
        public:
        YObjectExtremeNumbersJson() = default;
        virtual ~YObjectExtremeNumbersJson() = default;

        private:
        double max;
        double min;

        public:
        const double & get_max() const { return max; }
        double & get_mutable_max() { return max; }
        void set_max(const double & value) { this->max = value; }

        const double & get_min() const { return min; }
        double & get_mutable_min() { return min; }
        void set_min(const double & value) { this->min = value; }
    };

    class YObjectJson {
        public:
        YObjectJson() = default;
        virtual ~YObjectJson() = default;

        private:
        std::string asd;
        std::string dfg;

        public:
        const std::string & get_asd() const { return asd; }
        std::string & get_mutable_asd() { return asd; }
        void set_asd(const std::string & value) { this->asd = value; }

        const std::string & get_dfg() const { return dfg; }
        std::string & get_mutable_dfg() { return dfg; }
        void set_dfg(const std::string & value) { this->dfg = value; }
    };

    class X {
        public:
        X() = default;
        virtual ~X() = default;

        private:
        std::string id;

        public:
        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }
    };

    class YObjectLongStringsJson {
        public:
        YObjectLongStringsJson() = default;
        virtual ~YObjectLongStringsJson() = default;

        private:
        std::string id;
        std::vector<X> x;

        public:
        const std::string & get_id() const { return id; }
        std::string & get_mutable_id() { return id; }
        void set_id(const std::string & value) { this->id = value; }

        const std::vector<X> & get_x() const { return x; }
        std::vector<X> & get_mutable_x() { return x; }
        void set_x(const std::vector<X> & value) { this->x = value; }
    };

    class YObjectSimpleJson {
        public:
        YObjectSimpleJson() = default;
        virtual ~YObjectSimpleJson() = default;

        private:
        std::vector<nlohmann::json> a;

        public:
        const std::vector<nlohmann::json> & get_a() const { return a; }
        std::vector<nlohmann::json> & get_mutable_a() { return a; }
        void set_a(const std::vector<nlohmann::json> & value) { this->a = value; }
    };

    class YObjectStringUnicodeJson {
        public:
        YObjectStringUnicodeJson() = default;
        virtual ~YObjectStringUnicodeJson() = default;

        private:
        std::string title;

        public:
        const std::string & get_title() const { return title; }
        std::string & get_mutable_title() { return title; }
        void set_title(const std::string & value) { this->title = value; }
    };

    class YObjectWithNewlinesJson {
        public:
        YObjectWithNewlinesJson() = default;
        virtual ~YObjectWithNewlinesJson() = default;

        private:
        std::string a;

        public:
        const std::string & get_a() const { return a; }
        std::string & get_mutable_a() { return a; }
        void set_a(const std::string & value) { this->a = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        std::vector<std::vector<nlohmann::json>> y_array_arrays_with_spaces_json;
        std::vector<nlohmann::json> y_array_empty_json;
        std::vector<std::string> y_array_empty_string_json;
        std::vector<std::string> y_array_ending_with_newline_json;
        std::vector<bool> y_array_false_json;
        std::vector<YArrayHeterogeneousJson> y_array_heterogeneous_json;
        std::vector<nlohmann::json> y_array_null_json;
        std::vector<int64_t> y_array_with_1__and_newline_json;
        std::vector<int64_t> y_array_with_leading_space_json;
        std::vector<std::optional<int64_t>> y_array_with_several_null_json;
        std::vector<int64_t> y_array_with_trailing_space_json;
        std::vector<double> y_number_0_e1_json;
        std::vector<double> y_number_0_e_1_json;
        std::vector<int64_t> y_number_after_space_json;
        std::vector<double> y_number_double_close_to_zero_json;
        std::vector<double> y_number_int_with_exp_json;
        std::vector<double> y_number_json;
        std::vector<int64_t> y_number_minus_zero_json;
        std::vector<int64_t> y_number_negative_int_json;
        std::vector<int64_t> y_number_negative_one_json;
        std::vector<int64_t> y_number_negative_zero_json;
        std::vector<double> y_number_real_capital_e_json;
        std::vector<double> y_number_real_capital_e_neg_exp_json;
        std::vector<double> y_number_real_capital_e_pos_exp_json;
        std::vector<double> y_number_real_exponent_json;
        std::vector<double> y_number_real_fraction_exponent_json;
        std::vector<double> y_number_real_neg_exp_json;
        std::vector<double> y_number_real_pos_exponent_json;
        std::vector<int64_t> y_number_simple_int_json;
        std::vector<double> y_number_simple_real_json;
        YObjectBasicJson y_object_basic_json;
        Json y_object_empty_json;
        YObjectEmptyKeyJson y_object_empty_key_json;
        YObjectEscapedNullInKeyJson y_object_escaped_null_in_key_json;
        YObjectExtremeNumbersJson y_object_extreme_numbers_json;
        YObjectJson y_object_json;
        YObjectLongStringsJson y_object_long_strings_json;
        YObjectSimpleJson y_object_simple_json;
        YObjectStringUnicodeJson y_object_string_unicode_json;
        YObjectWithNewlinesJson y_object_with_newlines_json;
        std::vector<std::string> y_string_1_2_3__bytes_utf_8__sequences_json;
        std::vector<std::string> y_string_accepted_surrogate_pair_json;
        std::vector<std::string> y_string_accepted_surrogate_pairs_json;
        std::vector<std::string> y_string_allowed_escapes_json;
        std::vector<std::string> y_string_backslash_and_u_escaped_zero_json;
        std::vector<std::string> y_string_backslash_doublequotes_json;
        std::vector<std::string> y_string_comments_json;
        std::vector<std::string> y_string_double_escape_a_json;
        std::vector<std::string> y_string_double_escape_n_json;
        std::vector<std::string> y_string_escaped_control_character_json;
        std::vector<std::string> y_string_escaped_noncharacter_json;
        std::vector<std::string> y_string_in_array_json;
        std::vector<std::string> y_string_in_array_with_leading_space_json;
        std::vector<std::string> y_string_last_surrogates_1__and_2_json;
        std::vector<std::string> y_string_nbsp_uescaped_json;
        std::vector<std::string> y_string_non_character_in_utf_8__u_10_ffff_json;
        std::vector<std::string> y_string_non_character_in_utf_8__u_1_ffff_json;
        std::vector<std::string> y_string_non_character_in_utf_8__u_ffff_json;
        std::vector<std::string> y_string_null_escape_json;
        std::vector<std::string> y_string_one_byte_utf_8_json;
        std::vector<std::string> y_string_pi_json;
        std::vector<std::string> y_string_simple_ascii_json;
        std::string y_string_space_json;
        std::vector<std::string> y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json;
        std::vector<std::string> y_string_three_byte_utf_8_json;
        std::vector<std::string> y_string_two_byte_utf_8_json;
        std::vector<std::string> y_string_u_2028__line_sep_json;
        std::vector<std::string> y_string_u_2029__par_sep_json;
        std::vector<std::string> y_string_u_escape_json;
        std::vector<std::string> y_string_uescaped_newline_json;
        std::vector<std::string> y_string_unescaped_char_delete_json;
        std::vector<std::string> y_string_unicode_2_json;
        std::vector<std::string> y_string_unicode_escaped_backslash_json;
        std::vector<std::string> y_string_unicode_escaped_double_quote_json;
        std::vector<std::string> y_string_unicode_json;
        std::vector<std::string> y_string_unicode_u_10_fffe_nonchar_json;
        std::vector<std::string> y_string_unicode_u_1_fffe_nonchar_json;
        std::vector<std::string> y_string_unicode_u_200_b_zero_width_space_json;
        std::vector<std::string> y_string_unicode_u_2064__invisible_plus_json;
        std::vector<std::string> y_string_unicode_u_fdd0_nonchar_json;
        std::vector<std::string> y_string_unicode_u_fffe_nonchar_json;
        std::vector<std::string> y_string_utf8_json;
        std::vector<std::string> y_string_with_del_character_json;
        bool y_structure_lonely_false_json;
        int64_t y_structure_lonely_int_json;
        double y_structure_lonely_negative_real_json;
        nlohmann::json y_structure_lonely_null_json;
        std::string y_structure_lonely_string_json;
        bool y_structure_lonely_true_json;
        std::string y_structure_string_empty_json;
        std::vector<std::string> y_structure_trailing_newline_json;
        std::vector<bool> y_structure_true_in_array_json;
        std::vector<nlohmann::json> y_structure_whitespace_array_json;

        public:
        const std::vector<std::vector<nlohmann::json>> & get_y_array_arrays_with_spaces_json() const { return y_array_arrays_with_spaces_json; }
        std::vector<std::vector<nlohmann::json>> & get_mutable_y_array_arrays_with_spaces_json() { return y_array_arrays_with_spaces_json; }
        void set_y_array_arrays_with_spaces_json(const std::vector<std::vector<nlohmann::json>> & value) { this->y_array_arrays_with_spaces_json = value; }

        const std::vector<nlohmann::json> & get_y_array_empty_json() const { return y_array_empty_json; }
        std::vector<nlohmann::json> & get_mutable_y_array_empty_json() { return y_array_empty_json; }
        void set_y_array_empty_json(const std::vector<nlohmann::json> & value) { this->y_array_empty_json = value; }

        const std::vector<std::string> & get_y_array_empty_string_json() const { return y_array_empty_string_json; }
        std::vector<std::string> & get_mutable_y_array_empty_string_json() { return y_array_empty_string_json; }
        void set_y_array_empty_string_json(const std::vector<std::string> & value) { this->y_array_empty_string_json = value; }

        const std::vector<std::string> & get_y_array_ending_with_newline_json() const { return y_array_ending_with_newline_json; }
        std::vector<std::string> & get_mutable_y_array_ending_with_newline_json() { return y_array_ending_with_newline_json; }
        void set_y_array_ending_with_newline_json(const std::vector<std::string> & value) { this->y_array_ending_with_newline_json = value; }

        const std::vector<bool> & get_y_array_false_json() const { return y_array_false_json; }
        std::vector<bool> & get_mutable_y_array_false_json() { return y_array_false_json; }
        void set_y_array_false_json(const std::vector<bool> & value) { this->y_array_false_json = value; }

        const std::vector<YArrayHeterogeneousJson> & get_y_array_heterogeneous_json() const { return y_array_heterogeneous_json; }
        std::vector<YArrayHeterogeneousJson> & get_mutable_y_array_heterogeneous_json() { return y_array_heterogeneous_json; }
        void set_y_array_heterogeneous_json(const std::vector<YArrayHeterogeneousJson> & value) { this->y_array_heterogeneous_json = value; }

        const std::vector<nlohmann::json> & get_y_array_null_json() const { return y_array_null_json; }
        std::vector<nlohmann::json> & get_mutable_y_array_null_json() { return y_array_null_json; }
        void set_y_array_null_json(const std::vector<nlohmann::json> & value) { this->y_array_null_json = value; }

        const std::vector<int64_t> & get_y_array_with_1___and_newline_json() const { return y_array_with_1__and_newline_json; }
        std::vector<int64_t> & get_mutable_y_array_with_1___and_newline_json() { return y_array_with_1__and_newline_json; }
        void set_y_array_with_1___and_newline_json(const std::vector<int64_t> & value) { this->y_array_with_1__and_newline_json = value; }

        const std::vector<int64_t> & get_y_array_with_leading_space_json() const { return y_array_with_leading_space_json; }
        std::vector<int64_t> & get_mutable_y_array_with_leading_space_json() { return y_array_with_leading_space_json; }
        void set_y_array_with_leading_space_json(const std::vector<int64_t> & value) { this->y_array_with_leading_space_json = value; }

        const std::vector<std::optional<int64_t>> & get_y_array_with_several_null_json() const { return y_array_with_several_null_json; }
        std::vector<std::optional<int64_t>> & get_mutable_y_array_with_several_null_json() { return y_array_with_several_null_json; }
        void set_y_array_with_several_null_json(const std::vector<std::optional<int64_t>> & value) { this->y_array_with_several_null_json = value; }

        const std::vector<int64_t> & get_y_array_with_trailing_space_json() const { return y_array_with_trailing_space_json; }
        std::vector<int64_t> & get_mutable_y_array_with_trailing_space_json() { return y_array_with_trailing_space_json; }
        void set_y_array_with_trailing_space_json(const std::vector<int64_t> & value) { this->y_array_with_trailing_space_json = value; }

        const std::vector<double> & get_y_number_0__e1_json() const { return y_number_0_e1_json; }
        std::vector<double> & get_mutable_y_number_0__e1_json() { return y_number_0_e1_json; }
        void set_y_number_0__e1_json(const std::vector<double> & value) { this->y_number_0_e1_json = value; }

        const std::vector<double> & get_y_number_0__e_1__json() const { return y_number_0_e_1_json; }
        std::vector<double> & get_mutable_y_number_0__e_1__json() { return y_number_0_e_1_json; }
        void set_y_number_0__e_1__json(const std::vector<double> & value) { this->y_number_0_e_1_json = value; }

        const std::vector<int64_t> & get_y_number_after_space_json() const { return y_number_after_space_json; }
        std::vector<int64_t> & get_mutable_y_number_after_space_json() { return y_number_after_space_json; }
        void set_y_number_after_space_json(const std::vector<int64_t> & value) { this->y_number_after_space_json = value; }

        const std::vector<double> & get_y_number_double_close_to_zero_json() const { return y_number_double_close_to_zero_json; }
        std::vector<double> & get_mutable_y_number_double_close_to_zero_json() { return y_number_double_close_to_zero_json; }
        void set_y_number_double_close_to_zero_json(const std::vector<double> & value) { this->y_number_double_close_to_zero_json = value; }

        const std::vector<double> & get_y_number_int_with_exp_json() const { return y_number_int_with_exp_json; }
        std::vector<double> & get_mutable_y_number_int_with_exp_json() { return y_number_int_with_exp_json; }
        void set_y_number_int_with_exp_json(const std::vector<double> & value) { this->y_number_int_with_exp_json = value; }

        const std::vector<double> & get_y_number_json() const { return y_number_json; }
        std::vector<double> & get_mutable_y_number_json() { return y_number_json; }
        void set_y_number_json(const std::vector<double> & value) { this->y_number_json = value; }

        const std::vector<int64_t> & get_y_number_minus_zero_json() const { return y_number_minus_zero_json; }
        std::vector<int64_t> & get_mutable_y_number_minus_zero_json() { return y_number_minus_zero_json; }
        void set_y_number_minus_zero_json(const std::vector<int64_t> & value) { this->y_number_minus_zero_json = value; }

        const std::vector<int64_t> & get_y_number_negative_int_json() const { return y_number_negative_int_json; }
        std::vector<int64_t> & get_mutable_y_number_negative_int_json() { return y_number_negative_int_json; }
        void set_y_number_negative_int_json(const std::vector<int64_t> & value) { this->y_number_negative_int_json = value; }

        const std::vector<int64_t> & get_y_number_negative_one_json() const { return y_number_negative_one_json; }
        std::vector<int64_t> & get_mutable_y_number_negative_one_json() { return y_number_negative_one_json; }
        void set_y_number_negative_one_json(const std::vector<int64_t> & value) { this->y_number_negative_one_json = value; }

        const std::vector<int64_t> & get_y_number_negative_zero_json() const { return y_number_negative_zero_json; }
        std::vector<int64_t> & get_mutable_y_number_negative_zero_json() { return y_number_negative_zero_json; }
        void set_y_number_negative_zero_json(const std::vector<int64_t> & value) { this->y_number_negative_zero_json = value; }

        const std::vector<double> & get_y_number_real_capital_e_json() const { return y_number_real_capital_e_json; }
        std::vector<double> & get_mutable_y_number_real_capital_e_json() { return y_number_real_capital_e_json; }
        void set_y_number_real_capital_e_json(const std::vector<double> & value) { this->y_number_real_capital_e_json = value; }

        const std::vector<double> & get_y_number_real_capital_e_neg_exp_json() const { return y_number_real_capital_e_neg_exp_json; }
        std::vector<double> & get_mutable_y_number_real_capital_e_neg_exp_json() { return y_number_real_capital_e_neg_exp_json; }
        void set_y_number_real_capital_e_neg_exp_json(const std::vector<double> & value) { this->y_number_real_capital_e_neg_exp_json = value; }

        const std::vector<double> & get_y_number_real_capital_e_pos_exp_json() const { return y_number_real_capital_e_pos_exp_json; }
        std::vector<double> & get_mutable_y_number_real_capital_e_pos_exp_json() { return y_number_real_capital_e_pos_exp_json; }
        void set_y_number_real_capital_e_pos_exp_json(const std::vector<double> & value) { this->y_number_real_capital_e_pos_exp_json = value; }

        const std::vector<double> & get_y_number_real_exponent_json() const { return y_number_real_exponent_json; }
        std::vector<double> & get_mutable_y_number_real_exponent_json() { return y_number_real_exponent_json; }
        void set_y_number_real_exponent_json(const std::vector<double> & value) { this->y_number_real_exponent_json = value; }

        const std::vector<double> & get_y_number_real_fraction_exponent_json() const { return y_number_real_fraction_exponent_json; }
        std::vector<double> & get_mutable_y_number_real_fraction_exponent_json() { return y_number_real_fraction_exponent_json; }
        void set_y_number_real_fraction_exponent_json(const std::vector<double> & value) { this->y_number_real_fraction_exponent_json = value; }

        const std::vector<double> & get_y_number_real_neg_exp_json() const { return y_number_real_neg_exp_json; }
        std::vector<double> & get_mutable_y_number_real_neg_exp_json() { return y_number_real_neg_exp_json; }
        void set_y_number_real_neg_exp_json(const std::vector<double> & value) { this->y_number_real_neg_exp_json = value; }

        const std::vector<double> & get_y_number_real_pos_exponent_json() const { return y_number_real_pos_exponent_json; }
        std::vector<double> & get_mutable_y_number_real_pos_exponent_json() { return y_number_real_pos_exponent_json; }
        void set_y_number_real_pos_exponent_json(const std::vector<double> & value) { this->y_number_real_pos_exponent_json = value; }

        const std::vector<int64_t> & get_y_number_simple_int_json() const { return y_number_simple_int_json; }
        std::vector<int64_t> & get_mutable_y_number_simple_int_json() { return y_number_simple_int_json; }
        void set_y_number_simple_int_json(const std::vector<int64_t> & value) { this->y_number_simple_int_json = value; }

        const std::vector<double> & get_y_number_simple_real_json() const { return y_number_simple_real_json; }
        std::vector<double> & get_mutable_y_number_simple_real_json() { return y_number_simple_real_json; }
        void set_y_number_simple_real_json(const std::vector<double> & value) { this->y_number_simple_real_json = value; }

        const YObjectBasicJson & get_y_object_basic_json() const { return y_object_basic_json; }
        YObjectBasicJson & get_mutable_y_object_basic_json() { return y_object_basic_json; }
        void set_y_object_basic_json(const YObjectBasicJson & value) { this->y_object_basic_json = value; }

        const Json & get_y_object_empty_json() const { return y_object_empty_json; }
        Json & get_mutable_y_object_empty_json() { return y_object_empty_json; }
        void set_y_object_empty_json(const Json & value) { this->y_object_empty_json = value; }

        const YObjectEmptyKeyJson & get_y_object_empty_key_json() const { return y_object_empty_key_json; }
        YObjectEmptyKeyJson & get_mutable_y_object_empty_key_json() { return y_object_empty_key_json; }
        void set_y_object_empty_key_json(const YObjectEmptyKeyJson & value) { this->y_object_empty_key_json = value; }

        const YObjectEscapedNullInKeyJson & get_y_object_escaped_null_in_key_json() const { return y_object_escaped_null_in_key_json; }
        YObjectEscapedNullInKeyJson & get_mutable_y_object_escaped_null_in_key_json() { return y_object_escaped_null_in_key_json; }
        void set_y_object_escaped_null_in_key_json(const YObjectEscapedNullInKeyJson & value) { this->y_object_escaped_null_in_key_json = value; }

        const YObjectExtremeNumbersJson & get_y_object_extreme_numbers_json() const { return y_object_extreme_numbers_json; }
        YObjectExtremeNumbersJson & get_mutable_y_object_extreme_numbers_json() { return y_object_extreme_numbers_json; }
        void set_y_object_extreme_numbers_json(const YObjectExtremeNumbersJson & value) { this->y_object_extreme_numbers_json = value; }

        const YObjectJson & get_y_object_json() const { return y_object_json; }
        YObjectJson & get_mutable_y_object_json() { return y_object_json; }
        void set_y_object_json(const YObjectJson & value) { this->y_object_json = value; }

        const YObjectLongStringsJson & get_y_object_long_strings_json() const { return y_object_long_strings_json; }
        YObjectLongStringsJson & get_mutable_y_object_long_strings_json() { return y_object_long_strings_json; }
        void set_y_object_long_strings_json(const YObjectLongStringsJson & value) { this->y_object_long_strings_json = value; }

        const YObjectSimpleJson & get_y_object_simple_json() const { return y_object_simple_json; }
        YObjectSimpleJson & get_mutable_y_object_simple_json() { return y_object_simple_json; }
        void set_y_object_simple_json(const YObjectSimpleJson & value) { this->y_object_simple_json = value; }

        const YObjectStringUnicodeJson & get_y_object_string_unicode_json() const { return y_object_string_unicode_json; }
        YObjectStringUnicodeJson & get_mutable_y_object_string_unicode_json() { return y_object_string_unicode_json; }
        void set_y_object_string_unicode_json(const YObjectStringUnicodeJson & value) { this->y_object_string_unicode_json = value; }

        const YObjectWithNewlinesJson & get_y_object_with_newlines_json() const { return y_object_with_newlines_json; }
        YObjectWithNewlinesJson & get_mutable_y_object_with_newlines_json() { return y_object_with_newlines_json; }
        void set_y_object_with_newlines_json(const YObjectWithNewlinesJson & value) { this->y_object_with_newlines_json = value; }

        const std::vector<std::string> & get_y_string_1_2_3___bytes_utf_8___sequences_json() const { return y_string_1_2_3__bytes_utf_8__sequences_json; }
        std::vector<std::string> & get_mutable_y_string_1_2_3___bytes_utf_8___sequences_json() { return y_string_1_2_3__bytes_utf_8__sequences_json; }
        void set_y_string_1_2_3___bytes_utf_8___sequences_json(const std::vector<std::string> & value) { this->y_string_1_2_3__bytes_utf_8__sequences_json = value; }

        const std::vector<std::string> & get_y_string_accepted_surrogate_pair_json() const { return y_string_accepted_surrogate_pair_json; }
        std::vector<std::string> & get_mutable_y_string_accepted_surrogate_pair_json() { return y_string_accepted_surrogate_pair_json; }
        void set_y_string_accepted_surrogate_pair_json(const std::vector<std::string> & value) { this->y_string_accepted_surrogate_pair_json = value; }

        const std::vector<std::string> & get_y_string_accepted_surrogate_pairs_json() const { return y_string_accepted_surrogate_pairs_json; }
        std::vector<std::string> & get_mutable_y_string_accepted_surrogate_pairs_json() { return y_string_accepted_surrogate_pairs_json; }
        void set_y_string_accepted_surrogate_pairs_json(const std::vector<std::string> & value) { this->y_string_accepted_surrogate_pairs_json = value; }

        const std::vector<std::string> & get_y_string_allowed_escapes_json() const { return y_string_allowed_escapes_json; }
        std::vector<std::string> & get_mutable_y_string_allowed_escapes_json() { return y_string_allowed_escapes_json; }
        void set_y_string_allowed_escapes_json(const std::vector<std::string> & value) { this->y_string_allowed_escapes_json = value; }

        const std::vector<std::string> & get_y_string_backslash_and_u_escaped_zero_json() const { return y_string_backslash_and_u_escaped_zero_json; }
        std::vector<std::string> & get_mutable_y_string_backslash_and_u_escaped_zero_json() { return y_string_backslash_and_u_escaped_zero_json; }
        void set_y_string_backslash_and_u_escaped_zero_json(const std::vector<std::string> & value) { this->y_string_backslash_and_u_escaped_zero_json = value; }

        const std::vector<std::string> & get_y_string_backslash_doublequotes_json() const { return y_string_backslash_doublequotes_json; }
        std::vector<std::string> & get_mutable_y_string_backslash_doublequotes_json() { return y_string_backslash_doublequotes_json; }
        void set_y_string_backslash_doublequotes_json(const std::vector<std::string> & value) { this->y_string_backslash_doublequotes_json = value; }

        const std::vector<std::string> & get_y_string_comments_json() const { return y_string_comments_json; }
        std::vector<std::string> & get_mutable_y_string_comments_json() { return y_string_comments_json; }
        void set_y_string_comments_json(const std::vector<std::string> & value) { this->y_string_comments_json = value; }

        const std::vector<std::string> & get_y_string_double_escape_a_json() const { return y_string_double_escape_a_json; }
        std::vector<std::string> & get_mutable_y_string_double_escape_a_json() { return y_string_double_escape_a_json; }
        void set_y_string_double_escape_a_json(const std::vector<std::string> & value) { this->y_string_double_escape_a_json = value; }

        const std::vector<std::string> & get_y_string_double_escape_n_json() const { return y_string_double_escape_n_json; }
        std::vector<std::string> & get_mutable_y_string_double_escape_n_json() { return y_string_double_escape_n_json; }
        void set_y_string_double_escape_n_json(const std::vector<std::string> & value) { this->y_string_double_escape_n_json = value; }

        const std::vector<std::string> & get_y_string_escaped_control_character_json() const { return y_string_escaped_control_character_json; }
        std::vector<std::string> & get_mutable_y_string_escaped_control_character_json() { return y_string_escaped_control_character_json; }
        void set_y_string_escaped_control_character_json(const std::vector<std::string> & value) { this->y_string_escaped_control_character_json = value; }

        const std::vector<std::string> & get_y_string_escaped_noncharacter_json() const { return y_string_escaped_noncharacter_json; }
        std::vector<std::string> & get_mutable_y_string_escaped_noncharacter_json() { return y_string_escaped_noncharacter_json; }
        void set_y_string_escaped_noncharacter_json(const std::vector<std::string> & value) { this->y_string_escaped_noncharacter_json = value; }

        const std::vector<std::string> & get_y_string_in_array_json() const { return y_string_in_array_json; }
        std::vector<std::string> & get_mutable_y_string_in_array_json() { return y_string_in_array_json; }
        void set_y_string_in_array_json(const std::vector<std::string> & value) { this->y_string_in_array_json = value; }

        const std::vector<std::string> & get_y_string_in_array_with_leading_space_json() const { return y_string_in_array_with_leading_space_json; }
        std::vector<std::string> & get_mutable_y_string_in_array_with_leading_space_json() { return y_string_in_array_with_leading_space_json; }
        void set_y_string_in_array_with_leading_space_json(const std::vector<std::string> & value) { this->y_string_in_array_with_leading_space_json = value; }

        const std::vector<std::string> & get_y_string_last_surrogates_1___and_2__json() const { return y_string_last_surrogates_1__and_2_json; }
        std::vector<std::string> & get_mutable_y_string_last_surrogates_1___and_2__json() { return y_string_last_surrogates_1__and_2_json; }
        void set_y_string_last_surrogates_1___and_2__json(const std::vector<std::string> & value) { this->y_string_last_surrogates_1__and_2_json = value; }

        const std::vector<std::string> & get_y_string_nbsp_uescaped_json() const { return y_string_nbsp_uescaped_json; }
        std::vector<std::string> & get_mutable_y_string_nbsp_uescaped_json() { return y_string_nbsp_uescaped_json; }
        void set_y_string_nbsp_uescaped_json(const std::vector<std::string> & value) { this->y_string_nbsp_uescaped_json = value; }

        const std::vector<std::string> & get_y_string_non_character_in_utf_8___u_10__ffff_json() const { return y_string_non_character_in_utf_8__u_10_ffff_json; }
        std::vector<std::string> & get_mutable_y_string_non_character_in_utf_8___u_10__ffff_json() { return y_string_non_character_in_utf_8__u_10_ffff_json; }
        void set_y_string_non_character_in_utf_8___u_10__ffff_json(const std::vector<std::string> & value) { this->y_string_non_character_in_utf_8__u_10_ffff_json = value; }

        const std::vector<std::string> & get_y_string_non_character_in_utf_8___u_1__ffff_json() const { return y_string_non_character_in_utf_8__u_1_ffff_json; }
        std::vector<std::string> & get_mutable_y_string_non_character_in_utf_8___u_1__ffff_json() { return y_string_non_character_in_utf_8__u_1_ffff_json; }
        void set_y_string_non_character_in_utf_8___u_1__ffff_json(const std::vector<std::string> & value) { this->y_string_non_character_in_utf_8__u_1_ffff_json = value; }

        const std::vector<std::string> & get_y_string_non_character_in_utf_8___u_ffff_json() const { return y_string_non_character_in_utf_8__u_ffff_json; }
        std::vector<std::string> & get_mutable_y_string_non_character_in_utf_8___u_ffff_json() { return y_string_non_character_in_utf_8__u_ffff_json; }
        void set_y_string_non_character_in_utf_8___u_ffff_json(const std::vector<std::string> & value) { this->y_string_non_character_in_utf_8__u_ffff_json = value; }

        const std::vector<std::string> & get_y_string_null_escape_json() const { return y_string_null_escape_json; }
        std::vector<std::string> & get_mutable_y_string_null_escape_json() { return y_string_null_escape_json; }
        void set_y_string_null_escape_json(const std::vector<std::string> & value) { this->y_string_null_escape_json = value; }

        const std::vector<std::string> & get_y_string_one_byte_utf_8__json() const { return y_string_one_byte_utf_8_json; }
        std::vector<std::string> & get_mutable_y_string_one_byte_utf_8__json() { return y_string_one_byte_utf_8_json; }
        void set_y_string_one_byte_utf_8__json(const std::vector<std::string> & value) { this->y_string_one_byte_utf_8_json = value; }

        const std::vector<std::string> & get_y_string_pi_json() const { return y_string_pi_json; }
        std::vector<std::string> & get_mutable_y_string_pi_json() { return y_string_pi_json; }
        void set_y_string_pi_json(const std::vector<std::string> & value) { this->y_string_pi_json = value; }

        const std::vector<std::string> & get_y_string_simple_ascii_json() const { return y_string_simple_ascii_json; }
        std::vector<std::string> & get_mutable_y_string_simple_ascii_json() { return y_string_simple_ascii_json; }
        void set_y_string_simple_ascii_json(const std::vector<std::string> & value) { this->y_string_simple_ascii_json = value; }

        const std::string & get_y_string_space_json() const { return y_string_space_json; }
        std::string & get_mutable_y_string_space_json() { return y_string_space_json; }
        void set_y_string_space_json(const std::string & value) { this->y_string_space_json = value; }

        const std::vector<std::string> & get_y_string_surrogates_u_1__d11_e_musical_symbol_g_clef_json() const { return y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json; }
        std::vector<std::string> & get_mutable_y_string_surrogates_u_1__d11_e_musical_symbol_g_clef_json() { return y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json; }
        void set_y_string_surrogates_u_1__d11_e_musical_symbol_g_clef_json(const std::vector<std::string> & value) { this->y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json = value; }

        const std::vector<std::string> & get_y_string_three_byte_utf_8__json() const { return y_string_three_byte_utf_8_json; }
        std::vector<std::string> & get_mutable_y_string_three_byte_utf_8__json() { return y_string_three_byte_utf_8_json; }
        void set_y_string_three_byte_utf_8__json(const std::vector<std::string> & value) { this->y_string_three_byte_utf_8_json = value; }

        const std::vector<std::string> & get_y_string_two_byte_utf_8__json() const { return y_string_two_byte_utf_8_json; }
        std::vector<std::string> & get_mutable_y_string_two_byte_utf_8__json() { return y_string_two_byte_utf_8_json; }
        void set_y_string_two_byte_utf_8__json(const std::vector<std::string> & value) { this->y_string_two_byte_utf_8_json = value; }

        const std::vector<std::string> & get_y_string_u_2028___line_sep_json() const { return y_string_u_2028__line_sep_json; }
        std::vector<std::string> & get_mutable_y_string_u_2028___line_sep_json() { return y_string_u_2028__line_sep_json; }
        void set_y_string_u_2028___line_sep_json(const std::vector<std::string> & value) { this->y_string_u_2028__line_sep_json = value; }

        const std::vector<std::string> & get_y_string_u_2029___par_sep_json() const { return y_string_u_2029__par_sep_json; }
        std::vector<std::string> & get_mutable_y_string_u_2029___par_sep_json() { return y_string_u_2029__par_sep_json; }
        void set_y_string_u_2029___par_sep_json(const std::vector<std::string> & value) { this->y_string_u_2029__par_sep_json = value; }

        const std::vector<std::string> & get_y_string_u_escape_json() const { return y_string_u_escape_json; }
        std::vector<std::string> & get_mutable_y_string_u_escape_json() { return y_string_u_escape_json; }
        void set_y_string_u_escape_json(const std::vector<std::string> & value) { this->y_string_u_escape_json = value; }

        const std::vector<std::string> & get_y_string_uescaped_newline_json() const { return y_string_uescaped_newline_json; }
        std::vector<std::string> & get_mutable_y_string_uescaped_newline_json() { return y_string_uescaped_newline_json; }
        void set_y_string_uescaped_newline_json(const std::vector<std::string> & value) { this->y_string_uescaped_newline_json = value; }

        const std::vector<std::string> & get_y_string_unescaped_char_delete_json() const { return y_string_unescaped_char_delete_json; }
        std::vector<std::string> & get_mutable_y_string_unescaped_char_delete_json() { return y_string_unescaped_char_delete_json; }
        void set_y_string_unescaped_char_delete_json(const std::vector<std::string> & value) { this->y_string_unescaped_char_delete_json = value; }

        const std::vector<std::string> & get_y_string_unicode_2__json() const { return y_string_unicode_2_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_2__json() { return y_string_unicode_2_json; }
        void set_y_string_unicode_2__json(const std::vector<std::string> & value) { this->y_string_unicode_2_json = value; }

        const std::vector<std::string> & get_y_string_unicode_escaped_backslash_json() const { return y_string_unicode_escaped_backslash_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_escaped_backslash_json() { return y_string_unicode_escaped_backslash_json; }
        void set_y_string_unicode_escaped_backslash_json(const std::vector<std::string> & value) { this->y_string_unicode_escaped_backslash_json = value; }

        const std::vector<std::string> & get_y_string_unicode_escaped_double_quote_json() const { return y_string_unicode_escaped_double_quote_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_escaped_double_quote_json() { return y_string_unicode_escaped_double_quote_json; }
        void set_y_string_unicode_escaped_double_quote_json(const std::vector<std::string> & value) { this->y_string_unicode_escaped_double_quote_json = value; }

        const std::vector<std::string> & get_y_string_unicode_json() const { return y_string_unicode_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_json() { return y_string_unicode_json; }
        void set_y_string_unicode_json(const std::vector<std::string> & value) { this->y_string_unicode_json = value; }

        const std::vector<std::string> & get_y_string_unicode_u_10__fffe_nonchar_json() const { return y_string_unicode_u_10_fffe_nonchar_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_u_10__fffe_nonchar_json() { return y_string_unicode_u_10_fffe_nonchar_json; }
        void set_y_string_unicode_u_10__fffe_nonchar_json(const std::vector<std::string> & value) { this->y_string_unicode_u_10_fffe_nonchar_json = value; }

        const std::vector<std::string> & get_y_string_unicode_u_1__fffe_nonchar_json() const { return y_string_unicode_u_1_fffe_nonchar_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_u_1__fffe_nonchar_json() { return y_string_unicode_u_1_fffe_nonchar_json; }
        void set_y_string_unicode_u_1__fffe_nonchar_json(const std::vector<std::string> & value) { this->y_string_unicode_u_1_fffe_nonchar_json = value; }

        const std::vector<std::string> & get_y_string_unicode_u_200__b_zero_width_space_json() const { return y_string_unicode_u_200_b_zero_width_space_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_u_200__b_zero_width_space_json() { return y_string_unicode_u_200_b_zero_width_space_json; }
        void set_y_string_unicode_u_200__b_zero_width_space_json(const std::vector<std::string> & value) { this->y_string_unicode_u_200_b_zero_width_space_json = value; }

        const std::vector<std::string> & get_y_string_unicode_u_2064___invisible_plus_json() const { return y_string_unicode_u_2064__invisible_plus_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_u_2064___invisible_plus_json() { return y_string_unicode_u_2064__invisible_plus_json; }
        void set_y_string_unicode_u_2064___invisible_plus_json(const std::vector<std::string> & value) { this->y_string_unicode_u_2064__invisible_plus_json = value; }

        const std::vector<std::string> & get_y_string_unicode_u_fdd0_nonchar_json() const { return y_string_unicode_u_fdd0_nonchar_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_u_fdd0_nonchar_json() { return y_string_unicode_u_fdd0_nonchar_json; }
        void set_y_string_unicode_u_fdd0_nonchar_json(const std::vector<std::string> & value) { this->y_string_unicode_u_fdd0_nonchar_json = value; }

        const std::vector<std::string> & get_y_string_unicode_u_fffe_nonchar_json() const { return y_string_unicode_u_fffe_nonchar_json; }
        std::vector<std::string> & get_mutable_y_string_unicode_u_fffe_nonchar_json() { return y_string_unicode_u_fffe_nonchar_json; }
        void set_y_string_unicode_u_fffe_nonchar_json(const std::vector<std::string> & value) { this->y_string_unicode_u_fffe_nonchar_json = value; }

        const std::vector<std::string> & get_y_string_utf8_json() const { return y_string_utf8_json; }
        std::vector<std::string> & get_mutable_y_string_utf8_json() { return y_string_utf8_json; }
        void set_y_string_utf8_json(const std::vector<std::string> & value) { this->y_string_utf8_json = value; }

        const std::vector<std::string> & get_y_string_with_del_character_json() const { return y_string_with_del_character_json; }
        std::vector<std::string> & get_mutable_y_string_with_del_character_json() { return y_string_with_del_character_json; }
        void set_y_string_with_del_character_json(const std::vector<std::string> & value) { this->y_string_with_del_character_json = value; }

        const bool & get_y_structure_lonely_false_json() const { return y_structure_lonely_false_json; }
        bool & get_mutable_y_structure_lonely_false_json() { return y_structure_lonely_false_json; }
        void set_y_structure_lonely_false_json(const bool & value) { this->y_structure_lonely_false_json = value; }

        const int64_t & get_y_structure_lonely_int_json() const { return y_structure_lonely_int_json; }
        int64_t & get_mutable_y_structure_lonely_int_json() { return y_structure_lonely_int_json; }
        void set_y_structure_lonely_int_json(const int64_t & value) { this->y_structure_lonely_int_json = value; }

        const double & get_y_structure_lonely_negative_real_json() const { return y_structure_lonely_negative_real_json; }
        double & get_mutable_y_structure_lonely_negative_real_json() { return y_structure_lonely_negative_real_json; }
        void set_y_structure_lonely_negative_real_json(const double & value) { this->y_structure_lonely_negative_real_json = value; }

        const nlohmann::json & get_y_structure_lonely_null_json() const { return y_structure_lonely_null_json; }
        nlohmann::json & get_mutable_y_structure_lonely_null_json() { return y_structure_lonely_null_json; }
        void set_y_structure_lonely_null_json(const nlohmann::json & value) { this->y_structure_lonely_null_json = value; }

        const std::string & get_y_structure_lonely_string_json() const { return y_structure_lonely_string_json; }
        std::string & get_mutable_y_structure_lonely_string_json() { return y_structure_lonely_string_json; }
        void set_y_structure_lonely_string_json(const std::string & value) { this->y_structure_lonely_string_json = value; }

        const bool & get_y_structure_lonely_true_json() const { return y_structure_lonely_true_json; }
        bool & get_mutable_y_structure_lonely_true_json() { return y_structure_lonely_true_json; }
        void set_y_structure_lonely_true_json(const bool & value) { this->y_structure_lonely_true_json = value; }

        const std::string & get_y_structure_string_empty_json() const { return y_structure_string_empty_json; }
        std::string & get_mutable_y_structure_string_empty_json() { return y_structure_string_empty_json; }
        void set_y_structure_string_empty_json(const std::string & value) { this->y_structure_string_empty_json = value; }

        const std::vector<std::string> & get_y_structure_trailing_newline_json() const { return y_structure_trailing_newline_json; }
        std::vector<std::string> & get_mutable_y_structure_trailing_newline_json() { return y_structure_trailing_newline_json; }
        void set_y_structure_trailing_newline_json(const std::vector<std::string> & value) { this->y_structure_trailing_newline_json = value; }

        const std::vector<bool> & get_y_structure_true_in_array_json() const { return y_structure_true_in_array_json; }
        std::vector<bool> & get_mutable_y_structure_true_in_array_json() { return y_structure_true_in_array_json; }
        void set_y_structure_true_in_array_json(const std::vector<bool> & value) { this->y_structure_true_in_array_json = value; }

        const std::vector<nlohmann::json> & get_y_structure_whitespace_array_json() const { return y_structure_whitespace_array_json; }
        std::vector<nlohmann::json> & get_mutable_y_structure_whitespace_array_json() { return y_structure_whitespace_array_json; }
        void set_y_structure_whitespace_array_json(const std::vector<nlohmann::json> & value) { this->y_structure_whitespace_array_json = value; }
    };
}

namespace quicktype {
void from_json(const json & j, Json & x);
void to_json(json & j, const Json & x);

void from_json(const json & j, YObjectBasicJson & x);
void to_json(json & j, const YObjectBasicJson & x);

void from_json(const json & j, YObjectEmptyKeyJson & x);
void to_json(json & j, const YObjectEmptyKeyJson & x);

void from_json(const json & j, YObjectEscapedNullInKeyJson & x);
void to_json(json & j, const YObjectEscapedNullInKeyJson & x);

void from_json(const json & j, YObjectExtremeNumbersJson & x);
void to_json(json & j, const YObjectExtremeNumbersJson & x);

void from_json(const json & j, YObjectJson & x);
void to_json(json & j, const YObjectJson & x);

void from_json(const json & j, X & x);
void to_json(json & j, const X & x);

void from_json(const json & j, YObjectLongStringsJson & x);
void to_json(json & j, const YObjectLongStringsJson & x);

void from_json(const json & j, YObjectSimpleJson & x);
void to_json(json & j, const YObjectSimpleJson & x);

void from_json(const json & j, YObjectStringUnicodeJson & x);
void to_json(json & j, const YObjectStringUnicodeJson & x);

void from_json(const json & j, YObjectWithNewlinesJson & x);
void to_json(json & j, const YObjectWithNewlinesJson & x);

void from_json(const json & j, TopLevel & x);
void to_json(json & j, const TopLevel & x);
}
namespace nlohmann {
template <>
struct adl_serializer<std::variant<quicktype::Json, int64_t, std::string>> {
    static void from_json(const json & j, std::variant<quicktype::Json, int64_t, std::string> & x);
    static void to_json(json & j, const std::variant<quicktype::Json, int64_t, std::string> & x);
};
}
namespace quicktype {
    inline void from_json(const json & j, Json& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        (void)j;
        (void)x;
    }

    inline void to_json(json & j, const Json & x) {
        j = json::object();
        (void)x;
    }

    inline void from_json(const json & j, YObjectBasicJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_asd(j.at("asd").get<std::string>());
    }

    inline void to_json(json & j, const YObjectBasicJson & x) {
        j = json::object();
        j["asd"] = x.get_asd();
    }

    inline void from_json(const json & j, YObjectEmptyKeyJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find("") != j.end() && !j.at("").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_empty(j.at("").get<int64_t>());
    }

    inline void to_json(json & j, const YObjectEmptyKeyJson & x) {
        j = json::object();
        j[""] = x.get_empty();
    }

    inline void from_json(const json & j, YObjectEscapedNullInKeyJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        if (j.find(([] { constexpr auto &s = "foo\u0000bar"; return std::string(s, sizeof(s) / sizeof(s[0]) - 1); }())) != j.end() && !j.at(([] { constexpr auto &s = "foo\u0000bar"; return std::string(s, sizeof(s) / sizeof(s[0]) - 1); }())).is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_foo_bar(j.at(([] { constexpr auto &s = "foo\u0000bar"; return std::string(s, sizeof(s) / sizeof(s[0]) - 1); }())).get<int64_t>());
    }

    inline void to_json(json & j, const YObjectEscapedNullInKeyJson & x) {
        j = json::object();
        j[([] { constexpr auto &s = "foo\u0000bar"; return std::string(s, sizeof(s) / sizeof(s[0]) - 1); }())] = x.get_foo_bar();
    }

    inline void from_json(const json & j, YObjectExtremeNumbersJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_max(j.at("max").get<double>());
        x.set_min(j.at("min").get<double>());
    }

    inline void to_json(json & j, const YObjectExtremeNumbersJson & x) {
        j = json::object();
        j["max"] = x.get_max();
        j["min"] = x.get_min();
    }

    inline void from_json(const json & j, YObjectJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_asd(j.at("asd").get<std::string>());
        x.set_dfg(j.at("dfg").get<std::string>());
    }

    inline void to_json(json & j, const YObjectJson & x) {
        j = json::object();
        j["asd"] = x.get_asd();
        j["dfg"] = x.get_dfg();
    }

    inline void from_json(const json & j, X& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_id(j.at("id").get<std::string>());
    }

    inline void to_json(json & j, const X & x) {
        j = json::object();
        j["id"] = x.get_id();
    }

    inline void from_json(const json & j, YObjectLongStringsJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_id(j.at("id").get<std::string>());
        x.set_x(j.at("x").get<std::vector<X>>());
    }

    inline void to_json(json & j, const YObjectLongStringsJson & x) {
        j = json::object();
        j["id"] = x.get_id();
        j["x"] = x.get_x();
    }

    inline void from_json(const json & j, YObjectSimpleJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_a(j.at("a").get<std::vector<nlohmann::json>>());
    }

    inline void to_json(json & j, const YObjectSimpleJson & x) {
        j = json::object();
        j["a"] = x.get_a();
    }

    inline void from_json(const json & j, YObjectStringUnicodeJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_title(j.at("title").get<std::string>());
    }

    inline void to_json(json & j, const YObjectStringUnicodeJson & x) {
        j = json::object();
        j["title"] = x.get_title();
    }

    inline void from_json(const json & j, YObjectWithNewlinesJson& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_a(j.at("a").get<std::string>());
    }

    inline void to_json(json & j, const YObjectWithNewlinesJson & x) {
        j = json::object();
        j["a"] = x.get_a();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_y_array_arrays_with_spaces_json(j.at("y_array_arraysWithSpaces.json").get<std::vector<std::vector<nlohmann::json>>>());
        x.set_y_array_empty_json(j.at("y_array_empty.json").get<std::vector<nlohmann::json>>());
        x.set_y_array_empty_string_json(j.at("y_array_empty-string.json").get<std::vector<std::string>>());
        x.set_y_array_ending_with_newline_json(j.at("y_array_ending_with_newline.json").get<std::vector<std::string>>());
        x.set_y_array_false_json(j.at("y_array_false.json").get<std::vector<bool>>());
        x.set_y_array_heterogeneous_json(j.at("y_array_heterogeneous.json").get<std::vector<YArrayHeterogeneousJson>>());
        x.set_y_array_null_json(j.at("y_array_null.json").get<std::vector<nlohmann::json>>());
        x.set_y_array_with_1___and_newline_json(j.at("y_array_with_1_and_newline.json").get<std::vector<int64_t>>());
        x.set_y_array_with_leading_space_json(j.at("y_array_with_leading_space.json").get<std::vector<int64_t>>());
        x.set_y_array_with_several_null_json(j.at("y_array_with_several_null.json").get<std::vector<std::optional<int64_t>>>());
        x.set_y_array_with_trailing_space_json(j.at("y_array_with_trailing_space.json").get<std::vector<int64_t>>());
        x.set_y_number_0__e1_json(j.at("y_number_0e1.json").get<std::vector<double>>());
        x.set_y_number_0__e_1__json(j.at("y_number_0e+1.json").get<std::vector<double>>());
        x.set_y_number_after_space_json(j.at("y_number_after_space.json").get<std::vector<int64_t>>());
        x.set_y_number_double_close_to_zero_json(j.at("y_number_double_close_to_zero.json").get<std::vector<double>>());
        x.set_y_number_int_with_exp_json(j.at("y_number_int_with_exp.json").get<std::vector<double>>());
        x.set_y_number_json(j.at("y_number.json").get<std::vector<double>>());
        x.set_y_number_minus_zero_json(j.at("y_number_minus_zero.json").get<std::vector<int64_t>>());
        x.set_y_number_negative_int_json(j.at("y_number_negative_int.json").get<std::vector<int64_t>>());
        x.set_y_number_negative_one_json(j.at("y_number_negative_one.json").get<std::vector<int64_t>>());
        x.set_y_number_negative_zero_json(j.at("y_number_negative_zero.json").get<std::vector<int64_t>>());
        x.set_y_number_real_capital_e_json(j.at("y_number_real_capital_e.json").get<std::vector<double>>());
        x.set_y_number_real_capital_e_neg_exp_json(j.at("y_number_real_capital_e_neg_exp.json").get<std::vector<double>>());
        x.set_y_number_real_capital_e_pos_exp_json(j.at("y_number_real_capital_e_pos_exp.json").get<std::vector<double>>());
        x.set_y_number_real_exponent_json(j.at("y_number_real_exponent.json").get<std::vector<double>>());
        x.set_y_number_real_fraction_exponent_json(j.at("y_number_real_fraction_exponent.json").get<std::vector<double>>());
        x.set_y_number_real_neg_exp_json(j.at("y_number_real_neg_exp.json").get<std::vector<double>>());
        x.set_y_number_real_pos_exponent_json(j.at("y_number_real_pos_exponent.json").get<std::vector<double>>());
        x.set_y_number_simple_int_json(j.at("y_number_simple_int.json").get<std::vector<int64_t>>());
        x.set_y_number_simple_real_json(j.at("y_number_simple_real.json").get<std::vector<double>>());
        x.set_y_object_basic_json(j.at("y_object_basic.json").get<YObjectBasicJson>());
        x.set_y_object_empty_json(j.at("y_object_empty.json").get<Json>());
        x.set_y_object_empty_key_json(j.at("y_object_empty_key.json").get<YObjectEmptyKeyJson>());
        x.set_y_object_escaped_null_in_key_json(j.at("y_object_escaped_null_in_key.json").get<YObjectEscapedNullInKeyJson>());
        x.set_y_object_extreme_numbers_json(j.at("y_object_extreme_numbers.json").get<YObjectExtremeNumbersJson>());
        x.set_y_object_json(j.at("y_object.json").get<YObjectJson>());
        x.set_y_object_long_strings_json(j.at("y_object_long_strings.json").get<YObjectLongStringsJson>());
        x.set_y_object_simple_json(j.at("y_object_simple.json").get<YObjectSimpleJson>());
        x.set_y_object_string_unicode_json(j.at("y_object_string_unicode.json").get<YObjectStringUnicodeJson>());
        x.set_y_object_with_newlines_json(j.at("y_object_with_newlines.json").get<YObjectWithNewlinesJson>());
        x.set_y_string_1_2_3___bytes_utf_8___sequences_json(j.at("y_string_1_2_3_bytes_UTF-8_sequences.json").get<std::vector<std::string>>());
        x.set_y_string_accepted_surrogate_pair_json(j.at("y_string_accepted_surrogate_pair.json").get<std::vector<std::string>>());
        x.set_y_string_accepted_surrogate_pairs_json(j.at("y_string_accepted_surrogate_pairs.json").get<std::vector<std::string>>());
        x.set_y_string_allowed_escapes_json(j.at("y_string_allowed_escapes.json").get<std::vector<std::string>>());
        x.set_y_string_backslash_and_u_escaped_zero_json(j.at("y_string_backslash_and_u_escaped_zero.json").get<std::vector<std::string>>());
        x.set_y_string_backslash_doublequotes_json(j.at("y_string_backslash_doublequotes.json").get<std::vector<std::string>>());
        x.set_y_string_comments_json(j.at("y_string_comments.json").get<std::vector<std::string>>());
        x.set_y_string_double_escape_a_json(j.at("y_string_double_escape_a.json").get<std::vector<std::string>>());
        x.set_y_string_double_escape_n_json(j.at("y_string_double_escape_n.json").get<std::vector<std::string>>());
        x.set_y_string_escaped_control_character_json(j.at("y_string_escaped_control_character.json").get<std::vector<std::string>>());
        x.set_y_string_escaped_noncharacter_json(j.at("y_string_escaped_noncharacter.json").get<std::vector<std::string>>());
        x.set_y_string_in_array_json(j.at("y_string_in_array.json").get<std::vector<std::string>>());
        x.set_y_string_in_array_with_leading_space_json(j.at("y_string_in_array_with_leading_space.json").get<std::vector<std::string>>());
        x.set_y_string_last_surrogates_1___and_2__json(j.at("y_string_last_surrogates_1_and_2.json").get<std::vector<std::string>>());
        x.set_y_string_nbsp_uescaped_json(j.at("y_string_nbsp_uescaped.json").get<std::vector<std::string>>());
        x.set_y_string_non_character_in_utf_8___u_10__ffff_json(j.at("y_string_nonCharacterInUTF-8_U+10FFFF.json").get<std::vector<std::string>>());
        x.set_y_string_non_character_in_utf_8___u_1__ffff_json(j.at("y_string_nonCharacterInUTF-8_U+1FFFF.json").get<std::vector<std::string>>());
        x.set_y_string_non_character_in_utf_8___u_ffff_json(j.at("y_string_nonCharacterInUTF-8_U+FFFF.json").get<std::vector<std::string>>());
        x.set_y_string_null_escape_json(j.at("y_string_null_escape.json").get<std::vector<std::string>>());
        x.set_y_string_one_byte_utf_8__json(j.at("y_string_one-byte-utf-8.json").get<std::vector<std::string>>());
        x.set_y_string_pi_json(j.at("y_string_pi.json").get<std::vector<std::string>>());
        x.set_y_string_simple_ascii_json(j.at("y_string_simple_ascii.json").get<std::vector<std::string>>());
        x.set_y_string_space_json(j.at("y_string_space.json").get<std::string>());
        x.set_y_string_surrogates_u_1__d11_e_musical_symbol_g_clef_json(j.at("y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json").get<std::vector<std::string>>());
        x.set_y_string_three_byte_utf_8__json(j.at("y_string_three-byte-utf-8.json").get<std::vector<std::string>>());
        x.set_y_string_two_byte_utf_8__json(j.at("y_string_two-byte-utf-8.json").get<std::vector<std::string>>());
        x.set_y_string_u_2028___line_sep_json(j.at("y_string_u+2028_line_sep.json").get<std::vector<std::string>>());
        x.set_y_string_u_2029___par_sep_json(j.at("y_string_u+2029_par_sep.json").get<std::vector<std::string>>());
        x.set_y_string_u_escape_json(j.at("y_string_uEscape.json").get<std::vector<std::string>>());
        x.set_y_string_uescaped_newline_json(j.at("y_string_uescaped_newline.json").get<std::vector<std::string>>());
        x.set_y_string_unescaped_char_delete_json(j.at("y_string_unescaped_char_delete.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_2__json(j.at("y_string_unicode_2.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_escaped_backslash_json(j.at("y_string_unicodeEscapedBackslash.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_escaped_double_quote_json(j.at("y_string_unicode_escaped_double_quote.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_json(j.at("y_string_unicode.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_u_10__fffe_nonchar_json(j.at("y_string_unicode_U+10FFFE_nonchar.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_u_1__fffe_nonchar_json(j.at("y_string_unicode_U+1FFFE_nonchar.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_u_200__b_zero_width_space_json(j.at("y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_u_2064___invisible_plus_json(j.at("y_string_unicode_U+2064_invisible_plus.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_u_fdd0_nonchar_json(j.at("y_string_unicode_U+FDD0_nonchar.json").get<std::vector<std::string>>());
        x.set_y_string_unicode_u_fffe_nonchar_json(j.at("y_string_unicode_U+FFFE_nonchar.json").get<std::vector<std::string>>());
        x.set_y_string_utf8_json(j.at("y_string_utf8.json").get<std::vector<std::string>>());
        x.set_y_string_with_del_character_json(j.at("y_string_with_del_character.json").get<std::vector<std::string>>());
        x.set_y_structure_lonely_false_json(j.at("y_structure_lonely_false.json").get<bool>());
        if (j.find("y_structure_lonely_int.json") != j.end() && !j.at("y_structure_lonely_int.json").is_number_integer()) throw std::runtime_error("Expected integer");
        x.set_y_structure_lonely_int_json(j.at("y_structure_lonely_int.json").get<int64_t>());
        x.set_y_structure_lonely_negative_real_json(j.at("y_structure_lonely_negative_real.json").get<double>());
        x.set_y_structure_lonely_null_json(get_untyped(j, "y_structure_lonely_null.json"));
        x.set_y_structure_lonely_string_json(j.at("y_structure_lonely_string.json").get<std::string>());
        x.set_y_structure_lonely_true_json(j.at("y_structure_lonely_true.json").get<bool>());
        x.set_y_structure_string_empty_json(j.at("y_structure_string_empty.json").get<std::string>());
        x.set_y_structure_trailing_newline_json(j.at("y_structure_trailing_newline.json").get<std::vector<std::string>>());
        x.set_y_structure_true_in_array_json(j.at("y_structure_true_in_array.json").get<std::vector<bool>>());
        x.set_y_structure_whitespace_array_json(j.at("y_structure_whitespace_array.json").get<std::vector<nlohmann::json>>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["y_array_arraysWithSpaces.json"] = x.get_y_array_arrays_with_spaces_json();
        j["y_array_empty.json"] = x.get_y_array_empty_json();
        j["y_array_empty-string.json"] = x.get_y_array_empty_string_json();
        j["y_array_ending_with_newline.json"] = x.get_y_array_ending_with_newline_json();
        j["y_array_false.json"] = x.get_y_array_false_json();
        j["y_array_heterogeneous.json"] = x.get_y_array_heterogeneous_json();
        j["y_array_null.json"] = x.get_y_array_null_json();
        j["y_array_with_1_and_newline.json"] = x.get_y_array_with_1___and_newline_json();
        j["y_array_with_leading_space.json"] = x.get_y_array_with_leading_space_json();
        j["y_array_with_several_null.json"] = x.get_y_array_with_several_null_json();
        j["y_array_with_trailing_space.json"] = x.get_y_array_with_trailing_space_json();
        j["y_number_0e1.json"] = x.get_y_number_0__e1_json();
        j["y_number_0e+1.json"] = x.get_y_number_0__e_1__json();
        j["y_number_after_space.json"] = x.get_y_number_after_space_json();
        j["y_number_double_close_to_zero.json"] = x.get_y_number_double_close_to_zero_json();
        j["y_number_int_with_exp.json"] = x.get_y_number_int_with_exp_json();
        j["y_number.json"] = x.get_y_number_json();
        j["y_number_minus_zero.json"] = x.get_y_number_minus_zero_json();
        j["y_number_negative_int.json"] = x.get_y_number_negative_int_json();
        j["y_number_negative_one.json"] = x.get_y_number_negative_one_json();
        j["y_number_negative_zero.json"] = x.get_y_number_negative_zero_json();
        j["y_number_real_capital_e.json"] = x.get_y_number_real_capital_e_json();
        j["y_number_real_capital_e_neg_exp.json"] = x.get_y_number_real_capital_e_neg_exp_json();
        j["y_number_real_capital_e_pos_exp.json"] = x.get_y_number_real_capital_e_pos_exp_json();
        j["y_number_real_exponent.json"] = x.get_y_number_real_exponent_json();
        j["y_number_real_fraction_exponent.json"] = x.get_y_number_real_fraction_exponent_json();
        j["y_number_real_neg_exp.json"] = x.get_y_number_real_neg_exp_json();
        j["y_number_real_pos_exponent.json"] = x.get_y_number_real_pos_exponent_json();
        j["y_number_simple_int.json"] = x.get_y_number_simple_int_json();
        j["y_number_simple_real.json"] = x.get_y_number_simple_real_json();
        j["y_object_basic.json"] = x.get_y_object_basic_json();
        j["y_object_empty.json"] = x.get_y_object_empty_json();
        j["y_object_empty_key.json"] = x.get_y_object_empty_key_json();
        j["y_object_escaped_null_in_key.json"] = x.get_y_object_escaped_null_in_key_json();
        j["y_object_extreme_numbers.json"] = x.get_y_object_extreme_numbers_json();
        j["y_object.json"] = x.get_y_object_json();
        j["y_object_long_strings.json"] = x.get_y_object_long_strings_json();
        j["y_object_simple.json"] = x.get_y_object_simple_json();
        j["y_object_string_unicode.json"] = x.get_y_object_string_unicode_json();
        j["y_object_with_newlines.json"] = x.get_y_object_with_newlines_json();
        j["y_string_1_2_3_bytes_UTF-8_sequences.json"] = x.get_y_string_1_2_3___bytes_utf_8___sequences_json();
        j["y_string_accepted_surrogate_pair.json"] = x.get_y_string_accepted_surrogate_pair_json();
        j["y_string_accepted_surrogate_pairs.json"] = x.get_y_string_accepted_surrogate_pairs_json();
        j["y_string_allowed_escapes.json"] = x.get_y_string_allowed_escapes_json();
        j["y_string_backslash_and_u_escaped_zero.json"] = x.get_y_string_backslash_and_u_escaped_zero_json();
        j["y_string_backslash_doublequotes.json"] = x.get_y_string_backslash_doublequotes_json();
        j["y_string_comments.json"] = x.get_y_string_comments_json();
        j["y_string_double_escape_a.json"] = x.get_y_string_double_escape_a_json();
        j["y_string_double_escape_n.json"] = x.get_y_string_double_escape_n_json();
        j["y_string_escaped_control_character.json"] = x.get_y_string_escaped_control_character_json();
        j["y_string_escaped_noncharacter.json"] = x.get_y_string_escaped_noncharacter_json();
        j["y_string_in_array.json"] = x.get_y_string_in_array_json();
        j["y_string_in_array_with_leading_space.json"] = x.get_y_string_in_array_with_leading_space_json();
        j["y_string_last_surrogates_1_and_2.json"] = x.get_y_string_last_surrogates_1___and_2__json();
        j["y_string_nbsp_uescaped.json"] = x.get_y_string_nbsp_uescaped_json();
        j["y_string_nonCharacterInUTF-8_U+10FFFF.json"] = x.get_y_string_non_character_in_utf_8___u_10__ffff_json();
        j["y_string_nonCharacterInUTF-8_U+1FFFF.json"] = x.get_y_string_non_character_in_utf_8___u_1__ffff_json();
        j["y_string_nonCharacterInUTF-8_U+FFFF.json"] = x.get_y_string_non_character_in_utf_8___u_ffff_json();
        j["y_string_null_escape.json"] = x.get_y_string_null_escape_json();
        j["y_string_one-byte-utf-8.json"] = x.get_y_string_one_byte_utf_8__json();
        j["y_string_pi.json"] = x.get_y_string_pi_json();
        j["y_string_simple_ascii.json"] = x.get_y_string_simple_ascii_json();
        j["y_string_space.json"] = x.get_y_string_space_json();
        j["y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json"] = x.get_y_string_surrogates_u_1__d11_e_musical_symbol_g_clef_json();
        j["y_string_three-byte-utf-8.json"] = x.get_y_string_three_byte_utf_8__json();
        j["y_string_two-byte-utf-8.json"] = x.get_y_string_two_byte_utf_8__json();
        j["y_string_u+2028_line_sep.json"] = x.get_y_string_u_2028___line_sep_json();
        j["y_string_u+2029_par_sep.json"] = x.get_y_string_u_2029___par_sep_json();
        j["y_string_uEscape.json"] = x.get_y_string_u_escape_json();
        j["y_string_uescaped_newline.json"] = x.get_y_string_uescaped_newline_json();
        j["y_string_unescaped_char_delete.json"] = x.get_y_string_unescaped_char_delete_json();
        j["y_string_unicode_2.json"] = x.get_y_string_unicode_2__json();
        j["y_string_unicodeEscapedBackslash.json"] = x.get_y_string_unicode_escaped_backslash_json();
        j["y_string_unicode_escaped_double_quote.json"] = x.get_y_string_unicode_escaped_double_quote_json();
        j["y_string_unicode.json"] = x.get_y_string_unicode_json();
        j["y_string_unicode_U+10FFFE_nonchar.json"] = x.get_y_string_unicode_u_10__fffe_nonchar_json();
        j["y_string_unicode_U+1FFFE_nonchar.json"] = x.get_y_string_unicode_u_1__fffe_nonchar_json();
        j["y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json"] = x.get_y_string_unicode_u_200__b_zero_width_space_json();
        j["y_string_unicode_U+2064_invisible_plus.json"] = x.get_y_string_unicode_u_2064___invisible_plus_json();
        j["y_string_unicode_U+FDD0_nonchar.json"] = x.get_y_string_unicode_u_fdd0_nonchar_json();
        j["y_string_unicode_U+FFFE_nonchar.json"] = x.get_y_string_unicode_u_fffe_nonchar_json();
        j["y_string_utf8.json"] = x.get_y_string_utf8_json();
        j["y_string_with_del_character.json"] = x.get_y_string_with_del_character_json();
        j["y_structure_lonely_false.json"] = x.get_y_structure_lonely_false_json();
        j["y_structure_lonely_int.json"] = x.get_y_structure_lonely_int_json();
        j["y_structure_lonely_negative_real.json"] = x.get_y_structure_lonely_negative_real_json();
        j["y_structure_lonely_null.json"] = x.get_y_structure_lonely_null_json();
        j["y_structure_lonely_string.json"] = x.get_y_structure_lonely_string_json();
        j["y_structure_lonely_true.json"] = x.get_y_structure_lonely_true_json();
        j["y_structure_string_empty.json"] = x.get_y_structure_string_empty_json();
        j["y_structure_trailing_newline.json"] = x.get_y_structure_trailing_newline_json();
        j["y_structure_true_in_array.json"] = x.get_y_structure_true_in_array_json();
        j["y_structure_whitespace_array.json"] = x.get_y_structure_whitespace_array_json();
    }
}
namespace nlohmann {
    inline void adl_serializer<std::variant<quicktype::Json, int64_t, std::string>>::from_json(const json & j, std::variant<quicktype::Json, int64_t, std::string> & x) {
        if (j.is_number_integer())
            x = j.get<int64_t>();
        else if (j.is_string())
            x = j.get<std::string>();
        else if (j.is_object())
            x = j.get<quicktype::Json>();
        else throw std::runtime_error("Could not deserialise!");
    }

    inline void adl_serializer<std::variant<quicktype::Json, int64_t, std::string>>::to_json(json & j, const std::variant<quicktype::Json, int64_t, std::string> & x) {
        switch (x.index()) {
            case 0:
                j = std::get<quicktype::Json>(x);
                break;
            case 1:
                j = std::get<int64_t>(x);
                break;
            case 2:
                j = std::get<std::string>(x);
                break;
            default: throw std::runtime_error("Input JSON does not conform to schema!");
        }
    }
}
