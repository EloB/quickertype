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

    class A {
        public:
        A() = default;
        virtual ~A() = default;

        private:
        std::string _12;
        std::string _13;
        std::string _14;
        std::string _25;
        std::string _7;
        std::string _8;
        std::string _9;
        std::string a;
        std::string a_0;
        std::string a_00;
        std::string a_000;
        std::string a_0000;
        std::string a_1;
        std::string a_10;
        std::string a_100000000;
        std::string a_1_e02;
        std::string a_alert_123_t;
        std::string a_false;
        std::string a_href_java_123456781112_script_javascript_alert_1_xxx_a;
        std::string a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_test;
        std::string a_true;
        std::string abc_div_style_x_exp_x00_ression_javascript_alert_1_def;
        std::string abc_div_style_x_exp_x5_cression_javascript_alert_1_def;
        std::string abc_div_style_x_x09_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x0_bexpression_javascript_alert_1_def;
        std::string abc_div_style_x_x20_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x3_aexpression_javascript_alert_1_def;
        std::string abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def;
        std::string alert_123;
        std::string alert_123_t;
        std::string alert_xss;
        std::string ambitious;
        std::string and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often;
        std::string arsenal_canal;
        std::string autofocus_onkeyup_javascript_alert_123;
        std::string aux;
        std::string braggadocious;
        std::string changing_length_when_lowercased;
        std::string characters_which_increase_in_length_2_to_3_bytes_when_lowercased;
        std::string classic;
        std::string command_injection_ruby;
        std::string cunning;
        std::string d;
        std::string dick_van_dyke;
        bool dont_make_a_map;
        std::string dr_herman_i_libshitz;
        std::string empty;
        std::string env_home;
        std::string etc_hosts;
        std::string etc_passwd_00;
        std::string fluffy;
        std::string fluffy_0;
        std::string fluffy_test;
        std::string fonts_and_have_a_number_of_special_behaviors;
        std::string foo_val_bar;
        std::string frisky;
        std::string hilarious;
        std::string home;
        std::string human_injection;
        std::string i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s;
        std::string if_img_src_x_onerror_javascript_alert_1;
        std::string if_script_javascript_alert_1_script;
        std::string img_src_106971189711599114105112116589710810111411640398883833941;
        std::string img_src_jav_ascript_alert_xss;
        std::string img_src_jav_x0_a_ascript_alert_xss;
        std::string img_src_jav_x0_d_ascript_alert_xss;
        std::string img_src_x09_x_onerror_javascript_alert_1;
        std::string img_src_x11_x_onerror_javascript_alert_1;
        std::string img_src_x_onerror_x00_javascript_alert_1;
        std::string img_src_x_onerror_x09_javascript_alert_1;
        std::string img_src_x_x09_onerror_javascript_alert_1;
        std::string img_src_x_x10_onerror_javascript_alert_1;
        std::string img_src_x_x11_onerror_javascript_alert_1;
        std::string img_src_x_x12_onerror_javascript_alert_1;
        std::string img_src_x_x13_onerror_javascript_alert_1;
        std::string img_src_xxx_x_x00_onerror_javascript_alert_1;
        std::string img_src_xxx_x_x0_bonerror_javascript_alert_1;
        std::string img_src_xxx_x_x2_fonerror_javascript_alert_1;
        std::string img_x00_src_x_onerror_alert_1;
        std::string img_x10_src_x_onerror_javascript_alert_1;
        std::string img_x13_src_x_onerror_javascript_alert_1;
        std::string img_x32_src_x_onerror_javascript_alert_1;
        std::string img_x39_src_x_onerror_javascript_alert_1;
        std::string indecent;
        std::string indigo;
        std::string inf;
        std::string infinity;
        std::string innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem;
        std::string jimmy_clitheroe;
        std::string kernel_exit_1;
        std::string known_cv_es_and_vulnerabilities;
        std::string lightwater_country_park;
        std::string lpt2;
        std::string lpt3;
        std::string ls_al;
        std::string magenta;
        std::string mischievous;
        std::string msdos_windows_special_filenames;
        std::string nil;
        std::string non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f;
        std::string none;
        std::string null;
        std::string onfocus_ja_va_s_cript_alert_123_autofocus;
        std::string or_11;
        std::string penistone_community_church;
        std::string perl_e_print_img_src_java_0_script_alert_xss_out;
        std::string prn;
        std::string purple;
        std::string purple_0;
        std::string purple_1;
        std::string purple_false;
        std::string purple_test;
        std::string purple_true;
        std::string romans_in_sussex_co_uk;
        std::string s;
        std::string s_un_s_u;
        std::string sc_script_ript_alert_123_sc_script_ript;
        std::string script_alert_123_script_x;
        std::string script_injection;
        std::string script_script_alert_123_script;
        std::string script_src_http_ha_ckers_org_xss_js_b;
        std::string script_src_http_ha_ckers_org_xss_js_script;
        std::string script_x00_javascript_alert_1_script;
        std::string script_x09_type_text_javascript_javascript_alert_1_script;
        std::string script_x0_cjavascript_alert_1_script;
        std::string script_x0_djavascript_alert_1_script;
        std::string script_x20_type_text_javascript_javascript_alert_1_script;
        std::string script_x3_etype_text_javascript_javascript_alert_1_script;
        std::string script_x_c2_x85_javascript_alert_1_script;
        std::string script_x_c2_x_a0_javascript_alert_1_script;
        std::string script_x_e1_x9_a_x80_javascript_alert_1_script;
        std::string script_x_e1_x_a0_x8_ejavascript_alert_1_script;
        std::string script_x_e2_x80_x81_javascript_alert_1_script;
        std::string script_x_e2_x80_x86_javascript_alert_1_script;
        std::string script_x_e2_x80_x89_javascript_alert_1_script;
        std::string script_x_e2_x81_x9_fjavascript_alert_1_script;
        std::string script_x_ef_x_bb_x_b_fjavascript_alert_1_script;
        std::string script_x_f0_x90_x96_x9_ajavascript_alert_1_script;
        std::string script_xss_src_http_ha_ckers_org_xss_js_script;
        std::string sql_injection;
        std::string sticky;
        std::string string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser;
        std::string strings_that_test_for_known_vulnerabilities;
        std::string strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string;
        std::string strings_which_can_call_system_commands_within_ruby_rails_applications;
        std::string strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web;
        std::string strings_which_contain_bold_italic_etc_versions_of_normal_characters;
        std::string strings_which_contain_common_unicode_symbols_e_g_smart_quotes;
        std::string strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always;
        std::string strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors;
        std::string strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues;
        std::string strings_which_crashed_i_message_in_various_versions_of_i_os;
        std::string strings_which_may_cause_human_to_reinterpret_worldview;
        std::string super_bowl_xxx;
        std::string tentacled;
        std::string test;
        std::string textarea_script_alert_123_script;
        std::string the_0;
        std::string the_00;
        std::string the_000;
        std::string the_0000;
        std::string the_0_x0;
        std::string the_1;
        std::string the_10;
        std::string the_100;
        std::string the_1000;
        std::string the_100000;
        std::string the_100000000;
        std::string the_11;
        std::string the_12;
        std::string the_123456789012345678901234567890123456789;
        std::string the_15;
        std::string the_16;
        std::string the_17;
        std::string the_18;
        std::string the_19;
        std::string the_1_drop_table_users;
        std::string the_1_e02;
        std::string the_1_e2;
        std::string the_1_qnan;
        std::string the_1_snan;
        std::string the_2;
        std::string the_20;
        std::string the_21;
        std::string the_22;
        std::string the_23;
        std::string the_24;
        std::string the_26;
        std::string the_27;
        std::string the_3;
        std::string the_4;
        std::string the_5;
        std::string the_6;
        std::string the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999;
        std::string the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers;
        std::string the_quic_k_brown_fo_x_beeeep;
        std::string two_byte_characters;
        std::string u_0000_u_000_a_or_u_000_d_nul_lf_cr;
        std::string u_oncopy_alert_copy_me_u;
        std::string undef;
        std::string unicode_font;
        std::string unicode_numbers;
        std::string unwanted_interpolation;
        std::string x_ls_al;
        std::string z_g_o;

        public:
        const std::string & get_12() const { return _12; }
        std::string & get_mutable_12() { return _12; }
        void set_12(const std::string & value) { this->_12 = value; }

        const std::string & get_13() const { return _13; }
        std::string & get_mutable_13() { return _13; }
        void set_13(const std::string & value) { this->_13 = value; }

        const std::string & get_14() const { return _14; }
        std::string & get_mutable_14() { return _14; }
        void set_14(const std::string & value) { this->_14 = value; }

        const std::string & get_25() const { return _25; }
        std::string & get_mutable_25() { return _25; }
        void set_25(const std::string & value) { this->_25 = value; }

        const std::string & get_7() const { return _7; }
        std::string & get_mutable_7() { return _7; }
        void set_7(const std::string & value) { this->_7 = value; }

        const std::string & get_8() const { return _8; }
        std::string & get_mutable_8() { return _8; }
        void set_8(const std::string & value) { this->_8 = value; }

        const std::string & get_9() const { return _9; }
        std::string & get_mutable_9() { return _9; }
        void set_9(const std::string & value) { this->_9 = value; }

        const std::string & get_a() const { return a; }
        std::string & get_mutable_a() { return a; }
        void set_a(const std::string & value) { this->a = value; }

        const std::string & get_a_0() const { return a_0; }
        std::string & get_mutable_a_0() { return a_0; }
        void set_a_0(const std::string & value) { this->a_0 = value; }

        const std::string & get_a_00() const { return a_00; }
        std::string & get_mutable_a_00() { return a_00; }
        void set_a_00(const std::string & value) { this->a_00 = value; }

        const std::string & get_a_000() const { return a_000; }
        std::string & get_mutable_a_000() { return a_000; }
        void set_a_000(const std::string & value) { this->a_000 = value; }

        const std::string & get_a_0000() const { return a_0000; }
        std::string & get_mutable_a_0000() { return a_0000; }
        void set_a_0000(const std::string & value) { this->a_0000 = value; }

        const std::string & get_a_1() const { return a_1; }
        std::string & get_mutable_a_1() { return a_1; }
        void set_a_1(const std::string & value) { this->a_1 = value; }

        const std::string & get_a_10() const { return a_10; }
        std::string & get_mutable_a_10() { return a_10; }
        void set_a_10(const std::string & value) { this->a_10 = value; }

        const std::string & get_a_100000000() const { return a_100000000; }
        std::string & get_mutable_a_100000000() { return a_100000000; }
        void set_a_100000000(const std::string & value) { this->a_100000000 = value; }

        const std::string & get_a_1__e02() const { return a_1_e02; }
        std::string & get_mutable_a_1__e02() { return a_1_e02; }
        void set_a_1__e02(const std::string & value) { this->a_1_e02 = value; }

        const std::string & get_a_alert_123__t() const { return a_alert_123_t; }
        std::string & get_mutable_a_alert_123__t() { return a_alert_123_t; }
        void set_a_alert_123__t(const std::string & value) { this->a_alert_123_t = value; }

        const std::string & get_a_false() const { return a_false; }
        std::string & get_mutable_a_false() { return a_false; }
        void set_a_false(const std::string & value) { this->a_false = value; }

        const std::string & get_a_href_java_123456781112__script_javascript_alert_1__xxx_a() const { return a_href_java_123456781112_script_javascript_alert_1_xxx_a; }
        std::string & get_mutable_a_href_java_123456781112__script_javascript_alert_1__xxx_a() { return a_href_java_123456781112_script_javascript_alert_1_xxx_a; }
        void set_a_href_java_123456781112__script_javascript_alert_1__xxx_a(const std::string & value) { this->a_href_java_123456781112_script_javascript_alert_1_xxx_a = value; }

        const std::string & get_a_href_javascript_x09_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_javascript_x09_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_javascript_x09_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_javascript_x0_a_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_javascript_x0_a_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_javascript_x0_a_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_javascript_x3_a_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_javascript_x3_a_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_javascript_x3_a_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x01_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x01_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x01_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x05_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x05_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x05_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x08_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x08_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x08_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x09_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x09_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x09_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x0_cjavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x0_cjavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x0_cjavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x10_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x10_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x10_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x11_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x11_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x11_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x13_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x13_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x13_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x17_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x17_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x17_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x1_fjavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x1_fjavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x1_fjavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_c2_x_a0_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_c2_x_a0_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_c2_x_a0_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e1_x9_a_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e1_x9_a_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e1_x9_a_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x83_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x83_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x83_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x84_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x84_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x84_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x86_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x86_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x86_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x87_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x87_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x87_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x_a8_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x_a8_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x_a8_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_test() const { return a_test; }
        std::string & get_mutable_a_test() { return a_test; }
        void set_a_test(const std::string & value) { this->a_test = value; }

        const std::string & get_a_true() const { return a_true; }
        std::string & get_mutable_a_true() { return a_true; }
        void set_a_true(const std::string & value) { this->a_true = value; }

        const std::string & get_abc_div_style_x_exp_x00_ression_javascript_alert_1__def() const { return abc_div_style_x_exp_x00_ression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_exp_x00_ression_javascript_alert_1__def() { return abc_div_style_x_exp_x00_ression_javascript_alert_1_def; }
        void set_abc_div_style_x_exp_x00_ression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_exp_x00_ression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_exp_x5_cression_javascript_alert_1__def() const { return abc_div_style_x_exp_x5_cression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_exp_x5_cression_javascript_alert_1__def() { return abc_div_style_x_exp_x5_cression_javascript_alert_1_def; }
        void set_abc_div_style_x_exp_x5_cression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_exp_x5_cression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x09_expression_javascript_alert_1__def() const { return abc_div_style_x_x09_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x09_expression_javascript_alert_1__def() { return abc_div_style_x_x09_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x09_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x09_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x0_bexpression_javascript_alert_1__def() const { return abc_div_style_x_x0_bexpression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x0_bexpression_javascript_alert_1__def() { return abc_div_style_x_x0_bexpression_javascript_alert_1_def; }
        void set_abc_div_style_x_x0_bexpression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x0_bexpression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x20_expression_javascript_alert_1__def() const { return abc_div_style_x_x20_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x20_expression_javascript_alert_1__def() { return abc_div_style_x_x20_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x20_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x20_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x3_aexpression_javascript_alert_1__def() const { return abc_div_style_x_x3_aexpression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x3_aexpression_javascript_alert_1__def() { return abc_div_style_x_x3_aexpression_javascript_alert_1_def; }
        void set_abc_div_style_x_x3_aexpression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x3_aexpression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1__def() const { return abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1__def() { return abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def = value; }

        const std::string & get_alert_123() const { return alert_123; }
        std::string & get_mutable_alert_123() { return alert_123; }
        void set_alert_123(const std::string & value) { this->alert_123 = value; }

        const std::string & get_alert_123__t() const { return alert_123_t; }
        std::string & get_mutable_alert_123__t() { return alert_123_t; }
        void set_alert_123__t(const std::string & value) { this->alert_123_t = value; }

        const std::string & get_alert_xss() const { return alert_xss; }
        std::string & get_mutable_alert_xss() { return alert_xss; }
        void set_alert_xss(const std::string & value) { this->alert_xss = value; }

        const std::string & get_ambitious() const { return ambitious; }
        std::string & get_mutable_ambitious() { return ambitious; }
        void set_ambitious(const std::string & value) { this->ambitious = value; }

        const std::string & get_and_u_200__b_zero_width_space_which_are_in_the_c_categories_but_are_often() const { return and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often; }
        std::string & get_mutable_and_u_200__b_zero_width_space_which_are_in_the_c_categories_but_are_often() { return and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often; }
        void set_and_u_200__b_zero_width_space_which_are_in_the_c_categories_but_are_often(const std::string & value) { this->and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often = value; }

        const std::string & get_arsenal_canal() const { return arsenal_canal; }
        std::string & get_mutable_arsenal_canal() { return arsenal_canal; }
        void set_arsenal_canal(const std::string & value) { this->arsenal_canal = value; }

        const std::string & get_autofocus_onkeyup_javascript_alert_123() const { return autofocus_onkeyup_javascript_alert_123; }
        std::string & get_mutable_autofocus_onkeyup_javascript_alert_123() { return autofocus_onkeyup_javascript_alert_123; }
        void set_autofocus_onkeyup_javascript_alert_123(const std::string & value) { this->autofocus_onkeyup_javascript_alert_123 = value; }

        const std::string & get_aux() const { return aux; }
        std::string & get_mutable_aux() { return aux; }
        void set_aux(const std::string & value) { this->aux = value; }

        const std::string & get_braggadocious() const { return braggadocious; }
        std::string & get_mutable_braggadocious() { return braggadocious; }
        void set_braggadocious(const std::string & value) { this->braggadocious = value; }

        const std::string & get_changing_length_when_lowercased() const { return changing_length_when_lowercased; }
        std::string & get_mutable_changing_length_when_lowercased() { return changing_length_when_lowercased; }
        void set_changing_length_when_lowercased(const std::string & value) { this->changing_length_when_lowercased = value; }

        const std::string & get_characters_which_increase_in_length_2__to_3__bytes_when_lowercased() const { return characters_which_increase_in_length_2_to_3_bytes_when_lowercased; }
        std::string & get_mutable_characters_which_increase_in_length_2__to_3__bytes_when_lowercased() { return characters_which_increase_in_length_2_to_3_bytes_when_lowercased; }
        void set_characters_which_increase_in_length_2__to_3__bytes_when_lowercased(const std::string & value) { this->characters_which_increase_in_length_2_to_3_bytes_when_lowercased = value; }

        const std::string & get_classic() const { return classic; }
        std::string & get_mutable_classic() { return classic; }
        void set_classic(const std::string & value) { this->classic = value; }

        const std::string & get_command_injection_ruby() const { return command_injection_ruby; }
        std::string & get_mutable_command_injection_ruby() { return command_injection_ruby; }
        void set_command_injection_ruby(const std::string & value) { this->command_injection_ruby = value; }

        const std::string & get_cunning() const { return cunning; }
        std::string & get_mutable_cunning() { return cunning; }
        void set_cunning(const std::string & value) { this->cunning = value; }

        const std::string & get_d() const { return d; }
        std::string & get_mutable_d() { return d; }
        void set_d(const std::string & value) { this->d = value; }

        const std::string & get_dick_van_dyke() const { return dick_van_dyke; }
        std::string & get_mutable_dick_van_dyke() { return dick_van_dyke; }
        void set_dick_van_dyke(const std::string & value) { this->dick_van_dyke = value; }

        const bool & get_dont_make_a_map() const { return dont_make_a_map; }
        bool & get_mutable_dont_make_a_map() { return dont_make_a_map; }
        void set_dont_make_a_map(const bool & value) { this->dont_make_a_map = value; }

        const std::string & get_dr_herman_i_libshitz() const { return dr_herman_i_libshitz; }
        std::string & get_mutable_dr_herman_i_libshitz() { return dr_herman_i_libshitz; }
        void set_dr_herman_i_libshitz(const std::string & value) { this->dr_herman_i_libshitz = value; }

        const std::string & get_empty() const { return empty; }
        std::string & get_mutable_empty() { return empty; }
        void set_empty(const std::string & value) { this->empty = value; }

        const std::string & get_env_home() const { return env_home; }
        std::string & get_mutable_env_home() { return env_home; }
        void set_env_home(const std::string & value) { this->env_home = value; }

        const std::string & get_etc_hosts() const { return etc_hosts; }
        std::string & get_mutable_etc_hosts() { return etc_hosts; }
        void set_etc_hosts(const std::string & value) { this->etc_hosts = value; }

        const std::string & get_etc_passwd_00() const { return etc_passwd_00; }
        std::string & get_mutable_etc_passwd_00() { return etc_passwd_00; }
        void set_etc_passwd_00(const std::string & value) { this->etc_passwd_00 = value; }

        const std::string & get_fluffy() const { return fluffy; }
        std::string & get_mutable_fluffy() { return fluffy; }
        void set_fluffy(const std::string & value) { this->fluffy = value; }

        const std::string & get_fluffy_0() const { return fluffy_0; }
        std::string & get_mutable_fluffy_0() { return fluffy_0; }
        void set_fluffy_0(const std::string & value) { this->fluffy_0 = value; }

        const std::string & get_fluffy_test() const { return fluffy_test; }
        std::string & get_mutable_fluffy_test() { return fluffy_test; }
        void set_fluffy_test(const std::string & value) { this->fluffy_test = value; }

        const std::string & get_fonts_and_have_a_number_of_special_behaviors() const { return fonts_and_have_a_number_of_special_behaviors; }
        std::string & get_mutable_fonts_and_have_a_number_of_special_behaviors() { return fonts_and_have_a_number_of_special_behaviors; }
        void set_fonts_and_have_a_number_of_special_behaviors(const std::string & value) { this->fonts_and_have_a_number_of_special_behaviors = value; }

        const std::string & get_foo_val_bar() const { return foo_val_bar; }
        std::string & get_mutable_foo_val_bar() { return foo_val_bar; }
        void set_foo_val_bar(const std::string & value) { this->foo_val_bar = value; }

        const std::string & get_frisky() const { return frisky; }
        std::string & get_mutable_frisky() { return frisky; }
        void set_frisky(const std::string & value) { this->frisky = value; }

        const std::string & get_hilarious() const { return hilarious; }
        std::string & get_mutable_hilarious() { return hilarious; }
        void set_hilarious(const std::string & value) { this->hilarious = value; }

        const std::string & get_home() const { return home; }
        std::string & get_mutable_home() { return home; }
        void set_home(const std::string & value) { this->home = value; }

        const std::string & get_human_injection() const { return human_injection; }
        std::string & get_mutable_human_injection() { return human_injection; }
        void set_human_injection(const std::string & value) { this->human_injection = value; }

        const std::string & get_i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s() const { return i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s; }
        std::string & get_mutable_i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s() { return i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s; }
        void set_i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s(const std::string & value) { this->i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s = value; }

        const std::string & get_if_img_src_x_onerror_javascript_alert_1() const { return if_img_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_if_img_src_x_onerror_javascript_alert_1() { return if_img_src_x_onerror_javascript_alert_1; }
        void set_if_img_src_x_onerror_javascript_alert_1(const std::string & value) { this->if_img_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_if_script_javascript_alert_1__script() const { return if_script_javascript_alert_1_script; }
        std::string & get_mutable_if_script_javascript_alert_1__script() { return if_script_javascript_alert_1_script; }
        void set_if_script_javascript_alert_1__script(const std::string & value) { this->if_script_javascript_alert_1_script = value; }

        const std::string & get_img_src_106971189711599114105112116589710810111411640398883833941() const { return img_src_106971189711599114105112116589710810111411640398883833941; }
        std::string & get_mutable_img_src_106971189711599114105112116589710810111411640398883833941() { return img_src_106971189711599114105112116589710810111411640398883833941; }
        void set_img_src_106971189711599114105112116589710810111411640398883833941(const std::string & value) { this->img_src_106971189711599114105112116589710810111411640398883833941 = value; }

        const std::string & get_img_src_jav_ascript_alert_xss() const { return img_src_jav_ascript_alert_xss; }
        std::string & get_mutable_img_src_jav_ascript_alert_xss() { return img_src_jav_ascript_alert_xss; }
        void set_img_src_jav_ascript_alert_xss(const std::string & value) { this->img_src_jav_ascript_alert_xss = value; }

        const std::string & get_img_src_jav_x0_a_ascript_alert_xss() const { return img_src_jav_x0_a_ascript_alert_xss; }
        std::string & get_mutable_img_src_jav_x0_a_ascript_alert_xss() { return img_src_jav_x0_a_ascript_alert_xss; }
        void set_img_src_jav_x0_a_ascript_alert_xss(const std::string & value) { this->img_src_jav_x0_a_ascript_alert_xss = value; }

        const std::string & get_img_src_jav_x0_d_ascript_alert_xss() const { return img_src_jav_x0_d_ascript_alert_xss; }
        std::string & get_mutable_img_src_jav_x0_d_ascript_alert_xss() { return img_src_jav_x0_d_ascript_alert_xss; }
        void set_img_src_jav_x0_d_ascript_alert_xss(const std::string & value) { this->img_src_jav_x0_d_ascript_alert_xss = value; }

        const std::string & get_img_src_x09_x_onerror_javascript_alert_1() const { return img_src_x09_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x09_x_onerror_javascript_alert_1() { return img_src_x09_x_onerror_javascript_alert_1; }
        void set_img_src_x09_x_onerror_javascript_alert_1(const std::string & value) { this->img_src_x09_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x11_x_onerror_javascript_alert_1() const { return img_src_x11_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x11_x_onerror_javascript_alert_1() { return img_src_x11_x_onerror_javascript_alert_1; }
        void set_img_src_x11_x_onerror_javascript_alert_1(const std::string & value) { this->img_src_x11_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x_onerror_x00_javascript_alert_1() const { return img_src_x_onerror_x00_javascript_alert_1; }
        std::string & get_mutable_img_src_x_onerror_x00_javascript_alert_1() { return img_src_x_onerror_x00_javascript_alert_1; }
        void set_img_src_x_onerror_x00_javascript_alert_1(const std::string & value) { this->img_src_x_onerror_x00_javascript_alert_1 = value; }

        const std::string & get_img_src_x_onerror_x09_javascript_alert_1() const { return img_src_x_onerror_x09_javascript_alert_1; }
        std::string & get_mutable_img_src_x_onerror_x09_javascript_alert_1() { return img_src_x_onerror_x09_javascript_alert_1; }
        void set_img_src_x_onerror_x09_javascript_alert_1(const std::string & value) { this->img_src_x_onerror_x09_javascript_alert_1 = value; }

        const std::string & get_img_src_x_x09_onerror_javascript_alert_1() const { return img_src_x_x09_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x_x09_onerror_javascript_alert_1() { return img_src_x_x09_onerror_javascript_alert_1; }
        void set_img_src_x_x09_onerror_javascript_alert_1(const std::string & value) { this->img_src_x_x09_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x_x10_onerror_javascript_alert_1() const { return img_src_x_x10_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x_x10_onerror_javascript_alert_1() { return img_src_x_x10_onerror_javascript_alert_1; }
        void set_img_src_x_x10_onerror_javascript_alert_1(const std::string & value) { this->img_src_x_x10_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x_x11_onerror_javascript_alert_1() const { return img_src_x_x11_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x_x11_onerror_javascript_alert_1() { return img_src_x_x11_onerror_javascript_alert_1; }
        void set_img_src_x_x11_onerror_javascript_alert_1(const std::string & value) { this->img_src_x_x11_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x_x12_onerror_javascript_alert_1() const { return img_src_x_x12_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x_x12_onerror_javascript_alert_1() { return img_src_x_x12_onerror_javascript_alert_1; }
        void set_img_src_x_x12_onerror_javascript_alert_1(const std::string & value) { this->img_src_x_x12_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x_x13_onerror_javascript_alert_1() const { return img_src_x_x13_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x_x13_onerror_javascript_alert_1() { return img_src_x_x13_onerror_javascript_alert_1; }
        void set_img_src_x_x13_onerror_javascript_alert_1(const std::string & value) { this->img_src_x_x13_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x00_onerror_javascript_alert_1() const { return img_src_xxx_x_x00_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x00_onerror_javascript_alert_1() { return img_src_xxx_x_x00_onerror_javascript_alert_1; }
        void set_img_src_xxx_x_x00_onerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x00_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x0_bonerror_javascript_alert_1() const { return img_src_xxx_x_x0_bonerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x0_bonerror_javascript_alert_1() { return img_src_xxx_x_x0_bonerror_javascript_alert_1; }
        void set_img_src_xxx_x_x0_bonerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x0_bonerror_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x2_fonerror_javascript_alert_1() const { return img_src_xxx_x_x2_fonerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x2_fonerror_javascript_alert_1() { return img_src_xxx_x_x2_fonerror_javascript_alert_1; }
        void set_img_src_xxx_x_x2_fonerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x2_fonerror_javascript_alert_1 = value; }

        const std::string & get_img_x00_src_x_onerror_alert_1() const { return img_x00_src_x_onerror_alert_1; }
        std::string & get_mutable_img_x00_src_x_onerror_alert_1() { return img_x00_src_x_onerror_alert_1; }
        void set_img_x00_src_x_onerror_alert_1(const std::string & value) { this->img_x00_src_x_onerror_alert_1 = value; }

        const std::string & get_img_x10_src_x_onerror_javascript_alert_1() const { return img_x10_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x10_src_x_onerror_javascript_alert_1() { return img_x10_src_x_onerror_javascript_alert_1; }
        void set_img_x10_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x10_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x13_src_x_onerror_javascript_alert_1() const { return img_x13_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x13_src_x_onerror_javascript_alert_1() { return img_x13_src_x_onerror_javascript_alert_1; }
        void set_img_x13_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x13_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x32_src_x_onerror_javascript_alert_1() const { return img_x32_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x32_src_x_onerror_javascript_alert_1() { return img_x32_src_x_onerror_javascript_alert_1; }
        void set_img_x32_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x32_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x39_src_x_onerror_javascript_alert_1() const { return img_x39_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x39_src_x_onerror_javascript_alert_1() { return img_x39_src_x_onerror_javascript_alert_1; }
        void set_img_x39_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x39_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_indecent() const { return indecent; }
        std::string & get_mutable_indecent() { return indecent; }
        void set_indecent(const std::string & value) { this->indecent = value; }

        const std::string & get_indigo() const { return indigo; }
        std::string & get_mutable_indigo() { return indigo; }
        void set_indigo(const std::string & value) { this->indigo = value; }

        const std::string & get_inf() const { return inf; }
        std::string & get_mutable_inf() { return inf; }
        void set_inf(const std::string & value) { this->inf = value; }

        const std::string & get_infinity() const { return infinity; }
        std::string & get_mutable_infinity() { return infinity; }
        void set_infinity(const std::string & value) { this->infinity = value; }

        const std::string & get_innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem() const { return innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem; }
        std::string & get_mutable_innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem() { return innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem; }
        void set_innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem(const std::string & value) { this->innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem = value; }

        const std::string & get_jimmy_clitheroe() const { return jimmy_clitheroe; }
        std::string & get_mutable_jimmy_clitheroe() { return jimmy_clitheroe; }
        void set_jimmy_clitheroe(const std::string & value) { this->jimmy_clitheroe = value; }

        const std::string & get_kernel_exit_1() const { return kernel_exit_1; }
        std::string & get_mutable_kernel_exit_1() { return kernel_exit_1; }
        void set_kernel_exit_1(const std::string & value) { this->kernel_exit_1 = value; }

        const std::string & get_known_cv_es_and_vulnerabilities() const { return known_cv_es_and_vulnerabilities; }
        std::string & get_mutable_known_cv_es_and_vulnerabilities() { return known_cv_es_and_vulnerabilities; }
        void set_known_cv_es_and_vulnerabilities(const std::string & value) { this->known_cv_es_and_vulnerabilities = value; }

        const std::string & get_lightwater_country_park() const { return lightwater_country_park; }
        std::string & get_mutable_lightwater_country_park() { return lightwater_country_park; }
        void set_lightwater_country_park(const std::string & value) { this->lightwater_country_park = value; }

        const std::string & get_lpt2() const { return lpt2; }
        std::string & get_mutable_lpt2() { return lpt2; }
        void set_lpt2(const std::string & value) { this->lpt2 = value; }

        const std::string & get_lpt3() const { return lpt3; }
        std::string & get_mutable_lpt3() { return lpt3; }
        void set_lpt3(const std::string & value) { this->lpt3 = value; }

        const std::string & get_ls_al() const { return ls_al; }
        std::string & get_mutable_ls_al() { return ls_al; }
        void set_ls_al(const std::string & value) { this->ls_al = value; }

        const std::string & get_magenta() const { return magenta; }
        std::string & get_mutable_magenta() { return magenta; }
        void set_magenta(const std::string & value) { this->magenta = value; }

        const std::string & get_mischievous() const { return mischievous; }
        std::string & get_mutable_mischievous() { return mischievous; }
        void set_mischievous(const std::string & value) { this->mischievous = value; }

        const std::string & get_msdos_windows_special_filenames() const { return msdos_windows_special_filenames; }
        std::string & get_mutable_msdos_windows_special_filenames() { return msdos_windows_special_filenames; }
        void set_msdos_windows_special_filenames(const std::string & value) { this->msdos_windows_special_filenames = value; }

        const std::string & get_nil() const { return nil; }
        std::string & get_mutable_nil() { return nil; }
        void set_nil(const std::string & value) { this->nil = value; }

        const std::string & get_non_whitespace_c1_controls_u_0080__through_u_0084__and_u_0086__through_u_009__f() const { return non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f; }
        std::string & get_mutable_non_whitespace_c1_controls_u_0080__through_u_0084__and_u_0086__through_u_009__f() { return non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f; }
        void set_non_whitespace_c1_controls_u_0080__through_u_0084__and_u_0086__through_u_009__f(const std::string & value) { this->non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f = value; }

        const std::string & get_none() const { return none; }
        std::string & get_mutable_none() { return none; }
        void set_none(const std::string & value) { this->none = value; }

        const std::string & get_null() const { return null; }
        std::string & get_mutable_null() { return null; }
        void set_null(const std::string & value) { this->null = value; }

        const std::string & get_onfocus_ja_va_s_cript_alert_123__autofocus() const { return onfocus_ja_va_s_cript_alert_123_autofocus; }
        std::string & get_mutable_onfocus_ja_va_s_cript_alert_123__autofocus() { return onfocus_ja_va_s_cript_alert_123_autofocus; }
        void set_onfocus_ja_va_s_cript_alert_123__autofocus(const std::string & value) { this->onfocus_ja_va_s_cript_alert_123_autofocus = value; }

        const std::string & get_or_11() const { return or_11; }
        std::string & get_mutable_or_11() { return or_11; }
        void set_or_11(const std::string & value) { this->or_11 = value; }

        const std::string & get_penistone_community_church() const { return penistone_community_church; }
        std::string & get_mutable_penistone_community_church() { return penistone_community_church; }
        void set_penistone_community_church(const std::string & value) { this->penistone_community_church = value; }

        const std::string & get_perl_e_print_img_src_java_0__script_alert_xss_out() const { return perl_e_print_img_src_java_0_script_alert_xss_out; }
        std::string & get_mutable_perl_e_print_img_src_java_0__script_alert_xss_out() { return perl_e_print_img_src_java_0_script_alert_xss_out; }
        void set_perl_e_print_img_src_java_0__script_alert_xss_out(const std::string & value) { this->perl_e_print_img_src_java_0_script_alert_xss_out = value; }

        const std::string & get_prn() const { return prn; }
        std::string & get_mutable_prn() { return prn; }
        void set_prn(const std::string & value) { this->prn = value; }

        const std::string & get_purple() const { return purple; }
        std::string & get_mutable_purple() { return purple; }
        void set_purple(const std::string & value) { this->purple = value; }

        const std::string & get_purple_0() const { return purple_0; }
        std::string & get_mutable_purple_0() { return purple_0; }
        void set_purple_0(const std::string & value) { this->purple_0 = value; }

        const std::string & get_purple_1() const { return purple_1; }
        std::string & get_mutable_purple_1() { return purple_1; }
        void set_purple_1(const std::string & value) { this->purple_1 = value; }

        const std::string & get_purple_false() const { return purple_false; }
        std::string & get_mutable_purple_false() { return purple_false; }
        void set_purple_false(const std::string & value) { this->purple_false = value; }

        const std::string & get_purple_test() const { return purple_test; }
        std::string & get_mutable_purple_test() { return purple_test; }
        void set_purple_test(const std::string & value) { this->purple_test = value; }

        const std::string & get_purple_true() const { return purple_true; }
        std::string & get_mutable_purple_true() { return purple_true; }
        void set_purple_true(const std::string & value) { this->purple_true = value; }

        const std::string & get_romans_in_sussex_co_uk() const { return romans_in_sussex_co_uk; }
        std::string & get_mutable_romans_in_sussex_co_uk() { return romans_in_sussex_co_uk; }
        void set_romans_in_sussex_co_uk(const std::string & value) { this->romans_in_sussex_co_uk = value; }

        const std::string & get_s() const { return s; }
        std::string & get_mutable_s() { return s; }
        void set_s(const std::string & value) { this->s = value; }

        const std::string & get_s_un_s_u() const { return s_un_s_u; }
        std::string & get_mutable_s_un_s_u() { return s_un_s_u; }
        void set_s_un_s_u(const std::string & value) { this->s_un_s_u = value; }

        const std::string & get_sc_script_ript_alert_123__sc_script_ript() const { return sc_script_ript_alert_123_sc_script_ript; }
        std::string & get_mutable_sc_script_ript_alert_123__sc_script_ript() { return sc_script_ript_alert_123_sc_script_ript; }
        void set_sc_script_ript_alert_123__sc_script_ript(const std::string & value) { this->sc_script_ript_alert_123_sc_script_ript = value; }

        const std::string & get_script_alert_123__script_x() const { return script_alert_123_script_x; }
        std::string & get_mutable_script_alert_123__script_x() { return script_alert_123_script_x; }
        void set_script_alert_123__script_x(const std::string & value) { this->script_alert_123_script_x = value; }

        const std::string & get_script_injection() const { return script_injection; }
        std::string & get_mutable_script_injection() { return script_injection; }
        void set_script_injection(const std::string & value) { this->script_injection = value; }

        const std::string & get_script_script_alert_123__script() const { return script_script_alert_123_script; }
        std::string & get_mutable_script_script_alert_123__script() { return script_script_alert_123_script; }
        void set_script_script_alert_123__script(const std::string & value) { this->script_script_alert_123_script = value; }

        const std::string & get_script_src_http_ha_ckers_org_xss_js_b() const { return script_src_http_ha_ckers_org_xss_js_b; }
        std::string & get_mutable_script_src_http_ha_ckers_org_xss_js_b() { return script_src_http_ha_ckers_org_xss_js_b; }
        void set_script_src_http_ha_ckers_org_xss_js_b(const std::string & value) { this->script_src_http_ha_ckers_org_xss_js_b = value; }

        const std::string & get_script_src_http_ha_ckers_org_xss_js_script() const { return script_src_http_ha_ckers_org_xss_js_script; }
        std::string & get_mutable_script_src_http_ha_ckers_org_xss_js_script() { return script_src_http_ha_ckers_org_xss_js_script; }
        void set_script_src_http_ha_ckers_org_xss_js_script(const std::string & value) { this->script_src_http_ha_ckers_org_xss_js_script = value; }

        const std::string & get_script_x00_javascript_alert_1__script() const { return script_x00_javascript_alert_1_script; }
        std::string & get_mutable_script_x00_javascript_alert_1__script() { return script_x00_javascript_alert_1_script; }
        void set_script_x00_javascript_alert_1__script(const std::string & value) { this->script_x00_javascript_alert_1_script = value; }

        const std::string & get_script_x09_type_text_javascript_javascript_alert_1__script() const { return script_x09_type_text_javascript_javascript_alert_1_script; }
        std::string & get_mutable_script_x09_type_text_javascript_javascript_alert_1__script() { return script_x09_type_text_javascript_javascript_alert_1_script; }
        void set_script_x09_type_text_javascript_javascript_alert_1__script(const std::string & value) { this->script_x09_type_text_javascript_javascript_alert_1_script = value; }

        const std::string & get_script_x0_cjavascript_alert_1__script() const { return script_x0_cjavascript_alert_1_script; }
        std::string & get_mutable_script_x0_cjavascript_alert_1__script() { return script_x0_cjavascript_alert_1_script; }
        void set_script_x0_cjavascript_alert_1__script(const std::string & value) { this->script_x0_cjavascript_alert_1_script = value; }

        const std::string & get_script_x0_djavascript_alert_1__script() const { return script_x0_djavascript_alert_1_script; }
        std::string & get_mutable_script_x0_djavascript_alert_1__script() { return script_x0_djavascript_alert_1_script; }
        void set_script_x0_djavascript_alert_1__script(const std::string & value) { this->script_x0_djavascript_alert_1_script = value; }

        const std::string & get_script_x20_type_text_javascript_javascript_alert_1__script() const { return script_x20_type_text_javascript_javascript_alert_1_script; }
        std::string & get_mutable_script_x20_type_text_javascript_javascript_alert_1__script() { return script_x20_type_text_javascript_javascript_alert_1_script; }
        void set_script_x20_type_text_javascript_javascript_alert_1__script(const std::string & value) { this->script_x20_type_text_javascript_javascript_alert_1_script = value; }

        const std::string & get_script_x3_etype_text_javascript_javascript_alert_1__script() const { return script_x3_etype_text_javascript_javascript_alert_1_script; }
        std::string & get_mutable_script_x3_etype_text_javascript_javascript_alert_1__script() { return script_x3_etype_text_javascript_javascript_alert_1_script; }
        void set_script_x3_etype_text_javascript_javascript_alert_1__script(const std::string & value) { this->script_x3_etype_text_javascript_javascript_alert_1_script = value; }

        const std::string & get_script_x_c2_x85_javascript_alert_1__script() const { return script_x_c2_x85_javascript_alert_1_script; }
        std::string & get_mutable_script_x_c2_x85_javascript_alert_1__script() { return script_x_c2_x85_javascript_alert_1_script; }
        void set_script_x_c2_x85_javascript_alert_1__script(const std::string & value) { this->script_x_c2_x85_javascript_alert_1_script = value; }

        const std::string & get_script_x_c2_x_a0_javascript_alert_1__script() const { return script_x_c2_x_a0_javascript_alert_1_script; }
        std::string & get_mutable_script_x_c2_x_a0_javascript_alert_1__script() { return script_x_c2_x_a0_javascript_alert_1_script; }
        void set_script_x_c2_x_a0_javascript_alert_1__script(const std::string & value) { this->script_x_c2_x_a0_javascript_alert_1_script = value; }

        const std::string & get_script_x_e1_x9_a_x80_javascript_alert_1__script() const { return script_x_e1_x9_a_x80_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e1_x9_a_x80_javascript_alert_1__script() { return script_x_e1_x9_a_x80_javascript_alert_1_script; }
        void set_script_x_e1_x9_a_x80_javascript_alert_1__script(const std::string & value) { this->script_x_e1_x9_a_x80_javascript_alert_1_script = value; }

        const std::string & get_script_x_e1_x_a0_x8_ejavascript_alert_1__script() const { return script_x_e1_x_a0_x8_ejavascript_alert_1_script; }
        std::string & get_mutable_script_x_e1_x_a0_x8_ejavascript_alert_1__script() { return script_x_e1_x_a0_x8_ejavascript_alert_1_script; }
        void set_script_x_e1_x_a0_x8_ejavascript_alert_1__script(const std::string & value) { this->script_x_e1_x_a0_x8_ejavascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x81_javascript_alert_1__script() const { return script_x_e2_x80_x81_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x81_javascript_alert_1__script() { return script_x_e2_x80_x81_javascript_alert_1_script; }
        void set_script_x_e2_x80_x81_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x81_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x86_javascript_alert_1__script() const { return script_x_e2_x80_x86_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x86_javascript_alert_1__script() { return script_x_e2_x80_x86_javascript_alert_1_script; }
        void set_script_x_e2_x80_x86_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x86_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x89_javascript_alert_1__script() const { return script_x_e2_x80_x89_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x89_javascript_alert_1__script() { return script_x_e2_x80_x89_javascript_alert_1_script; }
        void set_script_x_e2_x80_x89_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x89_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x81_x9_fjavascript_alert_1__script() const { return script_x_e2_x81_x9_fjavascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x81_x9_fjavascript_alert_1__script() { return script_x_e2_x81_x9_fjavascript_alert_1_script; }
        void set_script_x_e2_x81_x9_fjavascript_alert_1__script(const std::string & value) { this->script_x_e2_x81_x9_fjavascript_alert_1_script = value; }

        const std::string & get_script_x_ef_x_bb_x_b_fjavascript_alert_1__script() const { return script_x_ef_x_bb_x_b_fjavascript_alert_1_script; }
        std::string & get_mutable_script_x_ef_x_bb_x_b_fjavascript_alert_1__script() { return script_x_ef_x_bb_x_b_fjavascript_alert_1_script; }
        void set_script_x_ef_x_bb_x_b_fjavascript_alert_1__script(const std::string & value) { this->script_x_ef_x_bb_x_b_fjavascript_alert_1_script = value; }

        const std::string & get_script_x_f0_x90_x96_x9_ajavascript_alert_1__script() const { return script_x_f0_x90_x96_x9_ajavascript_alert_1_script; }
        std::string & get_mutable_script_x_f0_x90_x96_x9_ajavascript_alert_1__script() { return script_x_f0_x90_x96_x9_ajavascript_alert_1_script; }
        void set_script_x_f0_x90_x96_x9_ajavascript_alert_1__script(const std::string & value) { this->script_x_f0_x90_x96_x9_ajavascript_alert_1_script = value; }

        const std::string & get_script_xss_src_http_ha_ckers_org_xss_js_script() const { return script_xss_src_http_ha_ckers_org_xss_js_script; }
        std::string & get_mutable_script_xss_src_http_ha_ckers_org_xss_js_script() { return script_xss_src_http_ha_ckers_org_xss_js_script; }
        void set_script_xss_src_http_ha_ckers_org_xss_js_script(const std::string & value) { this->script_xss_src_http_ha_ckers_org_xss_js_script = value; }

        const std::string & get_sql_injection() const { return sql_injection; }
        std::string & get_mutable_sql_injection() { return sql_injection; }
        void set_sql_injection(const std::string & value) { this->sql_injection = value; }

        const std::string & get_sticky() const { return sticky; }
        std::string & get_mutable_sticky() { return sticky; }
        void set_sticky(const std::string & value) { this->sticky = value; }

        const std::string & get_string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser() const { return string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser; }
        std::string & get_mutable_string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser() { return string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser; }
        void set_string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser(const std::string & value) { this->string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser = value; }

        const std::string & get_strings_that_test_for_known_vulnerabilities() const { return strings_that_test_for_known_vulnerabilities; }
        std::string & get_mutable_strings_that_test_for_known_vulnerabilities() { return strings_that_test_for_known_vulnerabilities; }
        void set_strings_that_test_for_known_vulnerabilities(const std::string & value) { this->strings_that_test_for_known_vulnerabilities = value; }

        const std::string & get_strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string() const { return strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string; }
        std::string & get_mutable_strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string() { return strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string; }
        void set_strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string(const std::string & value) { this->strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string = value; }

        const std::string & get_strings_which_can_call_system_commands_within_ruby_rails_applications() const { return strings_which_can_call_system_commands_within_ruby_rails_applications; }
        std::string & get_mutable_strings_which_can_call_system_commands_within_ruby_rails_applications() { return strings_which_can_call_system_commands_within_ruby_rails_applications; }
        void set_strings_which_can_call_system_commands_within_ruby_rails_applications(const std::string & value) { this->strings_which_can_call_system_commands_within_ruby_rails_applications = value; }

        const std::string & get_strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web() const { return strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web; }
        std::string & get_mutable_strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web() { return strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web; }
        void set_strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web(const std::string & value) { this->strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web = value; }

        const std::string & get_strings_which_contain_bold_italic_etc_versions_of_normal_characters() const { return strings_which_contain_bold_italic_etc_versions_of_normal_characters; }
        std::string & get_mutable_strings_which_contain_bold_italic_etc_versions_of_normal_characters() { return strings_which_contain_bold_italic_etc_versions_of_normal_characters; }
        void set_strings_which_contain_bold_italic_etc_versions_of_normal_characters(const std::string & value) { this->strings_which_contain_bold_italic_etc_versions_of_normal_characters = value; }

        const std::string & get_strings_which_contain_common_unicode_symbols_e_g_smart_quotes() const { return strings_which_contain_common_unicode_symbols_e_g_smart_quotes; }
        std::string & get_mutable_strings_which_contain_common_unicode_symbols_e_g_smart_quotes() { return strings_which_contain_common_unicode_symbols_e_g_smart_quotes; }
        void set_strings_which_contain_common_unicode_symbols_e_g_smart_quotes(const std::string & value) { this->strings_which_contain_common_unicode_symbols_e_g_smart_quotes = value; }

        const std::string & get_strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always() const { return strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always; }
        std::string & get_mutable_strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always() { return strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always; }
        void set_strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always(const std::string & value) { this->strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always = value; }

        const std::string & get_strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors() const { return strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors; }
        std::string & get_mutable_strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors() { return strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors; }
        void set_strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors(const std::string & value) { this->strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors = value; }

        const std::string & get_strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues() const { return strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues; }
        std::string & get_mutable_strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues() { return strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues; }
        void set_strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues(const std::string & value) { this->strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues = value; }

        const std::string & get_strings_which_crashed_i_message_in_various_versions_of_i_os() const { return strings_which_crashed_i_message_in_various_versions_of_i_os; }
        std::string & get_mutable_strings_which_crashed_i_message_in_various_versions_of_i_os() { return strings_which_crashed_i_message_in_various_versions_of_i_os; }
        void set_strings_which_crashed_i_message_in_various_versions_of_i_os(const std::string & value) { this->strings_which_crashed_i_message_in_various_versions_of_i_os = value; }

        const std::string & get_strings_which_may_cause_human_to_reinterpret_worldview() const { return strings_which_may_cause_human_to_reinterpret_worldview; }
        std::string & get_mutable_strings_which_may_cause_human_to_reinterpret_worldview() { return strings_which_may_cause_human_to_reinterpret_worldview; }
        void set_strings_which_may_cause_human_to_reinterpret_worldview(const std::string & value) { this->strings_which_may_cause_human_to_reinterpret_worldview = value; }

        const std::string & get_super_bowl_xxx() const { return super_bowl_xxx; }
        std::string & get_mutable_super_bowl_xxx() { return super_bowl_xxx; }
        void set_super_bowl_xxx(const std::string & value) { this->super_bowl_xxx = value; }

        const std::string & get_tentacled() const { return tentacled; }
        std::string & get_mutable_tentacled() { return tentacled; }
        void set_tentacled(const std::string & value) { this->tentacled = value; }

        const std::string & get_test() const { return test; }
        std::string & get_mutable_test() { return test; }
        void set_test(const std::string & value) { this->test = value; }

        const std::string & get_textarea_script_alert_123__script() const { return textarea_script_alert_123_script; }
        std::string & get_mutable_textarea_script_alert_123__script() { return textarea_script_alert_123_script; }
        void set_textarea_script_alert_123__script(const std::string & value) { this->textarea_script_alert_123_script = value; }

        const std::string & get_the_0() const { return the_0; }
        std::string & get_mutable_the_0() { return the_0; }
        void set_the_0(const std::string & value) { this->the_0 = value; }

        const std::string & get_the_00() const { return the_00; }
        std::string & get_mutable_the_00() { return the_00; }
        void set_the_00(const std::string & value) { this->the_00 = value; }

        const std::string & get_the_000() const { return the_000; }
        std::string & get_mutable_the_000() { return the_000; }
        void set_the_000(const std::string & value) { this->the_000 = value; }

        const std::string & get_the_0000() const { return the_0000; }
        std::string & get_mutable_the_0000() { return the_0000; }
        void set_the_0000(const std::string & value) { this->the_0000 = value; }

        const std::string & get_the_0__x0() const { return the_0_x0; }
        std::string & get_mutable_the_0__x0() { return the_0_x0; }
        void set_the_0__x0(const std::string & value) { this->the_0_x0 = value; }

        const std::string & get_the_1() const { return the_1; }
        std::string & get_mutable_the_1() { return the_1; }
        void set_the_1(const std::string & value) { this->the_1 = value; }

        const std::string & get_the_10() const { return the_10; }
        std::string & get_mutable_the_10() { return the_10; }
        void set_the_10(const std::string & value) { this->the_10 = value; }

        const std::string & get_the_100() const { return the_100; }
        std::string & get_mutable_the_100() { return the_100; }
        void set_the_100(const std::string & value) { this->the_100 = value; }

        const std::string & get_the_1000() const { return the_1000; }
        std::string & get_mutable_the_1000() { return the_1000; }
        void set_the_1000(const std::string & value) { this->the_1000 = value; }

        const std::string & get_the_100000() const { return the_100000; }
        std::string & get_mutable_the_100000() { return the_100000; }
        void set_the_100000(const std::string & value) { this->the_100000 = value; }

        const std::string & get_the_100000000() const { return the_100000000; }
        std::string & get_mutable_the_100000000() { return the_100000000; }
        void set_the_100000000(const std::string & value) { this->the_100000000 = value; }

        const std::string & get_the_11() const { return the_11; }
        std::string & get_mutable_the_11() { return the_11; }
        void set_the_11(const std::string & value) { this->the_11 = value; }

        const std::string & get_the_12() const { return the_12; }
        std::string & get_mutable_the_12() { return the_12; }
        void set_the_12(const std::string & value) { this->the_12 = value; }

        const std::string & get_the_123456789012345678901234567890123456789() const { return the_123456789012345678901234567890123456789; }
        std::string & get_mutable_the_123456789012345678901234567890123456789() { return the_123456789012345678901234567890123456789; }
        void set_the_123456789012345678901234567890123456789(const std::string & value) { this->the_123456789012345678901234567890123456789 = value; }

        const std::string & get_the_15() const { return the_15; }
        std::string & get_mutable_the_15() { return the_15; }
        void set_the_15(const std::string & value) { this->the_15 = value; }

        const std::string & get_the_16() const { return the_16; }
        std::string & get_mutable_the_16() { return the_16; }
        void set_the_16(const std::string & value) { this->the_16 = value; }

        const std::string & get_the_17() const { return the_17; }
        std::string & get_mutable_the_17() { return the_17; }
        void set_the_17(const std::string & value) { this->the_17 = value; }

        const std::string & get_the_18() const { return the_18; }
        std::string & get_mutable_the_18() { return the_18; }
        void set_the_18(const std::string & value) { this->the_18 = value; }

        const std::string & get_the_19() const { return the_19; }
        std::string & get_mutable_the_19() { return the_19; }
        void set_the_19(const std::string & value) { this->the_19 = value; }

        const std::string & get_the_1__drop_table_users() const { return the_1_drop_table_users; }
        std::string & get_mutable_the_1__drop_table_users() { return the_1_drop_table_users; }
        void set_the_1__drop_table_users(const std::string & value) { this->the_1_drop_table_users = value; }

        const std::string & get_the_1__e02() const { return the_1_e02; }
        std::string & get_mutable_the_1__e02() { return the_1_e02; }
        void set_the_1__e02(const std::string & value) { this->the_1_e02 = value; }

        const std::string & get_the_1__e2() const { return the_1_e2; }
        std::string & get_mutable_the_1__e2() { return the_1_e2; }
        void set_the_1__e2(const std::string & value) { this->the_1_e2 = value; }

        const std::string & get_the_1__qnan() const { return the_1_qnan; }
        std::string & get_mutable_the_1__qnan() { return the_1_qnan; }
        void set_the_1__qnan(const std::string & value) { this->the_1_qnan = value; }

        const std::string & get_the_1__snan() const { return the_1_snan; }
        std::string & get_mutable_the_1__snan() { return the_1_snan; }
        void set_the_1__snan(const std::string & value) { this->the_1_snan = value; }

        const std::string & get_the_2() const { return the_2; }
        std::string & get_mutable_the_2() { return the_2; }
        void set_the_2(const std::string & value) { this->the_2 = value; }

        const std::string & get_the_20() const { return the_20; }
        std::string & get_mutable_the_20() { return the_20; }
        void set_the_20(const std::string & value) { this->the_20 = value; }

        const std::string & get_the_21() const { return the_21; }
        std::string & get_mutable_the_21() { return the_21; }
        void set_the_21(const std::string & value) { this->the_21 = value; }

        const std::string & get_the_22() const { return the_22; }
        std::string & get_mutable_the_22() { return the_22; }
        void set_the_22(const std::string & value) { this->the_22 = value; }

        const std::string & get_the_23() const { return the_23; }
        std::string & get_mutable_the_23() { return the_23; }
        void set_the_23(const std::string & value) { this->the_23 = value; }

        const std::string & get_the_24() const { return the_24; }
        std::string & get_mutable_the_24() { return the_24; }
        void set_the_24(const std::string & value) { this->the_24 = value; }

        const std::string & get_the_26() const { return the_26; }
        std::string & get_mutable_the_26() { return the_26; }
        void set_the_26(const std::string & value) { this->the_26 = value; }

        const std::string & get_the_27() const { return the_27; }
        std::string & get_mutable_the_27() { return the_27; }
        void set_the_27(const std::string & value) { this->the_27 = value; }

        const std::string & get_the_3() const { return the_3; }
        std::string & get_mutable_the_3() { return the_3; }
        void set_the_3(const std::string & value) { this->the_3 = value; }

        const std::string & get_the_4() const { return the_4; }
        std::string & get_mutable_the_4() { return the_4; }
        void set_the_4(const std::string & value) { this->the_4 = value; }

        const std::string & get_the_5() const { return the_5; }
        std::string & get_mutable_the_5() { return the_5; }
        void set_the_5(const std::string & value) { this->the_5 = value; }

        const std::string & get_the_6() const { return the_6; }
        std::string & get_mutable_the_6() { return the_6; }
        void set_the_6(const std::string & value) { this->the_6 = value; }

        const std::string & get_the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999() const { return the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999; }
        std::string & get_mutable_the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999() { return the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999; }
        void set_the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999(const std::string & value) { this->the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 = value; }

        const std::string & get_the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers() const { return the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers; }
        std::string & get_mutable_the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers() { return the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers; }
        void set_the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers(const std::string & value) { this->the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers = value; }

        const std::string & get_the_quic_k_brown_fo_x_beeeep() const { return the_quic_k_brown_fo_x_beeeep; }
        std::string & get_mutable_the_quic_k_brown_fo_x_beeeep() { return the_quic_k_brown_fo_x_beeeep; }
        void set_the_quic_k_brown_fo_x_beeeep(const std::string & value) { this->the_quic_k_brown_fo_x_beeeep = value; }

        const std::string & get_two_byte_characters() const { return two_byte_characters; }
        std::string & get_mutable_two_byte_characters() { return two_byte_characters; }
        void set_two_byte_characters(const std::string & value) { this->two_byte_characters = value; }

        const std::string & get_u_0000__u_000__a_or_u_000__d_nul_lf_cr() const { return u_0000_u_000_a_or_u_000_d_nul_lf_cr; }
        std::string & get_mutable_u_0000__u_000__a_or_u_000__d_nul_lf_cr() { return u_0000_u_000_a_or_u_000_d_nul_lf_cr; }
        void set_u_0000__u_000__a_or_u_000__d_nul_lf_cr(const std::string & value) { this->u_0000_u_000_a_or_u_000_d_nul_lf_cr = value; }

        const std::string & get_u_oncopy_alert_copy_me_u() const { return u_oncopy_alert_copy_me_u; }
        std::string & get_mutable_u_oncopy_alert_copy_me_u() { return u_oncopy_alert_copy_me_u; }
        void set_u_oncopy_alert_copy_me_u(const std::string & value) { this->u_oncopy_alert_copy_me_u = value; }

        const std::string & get_undef() const { return undef; }
        std::string & get_mutable_undef() { return undef; }
        void set_undef(const std::string & value) { this->undef = value; }

        const std::string & get_unicode_font() const { return unicode_font; }
        std::string & get_mutable_unicode_font() { return unicode_font; }
        void set_unicode_font(const std::string & value) { this->unicode_font = value; }

        const std::string & get_unicode_numbers() const { return unicode_numbers; }
        std::string & get_mutable_unicode_numbers() { return unicode_numbers; }
        void set_unicode_numbers(const std::string & value) { this->unicode_numbers = value; }

        const std::string & get_unwanted_interpolation() const { return unwanted_interpolation; }
        std::string & get_mutable_unwanted_interpolation() { return unwanted_interpolation; }
        void set_unwanted_interpolation(const std::string & value) { this->unwanted_interpolation = value; }

        const std::string & get_x_ls_al() const { return x_ls_al; }
        std::string & get_mutable_x_ls_al() { return x_ls_al; }
        void set_x_ls_al(const std::string & value) { this->x_ls_al = value; }

        const std::string & get_z_g_o() const { return z_g_o; }
        std::string & get_mutable_z_g_o() { return z_g_o; }
        void set_z_g_o(const std::string & value) { this->z_g_o = value; }
    };

    class B {
        public:
        B() = default;
        virtual ~B() = default;

        private:
        std::string _;
        std::string _2;
        std::string _3;
        std::string a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a;
        std::string a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string abc_div_style_x_expression_x5_c_javascript_alert_1_def;
        std::string abc_div_style_x_x0_aexpression_javascript_alert_1_def;
        std::string abc_div_style_x_x0_dexpression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def;
        std::string ambitious;
        std::string appear_in_input;
        std::string ath0;
        std::string autofocus_onkeyup_javascript_alert_123;
        std::string b;
        std::string b_100000;
        std::string b_false;
        std::string b_img_src_onmouseover_alert_xxs;
        std::string b_script_alert_123_script;
        std::string b_touch_tmp_blns_fail;
        std::string basement;
        std::string braggadocious;
        std::string but_now_20_cfor_my_greatest_trick_8_m;
        std::string byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line;
        std::string com1;
        std::string com3;
        std::string commonly_misinterpreted_as_additional_graphic_characters;
        std::string con;
        std::string contexts_divided_into_three_groups_based_on_us_layout_keyboard_position;
        std::string credit_https_twitter_com_jifa_status_625776454479970304;
        std::string cunning;
        std::string dev_null_touch_tmp_blns_fail_echo;
        bool dont_make_a_map;
        std::string empty;
        std::string eval_puts_hello_world;
        std::string expression;
        std::string file;
        std::string file_inclusion;
        std::string fluffy;
        std::string foo_val_bar;
        std::string frisky;
        std::string general_category_cf_in_unicode_800;
        std::string h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l;
        std::string help;
        std::string hilarious;
        std::string http_a_3030;
        std::string i_os_vulnerabilities;
        std::string if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you;
        std::string iframe_src_http_ha_ckers_org_scriptlet_html;
        std::string img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041;
        std::string img_src_14_javascript_alert_xss;
        std::string img_src_jav_x09_ascript_alert_xss;
        std::string img_src_onmouseover_alert_xxs;
        std::string img_src_x00_x_onerror_javascript_alert_1;
        std::string img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29;
        std::string img_src_x_onerror_x11_javascript_alert_1;
        std::string img_src_x_onerror_x12_javascript_alert_1;
        std::string img_src_xxx_x_x0_aonerror_javascript_alert_1;
        std::string img_src_xxx_x_x0_conerror_javascript_alert_1;
        std::string img_src_xxx_x_x0_donerror_javascript_alert_1;
        std::string img_x00_src_x_onerror_javascript_alert_1;
        std::string img_x11_src_x_onerror_javascript_alert_1;
        std::string img_x12_src_x_onerror_javascript_alert_1;
        std::string img_x47_src_x_onerror_javascript_alert_1;
        std::string indecent;
        std::string indigo;
        std::string irc_specific_strings;
        std::string japanese_emoticons;
        std::string kernel_exec_ls_al;
        std::string linda_callahan;
        std::string magenta;
        std::string mischievous;
        std::string nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o;
        std::string nil;
        std::string nul;
        std::string null;
        std::string numeric_strings;
        std::string o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s;
        std::string often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml;
        std::string onfocus_ja_va_s_cript_alert_123_autofocus;
        std::string or_111;
        std::string purple;
        std::string purple_script_alert_123_script;
        std::string quotation_marks;
        std::string regional_indicator_symbols;
        std::string regional_indicator_symbols_can_be_displayed_differently_across;
        std::string reserved_strings;
        std::string script_alert_123_script;
        std::string script_alert_123_script_x;
        std::string script_alert_xss_script;
        std::string script_src_ha_ckers_org_j;
        std::string script_src_jscript_s_script;
        std::string script_x09_javascript_alert_1_script;
        std::string script_x0_atype_text_javascript_javascript_alert_1_script;
        std::string script_x0_dtype_text_javascript_javascript_alert_1_script;
        std::string script_x21_javascript_alert_1_script;
        std::string script_x3_bjavascript_alert_1_script;
        std::string script_x_e2_x80_x85_javascript_alert_1_script;
        std::string script_x_e2_x80_x87_javascript_alert_1_script;
        std::string script_x_e2_x80_x8_ajavascript_alert_1_script;
        std::string script_x_e2_x80_x_a8_javascript_alert_1_script;
        std::string script_x_e2_x80_x_a9_javascript_alert_1_script;
        std::string script_x_e2_x80_x_a_fjavascript_alert_1_script;
        std::string script_x_e3_x80_x80_javascript_alert_1_script;
        std::string scunthorpe_problem;
        std::string sticky;
        std::string strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out;
        std::string strings_which_are_reserved_characters_in_msdos_windows;
        std::string strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss;
        std::string strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew;
        std::string strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues;
        std::string strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric;
        std::string strings_which_may_be_used_elsewhere_in_code;
        std::string tentacled;
        std::string terminal_escape_codes;
        std::string the_000;
        std::string the_01000;
        std::string the_08;
        std::string the_09;
        std::string the_0_xffffffffffffffff;
        std::string the_1;
        std::string the_100;
        std::string the_1000;
        std::string the_100000;
        std::string the_100000000;
        std::string the_1_drop_table_users_1;
        std::string the_1_ind;
        std::string the_1_inf;
        std::string the_21474836481;
        std::string the_22250738585072011_e_308;
        std::string the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers;
        std::string the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers;
        std::string the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers;
        std::string this_file_unfortunately_cannot_express_strings_containing;
        std::string touch_tmp_blns_fail;
        std::string touch_tmp_blns_shellshock2_fail;
        std::string tyson_gay;
        std::string unicode_symbols;
        std::string x00_script_javascript_alert_1_script;
        std::string x3_cscript_javascript_alert_1_script;

        public:
        const std::string & get() const { return _; }
        std::string & get_mutable() { return _; }
        void set(const std::string & value) { this->_ = value; }

        const std::string & get_2() const { return _2; }
        std::string & get_mutable_2() { return _2; }
        void set_2(const std::string & value) { this->_2 = value; }

        const std::string & get_3() const { return _3; }
        std::string & get_mutable_3() { return _3; }
        void set_3(const std::string & value) { this->_3 = value; }

        const std::string & get_a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1__a() const { return a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a; }
        std::string & get_mutable_a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1__a() { return a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a; }
        void set_a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1__a(const std::string & value) { this->a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a = value; }

        const std::string & get_a_href_javascript_x00_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_javascript_x00_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_javascript_x00_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_javascript_x0_d_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_javascript_x0_d_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_javascript_x0_d_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x02_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x02_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x02_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x04_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x04_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x04_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x0_ajavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x0_ajavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x0_ajavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x0_djavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x0_djavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x0_djavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x0_ejavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x0_ejavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x0_ejavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x0_fjavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x0_fjavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x0_fjavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x16_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x16_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x16_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x19_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x19_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x19_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x1_ajavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x1_ajavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x1_ajavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x1_djavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x1_djavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x1_djavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x1_ejavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x1_ejavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x1_ejavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x81_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x81_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x81_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x82_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x82_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x82_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x_a9_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x_a9_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x_a9_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_abc_div_style_x_expression_x5_c_javascript_alert_1__def() const { return abc_div_style_x_expression_x5_c_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_expression_x5_c_javascript_alert_1__def() { return abc_div_style_x_expression_x5_c_javascript_alert_1_def; }
        void set_abc_div_style_x_expression_x5_c_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_expression_x5_c_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x0_aexpression_javascript_alert_1__def() const { return abc_div_style_x_x0_aexpression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x0_aexpression_javascript_alert_1__def() { return abc_div_style_x_x0_aexpression_javascript_alert_1_def; }
        void set_abc_div_style_x_x0_aexpression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x0_aexpression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x0_dexpression_javascript_alert_1__def() const { return abc_div_style_x_x0_dexpression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x0_dexpression_javascript_alert_1__def() { return abc_div_style_x_x0_dexpression_javascript_alert_1_def; }
        void set_abc_div_style_x_x0_dexpression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x0_dexpression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def = value; }

        const std::string & get_ambitious() const { return ambitious; }
        std::string & get_mutable_ambitious() { return ambitious; }
        void set_ambitious(const std::string & value) { this->ambitious = value; }

        const std::string & get_appear_in_input() const { return appear_in_input; }
        std::string & get_mutable_appear_in_input() { return appear_in_input; }
        void set_appear_in_input(const std::string & value) { this->appear_in_input = value; }

        const std::string & get_ath0() const { return ath0; }
        std::string & get_mutable_ath0() { return ath0; }
        void set_ath0(const std::string & value) { this->ath0 = value; }

        const std::string & get_autofocus_onkeyup_javascript_alert_123() const { return autofocus_onkeyup_javascript_alert_123; }
        std::string & get_mutable_autofocus_onkeyup_javascript_alert_123() { return autofocus_onkeyup_javascript_alert_123; }
        void set_autofocus_onkeyup_javascript_alert_123(const std::string & value) { this->autofocus_onkeyup_javascript_alert_123 = value; }

        const std::string & get_b() const { return b; }
        std::string & get_mutable_b() { return b; }
        void set_b(const std::string & value) { this->b = value; }

        const std::string & get_b_100000() const { return b_100000; }
        std::string & get_mutable_b_100000() { return b_100000; }
        void set_b_100000(const std::string & value) { this->b_100000 = value; }

        const std::string & get_b_false() const { return b_false; }
        std::string & get_mutable_b_false() { return b_false; }
        void set_b_false(const std::string & value) { this->b_false = value; }

        const std::string & get_b_img_src_onmouseover_alert_xxs() const { return b_img_src_onmouseover_alert_xxs; }
        std::string & get_mutable_b_img_src_onmouseover_alert_xxs() { return b_img_src_onmouseover_alert_xxs; }
        void set_b_img_src_onmouseover_alert_xxs(const std::string & value) { this->b_img_src_onmouseover_alert_xxs = value; }

        const std::string & get_b_script_alert_123__script() const { return b_script_alert_123_script; }
        std::string & get_mutable_b_script_alert_123__script() { return b_script_alert_123_script; }
        void set_b_script_alert_123__script(const std::string & value) { this->b_script_alert_123_script = value; }

        const std::string & get_b_touch_tmp_blns_fail() const { return b_touch_tmp_blns_fail; }
        std::string & get_mutable_b_touch_tmp_blns_fail() { return b_touch_tmp_blns_fail; }
        void set_b_touch_tmp_blns_fail(const std::string & value) { this->b_touch_tmp_blns_fail = value; }

        const std::string & get_basement() const { return basement; }
        std::string & get_mutable_basement() { return basement; }
        void set_basement(const std::string & value) { this->basement = value; }

        const std::string & get_braggadocious() const { return braggadocious; }
        std::string & get_mutable_braggadocious() { return braggadocious; }
        void set_braggadocious(const std::string & value) { this->braggadocious = value; }

        const std::string & get_but_now_20__cfor_my_greatest_trick_8__m() const { return but_now_20_cfor_my_greatest_trick_8_m; }
        std::string & get_mutable_but_now_20__cfor_my_greatest_trick_8__m() { return but_now_20_cfor_my_greatest_trick_8_m; }
        void set_but_now_20__cfor_my_greatest_trick_8__m(const std::string & value) { this->but_now_20_cfor_my_greatest_trick_8_m = value; }

        const std::string & get_byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line() const { return byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line; }
        std::string & get_mutable_byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line() { return byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line; }
        void set_byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line(const std::string & value) { this->byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line = value; }

        const std::string & get_com1() const { return com1; }
        std::string & get_mutable_com1() { return com1; }
        void set_com1(const std::string & value) { this->com1 = value; }

        const std::string & get_com3() const { return com3; }
        std::string & get_mutable_com3() { return com3; }
        void set_com3(const std::string & value) { this->com3 = value; }

        const std::string & get_commonly_misinterpreted_as_additional_graphic_characters() const { return commonly_misinterpreted_as_additional_graphic_characters; }
        std::string & get_mutable_commonly_misinterpreted_as_additional_graphic_characters() { return commonly_misinterpreted_as_additional_graphic_characters; }
        void set_commonly_misinterpreted_as_additional_graphic_characters(const std::string & value) { this->commonly_misinterpreted_as_additional_graphic_characters = value; }

        const std::string & get_con() const { return con; }
        std::string & get_mutable_con() { return con; }
        void set_con(const std::string & value) { this->con = value; }

        const std::string & get_contexts_divided_into_three_groups_based_on_us_layout_keyboard_position() const { return contexts_divided_into_three_groups_based_on_us_layout_keyboard_position; }
        std::string & get_mutable_contexts_divided_into_three_groups_based_on_us_layout_keyboard_position() { return contexts_divided_into_three_groups_based_on_us_layout_keyboard_position; }
        void set_contexts_divided_into_three_groups_based_on_us_layout_keyboard_position(const std::string & value) { this->contexts_divided_into_three_groups_based_on_us_layout_keyboard_position = value; }

        const std::string & get_credit_https_twitter_com_jifa_status_625776454479970304() const { return credit_https_twitter_com_jifa_status_625776454479970304; }
        std::string & get_mutable_credit_https_twitter_com_jifa_status_625776454479970304() { return credit_https_twitter_com_jifa_status_625776454479970304; }
        void set_credit_https_twitter_com_jifa_status_625776454479970304(const std::string & value) { this->credit_https_twitter_com_jifa_status_625776454479970304 = value; }

        const std::string & get_cunning() const { return cunning; }
        std::string & get_mutable_cunning() { return cunning; }
        void set_cunning(const std::string & value) { this->cunning = value; }

        const std::string & get_dev_null_touch_tmp_blns_fail_echo() const { return dev_null_touch_tmp_blns_fail_echo; }
        std::string & get_mutable_dev_null_touch_tmp_blns_fail_echo() { return dev_null_touch_tmp_blns_fail_echo; }
        void set_dev_null_touch_tmp_blns_fail_echo(const std::string & value) { this->dev_null_touch_tmp_blns_fail_echo = value; }

        const bool & get_dont_make_a_map() const { return dont_make_a_map; }
        bool & get_mutable_dont_make_a_map() { return dont_make_a_map; }
        void set_dont_make_a_map(const bool & value) { this->dont_make_a_map = value; }

        const std::string & get_empty() const { return empty; }
        std::string & get_mutable_empty() { return empty; }
        void set_empty(const std::string & value) { this->empty = value; }

        const std::string & get_eval_puts_hello_world() const { return eval_puts_hello_world; }
        std::string & get_mutable_eval_puts_hello_world() { return eval_puts_hello_world; }
        void set_eval_puts_hello_world(const std::string & value) { this->eval_puts_hello_world = value; }

        const std::string & get_expression() const { return expression; }
        std::string & get_mutable_expression() { return expression; }
        void set_expression(const std::string & value) { this->expression = value; }

        const std::string & get_file() const { return file; }
        std::string & get_mutable_file() { return file; }
        void set_file(const std::string & value) { this->file = value; }

        const std::string & get_file_inclusion() const { return file_inclusion; }
        std::string & get_mutable_file_inclusion() { return file_inclusion; }
        void set_file_inclusion(const std::string & value) { this->file_inclusion = value; }

        const std::string & get_fluffy() const { return fluffy; }
        std::string & get_mutable_fluffy() { return fluffy; }
        void set_fluffy(const std::string & value) { this->fluffy = value; }

        const std::string & get_foo_val_bar() const { return foo_val_bar; }
        std::string & get_mutable_foo_val_bar() { return foo_val_bar; }
        void set_foo_val_bar(const std::string & value) { this->foo_val_bar = value; }

        const std::string & get_frisky() const { return frisky; }
        std::string & get_mutable_frisky() { return frisky; }
        void set_frisky(const std::string & value) { this->frisky = value; }

        const std::string & get_general_category_cf_in_unicode_800() const { return general_category_cf_in_unicode_800; }
        std::string & get_mutable_general_category_cf_in_unicode_800() { return general_category_cf_in_unicode_800; }
        void set_general_category_cf_in_unicode_800(const std::string & value) { this->general_category_cf_in_unicode_800 = value; }

        const std::string & get_h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l() const { return h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l; }
        std::string & get_mutable_h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l() { return h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l; }
        void set_h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l(const std::string & value) { this->h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l = value; }

        const std::string & get_help() const { return help; }
        std::string & get_mutable_help() { return help; }
        void set_help(const std::string & value) { this->help = value; }

        const std::string & get_hilarious() const { return hilarious; }
        std::string & get_mutable_hilarious() { return hilarious; }
        void set_hilarious(const std::string & value) { this->hilarious = value; }

        const std::string & get_http_a_3030() const { return http_a_3030; }
        std::string & get_mutable_http_a_3030() { return http_a_3030; }
        void set_http_a_3030(const std::string & value) { this->http_a_3030 = value; }

        const std::string & get_i_os_vulnerabilities() const { return i_os_vulnerabilities; }
        std::string & get_mutable_i_os_vulnerabilities() { return i_os_vulnerabilities; }
        void set_i_os_vulnerabilities(const std::string & value) { this->i_os_vulnerabilities = value; }

        const std::string & get_if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20__years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you() const { return if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you; }
        std::string & get_mutable_if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20__years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you() { return if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you; }
        void set_if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20__years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you(const std::string & value) { this->if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you = value; }

        const std::string & get_iframe_src_http_ha_ckers_org_scriptlet_html() const { return iframe_src_http_ha_ckers_org_scriptlet_html; }
        std::string & get_mutable_iframe_src_http_ha_ckers_org_scriptlet_html() { return iframe_src_http_ha_ckers_org_scriptlet_html; }
        void set_iframe_src_http_ha_ckers_org_scriptlet_html(const std::string & value) { this->iframe_src_http_ha_ckers_org_scriptlet_html = value; }

        const std::string & get_img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041() const { return img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041; }
        std::string & get_mutable_img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041() { return img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041; }
        void set_img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041(const std::string & value) { this->img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041 = value; }

        const std::string & get_img_src_14__javascript_alert_xss() const { return img_src_14_javascript_alert_xss; }
        std::string & get_mutable_img_src_14__javascript_alert_xss() { return img_src_14_javascript_alert_xss; }
        void set_img_src_14__javascript_alert_xss(const std::string & value) { this->img_src_14_javascript_alert_xss = value; }

        const std::string & get_img_src_jav_x09_ascript_alert_xss() const { return img_src_jav_x09_ascript_alert_xss; }
        std::string & get_mutable_img_src_jav_x09_ascript_alert_xss() { return img_src_jav_x09_ascript_alert_xss; }
        void set_img_src_jav_x09_ascript_alert_xss(const std::string & value) { this->img_src_jav_x09_ascript_alert_xss = value; }

        const std::string & get_img_src_onmouseover_alert_xxs() const { return img_src_onmouseover_alert_xxs; }
        std::string & get_mutable_img_src_onmouseover_alert_xxs() { return img_src_onmouseover_alert_xxs; }
        void set_img_src_onmouseover_alert_xxs(const std::string & value) { this->img_src_onmouseover_alert_xxs = value; }

        const std::string & get_img_src_x00_x_onerror_javascript_alert_1() const { return img_src_x00_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x00_x_onerror_javascript_alert_1() { return img_src_x00_x_onerror_javascript_alert_1; }
        void set_img_src_x00_x_onerror_javascript_alert_1(const std::string & value) { this->img_src_x00_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29() const { return img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29; }
        std::string & get_mutable_img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29() { return img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29; }
        void set_img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29(const std::string & value) { this->img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29 = value; }

        const std::string & get_img_src_x_onerror_x11_javascript_alert_1() const { return img_src_x_onerror_x11_javascript_alert_1; }
        std::string & get_mutable_img_src_x_onerror_x11_javascript_alert_1() { return img_src_x_onerror_x11_javascript_alert_1; }
        void set_img_src_x_onerror_x11_javascript_alert_1(const std::string & value) { this->img_src_x_onerror_x11_javascript_alert_1 = value; }

        const std::string & get_img_src_x_onerror_x12_javascript_alert_1() const { return img_src_x_onerror_x12_javascript_alert_1; }
        std::string & get_mutable_img_src_x_onerror_x12_javascript_alert_1() { return img_src_x_onerror_x12_javascript_alert_1; }
        void set_img_src_x_onerror_x12_javascript_alert_1(const std::string & value) { this->img_src_x_onerror_x12_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x0_aonerror_javascript_alert_1() const { return img_src_xxx_x_x0_aonerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x0_aonerror_javascript_alert_1() { return img_src_xxx_x_x0_aonerror_javascript_alert_1; }
        void set_img_src_xxx_x_x0_aonerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x0_aonerror_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x0_conerror_javascript_alert_1() const { return img_src_xxx_x_x0_conerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x0_conerror_javascript_alert_1() { return img_src_xxx_x_x0_conerror_javascript_alert_1; }
        void set_img_src_xxx_x_x0_conerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x0_conerror_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x0_donerror_javascript_alert_1() const { return img_src_xxx_x_x0_donerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x0_donerror_javascript_alert_1() { return img_src_xxx_x_x0_donerror_javascript_alert_1; }
        void set_img_src_xxx_x_x0_donerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x0_donerror_javascript_alert_1 = value; }

        const std::string & get_img_x00_src_x_onerror_javascript_alert_1() const { return img_x00_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x00_src_x_onerror_javascript_alert_1() { return img_x00_src_x_onerror_javascript_alert_1; }
        void set_img_x00_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x00_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x11_src_x_onerror_javascript_alert_1() const { return img_x11_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x11_src_x_onerror_javascript_alert_1() { return img_x11_src_x_onerror_javascript_alert_1; }
        void set_img_x11_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x11_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x12_src_x_onerror_javascript_alert_1() const { return img_x12_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x12_src_x_onerror_javascript_alert_1() { return img_x12_src_x_onerror_javascript_alert_1; }
        void set_img_x12_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x12_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x47_src_x_onerror_javascript_alert_1() const { return img_x47_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x47_src_x_onerror_javascript_alert_1() { return img_x47_src_x_onerror_javascript_alert_1; }
        void set_img_x47_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x47_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_indecent() const { return indecent; }
        std::string & get_mutable_indecent() { return indecent; }
        void set_indecent(const std::string & value) { this->indecent = value; }

        const std::string & get_indigo() const { return indigo; }
        std::string & get_mutable_indigo() { return indigo; }
        void set_indigo(const std::string & value) { this->indigo = value; }

        const std::string & get_irc_specific_strings() const { return irc_specific_strings; }
        std::string & get_mutable_irc_specific_strings() { return irc_specific_strings; }
        void set_irc_specific_strings(const std::string & value) { this->irc_specific_strings = value; }

        const std::string & get_japanese_emoticons() const { return japanese_emoticons; }
        std::string & get_mutable_japanese_emoticons() { return japanese_emoticons; }
        void set_japanese_emoticons(const std::string & value) { this->japanese_emoticons = value; }

        const std::string & get_kernel_exec_ls_al() const { return kernel_exec_ls_al; }
        std::string & get_mutable_kernel_exec_ls_al() { return kernel_exec_ls_al; }
        void set_kernel_exec_ls_al(const std::string & value) { this->kernel_exec_ls_al = value; }

        const std::string & get_linda_callahan() const { return linda_callahan; }
        std::string & get_mutable_linda_callahan() { return linda_callahan; }
        void set_linda_callahan(const std::string & value) { this->linda_callahan = value; }

        const std::string & get_magenta() const { return magenta; }
        std::string & get_mutable_magenta() { return magenta; }
        void set_magenta(const std::string & value) { this->magenta = value; }

        const std::string & get_mischievous() const { return mischievous; }
        std::string & get_mutable_mischievous() { return mischievous; }
        void set_mischievous(const std::string & value) { this->mischievous = value; }

        const std::string & get_nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o() const { return nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o; }
        std::string & get_mutable_nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o() { return nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o; }
        void set_nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o(const std::string & value) { this->nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o = value; }

        const std::string & get_nil() const { return nil; }
        std::string & get_mutable_nil() { return nil; }
        void set_nil(const std::string & value) { this->nil = value; }

        const std::string & get_nul() const { return nul; }
        std::string & get_mutable_nul() { return nul; }
        void set_nul(const std::string & value) { this->nul = value; }

        const std::string & get_null() const { return null; }
        std::string & get_mutable_null() { return null; }
        void set_null(const std::string & value) { this->null = value; }

        const std::string & get_numeric_strings() const { return numeric_strings; }
        std::string & get_mutable_numeric_strings() { return numeric_strings; }
        void set_numeric_strings(const std::string & value) { this->numeric_strings = value; }

        const std::string & get_o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s() const { return o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s; }
        std::string & get_mutable_o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s() { return o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s; }
        void set_o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s(const std::string & value) { this->o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s = value; }

        const std::string & get_often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml() const { return often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml; }
        std::string & get_mutable_often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml() { return often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml; }
        void set_often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml(const std::string & value) { this->often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml = value; }

        const std::string & get_onfocus_ja_va_s_cript_alert_123__autofocus() const { return onfocus_ja_va_s_cript_alert_123_autofocus; }
        std::string & get_mutable_onfocus_ja_va_s_cript_alert_123__autofocus() { return onfocus_ja_va_s_cript_alert_123_autofocus; }
        void set_onfocus_ja_va_s_cript_alert_123__autofocus(const std::string & value) { this->onfocus_ja_va_s_cript_alert_123_autofocus = value; }

        const std::string & get_or_111() const { return or_111; }
        std::string & get_mutable_or_111() { return or_111; }
        void set_or_111(const std::string & value) { this->or_111 = value; }

        const std::string & get_purple() const { return purple; }
        std::string & get_mutable_purple() { return purple; }
        void set_purple(const std::string & value) { this->purple = value; }

        const std::string & get_purple_script_alert_123__script() const { return purple_script_alert_123_script; }
        std::string & get_mutable_purple_script_alert_123__script() { return purple_script_alert_123_script; }
        void set_purple_script_alert_123__script(const std::string & value) { this->purple_script_alert_123_script = value; }

        const std::string & get_quotation_marks() const { return quotation_marks; }
        std::string & get_mutable_quotation_marks() { return quotation_marks; }
        void set_quotation_marks(const std::string & value) { this->quotation_marks = value; }

        const std::string & get_regional_indicator_symbols() const { return regional_indicator_symbols; }
        std::string & get_mutable_regional_indicator_symbols() { return regional_indicator_symbols; }
        void set_regional_indicator_symbols(const std::string & value) { this->regional_indicator_symbols = value; }

        const std::string & get_regional_indicator_symbols_can_be_displayed_differently_across() const { return regional_indicator_symbols_can_be_displayed_differently_across; }
        std::string & get_mutable_regional_indicator_symbols_can_be_displayed_differently_across() { return regional_indicator_symbols_can_be_displayed_differently_across; }
        void set_regional_indicator_symbols_can_be_displayed_differently_across(const std::string & value) { this->regional_indicator_symbols_can_be_displayed_differently_across = value; }

        const std::string & get_reserved_strings() const { return reserved_strings; }
        std::string & get_mutable_reserved_strings() { return reserved_strings; }
        void set_reserved_strings(const std::string & value) { this->reserved_strings = value; }

        const std::string & get_script_alert_123__script() const { return script_alert_123_script; }
        std::string & get_mutable_script_alert_123__script() { return script_alert_123_script; }
        void set_script_alert_123__script(const std::string & value) { this->script_alert_123_script = value; }

        const std::string & get_script_alert_123__script_x() const { return script_alert_123_script_x; }
        std::string & get_mutable_script_alert_123__script_x() { return script_alert_123_script_x; }
        void set_script_alert_123__script_x(const std::string & value) { this->script_alert_123_script_x = value; }

        const std::string & get_script_alert_xss_script() const { return script_alert_xss_script; }
        std::string & get_mutable_script_alert_xss_script() { return script_alert_xss_script; }
        void set_script_alert_xss_script(const std::string & value) { this->script_alert_xss_script = value; }

        const std::string & get_script_src_ha_ckers_org_j() const { return script_src_ha_ckers_org_j; }
        std::string & get_mutable_script_src_ha_ckers_org_j() { return script_src_ha_ckers_org_j; }
        void set_script_src_ha_ckers_org_j(const std::string & value) { this->script_src_ha_ckers_org_j = value; }

        const std::string & get_script_src_jscript_s_script() const { return script_src_jscript_s_script; }
        std::string & get_mutable_script_src_jscript_s_script() { return script_src_jscript_s_script; }
        void set_script_src_jscript_s_script(const std::string & value) { this->script_src_jscript_s_script = value; }

        const std::string & get_script_x09_javascript_alert_1__script() const { return script_x09_javascript_alert_1_script; }
        std::string & get_mutable_script_x09_javascript_alert_1__script() { return script_x09_javascript_alert_1_script; }
        void set_script_x09_javascript_alert_1__script(const std::string & value) { this->script_x09_javascript_alert_1_script = value; }

        const std::string & get_script_x0_atype_text_javascript_javascript_alert_1__script() const { return script_x0_atype_text_javascript_javascript_alert_1_script; }
        std::string & get_mutable_script_x0_atype_text_javascript_javascript_alert_1__script() { return script_x0_atype_text_javascript_javascript_alert_1_script; }
        void set_script_x0_atype_text_javascript_javascript_alert_1__script(const std::string & value) { this->script_x0_atype_text_javascript_javascript_alert_1_script = value; }

        const std::string & get_script_x0_dtype_text_javascript_javascript_alert_1__script() const { return script_x0_dtype_text_javascript_javascript_alert_1_script; }
        std::string & get_mutable_script_x0_dtype_text_javascript_javascript_alert_1__script() { return script_x0_dtype_text_javascript_javascript_alert_1_script; }
        void set_script_x0_dtype_text_javascript_javascript_alert_1__script(const std::string & value) { this->script_x0_dtype_text_javascript_javascript_alert_1_script = value; }

        const std::string & get_script_x21_javascript_alert_1__script() const { return script_x21_javascript_alert_1_script; }
        std::string & get_mutable_script_x21_javascript_alert_1__script() { return script_x21_javascript_alert_1_script; }
        void set_script_x21_javascript_alert_1__script(const std::string & value) { this->script_x21_javascript_alert_1_script = value; }

        const std::string & get_script_x3_bjavascript_alert_1__script() const { return script_x3_bjavascript_alert_1_script; }
        std::string & get_mutable_script_x3_bjavascript_alert_1__script() { return script_x3_bjavascript_alert_1_script; }
        void set_script_x3_bjavascript_alert_1__script(const std::string & value) { this->script_x3_bjavascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x85_javascript_alert_1__script() const { return script_x_e2_x80_x85_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x85_javascript_alert_1__script() { return script_x_e2_x80_x85_javascript_alert_1_script; }
        void set_script_x_e2_x80_x85_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x85_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x87_javascript_alert_1__script() const { return script_x_e2_x80_x87_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x87_javascript_alert_1__script() { return script_x_e2_x80_x87_javascript_alert_1_script; }
        void set_script_x_e2_x80_x87_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x87_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x8_ajavascript_alert_1__script() const { return script_x_e2_x80_x8_ajavascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x8_ajavascript_alert_1__script() { return script_x_e2_x80_x8_ajavascript_alert_1_script; }
        void set_script_x_e2_x80_x8_ajavascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x8_ajavascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x_a8_javascript_alert_1__script() const { return script_x_e2_x80_x_a8_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x_a8_javascript_alert_1__script() { return script_x_e2_x80_x_a8_javascript_alert_1_script; }
        void set_script_x_e2_x80_x_a8_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x_a8_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x_a9_javascript_alert_1__script() const { return script_x_e2_x80_x_a9_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x_a9_javascript_alert_1__script() { return script_x_e2_x80_x_a9_javascript_alert_1_script; }
        void set_script_x_e2_x80_x_a9_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x_a9_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x_a_fjavascript_alert_1__script() const { return script_x_e2_x80_x_a_fjavascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x_a_fjavascript_alert_1__script() { return script_x_e2_x80_x_a_fjavascript_alert_1_script; }
        void set_script_x_e2_x80_x_a_fjavascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x_a_fjavascript_alert_1_script = value; }

        const std::string & get_script_x_e3_x80_x80_javascript_alert_1__script() const { return script_x_e3_x80_x80_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e3_x80_x80_javascript_alert_1__script() { return script_x_e3_x80_x80_javascript_alert_1_script; }
        void set_script_x_e3_x80_x80_javascript_alert_1__script(const std::string & value) { this->script_x_e3_x80_x80_javascript_alert_1_script = value; }

        const std::string & get_scunthorpe_problem() const { return scunthorpe_problem; }
        std::string & get_mutable_scunthorpe_problem() { return scunthorpe_problem; }
        void set_scunthorpe_problem(const std::string & value) { this->scunthorpe_problem = value; }

        const std::string & get_sticky() const { return sticky; }
        std::string & get_mutable_sticky() { return sticky; }
        void set_sticky(const std::string & value) { this->sticky = value; }

        const std::string & get_strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out() const { return strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out; }
        std::string & get_mutable_strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out() { return strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out; }
        void set_strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out(const std::string & value) { this->strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out = value; }

        const std::string & get_strings_which_are_reserved_characters_in_msdos_windows() const { return strings_which_are_reserved_characters_in_msdos_windows; }
        std::string & get_mutable_strings_which_are_reserved_characters_in_msdos_windows() { return strings_which_are_reserved_characters_in_msdos_windows; }
        void set_strings_which_are_reserved_characters_in_msdos_windows(const std::string & value) { this->strings_which_are_reserved_characters_in_msdos_windows = value; }

        const std::string & get_strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss() const { return strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss; }
        std::string & get_mutable_strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss() { return strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss; }
        void set_strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss(const std::string & value) { this->strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss = value; }

        const std::string & get_strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew() const { return strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew; }
        std::string & get_mutable_strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew() { return strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew; }
        void set_strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew(const std::string & value) { this->strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew = value; }

        const std::string & get_strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues() const { return strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues; }
        std::string & get_mutable_strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues() { return strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues; }
        void set_strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues(const std::string & value) { this->strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues = value; }

        const std::string & get_strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric() const { return strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric; }
        std::string & get_mutable_strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric() { return strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric; }
        void set_strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric(const std::string & value) { this->strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric = value; }

        const std::string & get_strings_which_may_be_used_elsewhere_in_code() const { return strings_which_may_be_used_elsewhere_in_code; }
        std::string & get_mutable_strings_which_may_be_used_elsewhere_in_code() { return strings_which_may_be_used_elsewhere_in_code; }
        void set_strings_which_may_be_used_elsewhere_in_code(const std::string & value) { this->strings_which_may_be_used_elsewhere_in_code = value; }

        const std::string & get_tentacled() const { return tentacled; }
        std::string & get_mutable_tentacled() { return tentacled; }
        void set_tentacled(const std::string & value) { this->tentacled = value; }

        const std::string & get_terminal_escape_codes() const { return terminal_escape_codes; }
        std::string & get_mutable_terminal_escape_codes() { return terminal_escape_codes; }
        void set_terminal_escape_codes(const std::string & value) { this->terminal_escape_codes = value; }

        const std::string & get_the_000() const { return the_000; }
        std::string & get_mutable_the_000() { return the_000; }
        void set_the_000(const std::string & value) { this->the_000 = value; }

        const std::string & get_the_01000() const { return the_01000; }
        std::string & get_mutable_the_01000() { return the_01000; }
        void set_the_01000(const std::string & value) { this->the_01000 = value; }

        const std::string & get_the_08() const { return the_08; }
        std::string & get_mutable_the_08() { return the_08; }
        void set_the_08(const std::string & value) { this->the_08 = value; }

        const std::string & get_the_09() const { return the_09; }
        std::string & get_mutable_the_09() { return the_09; }
        void set_the_09(const std::string & value) { this->the_09 = value; }

        const std::string & get_the_0__xffffffffffffffff() const { return the_0_xffffffffffffffff; }
        std::string & get_mutable_the_0__xffffffffffffffff() { return the_0_xffffffffffffffff; }
        void set_the_0__xffffffffffffffff(const std::string & value) { this->the_0_xffffffffffffffff = value; }

        const std::string & get_the_1() const { return the_1; }
        std::string & get_mutable_the_1() { return the_1; }
        void set_the_1(const std::string & value) { this->the_1 = value; }

        const std::string & get_the_100() const { return the_100; }
        std::string & get_mutable_the_100() { return the_100; }
        void set_the_100(const std::string & value) { this->the_100 = value; }

        const std::string & get_the_1000() const { return the_1000; }
        std::string & get_mutable_the_1000() { return the_1000; }
        void set_the_1000(const std::string & value) { this->the_1000 = value; }

        const std::string & get_the_100000() const { return the_100000; }
        std::string & get_mutable_the_100000() { return the_100000; }
        void set_the_100000(const std::string & value) { this->the_100000 = value; }

        const std::string & get_the_100000000() const { return the_100000000; }
        std::string & get_mutable_the_100000000() { return the_100000000; }
        void set_the_100000000(const std::string & value) { this->the_100000000 = value; }

        const std::string & get_the_1__drop_table_users_1() const { return the_1_drop_table_users_1; }
        std::string & get_mutable_the_1__drop_table_users_1() { return the_1_drop_table_users_1; }
        void set_the_1__drop_table_users_1(const std::string & value) { this->the_1_drop_table_users_1 = value; }

        const std::string & get_the_1__ind() const { return the_1_ind; }
        std::string & get_mutable_the_1__ind() { return the_1_ind; }
        void set_the_1__ind(const std::string & value) { this->the_1_ind = value; }

        const std::string & get_the_1__inf() const { return the_1_inf; }
        std::string & get_mutable_the_1__inf() { return the_1_inf; }
        void set_the_1__inf(const std::string & value) { this->the_1_inf = value; }

        const std::string & get_the_21474836481() const { return the_21474836481; }
        std::string & get_mutable_the_21474836481() { return the_21474836481; }
        void set_the_21474836481(const std::string & value) { this->the_21474836481 = value; }

        const std::string & get_the_22250738585072011__e_308() const { return the_22250738585072011_e_308; }
        std::string & get_mutable_the_22250738585072011__e_308() { return the_22250738585072011_e_308; }
        void set_the_22250738585072011__e_308(const std::string & value) { this->the_22250738585072011_e_308 = value; }

        const std::string & get_the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers() const { return the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers; }
        std::string & get_mutable_the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers() { return the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers; }
        void set_the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers(const std::string & value) { this->the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers = value; }

        const std::string & get_the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers() const { return the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers; }
        std::string & get_mutable_the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers() { return the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers; }
        void set_the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers(const std::string & value) { this->the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers = value; }

        const std::string & get_the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers() const { return the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers; }
        std::string & get_mutable_the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers() { return the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers; }
        void set_the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers(const std::string & value) { this->the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers = value; }

        const std::string & get_this_file_unfortunately_cannot_express_strings_containing() const { return this_file_unfortunately_cannot_express_strings_containing; }
        std::string & get_mutable_this_file_unfortunately_cannot_express_strings_containing() { return this_file_unfortunately_cannot_express_strings_containing; }
        void set_this_file_unfortunately_cannot_express_strings_containing(const std::string & value) { this->this_file_unfortunately_cannot_express_strings_containing = value; }

        const std::string & get_touch_tmp_blns_fail() const { return touch_tmp_blns_fail; }
        std::string & get_mutable_touch_tmp_blns_fail() { return touch_tmp_blns_fail; }
        void set_touch_tmp_blns_fail(const std::string & value) { this->touch_tmp_blns_fail = value; }

        const std::string & get_touch_tmp_blns_shellshock2_fail() const { return touch_tmp_blns_shellshock2_fail; }
        std::string & get_mutable_touch_tmp_blns_shellshock2_fail() { return touch_tmp_blns_shellshock2_fail; }
        void set_touch_tmp_blns_shellshock2_fail(const std::string & value) { this->touch_tmp_blns_shellshock2_fail = value; }

        const std::string & get_tyson_gay() const { return tyson_gay; }
        std::string & get_mutable_tyson_gay() { return tyson_gay; }
        void set_tyson_gay(const std::string & value) { this->tyson_gay = value; }

        const std::string & get_unicode_symbols() const { return unicode_symbols; }
        std::string & get_mutable_unicode_symbols() { return unicode_symbols; }
        void set_unicode_symbols(const std::string & value) { this->unicode_symbols = value; }

        const std::string & get_x00_script_javascript_alert_1__script() const { return x00_script_javascript_alert_1_script; }
        std::string & get_mutable_x00_script_javascript_alert_1__script() { return x00_script_javascript_alert_1_script; }
        void set_x00_script_javascript_alert_1__script(const std::string & value) { this->x00_script_javascript_alert_1_script = value; }

        const std::string & get_x3_cscript_javascript_alert_1__script() const { return x3_cscript_javascript_alert_1_script; }
        std::string & get_mutable_x3_cscript_javascript_alert_1__script() { return x3_cscript_javascript_alert_1_script; }
        void set_x3_cscript_javascript_alert_1__script(const std::string & value) { this->x3_cscript_javascript_alert_1_script = value; }
    };

    class C {
        public:
        C() = default;
        virtual ~C() = default;

        private:
        std::string _;
        std::string _1;
        std::string _12;
        std::string _2;
        std::string _7;
        std::string a;
        std::string a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a;
        std::string abc_div_style_x_expression_x00_javascript_alert_1_def;
        std::string abc_div_style_x_x00_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x0_cexpression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def;
        std::string abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def;
        std::string ambitious;
        std::string and_u_007_f_del;
        std::string ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some;
        std::string body_onload_alert_xss;
        std::string braggadocious;
        std::string c;
        std::string c_00;
        std::string c_000;
        std::string c_100;
        std::string c_100000;
        std::string c_100000000;
        std::string c_1_e_02;
        std::string c_script_alert_123_script;
        std::string c_true;
        std::string clock;
        std::string com2;
        std::string com4;
        std::string craig_cockburn_software_specialist;
        std::string cunning;
        std::string dcc_send_startkeylogger_000;
        bool dont_make_a_map;
        std::string emoji;
        std::string empty;
        std::string evaluate;
        std::string fluffy;
        std::string fluffy_00;
        std::string foo_val_bar;
        std::string frisky;
        std::string h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o;
        std::string has_own_property;
        std::string hilarious;
        std::string horniman_museum;
        std::string http_www_cum_qc_ca;
        std::string i_onwheel_alert_1_scroll_over_me_i;
        std::string img_a_b_c_src_d_x_e_onerror_f_alert_1;
        std::string img_onmouseover_alert_xxs;
        std::string img_script_alert_xss_script;
        std::string img_src_javascript_alert_string_from_char_code_888383;
        std::string img_src_javascript_alert_xss;
        std::string img_src_onerror_alt_javascript_alert_1;
        std::string img_src_x10_x_onerror_javascript_alert_1;
        std::string img_src_x12_x_onerror_javascript_alert_1;
        std::string img_src_x13_x_onerror_javascript_alert_1;
        std::string img_src_x32_x_onerror_javascript_alert_1;
        std::string img_src_x47_x_onerror_javascript_alert_1;
        std::string img_src_x_onerror_alert_123;
        std::string img_src_x_onerror_x10_javascript_alert_1;
        std::string img_src_x_onerror_x32_javascript_alert_1;
        std::string img_src_x_script_javascript_alert_1_script;
        std::string img_src_xxx_x_x09_onerror_javascript_alert_1;
        std::string img_src_xxx_x_x20_onerror_javascript_alert_1;
        std::string img_src_xxx_x_x22_onerror_javascript_alert_1;
        std::string img_src_xxx_x_x27_onerror_javascript_alert_1;
        std::string img_x11_src_x_onerror_javascript_alert_1;
        std::string img_x34_src_x_onerror_javascript_alert_1;
        std::string img_x47_src_x_onerror_javascript_alert_1;
        std::string indecent;
        std::string indigo;
        std::string infinity;
        std::string java_s_cript_alert_123;
        std::string lpt1;
        std::string lt_script_gt_alert_3912339_lt_script_gt;
        std::string magenta;
        std::string magna_cum_laude;
        std::string medieval_erection_of_parapets;
        std::string mischievous;
        std::string mocha;
        std::string na_n;
        std::string non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f;
        std::string null;
        std::string onfocus_ja_va_s_cript_alert_123_autofocus;
        std::string or_reused_for_internal_delimiters_on_the_theory_that_they_should_never;
        std::string plaintext;
        std::string power_h;
        std::string purple;
        std::string purple_00;
        std::string purple_100000;
        std::string purple_100000000;
        std::string purple_script_alert_123_script;
        std::string right_to_left_strings;
        std::string roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue;
        std::string s;
        std::string script_alert_123_script;
        std::string script_alert_123_script_x;
        std::string script_javascript_alert_1_script;
        std::string script_script_alert_123_script;
        std::string script_src_jscript_s_script;
        std::string script_x0_ajavascript_alert_1_script;
        std::string script_x0_bjavascript_alert_1_script;
        std::string script_x0_ctype_text_javascript_javascript_alert_1_script;
        std::string script_x20_javascript_alert_1_script;
        std::string script_x2_bjavascript_alert_1_script;
        std::string script_x2_ftype_text_javascript_javascript_alert_1_script;
        std::string script_x7_ejavascript_alert_1_script;
        std::string script_x_e2_x80_x80_javascript_alert_1_script;
        std::string script_x_e2_x80_x82_javascript_alert_1_script;
        std::string script_x_e2_x80_x83_javascript_alert_1_script;
        std::string script_x_e2_x80_x84_javascript_alert_1_script;
        std::string script_x_e2_x80_x88_javascript_alert_1_script;
        std::string script_x_e2_x80_x8_bjavascript_alert_1_script;
        std::string script_x_ef_x_bf_x_a_ejavascript_alert_1_script;
        std::string script_x_ef_x_bf_x_b_ejavascript_alert_1_script;
        std::string scunthorpe_general_hospital;
        std::string server_code_injection;
        std::string shitake_mushrooms;
        std::string special_characters;
        std::string src_ja_va_s_cript_prompt_132;
        std::string sticky;
        std::string strings_which_can_be_interpreted_as_numeric;
        std::string strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized;
        std::string strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server;
        std::string strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153;
        std::string strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net;
        std::string strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com;
        std::string strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf;
        std::string strings_which_punish_the_fools_who_use_cat_type_on_this_file;
        std::string svg_script_1231_alert_123_script;
        std::string system_ls_al;
        std::string system_touch_tmp_blns_fail;
        std::string tentacled;
        std::string test;
        std::string test_test;
        std::string the_0;
        std::string the_00;
        std::string the_000;
        std::string the_0123456789;
        std::string the_0_touch_tmp_blns_shellshock1_fail;
        std::string the_0_xabad1_dea;
        std::string the_0_xffffffff;
        std::string the_1;
        std::string the_10;
        std::string the_100;
        std::string the_100000;
        std::string the_100000000;
        std::string the_11;
        std::string the_12;
        std::string the_13;
        std::string the_1_e2;
        std::string the_1_e_02;
        std::string the_1_ind;
        std::string the_3;
        std::string the_4;
        std::string the_5;
        std::string the_6;
        std::string the_8;
        std::string the_9;
        std::string the_92233720368547758081;
        std::string title_onpropertychange_javascript_alert_1_title_title_title;
        std::string treated_as_whitespace_in_some_contexts;
        std::string trick_unicode;
        std::string undefined;
        std::string unicode_additional_control_characters_all_of_the_characters_with;
        std::string unicode_subscript_superscript_accents;
        std::string unicode_upsidedown;
        std::string user;
        std::string version;
        std::string version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel;
        std::string whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode;
        std::string xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo;
        std::string xxe_injection_xml;
        std::string zalgo_text;
        std::string zz;

        public:
        const std::string & get() const { return _; }
        std::string & get_mutable() { return _; }
        void set(const std::string & value) { this->_ = value; }

        const std::string & get_1() const { return _1; }
        std::string & get_mutable_1() { return _1; }
        void set_1(const std::string & value) { this->_1 = value; }

        const std::string & get_12() const { return _12; }
        std::string & get_mutable_12() { return _12; }
        void set_12(const std::string & value) { this->_12 = value; }

        const std::string & get_2() const { return _2; }
        std::string & get_mutable_2() { return _2; }
        void set_2(const std::string & value) { this->_2 = value; }

        const std::string & get_7() const { return _7; }
        std::string & get_mutable_7() { return _7; }
        void set_7(const std::string & value) { this->_7 = value; }

        const std::string & get_a() const { return a; }
        std::string & get_mutable_a() { return a; }
        void set_a(const std::string & value) { this->a = value; }

        const std::string & get_a_href_x00_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x00_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x00_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x03_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x03_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x03_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x06_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x06_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x06_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x07_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x07_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x07_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x0_bjavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x0_bjavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x0_bjavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x12_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x12_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x12_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x14_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x14_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x14_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x15_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x15_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x15_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x18_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x18_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x18_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x1_bjavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x1_bjavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x1_bjavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x1_cjavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x1_cjavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x1_cjavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x20_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x20_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x20_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x85_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x85_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x85_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x88_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x88_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x88_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x89_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x89_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x89_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x80_x8_ajavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x80_x8_ajavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x80_x8_ajavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e2_x81_x9_fjavascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e2_x81_x9_fjavascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e2_x81_x9_fjavascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_a_href_x_e3_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a() const { return a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        std::string & get_mutable_a_href_x_e3_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a() { return a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a; }
        void set_a_href_x_e3_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a(const std::string & value) { this->a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a = value; }

        const std::string & get_abc_div_style_x_expression_x00_javascript_alert_1__def() const { return abc_div_style_x_expression_x00_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_expression_x00_javascript_alert_1__def() { return abc_div_style_x_expression_x00_javascript_alert_1_def; }
        void set_abc_div_style_x_expression_x00_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_expression_x00_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x00_expression_javascript_alert_1__def() const { return abc_div_style_x_x00_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x00_expression_javascript_alert_1__def() { return abc_div_style_x_x00_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x00_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x00_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x0_cexpression_javascript_alert_1__def() const { return abc_div_style_x_x0_cexpression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x0_cexpression_javascript_alert_1__def() { return abc_div_style_x_x0_cexpression_javascript_alert_1_def; }
        void set_abc_div_style_x_x0_cexpression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x0_cexpression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1__def() { return abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1__def() const { return abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1__def() { return abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def = value; }

        const std::string & get_abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1__def() const { return abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def; }
        std::string & get_mutable_abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1__def() { return abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def; }
        void set_abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1__def(const std::string & value) { this->abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def = value; }

        const std::string & get_ambitious() const { return ambitious; }
        std::string & get_mutable_ambitious() { return ambitious; }
        void set_ambitious(const std::string & value) { this->ambitious = value; }

        const std::string & get_and_u_007__f_del() const { return and_u_007_f_del; }
        std::string & get_mutable_and_u_007__f_del() { return and_u_007_f_del; }
        void set_and_u_007__f_del(const std::string & value) { this->and_u_007_f_del = value; }

        const std::string & get_ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some() const { return ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some; }
        std::string & get_mutable_ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some() { return ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some; }
        void set_ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some(const std::string & value) { this->ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some = value; }

        const std::string & get_body_onload_alert_xss() const { return body_onload_alert_xss; }
        std::string & get_mutable_body_onload_alert_xss() { return body_onload_alert_xss; }
        void set_body_onload_alert_xss(const std::string & value) { this->body_onload_alert_xss = value; }

        const std::string & get_braggadocious() const { return braggadocious; }
        std::string & get_mutable_braggadocious() { return braggadocious; }
        void set_braggadocious(const std::string & value) { this->braggadocious = value; }

        const std::string & get_c() const { return c; }
        std::string & get_mutable_c() { return c; }
        void set_c(const std::string & value) { this->c = value; }

        const std::string & get_c_00() const { return c_00; }
        std::string & get_mutable_c_00() { return c_00; }
        void set_c_00(const std::string & value) { this->c_00 = value; }

        const std::string & get_c_000() const { return c_000; }
        std::string & get_mutable_c_000() { return c_000; }
        void set_c_000(const std::string & value) { this->c_000 = value; }

        const std::string & get_c_100() const { return c_100; }
        std::string & get_mutable_c_100() { return c_100; }
        void set_c_100(const std::string & value) { this->c_100 = value; }

        const std::string & get_c_100000() const { return c_100000; }
        std::string & get_mutable_c_100000() { return c_100000; }
        void set_c_100000(const std::string & value) { this->c_100000 = value; }

        const std::string & get_c_100000000() const { return c_100000000; }
        std::string & get_mutable_c_100000000() { return c_100000000; }
        void set_c_100000000(const std::string & value) { this->c_100000000 = value; }

        const std::string & get_c_1__e_02() const { return c_1_e_02; }
        std::string & get_mutable_c_1__e_02() { return c_1_e_02; }
        void set_c_1__e_02(const std::string & value) { this->c_1_e_02 = value; }

        const std::string & get_c_script_alert_123__script() const { return c_script_alert_123_script; }
        std::string & get_mutable_c_script_alert_123__script() { return c_script_alert_123_script; }
        void set_c_script_alert_123__script(const std::string & value) { this->c_script_alert_123_script = value; }

        const std::string & get_c_true() const { return c_true; }
        std::string & get_mutable_c_true() { return c_true; }
        void set_c_true(const std::string & value) { this->c_true = value; }

        const std::string & get_clock() const { return clock; }
        std::string & get_mutable_clock() { return clock; }
        void set_clock(const std::string & value) { this->clock = value; }

        const std::string & get_com2() const { return com2; }
        std::string & get_mutable_com2() { return com2; }
        void set_com2(const std::string & value) { this->com2 = value; }

        const std::string & get_com4() const { return com4; }
        std::string & get_mutable_com4() { return com4; }
        void set_com4(const std::string & value) { this->com4 = value; }

        const std::string & get_craig_cockburn_software_specialist() const { return craig_cockburn_software_specialist; }
        std::string & get_mutable_craig_cockburn_software_specialist() { return craig_cockburn_software_specialist; }
        void set_craig_cockburn_software_specialist(const std::string & value) { this->craig_cockburn_software_specialist = value; }

        const std::string & get_cunning() const { return cunning; }
        std::string & get_mutable_cunning() { return cunning; }
        void set_cunning(const std::string & value) { this->cunning = value; }

        const std::string & get_dcc_send_startkeylogger_000() const { return dcc_send_startkeylogger_000; }
        std::string & get_mutable_dcc_send_startkeylogger_000() { return dcc_send_startkeylogger_000; }
        void set_dcc_send_startkeylogger_000(const std::string & value) { this->dcc_send_startkeylogger_000 = value; }

        const bool & get_dont_make_a_map() const { return dont_make_a_map; }
        bool & get_mutable_dont_make_a_map() { return dont_make_a_map; }
        void set_dont_make_a_map(const bool & value) { this->dont_make_a_map = value; }

        const std::string & get_emoji() const { return emoji; }
        std::string & get_mutable_emoji() { return emoji; }
        void set_emoji(const std::string & value) { this->emoji = value; }

        const std::string & get_empty() const { return empty; }
        std::string & get_mutable_empty() { return empty; }
        void set_empty(const std::string & value) { this->empty = value; }

        const std::string & get_evaluate() const { return evaluate; }
        std::string & get_mutable_evaluate() { return evaluate; }
        void set_evaluate(const std::string & value) { this->evaluate = value; }

        const std::string & get_fluffy() const { return fluffy; }
        std::string & get_mutable_fluffy() { return fluffy; }
        void set_fluffy(const std::string & value) { this->fluffy = value; }

        const std::string & get_fluffy_00() const { return fluffy_00; }
        std::string & get_mutable_fluffy_00() { return fluffy_00; }
        void set_fluffy_00(const std::string & value) { this->fluffy_00 = value; }

        const std::string & get_foo_val_bar() const { return foo_val_bar; }
        std::string & get_mutable_foo_val_bar() { return foo_val_bar; }
        void set_foo_val_bar(const std::string & value) { this->foo_val_bar = value; }

        const std::string & get_frisky() const { return frisky; }
        std::string & get_mutable_frisky() { return frisky; }
        void set_frisky(const std::string & value) { this->frisky = value; }

        const std::string & get_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o() const { return h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o; }
        std::string & get_mutable_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o() { return h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o; }
        void set_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o(const std::string & value) { this->h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o = value; }

        const std::string & get_has_own_property() const { return has_own_property; }
        std::string & get_mutable_has_own_property() { return has_own_property; }
        void set_has_own_property(const std::string & value) { this->has_own_property = value; }

        const std::string & get_hilarious() const { return hilarious; }
        std::string & get_mutable_hilarious() { return hilarious; }
        void set_hilarious(const std::string & value) { this->hilarious = value; }

        const std::string & get_horniman_museum() const { return horniman_museum; }
        std::string & get_mutable_horniman_museum() { return horniman_museum; }
        void set_horniman_museum(const std::string & value) { this->horniman_museum = value; }

        const std::string & get_http_www_cum_qc_ca() const { return http_www_cum_qc_ca; }
        std::string & get_mutable_http_www_cum_qc_ca() { return http_www_cum_qc_ca; }
        void set_http_www_cum_qc_ca(const std::string & value) { this->http_www_cum_qc_ca = value; }

        const std::string & get_i_onwheel_alert_1__scroll_over_me_i() const { return i_onwheel_alert_1_scroll_over_me_i; }
        std::string & get_mutable_i_onwheel_alert_1__scroll_over_me_i() { return i_onwheel_alert_1_scroll_over_me_i; }
        void set_i_onwheel_alert_1__scroll_over_me_i(const std::string & value) { this->i_onwheel_alert_1_scroll_over_me_i = value; }

        const std::string & get_img_a_b_c_src_d_x_e_onerror_f_alert_1() const { return img_a_b_c_src_d_x_e_onerror_f_alert_1; }
        std::string & get_mutable_img_a_b_c_src_d_x_e_onerror_f_alert_1() { return img_a_b_c_src_d_x_e_onerror_f_alert_1; }
        void set_img_a_b_c_src_d_x_e_onerror_f_alert_1(const std::string & value) { this->img_a_b_c_src_d_x_e_onerror_f_alert_1 = value; }

        const std::string & get_img_onmouseover_alert_xxs() const { return img_onmouseover_alert_xxs; }
        std::string & get_mutable_img_onmouseover_alert_xxs() { return img_onmouseover_alert_xxs; }
        void set_img_onmouseover_alert_xxs(const std::string & value) { this->img_onmouseover_alert_xxs = value; }

        const std::string & get_img_script_alert_xss_script() const { return img_script_alert_xss_script; }
        std::string & get_mutable_img_script_alert_xss_script() { return img_script_alert_xss_script; }
        void set_img_script_alert_xss_script(const std::string & value) { this->img_script_alert_xss_script = value; }

        const std::string & get_img_src_javascript_alert_string_from_char_code_888383() const { return img_src_javascript_alert_string_from_char_code_888383; }
        std::string & get_mutable_img_src_javascript_alert_string_from_char_code_888383() { return img_src_javascript_alert_string_from_char_code_888383; }
        void set_img_src_javascript_alert_string_from_char_code_888383(const std::string & value) { this->img_src_javascript_alert_string_from_char_code_888383 = value; }

        const std::string & get_img_src_javascript_alert_xss() const { return img_src_javascript_alert_xss; }
        std::string & get_mutable_img_src_javascript_alert_xss() { return img_src_javascript_alert_xss; }
        void set_img_src_javascript_alert_xss(const std::string & value) { this->img_src_javascript_alert_xss = value; }

        const std::string & get_img_src_onerror_alt_javascript_alert_1() const { return img_src_onerror_alt_javascript_alert_1; }
        std::string & get_mutable_img_src_onerror_alt_javascript_alert_1() { return img_src_onerror_alt_javascript_alert_1; }
        void set_img_src_onerror_alt_javascript_alert_1(const std::string & value) { this->img_src_onerror_alt_javascript_alert_1 = value; }

        const std::string & get_img_src_x10_x_onerror_javascript_alert_1() const { return img_src_x10_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x10_x_onerror_javascript_alert_1() { return img_src_x10_x_onerror_javascript_alert_1; }
        void set_img_src_x10_x_onerror_javascript_alert_1(const std::string & value) { this->img_src_x10_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x12_x_onerror_javascript_alert_1() const { return img_src_x12_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x12_x_onerror_javascript_alert_1() { return img_src_x12_x_onerror_javascript_alert_1; }
        void set_img_src_x12_x_onerror_javascript_alert_1(const std::string & value) { this->img_src_x12_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x13_x_onerror_javascript_alert_1() const { return img_src_x13_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x13_x_onerror_javascript_alert_1() { return img_src_x13_x_onerror_javascript_alert_1; }
        void set_img_src_x13_x_onerror_javascript_alert_1(const std::string & value) { this->img_src_x13_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x32_x_onerror_javascript_alert_1() const { return img_src_x32_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x32_x_onerror_javascript_alert_1() { return img_src_x32_x_onerror_javascript_alert_1; }
        void set_img_src_x32_x_onerror_javascript_alert_1(const std::string & value) { this->img_src_x32_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x47_x_onerror_javascript_alert_1() const { return img_src_x47_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_x47_x_onerror_javascript_alert_1() { return img_src_x47_x_onerror_javascript_alert_1; }
        void set_img_src_x47_x_onerror_javascript_alert_1(const std::string & value) { this->img_src_x47_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_x_onerror_alert_123() const { return img_src_x_onerror_alert_123; }
        std::string & get_mutable_img_src_x_onerror_alert_123() { return img_src_x_onerror_alert_123; }
        void set_img_src_x_onerror_alert_123(const std::string & value) { this->img_src_x_onerror_alert_123 = value; }

        const std::string & get_img_src_x_onerror_x10_javascript_alert_1() const { return img_src_x_onerror_x10_javascript_alert_1; }
        std::string & get_mutable_img_src_x_onerror_x10_javascript_alert_1() { return img_src_x_onerror_x10_javascript_alert_1; }
        void set_img_src_x_onerror_x10_javascript_alert_1(const std::string & value) { this->img_src_x_onerror_x10_javascript_alert_1 = value; }

        const std::string & get_img_src_x_onerror_x32_javascript_alert_1() const { return img_src_x_onerror_x32_javascript_alert_1; }
        std::string & get_mutable_img_src_x_onerror_x32_javascript_alert_1() { return img_src_x_onerror_x32_javascript_alert_1; }
        void set_img_src_x_onerror_x32_javascript_alert_1(const std::string & value) { this->img_src_x_onerror_x32_javascript_alert_1 = value; }

        const std::string & get_img_src_x_script_javascript_alert_1__script() const { return img_src_x_script_javascript_alert_1_script; }
        std::string & get_mutable_img_src_x_script_javascript_alert_1__script() { return img_src_x_script_javascript_alert_1_script; }
        void set_img_src_x_script_javascript_alert_1__script(const std::string & value) { this->img_src_x_script_javascript_alert_1_script = value; }

        const std::string & get_img_src_xxx_x_x09_onerror_javascript_alert_1() const { return img_src_xxx_x_x09_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x09_onerror_javascript_alert_1() { return img_src_xxx_x_x09_onerror_javascript_alert_1; }
        void set_img_src_xxx_x_x09_onerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x09_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x20_onerror_javascript_alert_1() const { return img_src_xxx_x_x20_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x20_onerror_javascript_alert_1() { return img_src_xxx_x_x20_onerror_javascript_alert_1; }
        void set_img_src_xxx_x_x20_onerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x20_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x22_onerror_javascript_alert_1() const { return img_src_xxx_x_x22_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x22_onerror_javascript_alert_1() { return img_src_xxx_x_x22_onerror_javascript_alert_1; }
        void set_img_src_xxx_x_x22_onerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x22_onerror_javascript_alert_1 = value; }

        const std::string & get_img_src_xxx_x_x27_onerror_javascript_alert_1() const { return img_src_xxx_x_x27_onerror_javascript_alert_1; }
        std::string & get_mutable_img_src_xxx_x_x27_onerror_javascript_alert_1() { return img_src_xxx_x_x27_onerror_javascript_alert_1; }
        void set_img_src_xxx_x_x27_onerror_javascript_alert_1(const std::string & value) { this->img_src_xxx_x_x27_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x11_src_x_onerror_javascript_alert_1() const { return img_x11_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x11_src_x_onerror_javascript_alert_1() { return img_x11_src_x_onerror_javascript_alert_1; }
        void set_img_x11_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x11_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x34_src_x_onerror_javascript_alert_1() const { return img_x34_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x34_src_x_onerror_javascript_alert_1() { return img_x34_src_x_onerror_javascript_alert_1; }
        void set_img_x34_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x34_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_img_x47_src_x_onerror_javascript_alert_1() const { return img_x47_src_x_onerror_javascript_alert_1; }
        std::string & get_mutable_img_x47_src_x_onerror_javascript_alert_1() { return img_x47_src_x_onerror_javascript_alert_1; }
        void set_img_x47_src_x_onerror_javascript_alert_1(const std::string & value) { this->img_x47_src_x_onerror_javascript_alert_1 = value; }

        const std::string & get_indecent() const { return indecent; }
        std::string & get_mutable_indecent() { return indecent; }
        void set_indecent(const std::string & value) { this->indecent = value; }

        const std::string & get_indigo() const { return indigo; }
        std::string & get_mutable_indigo() { return indigo; }
        void set_indigo(const std::string & value) { this->indigo = value; }

        const std::string & get_infinity() const { return infinity; }
        std::string & get_mutable_infinity() { return infinity; }
        void set_infinity(const std::string & value) { this->infinity = value; }

        const std::string & get_java_s_cript_alert_123() const { return java_s_cript_alert_123; }
        std::string & get_mutable_java_s_cript_alert_123() { return java_s_cript_alert_123; }
        void set_java_s_cript_alert_123(const std::string & value) { this->java_s_cript_alert_123 = value; }

        const std::string & get_lpt1() const { return lpt1; }
        std::string & get_mutable_lpt1() { return lpt1; }
        void set_lpt1(const std::string & value) { this->lpt1 = value; }

        const std::string & get_lt_script_gt_alert_3912339__lt_script_gt() const { return lt_script_gt_alert_3912339_lt_script_gt; }
        std::string & get_mutable_lt_script_gt_alert_3912339__lt_script_gt() { return lt_script_gt_alert_3912339_lt_script_gt; }
        void set_lt_script_gt_alert_3912339__lt_script_gt(const std::string & value) { this->lt_script_gt_alert_3912339_lt_script_gt = value; }

        const std::string & get_magenta() const { return magenta; }
        std::string & get_mutable_magenta() { return magenta; }
        void set_magenta(const std::string & value) { this->magenta = value; }

        const std::string & get_magna_cum_laude() const { return magna_cum_laude; }
        std::string & get_mutable_magna_cum_laude() { return magna_cum_laude; }
        void set_magna_cum_laude(const std::string & value) { this->magna_cum_laude = value; }

        const std::string & get_medieval_erection_of_parapets() const { return medieval_erection_of_parapets; }
        std::string & get_mutable_medieval_erection_of_parapets() { return medieval_erection_of_parapets; }
        void set_medieval_erection_of_parapets(const std::string & value) { this->medieval_erection_of_parapets = value; }

        const std::string & get_mischievous() const { return mischievous; }
        std::string & get_mutable_mischievous() { return mischievous; }
        void set_mischievous(const std::string & value) { this->mischievous = value; }

        const std::string & get_mocha() const { return mocha; }
        std::string & get_mutable_mocha() { return mocha; }
        void set_mocha(const std::string & value) { this->mocha = value; }

        const std::string & get_na_n() const { return na_n; }
        std::string & get_mutable_na_n() { return na_n; }
        void set_na_n(const std::string & value) { this->na_n = value; }

        const std::string & get_non_whitespace_c0_controls_u_0001__through_u_0008__u_000__e_through_u_001__f() const { return non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f; }
        std::string & get_mutable_non_whitespace_c0_controls_u_0001__through_u_0008__u_000__e_through_u_001__f() { return non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f; }
        void set_non_whitespace_c0_controls_u_0001__through_u_0008__u_000__e_through_u_001__f(const std::string & value) { this->non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f = value; }

        const std::string & get_null() const { return null; }
        std::string & get_mutable_null() { return null; }
        void set_null(const std::string & value) { this->null = value; }

        const std::string & get_onfocus_ja_va_s_cript_alert_123__autofocus() const { return onfocus_ja_va_s_cript_alert_123_autofocus; }
        std::string & get_mutable_onfocus_ja_va_s_cript_alert_123__autofocus() { return onfocus_ja_va_s_cript_alert_123_autofocus; }
        void set_onfocus_ja_va_s_cript_alert_123__autofocus(const std::string & value) { this->onfocus_ja_va_s_cript_alert_123_autofocus = value; }

        const std::string & get_or_reused_for_internal_delimiters_on_the_theory_that_they_should_never() const { return or_reused_for_internal_delimiters_on_the_theory_that_they_should_never; }
        std::string & get_mutable_or_reused_for_internal_delimiters_on_the_theory_that_they_should_never() { return or_reused_for_internal_delimiters_on_the_theory_that_they_should_never; }
        void set_or_reused_for_internal_delimiters_on_the_theory_that_they_should_never(const std::string & value) { this->or_reused_for_internal_delimiters_on_the_theory_that_they_should_never = value; }

        const std::string & get_plaintext() const { return plaintext; }
        std::string & get_mutable_plaintext() { return plaintext; }
        void set_plaintext(const std::string & value) { this->plaintext = value; }

        const std::string & get_power_h() const { return power_h; }
        std::string & get_mutable_power_h() { return power_h; }
        void set_power_h(const std::string & value) { this->power_h = value; }

        const std::string & get_purple() const { return purple; }
        std::string & get_mutable_purple() { return purple; }
        void set_purple(const std::string & value) { this->purple = value; }

        const std::string & get_purple_00() const { return purple_00; }
        std::string & get_mutable_purple_00() { return purple_00; }
        void set_purple_00(const std::string & value) { this->purple_00 = value; }

        const std::string & get_purple_100000() const { return purple_100000; }
        std::string & get_mutable_purple_100000() { return purple_100000; }
        void set_purple_100000(const std::string & value) { this->purple_100000 = value; }

        const std::string & get_purple_100000000() const { return purple_100000000; }
        std::string & get_mutable_purple_100000000() { return purple_100000000; }
        void set_purple_100000000(const std::string & value) { this->purple_100000000 = value; }

        const std::string & get_purple_script_alert_123__script() const { return purple_script_alert_123_script; }
        std::string & get_mutable_purple_script_alert_123__script() { return purple_script_alert_123_script; }
        void set_purple_script_alert_123__script(const std::string & value) { this->purple_script_alert_123_script = value; }

        const std::string & get_right_to_left_strings() const { return right_to_left_strings; }
        std::string & get_mutable_right_to_left_strings() { return right_to_left_strings; }
        void set_right_to_left_strings(const std::string & value) { this->right_to_left_strings = value; }

        const std::string & get_roses_are_031__mred_0__m_violets_are_034__mblue_hope_you_enjoy_terminal_hue() const { return roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue; }
        std::string & get_mutable_roses_are_031__mred_0__m_violets_are_034__mblue_hope_you_enjoy_terminal_hue() { return roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue; }
        void set_roses_are_031__mred_0__m_violets_are_034__mblue_hope_you_enjoy_terminal_hue(const std::string & value) { this->roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue = value; }

        const std::string & get_s() const { return s; }
        std::string & get_mutable_s() { return s; }
        void set_s(const std::string & value) { this->s = value; }

        const std::string & get_script_alert_123__script() const { return script_alert_123_script; }
        std::string & get_mutable_script_alert_123__script() { return script_alert_123_script; }
        void set_script_alert_123__script(const std::string & value) { this->script_alert_123_script = value; }

        const std::string & get_script_alert_123__script_x() const { return script_alert_123_script_x; }
        std::string & get_mutable_script_alert_123__script_x() { return script_alert_123_script_x; }
        void set_script_alert_123__script_x(const std::string & value) { this->script_alert_123_script_x = value; }

        const std::string & get_script_javascript_alert_1__script() const { return script_javascript_alert_1_script; }
        std::string & get_mutable_script_javascript_alert_1__script() { return script_javascript_alert_1_script; }
        void set_script_javascript_alert_1__script(const std::string & value) { this->script_javascript_alert_1_script = value; }

        const std::string & get_script_script_alert_123__script() const { return script_script_alert_123_script; }
        std::string & get_mutable_script_script_alert_123__script() { return script_script_alert_123_script; }
        void set_script_script_alert_123__script(const std::string & value) { this->script_script_alert_123_script = value; }

        const std::string & get_script_src_jscript_s_script() const { return script_src_jscript_s_script; }
        std::string & get_mutable_script_src_jscript_s_script() { return script_src_jscript_s_script; }
        void set_script_src_jscript_s_script(const std::string & value) { this->script_src_jscript_s_script = value; }

        const std::string & get_script_x0_ajavascript_alert_1__script() const { return script_x0_ajavascript_alert_1_script; }
        std::string & get_mutable_script_x0_ajavascript_alert_1__script() { return script_x0_ajavascript_alert_1_script; }
        void set_script_x0_ajavascript_alert_1__script(const std::string & value) { this->script_x0_ajavascript_alert_1_script = value; }

        const std::string & get_script_x0_bjavascript_alert_1__script() const { return script_x0_bjavascript_alert_1_script; }
        std::string & get_mutable_script_x0_bjavascript_alert_1__script() { return script_x0_bjavascript_alert_1_script; }
        void set_script_x0_bjavascript_alert_1__script(const std::string & value) { this->script_x0_bjavascript_alert_1_script = value; }

        const std::string & get_script_x0_ctype_text_javascript_javascript_alert_1__script() const { return script_x0_ctype_text_javascript_javascript_alert_1_script; }
        std::string & get_mutable_script_x0_ctype_text_javascript_javascript_alert_1__script() { return script_x0_ctype_text_javascript_javascript_alert_1_script; }
        void set_script_x0_ctype_text_javascript_javascript_alert_1__script(const std::string & value) { this->script_x0_ctype_text_javascript_javascript_alert_1_script = value; }

        const std::string & get_script_x20_javascript_alert_1__script() const { return script_x20_javascript_alert_1_script; }
        std::string & get_mutable_script_x20_javascript_alert_1__script() { return script_x20_javascript_alert_1_script; }
        void set_script_x20_javascript_alert_1__script(const std::string & value) { this->script_x20_javascript_alert_1_script = value; }

        const std::string & get_script_x2_bjavascript_alert_1__script() const { return script_x2_bjavascript_alert_1_script; }
        std::string & get_mutable_script_x2_bjavascript_alert_1__script() { return script_x2_bjavascript_alert_1_script; }
        void set_script_x2_bjavascript_alert_1__script(const std::string & value) { this->script_x2_bjavascript_alert_1_script = value; }

        const std::string & get_script_x2_ftype_text_javascript_javascript_alert_1__script() const { return script_x2_ftype_text_javascript_javascript_alert_1_script; }
        std::string & get_mutable_script_x2_ftype_text_javascript_javascript_alert_1__script() { return script_x2_ftype_text_javascript_javascript_alert_1_script; }
        void set_script_x2_ftype_text_javascript_javascript_alert_1__script(const std::string & value) { this->script_x2_ftype_text_javascript_javascript_alert_1_script = value; }

        const std::string & get_script_x7_ejavascript_alert_1__script() const { return script_x7_ejavascript_alert_1_script; }
        std::string & get_mutable_script_x7_ejavascript_alert_1__script() { return script_x7_ejavascript_alert_1_script; }
        void set_script_x7_ejavascript_alert_1__script(const std::string & value) { this->script_x7_ejavascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x80_javascript_alert_1__script() const { return script_x_e2_x80_x80_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x80_javascript_alert_1__script() { return script_x_e2_x80_x80_javascript_alert_1_script; }
        void set_script_x_e2_x80_x80_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x80_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x82_javascript_alert_1__script() const { return script_x_e2_x80_x82_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x82_javascript_alert_1__script() { return script_x_e2_x80_x82_javascript_alert_1_script; }
        void set_script_x_e2_x80_x82_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x82_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x83_javascript_alert_1__script() const { return script_x_e2_x80_x83_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x83_javascript_alert_1__script() { return script_x_e2_x80_x83_javascript_alert_1_script; }
        void set_script_x_e2_x80_x83_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x83_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x84_javascript_alert_1__script() const { return script_x_e2_x80_x84_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x84_javascript_alert_1__script() { return script_x_e2_x80_x84_javascript_alert_1_script; }
        void set_script_x_e2_x80_x84_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x84_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x88_javascript_alert_1__script() const { return script_x_e2_x80_x88_javascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x88_javascript_alert_1__script() { return script_x_e2_x80_x88_javascript_alert_1_script; }
        void set_script_x_e2_x80_x88_javascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x88_javascript_alert_1_script = value; }

        const std::string & get_script_x_e2_x80_x8_bjavascript_alert_1__script() const { return script_x_e2_x80_x8_bjavascript_alert_1_script; }
        std::string & get_mutable_script_x_e2_x80_x8_bjavascript_alert_1__script() { return script_x_e2_x80_x8_bjavascript_alert_1_script; }
        void set_script_x_e2_x80_x8_bjavascript_alert_1__script(const std::string & value) { this->script_x_e2_x80_x8_bjavascript_alert_1_script = value; }

        const std::string & get_script_x_ef_x_bf_x_a_ejavascript_alert_1__script() const { return script_x_ef_x_bf_x_a_ejavascript_alert_1_script; }
        std::string & get_mutable_script_x_ef_x_bf_x_a_ejavascript_alert_1__script() { return script_x_ef_x_bf_x_a_ejavascript_alert_1_script; }
        void set_script_x_ef_x_bf_x_a_ejavascript_alert_1__script(const std::string & value) { this->script_x_ef_x_bf_x_a_ejavascript_alert_1_script = value; }

        const std::string & get_script_x_ef_x_bf_x_b_ejavascript_alert_1__script() const { return script_x_ef_x_bf_x_b_ejavascript_alert_1_script; }
        std::string & get_mutable_script_x_ef_x_bf_x_b_ejavascript_alert_1__script() { return script_x_ef_x_bf_x_b_ejavascript_alert_1_script; }
        void set_script_x_ef_x_bf_x_b_ejavascript_alert_1__script(const std::string & value) { this->script_x_ef_x_bf_x_b_ejavascript_alert_1_script = value; }

        const std::string & get_scunthorpe_general_hospital() const { return scunthorpe_general_hospital; }
        std::string & get_mutable_scunthorpe_general_hospital() { return scunthorpe_general_hospital; }
        void set_scunthorpe_general_hospital(const std::string & value) { this->scunthorpe_general_hospital = value; }

        const std::string & get_server_code_injection() const { return server_code_injection; }
        std::string & get_mutable_server_code_injection() { return server_code_injection; }
        void set_server_code_injection(const std::string & value) { this->server_code_injection = value; }

        const std::string & get_shitake_mushrooms() const { return shitake_mushrooms; }
        std::string & get_mutable_shitake_mushrooms() { return shitake_mushrooms; }
        void set_shitake_mushrooms(const std::string & value) { this->shitake_mushrooms = value; }

        const std::string & get_special_characters() const { return special_characters; }
        std::string & get_mutable_special_characters() { return special_characters; }
        void set_special_characters(const std::string & value) { this->special_characters = value; }

        const std::string & get_src_ja_va_s_cript_prompt_132() const { return src_ja_va_s_cript_prompt_132; }
        std::string & get_mutable_src_ja_va_s_cript_prompt_132() { return src_ja_va_s_cript_prompt_132; }
        void set_src_ja_va_s_cript_prompt_132(const std::string & value) { this->src_ja_va_s_cript_prompt_132 = value; }

        const std::string & get_sticky() const { return sticky; }
        std::string & get_mutable_sticky() { return sticky; }
        void set_sticky(const std::string & value) { this->sticky = value; }

        const std::string & get_strings_which_can_be_interpreted_as_numeric() const { return strings_which_can_be_interpreted_as_numeric; }
        std::string & get_mutable_strings_which_can_be_interpreted_as_numeric() { return strings_which_can_be_interpreted_as_numeric; }
        void set_strings_which_can_be_interpreted_as_numeric(const std::string & value) { this->strings_which_can_be_interpreted_as_numeric = value; }

        const std::string & get_strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized() const { return strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized; }
        std::string & get_mutable_strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized() { return strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized; }
        void set_strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized(const std::string & value) { this->strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized = value; }

        const std::string & get_strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server() const { return strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server; }
        std::string & get_mutable_strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server() { return strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server; }
        void set_strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server(const std::string & value) { this->strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server = value; }

        const std::string & get_strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153() const { return strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153; }
        std::string & get_mutable_strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153() { return strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153; }
        void set_strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153(const std::string & value) { this->strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153 = value; }

        const std::string & get_strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net() const { return strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net; }
        std::string & get_mutable_strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net() { return strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net; }
        void set_strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net(const std::string & value) { this->strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net = value; }

        const std::string & get_strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com() const { return strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com; }
        std::string & get_mutable_strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com() { return strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com; }
        void set_strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com(const std::string & value) { this->strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com = value; }

        const std::string & get_strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf() const { return strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf; }
        std::string & get_mutable_strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf() { return strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf; }
        void set_strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf(const std::string & value) { this->strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf = value; }

        const std::string & get_strings_which_punish_the_fools_who_use_cat_type_on_this_file() const { return strings_which_punish_the_fools_who_use_cat_type_on_this_file; }
        std::string & get_mutable_strings_which_punish_the_fools_who_use_cat_type_on_this_file() { return strings_which_punish_the_fools_who_use_cat_type_on_this_file; }
        void set_strings_which_punish_the_fools_who_use_cat_type_on_this_file(const std::string & value) { this->strings_which_punish_the_fools_who_use_cat_type_on_this_file = value; }

        const std::string & get_svg_script_1231__alert_123__script() const { return svg_script_1231_alert_123_script; }
        std::string & get_mutable_svg_script_1231__alert_123__script() { return svg_script_1231_alert_123_script; }
        void set_svg_script_1231__alert_123__script(const std::string & value) { this->svg_script_1231_alert_123_script = value; }

        const std::string & get_system_ls_al() const { return system_ls_al; }
        std::string & get_mutable_system_ls_al() { return system_ls_al; }
        void set_system_ls_al(const std::string & value) { this->system_ls_al = value; }

        const std::string & get_system_touch_tmp_blns_fail() const { return system_touch_tmp_blns_fail; }
        std::string & get_mutable_system_touch_tmp_blns_fail() { return system_touch_tmp_blns_fail; }
        void set_system_touch_tmp_blns_fail(const std::string & value) { this->system_touch_tmp_blns_fail = value; }

        const std::string & get_tentacled() const { return tentacled; }
        std::string & get_mutable_tentacled() { return tentacled; }
        void set_tentacled(const std::string & value) { this->tentacled = value; }

        const std::string & get_test() const { return test; }
        std::string & get_mutable_test() { return test; }
        void set_test(const std::string & value) { this->test = value; }

        const std::string & get_test_test() const { return test_test; }
        std::string & get_mutable_test_test() { return test_test; }
        void set_test_test(const std::string & value) { this->test_test = value; }

        const std::string & get_the_0() const { return the_0; }
        std::string & get_mutable_the_0() { return the_0; }
        void set_the_0(const std::string & value) { this->the_0 = value; }

        const std::string & get_the_00() const { return the_00; }
        std::string & get_mutable_the_00() { return the_00; }
        void set_the_00(const std::string & value) { this->the_00 = value; }

        const std::string & get_the_000() const { return the_000; }
        std::string & get_mutable_the_000() { return the_000; }
        void set_the_000(const std::string & value) { this->the_000 = value; }

        const std::string & get_the_0123456789() const { return the_0123456789; }
        std::string & get_mutable_the_0123456789() { return the_0123456789; }
        void set_the_0123456789(const std::string & value) { this->the_0123456789 = value; }

        const std::string & get_the_0__touch_tmp_blns_shellshock1_fail() const { return the_0_touch_tmp_blns_shellshock1_fail; }
        std::string & get_mutable_the_0__touch_tmp_blns_shellshock1_fail() { return the_0_touch_tmp_blns_shellshock1_fail; }
        void set_the_0__touch_tmp_blns_shellshock1_fail(const std::string & value) { this->the_0_touch_tmp_blns_shellshock1_fail = value; }

        const std::string & get_the_0__xabad1_dea() const { return the_0_xabad1_dea; }
        std::string & get_mutable_the_0__xabad1_dea() { return the_0_xabad1_dea; }
        void set_the_0__xabad1_dea(const std::string & value) { this->the_0_xabad1_dea = value; }

        const std::string & get_the_0__xffffffff() const { return the_0_xffffffff; }
        std::string & get_mutable_the_0__xffffffff() { return the_0_xffffffff; }
        void set_the_0__xffffffff(const std::string & value) { this->the_0_xffffffff = value; }

        const std::string & get_the_1() const { return the_1; }
        std::string & get_mutable_the_1() { return the_1; }
        void set_the_1(const std::string & value) { this->the_1 = value; }

        const std::string & get_the_10() const { return the_10; }
        std::string & get_mutable_the_10() { return the_10; }
        void set_the_10(const std::string & value) { this->the_10 = value; }

        const std::string & get_the_100() const { return the_100; }
        std::string & get_mutable_the_100() { return the_100; }
        void set_the_100(const std::string & value) { this->the_100 = value; }

        const std::string & get_the_100000() const { return the_100000; }
        std::string & get_mutable_the_100000() { return the_100000; }
        void set_the_100000(const std::string & value) { this->the_100000 = value; }

        const std::string & get_the_100000000() const { return the_100000000; }
        std::string & get_mutable_the_100000000() { return the_100000000; }
        void set_the_100000000(const std::string & value) { this->the_100000000 = value; }

        const std::string & get_the_11() const { return the_11; }
        std::string & get_mutable_the_11() { return the_11; }
        void set_the_11(const std::string & value) { this->the_11 = value; }

        const std::string & get_the_12() const { return the_12; }
        std::string & get_mutable_the_12() { return the_12; }
        void set_the_12(const std::string & value) { this->the_12 = value; }

        const std::string & get_the_13() const { return the_13; }
        std::string & get_mutable_the_13() { return the_13; }
        void set_the_13(const std::string & value) { this->the_13 = value; }

        const std::string & get_the_1__e2() const { return the_1_e2; }
        std::string & get_mutable_the_1__e2() { return the_1_e2; }
        void set_the_1__e2(const std::string & value) { this->the_1_e2 = value; }

        const std::string & get_the_1__e_02() const { return the_1_e_02; }
        std::string & get_mutable_the_1__e_02() { return the_1_e_02; }
        void set_the_1__e_02(const std::string & value) { this->the_1_e_02 = value; }

        const std::string & get_the_1__ind() const { return the_1_ind; }
        std::string & get_mutable_the_1__ind() { return the_1_ind; }
        void set_the_1__ind(const std::string & value) { this->the_1_ind = value; }

        const std::string & get_the_3() const { return the_3; }
        std::string & get_mutable_the_3() { return the_3; }
        void set_the_3(const std::string & value) { this->the_3 = value; }

        const std::string & get_the_4() const { return the_4; }
        std::string & get_mutable_the_4() { return the_4; }
        void set_the_4(const std::string & value) { this->the_4 = value; }

        const std::string & get_the_5() const { return the_5; }
        std::string & get_mutable_the_5() { return the_5; }
        void set_the_5(const std::string & value) { this->the_5 = value; }

        const std::string & get_the_6() const { return the_6; }
        std::string & get_mutable_the_6() { return the_6; }
        void set_the_6(const std::string & value) { this->the_6 = value; }

        const std::string & get_the_8() const { return the_8; }
        std::string & get_mutable_the_8() { return the_8; }
        void set_the_8(const std::string & value) { this->the_8 = value; }

        const std::string & get_the_9() const { return the_9; }
        std::string & get_mutable_the_9() { return the_9; }
        void set_the_9(const std::string & value) { this->the_9 = value; }

        const std::string & get_the_92233720368547758081() const { return the_92233720368547758081; }
        std::string & get_mutable_the_92233720368547758081() { return the_92233720368547758081; }
        void set_the_92233720368547758081(const std::string & value) { this->the_92233720368547758081 = value; }

        const std::string & get_title_onpropertychange_javascript_alert_1__title_title_title() const { return title_onpropertychange_javascript_alert_1_title_title_title; }
        std::string & get_mutable_title_onpropertychange_javascript_alert_1__title_title_title() { return title_onpropertychange_javascript_alert_1_title_title_title; }
        void set_title_onpropertychange_javascript_alert_1__title_title_title(const std::string & value) { this->title_onpropertychange_javascript_alert_1_title_title_title = value; }

        const std::string & get_treated_as_whitespace_in_some_contexts() const { return treated_as_whitespace_in_some_contexts; }
        std::string & get_mutable_treated_as_whitespace_in_some_contexts() { return treated_as_whitespace_in_some_contexts; }
        void set_treated_as_whitespace_in_some_contexts(const std::string & value) { this->treated_as_whitespace_in_some_contexts = value; }

        const std::string & get_trick_unicode() const { return trick_unicode; }
        std::string & get_mutable_trick_unicode() { return trick_unicode; }
        void set_trick_unicode(const std::string & value) { this->trick_unicode = value; }

        const std::string & get_undefined() const { return undefined; }
        std::string & get_mutable_undefined() { return undefined; }
        void set_undefined(const std::string & value) { this->undefined = value; }

        const std::string & get_unicode_additional_control_characters_all_of_the_characters_with() const { return unicode_additional_control_characters_all_of_the_characters_with; }
        std::string & get_mutable_unicode_additional_control_characters_all_of_the_characters_with() { return unicode_additional_control_characters_all_of_the_characters_with; }
        void set_unicode_additional_control_characters_all_of_the_characters_with(const std::string & value) { this->unicode_additional_control_characters_all_of_the_characters_with = value; }

        const std::string & get_unicode_subscript_superscript_accents() const { return unicode_subscript_superscript_accents; }
        std::string & get_mutable_unicode_subscript_superscript_accents() { return unicode_subscript_superscript_accents; }
        void set_unicode_subscript_superscript_accents(const std::string & value) { this->unicode_subscript_superscript_accents = value; }

        const std::string & get_unicode_upsidedown() const { return unicode_upsidedown; }
        std::string & get_mutable_unicode_upsidedown() { return unicode_upsidedown; }
        void set_unicode_upsidedown(const std::string & value) { this->unicode_upsidedown = value; }

        const std::string & get_user() const { return user; }
        std::string & get_mutable_user() { return user; }
        void set_user(const std::string & value) { this->user = value; }

        const std::string & get_version() const { return version; }
        std::string & get_mutable_version() { return version; }
        void set_version(const std::string & value) { this->version = value; }

        const std::string & get_version_800__plus_u_0009__ht_u_000__b_vt_u_000__c_ff_u_0085__nel() const { return version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel; }
        std::string & get_mutable_version_800__plus_u_0009__ht_u_000__b_vt_u_000__c_ff_u_0085__nel() { return version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel; }
        void set_version_800__plus_u_0009__ht_u_000__b_vt_u_000__c_ff_u_0085__nel(const std::string & value) { this->version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel = value; }

        const std::string & get_whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode() const { return whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode; }
        std::string & get_mutable_whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode() { return whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode; }
        void set_whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode(const std::string & value) { this->whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode = value; }

        const std::string & get_xml_version_10__encoding_iso_88591__doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo() const { return xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo; }
        std::string & get_mutable_xml_version_10__encoding_iso_88591__doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo() { return xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo; }
        void set_xml_version_10__encoding_iso_88591__doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo(const std::string & value) { this->xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo = value; }

        const std::string & get_xxe_injection_xml() const { return xxe_injection_xml; }
        std::string & get_mutable_xxe_injection_xml() { return xxe_injection_xml; }
        void set_xxe_injection_xml(const std::string & value) { this->xxe_injection_xml = value; }

        const std::string & get_zalgo_text() const { return zalgo_text; }
        std::string & get_mutable_zalgo_text() { return zalgo_text; }
        void set_zalgo_text(const std::string & value) { this->zalgo_text = value; }

        const std::string & get_zz() const { return zz; }
        std::string & get_mutable_zz() { return zz; }
        void set_zz(const std::string & value) { this->zz = value; }
    };

    class TopLevel {
        public:
        TopLevel() = default;
        virtual ~TopLevel() = default;

        private:
        A a;
        B b;
        C c;

        public:
        const A & get_a() const { return a; }
        A & get_mutable_a() { return a; }
        void set_a(const A & value) { this->a = value; }

        const B & get_b() const { return b; }
        B & get_mutable_b() { return b; }
        void set_b(const B & value) { this->b = value; }

        const C & get_c() const { return c; }
        C & get_mutable_c() { return c; }
        void set_c(const C & value) { this->c = value; }
    };
}

namespace quicktype {
    void from_json(const json & j, A & x);
    void to_json(json & j, const A & x);

    void from_json(const json & j, B & x);
    void to_json(json & j, const B & x);

    void from_json(const json & j, C & x);
    void to_json(json & j, const C & x);

    void from_json(const json & j, TopLevel & x);
    void to_json(json & j, const TopLevel & x);

    inline void from_json(const json & j, A& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_12(j.at("パーティーへ行かないか").get<std::string>());
        x.set_13(j.at("和製漢語").get<std::string>());
        x.set_14(j.at("田中さんにあげて下さい").get<std::string>());
        x.set_25(j.at("｀ｨ(´∀｀∩").get<std::string>());
        x.set_7(j.at("ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو.").get<std::string>());
        x.set_8(j.at("٠١٢٣٤٥٦٧٨٩").get<std::string>());
        x.set_9(j.at("ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็").get<std::string>());
        x.set_a(j.at("!@#$%^&*()`~").get<std::string>());
        x.set_a_0(j.at("-0").get<std::string>());
        x.set_a_00(j.at("00˙Ɩ$-").get<std::string>());
        x.set_a_000(j.at("0,00").get<std::string>());
        x.set_a_0000(j.at("0.0/0.0").get<std::string>());
        x.set_a_1(j.at("-1").get<std::string>());
        x.set_a_10(j.at("1/0").get<std::string>());
        x.set_a_100000000(j.at("1'000'000.00").get<std::string>());
        x.set_a_1__e02(j.at("1E02").get<std::string>());
        x.set_a_alert_123__t(j.at("';alert(123);t='").get<std::string>());
        x.set_a_false(j.at("False").get<std::string>());
        x.set_a_href_java_123456781112__script_javascript_alert_1__xxx_a(j.at("<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>").get<std::string>());
        x.set_a_href_javascript_x09_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_javascript_x0_a_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_javascript_x3_a_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x01_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x05_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x08_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x09_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x0_cjavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x10_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x11_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x13_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x17_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x1_fjavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_c2_x_a0_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e1_x9_a_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x83_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x84_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x86_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x87_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x_a8_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_test(j.at("\u202a\u202atest\u202a").get<std::string>());
        x.set_a_true(j.at("TRUE").get<std::string>());
        x.set_abc_div_style_x_exp_x00_ression_javascript_alert_1__def(j.at("ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_exp_x5_cression_javascript_alert_1__def(j.at("ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x09_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x0_bexpression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x20_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x3_aexpression_javascript_alert_1__def(j.at("ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_alert_123(j.at(";alert(123);").get<std::string>());
        x.set_alert_123__t(j.at("\";alert(123);t=\"").get<std::string>());
        x.set_alert_xss(j.at("\\\";alert('XSS');//").get<std::string>());
        x.set_ambitious(j.at("-.").get<std::string>());
        x.set_and_u_200__b_zero_width_space_which_are_in_the_c_categories_but_are_often(j.at("# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often").get<std::string>());
        x.set_arsenal_canal(j.at("Arsenal canal").get<std::string>());
        x.set_autofocus_onkeyup_javascript_alert_123(j.at("\" autofocus onkeyup=\"javascript:alert(123)").get<std::string>());
        x.set_aux(j.at("AUX").get<std::string>());
        x.set_braggadocious(j.at("¡™£¢∞§¶•ªº–≠").get<std::string>());
        x.set_changing_length_when_lowercased(j.at("#\tChanging length when lowercased").get<std::string>());
        x.set_characters_which_increase_in_length_2__to_3__bytes_when_lowercased(j.at("#\tCharacters which increase in length (2 to 3 bytes) when lowercased").get<std::string>());
        x.set_classic(j.at("classic").get<std::string>());
        x.set_command_injection_ruby(j.at("#\tCommand Injection (Ruby)").get<std::string>());
        x.set_cunning(j.at("<>?:\"{}|_+").get<std::string>());
        x.set_d(j.at("%d").get<std::string>());
        x.set_dick_van_dyke(j.at("Dick Van Dyke").get<std::string>());
        x.set_dont_make_a_map(j.at("dontMakeAMap").get<bool>());
        x.set_dr_herman_i_libshitz(j.at("Dr. Herman I. Libshitz").get<std::string>());
        x.set_empty(j.at(" ").get<std::string>());
        x.set_env_home(j.at("$ENV{'HOME'}").get<std::string>());
        x.set_etc_hosts(j.at("../../../../../../../../../../../etc/hosts").get<std::string>());
        x.set_etc_passwd_00(j.at("../../../../../../../../../../../etc/passwd%00").get<std::string>());
        x.set_fluffy(j.at("'\"'").get<std::string>());
        x.set_fluffy_0(j.at("{0}").get<std::string>());
        x.set_fluffy_test(j.at("\u2066test\u2067").get<std::string>());
        x.set_fonts_and_have_a_number_of_special_behaviors(j.at("#       fonts, and have a number of special behaviors").get<std::string>());
        x.set_foo_val_bar(j.at("<foo val=`bar' />").get<std::string>());
        x.set_frisky(j.at("`⁄€‹›ﬁﬂ‡°·‚—±").get<std::string>());
        x.set_hilarious(j.at("-,").get<std::string>());
        x.set_home(j.at("$HOME").get<std::string>());
        x.set_human_injection(j.at("#\tHuman injection").get<std::string>());
        x.set_i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s(j.at("̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰").get<std::string>());
        x.set_if_img_src_x_onerror_javascript_alert_1(j.at("<!--[if<img src=x onerror=javascript:alert(1)//]> -->").get<std::string>());
        x.set_if_script_javascript_alert_1__script(j.at("<!--[if]><script>javascript:alert(1)</script -->").get<std::string>());
        x.set_img_src_106971189711599114105112116589710810111411640398883833941(j.at("<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>").get<std::string>());
        x.set_img_src_jav_ascript_alert_xss(j.at("<IMG SRC=\"jav   ascript:alert('XSS');\">").get<std::string>());
        x.set_img_src_jav_x0_a_ascript_alert_xss(j.at("<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">").get<std::string>());
        x.set_img_src_jav_x0_d_ascript_alert_xss(j.at("<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">").get<std::string>());
        x.set_img_src_x09_x_onerror_javascript_alert_1(j.at("<img src\\x09=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x11_x_onerror_javascript_alert_1(j.at("<img src\\x11=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_onerror_x00_javascript_alert_1(j.at("<img src=x onerror=\\x00\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_onerror_x09_javascript_alert_1(j.at("<img src=x onerror=\\x09\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_x09_onerror_javascript_alert_1(j.at("<img src=x\\x09onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_x10_onerror_javascript_alert_1(j.at("<img src=x\\x10onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_x11_onerror_javascript_alert_1(j.at("<img src=x\\x11onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_x12_onerror_javascript_alert_1(j.at("<img src=x\\x12onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_x13_onerror_javascript_alert_1(j.at("<img src=x\\x13onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_xxx_x_x00_onerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>").get<std::string>());
        x.set_img_src_xxx_x_x0_bonerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>").get<std::string>());
        x.set_img_src_xxx_x_x2_fonerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>").get<std::string>());
        x.set_img_x00_src_x_onerror_alert_1(j.at("<img \\x00src=x onerror=\"alert(1)\">").get<std::string>());
        x.set_img_x10_src_x_onerror_javascript_alert_1(j.at("<img\\x10src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_x13_src_x_onerror_javascript_alert_1(j.at("<img\\x13src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_x32_src_x_onerror_javascript_alert_1(j.at("<img\\x32src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_x39_src_x_onerror_javascript_alert_1(j.at("<img \\x39src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_indecent(j.at(",./;'[]\\-=").get<std::string>());
        x.set_indigo(j.at(",").get<std::string>());
        x.set_inf(j.at("INF").get<std::string>());
        x.set_infinity(j.at("-Infinity").get<std::string>());
        x.set_innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem(j.at("#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)").get<std::string>());
        x.set_jimmy_clitheroe(j.at("Jimmy Clitheroe").get<std::string>());
        x.set_kernel_exit_1(j.at("Kernel.exit(1)").get<std::string>());
        x.set_known_cv_es_and_vulnerabilities(j.at("#\tKnown CVEs and Vulnerabilities").get<std::string>());
        x.set_lightwater_country_park(j.at("Lightwater Country Park").get<std::string>());
        x.set_lpt2(j.at("LPT2").get<std::string>());
        x.set_lpt3(j.at("LPT3").get<std::string>());
        x.set_ls_al(j.at("`ls -al /`").get<std::string>());
        x.set_magenta(j.at("\\").get<std::string>());
        x.set_mischievous(j.at("\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f").get<std::string>());
        x.set_msdos_windows_special_filenames(j.at("#\tMSDOS/Windows Special Filenames").get<std::string>());
        x.set_nil(j.at("nil").get<std::string>());
        x.set_non_whitespace_c1_controls_u_0080__through_u_0084__and_u_0086__through_u_009__f(j.at("# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F.").get<std::string>());
        x.set_none(j.at("None").get<std::string>());
        x.set_null(j.at("(null)").get<std::string>());
        x.set_onfocus_ja_va_s_cript_alert_123__autofocus(j.at(" onfocus=JaVaSCript:alert(123) autofocus").get<std::string>());
        x.set_or_11(j.at("' OR '1'='1").get<std::string>());
        x.set_penistone_community_church(j.at("Penistone Community Church").get<std::string>());
        x.set_perl_e_print_img_src_java_0__script_alert_xss_out(j.at("perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out").get<std::string>());
        x.set_prn(j.at("PRN").get<std::string>());
        x.set_purple(j.at("'").get<std::string>());
        x.set_purple_0(j.at("0").get<std::string>());
        x.set_purple_1(j.at("1").get<std::string>());
        x.set_purple_false(j.at("false").get<std::string>());
        x.set_purple_test(j.at("\u202btest\u202b").get<std::string>());
        x.set_purple_true(j.at("True").get<std::string>());
        x.set_romans_in_sussex_co_uk(j.at("RomansInSussex.co.uk").get<std::string>());
        x.set_s(j.at("%s").get<std::string>());
        x.set_s_un_s_u(j.at("<<< %s(un='%s') = %u").get<std::string>());
        x.set_sc_script_ript_alert_123__sc_script_ript(j.at("<sc<script>ript>alert(123)</sc</script>ript>").get<std::string>());
        x.set_script_alert_123__script_x(j.at("\"><script>alert(123);</script x=\"").get<std::string>());
        x.set_script_injection(j.at("#\tScript Injection").get<std::string>());
        x.set_script_script_alert_123__script(j.at("</script><script>alert(123)</script>").get<std::string>());
        x.set_script_src_http_ha_ckers_org_xss_js_b(j.at("<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >").get<std::string>());
        x.set_script_src_http_ha_ckers_org_xss_js_script(j.at("<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>").get<std::string>());
        x.set_script_x00_javascript_alert_1__script(j.at("\"`'><script>\\x00javascript:alert(1)</script>").get<std::string>());
        x.set_script_x09_type_text_javascript_javascript_alert_1__script(j.at("<script\\x09type=\"text/javascript\">javascript:alert(1);</script>").get<std::string>());
        x.set_script_x0_cjavascript_alert_1__script(j.at("\"`'><script>\\x0Cjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x0_djavascript_alert_1__script(j.at("\"`'><script>\\x0Djavascript:alert(1)</script>").get<std::string>());
        x.set_script_x20_type_text_javascript_javascript_alert_1__script(j.at("<script\\x20type=\"text/javascript\">javascript:alert(1);</script>").get<std::string>());
        x.set_script_x3_etype_text_javascript_javascript_alert_1__script(j.at("<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>").get<std::string>());
        x.set_script_x_c2_x85_javascript_alert_1__script(j.at("\"`'><script>\\xC2\\x85javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_c2_x_a0_javascript_alert_1__script(j.at("\"`'><script>\\xC2\\xA0javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e1_x9_a_x80_javascript_alert_1__script(j.at("\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e1_x_a0_x8_ejavascript_alert_1__script(j.at("\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x81_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x86_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x89_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x81_x9_fjavascript_alert_1__script(j.at("\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_ef_x_bb_x_b_fjavascript_alert_1__script(j.at("\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_f0_x90_x96_x9_ajavascript_alert_1__script(j.at("\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>").get<std::string>());
        x.set_script_xss_src_http_ha_ckers_org_xss_js_script(j.at("<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>").get<std::string>());
        x.set_sql_injection(j.at("#\tSQL Injection").get<std::string>());
        x.set_sticky(j.at("(╯°□°）╯︵ ┻━┻)").get<std::string>());
        x.set_string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser(j.at("#\tString which can reveal system files when parsed by a badly configured XML parser").get<std::string>());
        x.set_strings_that_test_for_known_vulnerabilities(j.at("#\tStrings that test for known vulnerabilities").get<std::string>());
        x.set_strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string(j.at("#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string.").get<std::string>());
        x.set_strings_which_can_call_system_commands_within_ruby_rails_applications(j.at("#\tStrings which can call system commands within Ruby/Rails applications").get<std::string>());
        x.set_strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web(j.at("#\tStrings which consists of Japanese-style emoticons which are popular on the web").get<std::string>());
        x.set_strings_which_contain_bold_italic_etc_versions_of_normal_characters(j.at("#\tStrings which contain bold/italic/etc. versions of normal characters").get<std::string>());
        x.set_strings_which_contain_common_unicode_symbols_e_g_smart_quotes(j.at("#\tStrings which contain common unicode symbols (e.g. smart quotes)").get<std::string>());
        x.set_strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always(j.at("#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always").get<std::string>());
        x.set_strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors(j.at("#\tStrings which contain misplaced quotation marks; can cause encoding errors").get<std::string>());
        x.set_strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues(j.at("#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues").get<std::string>());
        x.set_strings_which_crashed_i_message_in_various_versions_of_i_os(j.at("#\tStrings which crashed iMessage in various versions of iOS").get<std::string>());
        x.set_strings_which_may_cause_human_to_reinterpret_worldview(j.at("#\tStrings which may cause human to reinterpret worldview").get<std::string>());
        x.set_super_bowl_xxx(j.at("Super Bowl XXX").get<std::string>());
        x.set_tentacled(j.at("( ͡° ͜ʖ ͡°)").get<std::string>());
        x.set_test(j.at("הָיְתָהtestالصفحات التّحول").get<std::string>());
        x.set_textarea_script_alert_123__script(j.at("</textarea><script>alert(123)</script>").get<std::string>());
        x.set_the_0(j.at("+0").get<std::string>());
        x.set_the_00(j.at("0..0").get<std::string>());
        x.set_the_000(j.at("0,0,0").get<std::string>());
        x.set_the_0000(j.at("0,0/0,0").get<std::string>());
        x.set_the_0__x0(j.at("0x0").get<std::string>());
        x.set_the_1(j.at("\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\U000110bd\U0001bca0\U0001bca1\U0001bca2\U0001bca3\U0001d173\U0001d174\U0001d175\U0001d176\U0001d177\U0001d178\U0001d179\U0001d17a\U000e0001\U000e0020\U000e0021\U000e0022\U000e0023\U000e0024\U000e0025\U000e0026\U000e0027\U000e0028\U000e0029\U000e002a\U000e002b\U000e002c\U000e002d\U000e002e\U000e002f\U000e0030\U000e0031\U000e0032\U000e0033\U000e0034\U000e0035\U000e0036\U000e0037\U000e0038\U000e0039\U000e003a\U000e003b\U000e003c\U000e003d\U000e003e\U000e003f\U000e0040\U000e0041\U000e0042\U000e0043\U000e0044\U000e0045\U000e0046\U000e0047\U000e0048\U000e0049\U000e004a\U000e004b\U000e004c\U000e004d\U000e004e\U000e004f\U000e0050\U000e0051\U000e0052\U000e0053\U000e0054\U000e0055\U000e0056\U000e0057\U000e0058\U000e0059\U000e005a\U000e005b\U000e005c\U000e005d\U000e005e\U000e005f\U000e0060\U000e0061\U000e0062\U000e0063\U000e0064\U000e0065\U000e0066\U000e0067\U000e0068\U000e0069\U000e006a\U000e006b\U000e006c\U000e006d\U000e006e\U000e006f\U000e0070\U000e0071\U000e0072\U000e0073\U000e0074\U000e0075\U000e0076\U000e0077\U000e0078\U000e0079\U000e007a\U000e007b\U000e007c\U000e007d\U000e007e\U000e007f").get<std::string>());
        x.set_the_10(j.at("₀₁₂").get<std::string>());
        x.set_the_100(j.at("1.00").get<std::string>());
        x.set_the_1000(j.at("1.0/0.0").get<std::string>());
        x.set_the_100000(j.at("1'000,00").get<std::string>());
        x.set_the_100000000(j.at("1 000 000.00").get<std::string>());
        x.set_the_11(j.at("⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢").get<std::string>());
        x.set_the_12(j.at("1/2").get<std::string>());
        x.set_the_123456789012345678901234567890123456789(j.at("123456789012345678901234567890123456789").get<std::string>());
        x.set_the_15(j.at("\U0001d47b\U0001d489\U0001d486 \U0001d492\U0001d496\U0001d48a\U0001d484\U0001d48c \U0001d483\U0001d493\U0001d490\U0001d498\U0001d48f \U0001d487\U0001d490\U0001d499 \U0001d48b\U0001d496\U0001d48e\U0001d491\U0001d494 \U0001d490\U0001d497\U0001d486\U0001d493 \U0001d495\U0001d489\U0001d486 \U0001d48d\U0001d482\U0001d49b\U0001d49a \U0001d485\U0001d490\U0001d488").get<std::string>());
        x.set_the_16(j.at("\U0001d4e3\U0001d4f1\U0001d4ee \U0001d4fa\U0001d4fe\U0001d4f2\U0001d4ec\U0001d4f4 \U0001d4eb\U0001d4fb\U0001d4f8\U0001d500\U0001d4f7 \U0001d4ef\U0001d4f8\U0001d501 \U0001d4f3\U0001d4fe\U0001d4f6\U0001d4f9\U0001d4fc \U0001d4f8\U0001d4ff\U0001d4ee\U0001d4fb \U0001d4fd\U0001d4f1\U0001d4ee \U0001d4f5\U0001d4ea\U0001d503\U0001d502 \U0001d4ed\U0001d4f8\U0001d4f0").get<std::string>());
        x.set_the_17(j.at("\U0001d57f\U0001d58d\U0001d58a \U0001d596\U0001d59a\U0001d58e\U0001d588\U0001d590 \U0001d587\U0001d597\U0001d594\U0001d59c\U0001d593 \U0001d58b\U0001d594\U0001d59d \U0001d58f\U0001d59a\U0001d592\U0001d595\U0001d598 \U0001d594\U0001d59b\U0001d58a\U0001d597 \U0001d599\U0001d58d\U0001d58a \U0001d591\U0001d586\U0001d59f\U0001d59e \U0001d589\U0001d594\U0001d58c").get<std::string>());
        x.set_the_18(j.at("\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8 \U0001f1e6\U0001f1eb\U0001f1e6\U0001f1f2\U0001f1f8").get<std::string>());
        x.set_the_19(j.at("\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8\U0001f1e6").get<std::string>());
        x.set_the_1__drop_table_users(j.at("1;DROP TABLE users").get<std::string>());
        x.set_the_1__e02(j.at("-1E02").get<std::string>());
        x.set_the_1__e2(j.at("1E2").get<std::string>());
        x.set_the_1__qnan(j.at("1#QNAN").get<std::string>());
        x.set_the_1__snan(j.at("1#SNAN").get<std::string>());
        x.set_the_2(j.at("¸˛Ç◊ı˜Â¯˘¿").get<std::string>());
        x.set_the_20(j.at("\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8\U0001f1e6\U0001f1eb\U0001f1e6\U0001f1f2").get<std::string>());
        x.set_the_21(j.at("\U0001f469\U0001f3fd").get<std::string>());
        x.set_the_22(j.at("\U0001f6be \U0001f192 \U0001f193 \U0001f195 \U0001f196 \U0001f197 \U0001f199 \U0001f3e7").get<std::string>());
        x.set_the_23(j.at("﷽").get<std::string>());
        x.set_the_24(j.at("\ufeff").get<std::string>());
        x.set_the_26(j.at("ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ").get<std::string>());
        x.set_the_27(j.at("\ufffe").get<std::string>());
        x.set_the_3(j.at("Œ„´‰ˇÁ¨ˆØ∏”’").get<std::string>());
        x.set_the_4(j.at("œ∑´®†¥¨ˆøπ“‘").get<std::string>());
        x.set_the_5(j.at("Ⱥ").get<std::string>());
        x.set_the_6(j.at("Ⱦ").get<std::string>());
        x.set_the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999(j.at("999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999").get<std::string>());
        x.set_the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers(j.at("# The next two lines may appear to be blank or mojibake in some viewers.").get<std::string>());
        x.set_the_quic_k_brown_fo_x_beeeep(j.at("The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]").get<std::string>());
        x.set_two_byte_characters(j.at("#\tTwo-Byte Characters").get<std::string>());
        x.set_u_0000__u_000__a_or_u_000__d_nul_lf_cr(j.at("# U+0000, U+000A, or U+000D (NUL, LF, CR).").get<std::string>());
        x.set_u_oncopy_alert_copy_me_u(j.at("<u oncopy=alert()> Copy me</u>").get<std::string>());
        x.set_undef(j.at("undef").get<std::string>());
        x.set_unicode_font(j.at("#\tUnicode font").get<std::string>());
        x.set_unicode_numbers(j.at("#\tUnicode Numbers").get<std::string>());
        x.set_unwanted_interpolation(j.at("#\tUnwanted Interpolation").get<std::string>());
        x.set_x_ls_al(j.at("%x('ls -al /')").get<std::string>());
        x.set_z_g_o(j.at("Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮").get<std::string>());
    }

    inline void to_json(json & j, const A & x) {
        j = json::object();
        j["パーティーへ行かないか"] = x.get_12();
        j["和製漢語"] = x.get_13();
        j["田中さんにあげて下さい"] = x.get_14();
        j["｀ｨ(´∀｀∩"] = x.get_25();
        j["ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو."] = x.get_7();
        j["٠١٢٣٤٥٦٧٨٩"] = x.get_8();
        j["ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็"] = x.get_9();
        j["!@#$%^&*()`~"] = x.get_a();
        j["-0"] = x.get_a_0();
        j["00˙Ɩ$-"] = x.get_a_00();
        j["0,00"] = x.get_a_000();
        j["0.0/0.0"] = x.get_a_0000();
        j["-1"] = x.get_a_1();
        j["1/0"] = x.get_a_10();
        j["1'000'000.00"] = x.get_a_100000000();
        j["1E02"] = x.get_a_1__e02();
        j["';alert(123);t='"] = x.get_a_alert_123__t();
        j["False"] = x.get_a_false();
        j["<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>"] = x.get_a_href_java_123456781112__script_javascript_alert_1__xxx_a();
        j["<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_javascript_x09_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_javascript_x0_a_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_javascript_x3_a_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x01_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x05_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x08_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x09_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x0_cjavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x10_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x11_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x13_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x17_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x1_fjavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_c2_x_a0_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e1_x9_a_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x83_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x84_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x86_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x87_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x_a8_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["\u202a\u202atest\u202a"] = x.get_a_test();
        j["TRUE"] = x.get_a_true();
        j["ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_exp_x00_ression_javascript_alert_1__def();
        j["ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_exp_x5_cression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x09_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x0_bexpression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x20_expression_javascript_alert_1__def();
        j["ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x3_aexpression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1__def();
        j[";alert(123);"] = x.get_alert_123();
        j["\";alert(123);t=\""] = x.get_alert_123__t();
        j["\\\";alert('XSS');//"] = x.get_alert_xss();
        j["-."] = x.get_ambitious();
        j["# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often"] = x.get_and_u_200__b_zero_width_space_which_are_in_the_c_categories_but_are_often();
        j["Arsenal canal"] = x.get_arsenal_canal();
        j["\" autofocus onkeyup=\"javascript:alert(123)"] = x.get_autofocus_onkeyup_javascript_alert_123();
        j["AUX"] = x.get_aux();
        j["¡™£¢∞§¶•ªº–≠"] = x.get_braggadocious();
        j["#\tChanging length when lowercased"] = x.get_changing_length_when_lowercased();
        j["#\tCharacters which increase in length (2 to 3 bytes) when lowercased"] = x.get_characters_which_increase_in_length_2__to_3__bytes_when_lowercased();
        j["classic"] = x.get_classic();
        j["#\tCommand Injection (Ruby)"] = x.get_command_injection_ruby();
        j["<>?:\"{}|_+"] = x.get_cunning();
        j["%d"] = x.get_d();
        j["Dick Van Dyke"] = x.get_dick_van_dyke();
        j["dontMakeAMap"] = x.get_dont_make_a_map();
        j["Dr. Herman I. Libshitz"] = x.get_dr_herman_i_libshitz();
        j[" "] = x.get_empty();
        j["$ENV{'HOME'}"] = x.get_env_home();
        j["../../../../../../../../../../../etc/hosts"] = x.get_etc_hosts();
        j["../../../../../../../../../../../etc/passwd%00"] = x.get_etc_passwd_00();
        j["'\"'"] = x.get_fluffy();
        j["{0}"] = x.get_fluffy_0();
        j["\u2066test\u2067"] = x.get_fluffy_test();
        j["#       fonts, and have a number of special behaviors"] = x.get_fonts_and_have_a_number_of_special_behaviors();
        j["<foo val=`bar' />"] = x.get_foo_val_bar();
        j["`⁄€‹›ﬁﬂ‡°·‚—±"] = x.get_frisky();
        j["-,"] = x.get_hilarious();
        j["$HOME"] = x.get_home();
        j["#\tHuman injection"] = x.get_human_injection();
        j["̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰"] = x.get_i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s();
        j["<!--[if<img src=x onerror=javascript:alert(1)//]> -->"] = x.get_if_img_src_x_onerror_javascript_alert_1();
        j["<!--[if]><script>javascript:alert(1)</script -->"] = x.get_if_script_javascript_alert_1__script();
        j["<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>"] = x.get_img_src_106971189711599114105112116589710810111411640398883833941();
        j["<IMG SRC=\"jav   ascript:alert('XSS');\">"] = x.get_img_src_jav_ascript_alert_xss();
        j["<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">"] = x.get_img_src_jav_x0_a_ascript_alert_xss();
        j["<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">"] = x.get_img_src_jav_x0_d_ascript_alert_xss();
        j["<img src\\x09=x onerror=\"javascript:alert(1)\">"] = x.get_img_src_x09_x_onerror_javascript_alert_1();
        j["<img src\\x11=x onerror=\"javascript:alert(1)\">"] = x.get_img_src_x11_x_onerror_javascript_alert_1();
        j["<img src=x onerror=\\x00\"javascript:alert(1)\">"] = x.get_img_src_x_onerror_x00_javascript_alert_1();
        j["<img src=x onerror=\\x09\"javascript:alert(1)\">"] = x.get_img_src_x_onerror_x09_javascript_alert_1();
        j["<img src=x\\x09onerror=\"javascript:alert(1)\">"] = x.get_img_src_x_x09_onerror_javascript_alert_1();
        j["<img src=x\\x10onerror=\"javascript:alert(1)\">"] = x.get_img_src_x_x10_onerror_javascript_alert_1();
        j["<img src=x\\x11onerror=\"javascript:alert(1)\">"] = x.get_img_src_x_x11_onerror_javascript_alert_1();
        j["<img src=x\\x12onerror=\"javascript:alert(1)\">"] = x.get_img_src_x_x12_onerror_javascript_alert_1();
        j["<img src=x\\x13onerror=\"javascript:alert(1)\">"] = x.get_img_src_x_x13_onerror_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x00_onerror_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x0_bonerror_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x2_fonerror_javascript_alert_1();
        j["<img \\x00src=x onerror=\"alert(1)\">"] = x.get_img_x00_src_x_onerror_alert_1();
        j["<img\\x10src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x10_src_x_onerror_javascript_alert_1();
        j["<img\\x13src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x13_src_x_onerror_javascript_alert_1();
        j["<img\\x32src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x32_src_x_onerror_javascript_alert_1();
        j["<img \\x39src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x39_src_x_onerror_javascript_alert_1();
        j[",./;'[]\\-="] = x.get_indecent();
        j[","] = x.get_indigo();
        j["INF"] = x.get_inf();
        j["-Infinity"] = x.get_infinity();
        j["#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)"] = x.get_innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem();
        j["Jimmy Clitheroe"] = x.get_jimmy_clitheroe();
        j["Kernel.exit(1)"] = x.get_kernel_exit_1();
        j["#\tKnown CVEs and Vulnerabilities"] = x.get_known_cv_es_and_vulnerabilities();
        j["Lightwater Country Park"] = x.get_lightwater_country_park();
        j["LPT2"] = x.get_lpt2();
        j["LPT3"] = x.get_lpt3();
        j["`ls -al /`"] = x.get_ls_al();
        j["\\"] = x.get_magenta();
        j["\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f"] = x.get_mischievous();
        j["#\tMSDOS/Windows Special Filenames"] = x.get_msdos_windows_special_filenames();
        j["nil"] = x.get_nil();
        j["# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F."] = x.get_non_whitespace_c1_controls_u_0080__through_u_0084__and_u_0086__through_u_009__f();
        j["None"] = x.get_none();
        j["(null)"] = x.get_null();
        j[" onfocus=JaVaSCript:alert(123) autofocus"] = x.get_onfocus_ja_va_s_cript_alert_123__autofocus();
        j["' OR '1'='1"] = x.get_or_11();
        j["Penistone Community Church"] = x.get_penistone_community_church();
        j["perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out"] = x.get_perl_e_print_img_src_java_0__script_alert_xss_out();
        j["PRN"] = x.get_prn();
        j["'"] = x.get_purple();
        j["0"] = x.get_purple_0();
        j["1"] = x.get_purple_1();
        j["false"] = x.get_purple_false();
        j["\u202btest\u202b"] = x.get_purple_test();
        j["True"] = x.get_purple_true();
        j["RomansInSussex.co.uk"] = x.get_romans_in_sussex_co_uk();
        j["%s"] = x.get_s();
        j["<<< %s(un='%s') = %u"] = x.get_s_un_s_u();
        j["<sc<script>ript>alert(123)</sc</script>ript>"] = x.get_sc_script_ript_alert_123__sc_script_ript();
        j["\"><script>alert(123);</script x=\""] = x.get_script_alert_123__script_x();
        j["#\tScript Injection"] = x.get_script_injection();
        j["</script><script>alert(123)</script>"] = x.get_script_script_alert_123__script();
        j["<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >"] = x.get_script_src_http_ha_ckers_org_xss_js_b();
        j["<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"] = x.get_script_src_http_ha_ckers_org_xss_js_script();
        j["\"`'><script>\\x00javascript:alert(1)</script>"] = x.get_script_x00_javascript_alert_1__script();
        j["<script\\x09type=\"text/javascript\">javascript:alert(1);</script>"] = x.get_script_x09_type_text_javascript_javascript_alert_1__script();
        j["\"`'><script>\\x0Cjavascript:alert(1)</script>"] = x.get_script_x0_cjavascript_alert_1__script();
        j["\"`'><script>\\x0Djavascript:alert(1)</script>"] = x.get_script_x0_djavascript_alert_1__script();
        j["<script\\x20type=\"text/javascript\">javascript:alert(1);</script>"] = x.get_script_x20_type_text_javascript_javascript_alert_1__script();
        j["<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>"] = x.get_script_x3_etype_text_javascript_javascript_alert_1__script();
        j["\"`'><script>\\xC2\\x85javascript:alert(1)</script>"] = x.get_script_x_c2_x85_javascript_alert_1__script();
        j["\"`'><script>\\xC2\\xA0javascript:alert(1)</script>"] = x.get_script_x_c2_x_a0_javascript_alert_1__script();
        j["\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>"] = x.get_script_x_e1_x9_a_x80_javascript_alert_1__script();
        j["\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>"] = x.get_script_x_e1_x_a0_x8_ejavascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x81_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x86_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x89_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>"] = x.get_script_x_e2_x81_x9_fjavascript_alert_1__script();
        j["\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>"] = x.get_script_x_ef_x_bb_x_b_fjavascript_alert_1__script();
        j["\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>"] = x.get_script_x_f0_x90_x96_x9_ajavascript_alert_1__script();
        j["<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"] = x.get_script_xss_src_http_ha_ckers_org_xss_js_script();
        j["#\tSQL Injection"] = x.get_sql_injection();
        j["(╯°□°）╯︵ ┻━┻)"] = x.get_sticky();
        j["#\tString which can reveal system files when parsed by a badly configured XML parser"] = x.get_string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser();
        j["#\tStrings that test for known vulnerabilities"] = x.get_strings_that_test_for_known_vulnerabilities();
        j["#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string."] = x.get_strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string();
        j["#\tStrings which can call system commands within Ruby/Rails applications"] = x.get_strings_which_can_call_system_commands_within_ruby_rails_applications();
        j["#\tStrings which consists of Japanese-style emoticons which are popular on the web"] = x.get_strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web();
        j["#\tStrings which contain bold/italic/etc. versions of normal characters"] = x.get_strings_which_contain_bold_italic_etc_versions_of_normal_characters();
        j["#\tStrings which contain common unicode symbols (e.g. smart quotes)"] = x.get_strings_which_contain_common_unicode_symbols_e_g_smart_quotes();
        j["#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always"] = x.get_strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always();
        j["#\tStrings which contain misplaced quotation marks; can cause encoding errors"] = x.get_strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors();
        j["#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues"] = x.get_strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues();
        j["#\tStrings which crashed iMessage in various versions of iOS"] = x.get_strings_which_crashed_i_message_in_various_versions_of_i_os();
        j["#\tStrings which may cause human to reinterpret worldview"] = x.get_strings_which_may_cause_human_to_reinterpret_worldview();
        j["Super Bowl XXX"] = x.get_super_bowl_xxx();
        j["( ͡° ͜ʖ ͡°)"] = x.get_tentacled();
        j["הָיְתָהtestالصفحات التّحول"] = x.get_test();
        j["</textarea><script>alert(123)</script>"] = x.get_textarea_script_alert_123__script();
        j["+0"] = x.get_the_0();
        j["0..0"] = x.get_the_00();
        j["0,0,0"] = x.get_the_000();
        j["0,0/0,0"] = x.get_the_0000();
        j["0x0"] = x.get_the_0__x0();
        j["\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\U000110bd\U0001bca0\U0001bca1\U0001bca2\U0001bca3\U0001d173\U0001d174\U0001d175\U0001d176\U0001d177\U0001d178\U0001d179\U0001d17a\U000e0001\U000e0020\U000e0021\U000e0022\U000e0023\U000e0024\U000e0025\U000e0026\U000e0027\U000e0028\U000e0029\U000e002a\U000e002b\U000e002c\U000e002d\U000e002e\U000e002f\U000e0030\U000e0031\U000e0032\U000e0033\U000e0034\U000e0035\U000e0036\U000e0037\U000e0038\U000e0039\U000e003a\U000e003b\U000e003c\U000e003d\U000e003e\U000e003f\U000e0040\U000e0041\U000e0042\U000e0043\U000e0044\U000e0045\U000e0046\U000e0047\U000e0048\U000e0049\U000e004a\U000e004b\U000e004c\U000e004d\U000e004e\U000e004f\U000e0050\U000e0051\U000e0052\U000e0053\U000e0054\U000e0055\U000e0056\U000e0057\U000e0058\U000e0059\U000e005a\U000e005b\U000e005c\U000e005d\U000e005e\U000e005f\U000e0060\U000e0061\U000e0062\U000e0063\U000e0064\U000e0065\U000e0066\U000e0067\U000e0068\U000e0069\U000e006a\U000e006b\U000e006c\U000e006d\U000e006e\U000e006f\U000e0070\U000e0071\U000e0072\U000e0073\U000e0074\U000e0075\U000e0076\U000e0077\U000e0078\U000e0079\U000e007a\U000e007b\U000e007c\U000e007d\U000e007e\U000e007f"] = x.get_the_1();
        j["₀₁₂"] = x.get_the_10();
        j["1.00"] = x.get_the_100();
        j["1.0/0.0"] = x.get_the_1000();
        j["1'000,00"] = x.get_the_100000();
        j["1 000 000.00"] = x.get_the_100000000();
        j["⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢"] = x.get_the_11();
        j["1/2"] = x.get_the_12();
        j["123456789012345678901234567890123456789"] = x.get_the_123456789012345678901234567890123456789();
        j["\U0001d47b\U0001d489\U0001d486 \U0001d492\U0001d496\U0001d48a\U0001d484\U0001d48c \U0001d483\U0001d493\U0001d490\U0001d498\U0001d48f \U0001d487\U0001d490\U0001d499 \U0001d48b\U0001d496\U0001d48e\U0001d491\U0001d494 \U0001d490\U0001d497\U0001d486\U0001d493 \U0001d495\U0001d489\U0001d486 \U0001d48d\U0001d482\U0001d49b\U0001d49a \U0001d485\U0001d490\U0001d488"] = x.get_the_15();
        j["\U0001d4e3\U0001d4f1\U0001d4ee \U0001d4fa\U0001d4fe\U0001d4f2\U0001d4ec\U0001d4f4 \U0001d4eb\U0001d4fb\U0001d4f8\U0001d500\U0001d4f7 \U0001d4ef\U0001d4f8\U0001d501 \U0001d4f3\U0001d4fe\U0001d4f6\U0001d4f9\U0001d4fc \U0001d4f8\U0001d4ff\U0001d4ee\U0001d4fb \U0001d4fd\U0001d4f1\U0001d4ee \U0001d4f5\U0001d4ea\U0001d503\U0001d502 \U0001d4ed\U0001d4f8\U0001d4f0"] = x.get_the_16();
        j["\U0001d57f\U0001d58d\U0001d58a \U0001d596\U0001d59a\U0001d58e\U0001d588\U0001d590 \U0001d587\U0001d597\U0001d594\U0001d59c\U0001d593 \U0001d58b\U0001d594\U0001d59d \U0001d58f\U0001d59a\U0001d592\U0001d595\U0001d598 \U0001d594\U0001d59b\U0001d58a\U0001d597 \U0001d599\U0001d58d\U0001d58a \U0001d591\U0001d586\U0001d59f\U0001d59e \U0001d589\U0001d594\U0001d58c"] = x.get_the_17();
        j["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8 \U0001f1e6\U0001f1eb\U0001f1e6\U0001f1f2\U0001f1f8"] = x.get_the_18();
        j["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8\U0001f1e6"] = x.get_the_19();
        j["1;DROP TABLE users"] = x.get_the_1__drop_table_users();
        j["-1E02"] = x.get_the_1__e02();
        j["1E2"] = x.get_the_1__e2();
        j["1#QNAN"] = x.get_the_1__qnan();
        j["1#SNAN"] = x.get_the_1__snan();
        j["¸˛Ç◊ı˜Â¯˘¿"] = x.get_the_2();
        j["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8\U0001f1e6\U0001f1eb\U0001f1e6\U0001f1f2"] = x.get_the_20();
        j["\U0001f469\U0001f3fd"] = x.get_the_21();
        j["\U0001f6be \U0001f192 \U0001f193 \U0001f195 \U0001f196 \U0001f197 \U0001f199 \U0001f3e7"] = x.get_the_22();
        j["﷽"] = x.get_the_23();
        j["\ufeff"] = x.get_the_24();
        j["ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ"] = x.get_the_26();
        j["\ufffe"] = x.get_the_27();
        j["Œ„´‰ˇÁ¨ˆØ∏”’"] = x.get_the_3();
        j["œ∑´®†¥¨ˆøπ“‘"] = x.get_the_4();
        j["Ⱥ"] = x.get_the_5();
        j["Ⱦ"] = x.get_the_6();
        j["999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"] = x.get_the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999();
        j["# The next two lines may appear to be blank or mojibake in some viewers."] = x.get_the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers();
        j["The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]"] = x.get_the_quic_k_brown_fo_x_beeeep();
        j["#\tTwo-Byte Characters"] = x.get_two_byte_characters();
        j["# U+0000, U+000A, or U+000D (NUL, LF, CR)."] = x.get_u_0000__u_000__a_or_u_000__d_nul_lf_cr();
        j["<u oncopy=alert()> Copy me</u>"] = x.get_u_oncopy_alert_copy_me_u();
        j["undef"] = x.get_undef();
        j["#\tUnicode font"] = x.get_unicode_font();
        j["#\tUnicode Numbers"] = x.get_unicode_numbers();
        j["#\tUnwanted Interpolation"] = x.get_unwanted_interpolation();
        j["%x('ls -al /')"] = x.get_x_ls_al();
        j["Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮"] = x.get_z_g_o();
    }

    inline void from_json(const json & j, B& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set(j.at("__ﾛ(,_,*)").get<std::string>());
        x.set_2(j.at("ﷺ").get<std::string>());
        x.set_3(j.at("１２３").get<std::string>());
        x.set_a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1__a(j.at("<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">").get<std::string>());
        x.set_a_href_javascript_x00_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_javascript_x0_d_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x02_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x04_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x0_ajavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x0_djavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x0_ejavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x0_fjavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x16_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x19_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x1_ajavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x1_djavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x1_ejavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x81_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x82_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x_a9_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_abc_div_style_x_expression_x5_c_javascript_alert_1__def(j.at("ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x0_aexpression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x0_dexpression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_ambitious(j.at("ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ").get<std::string>());
        x.set_appear_in_input(j.at("# appear in input.").get<std::string>());
        x.set_ath0(j.at("+++ATH0").get<std::string>());
        x.set_autofocus_onkeyup_javascript_alert_123(j.at("' autofocus onkeyup='javascript:alert(123)").get<std::string>());
        x.set_b(j.at("\t\u000b\u000c \u0085             \u200b\u2028\u2029  　").get<std::string>());
        x.set_b_100000(j.at("1'000.00").get<std::string>());
        x.set_b_false(j.at("FALSE").get<std::string>());
        x.set_b_img_src_onmouseover_alert_xxs(j.at("<IMG SRC=# onmouseover=\"alert('xxs')\">").get<std::string>());
        x.set_b_script_alert_123__script(j.at("--><script>alert(123)</script>").get<std::string>());
        x.set_b_touch_tmp_blns_fail(j.at("`touch /tmp/blns.fail`").get<std::string>());
        x.set_basement(j.at("basement").get<std::string>());
        x.set_braggadocious(j.at("\U0001d54b\U0001d559\U0001d556 \U0001d562\U0001d566\U0001d55a\U0001d554\U0001d55c \U0001d553\U0001d563\U0001d560\U0001d568\U0001d55f \U0001d557\U0001d560\U0001d569 \U0001d55b\U0001d566\U0001d55e\U0001d561\U0001d564 \U0001d560\U0001d567\U0001d556\U0001d563 \U0001d565\U0001d559\U0001d556 \U0001d55d\U0001d552\U0001d56b\U0001d56a \U0001d555\U0001d560\U0001d558").get<std::string>());
        x.set_but_now_20__cfor_my_greatest_trick_8__m(j.at("But now...\u001b[20Cfor my greatest trick...\u001b[8m").get<std::string>());
        x.set_byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line(j.at("# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line.").get<std::string>());
        x.set_com1(j.at("COM1").get<std::string>());
        x.set_com3(j.at("COM3").get<std::string>());
        x.set_commonly_misinterpreted_as_additional_graphic_characters(j.at("# Commonly misinterpreted as additional graphic characters.").get<std::string>());
        x.set_con(j.at("CON").get<std::string>());
        x.set_contexts_divided_into_three_groups_based_on_us_layout_keyboard_position(j.at("# contexts.  Divided into three groups based on (US-layout) keyboard position.").get<std::string>());
        x.set_credit_https_twitter_com_jifa_status_625776454479970304(j.at("#\tCredit: https://twitter.com/jifa/status/625776454479970304").get<std::string>());
        x.set_cunning(j.at("社會科學院語學研究所").get<std::string>());
        x.set_dev_null_touch_tmp_blns_fail_echo(j.at("/dev/null; touch /tmp/blns.fail ; echo").get<std::string>());
        x.set_dont_make_a_map(j.at("dontMakeAMap").get<bool>());
        x.set_empty(j.at("\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f").get<std::string>());
        x.set_eval_puts_hello_world(j.at("eval(\"puts 'hello world'\")").get<std::string>());
        x.set_expression(j.at("expression").get<std::string>());
        x.set_file(j.at("File:///").get<std::string>());
        x.set_file_inclusion(j.at("#\tFile Inclusion").get<std::string>());
        x.set_fluffy(j.at("#").get<std::string>());
        x.set_foo_val_bar(j.at("<foo val=”bar“ />").get<std::string>());
        x.set_frisky(j.at("사회과학원 어학연구소").get<std::string>());
        x.set_general_category_cf_in_unicode_800(j.at("# general category Cf (in Unicode 8.0.0).").get<std::string>());
        x.set_h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l(j.at("̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕").get<std::string>());
        x.set_help(j.at("--help").get<std::string>());
        x.set_hilarious(j.at("❤️ \U0001f494 \U0001f48c \U0001f495 \U0001f49e \U0001f493 \U0001f497 \U0001f496 \U0001f498 \U0001f49d \U0001f49f \U0001f49c \U0001f49b \U0001f49a \U0001f499").get<std::string>());
        x.set_http_a_3030(j.at("http://a/%%30%30").get<std::string>());
        x.set_i_os_vulnerabilities(j.at("#\tiOS Vulnerabilities").get<std::string>());
        x.set_if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20__years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you(j.at("If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you.").get<std::string>());
        x.set_iframe_src_http_ha_ckers_org_scriptlet_html(j.at("<iframe src=http://ha.ckers.org/scriptlet.html <").get<std::string>());
        x.set_img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041(j.at("<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>").get<std::string>());
        x.set_img_src_14__javascript_alert_xss(j.at("<IMG SRC=\" &#14;  javascript:alert('XSS');\">").get<std::string>());
        x.set_img_src_jav_x09_ascript_alert_xss(j.at("<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">").get<std::string>());
        x.set_img_src_onmouseover_alert_xxs(j.at("<IMG SRC= onmouseover=\"alert('xxs')\">").get<std::string>());
        x.set_img_src_x00_x_onerror_javascript_alert_1(j.at("<img src\\x00=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29(j.at("<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>").get<std::string>());
        x.set_img_src_x_onerror_x11_javascript_alert_1(j.at("<img src=x onerror=\\x11\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_onerror_x12_javascript_alert_1(j.at("<img src=x onerror=\\x12\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_xxx_x_x0_aonerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>").get<std::string>());
        x.set_img_src_xxx_x_x0_conerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>").get<std::string>());
        x.set_img_src_xxx_x_x0_donerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>").get<std::string>());
        x.set_img_x00_src_x_onerror_javascript_alert_1(j.at("<img \\x00src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_x11_src_x_onerror_javascript_alert_1(j.at("<img \\x11src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_x12_src_x_onerror_javascript_alert_1(j.at("<img \\x12src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_x47_src_x_onerror_javascript_alert_1(j.at("<img \\x47src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_indecent(j.at("⁰⁴⁵₀₁₂").get<std::string>());
        x.set_indigo(j.at("Ω≈ç√∫˜µ≤≥÷").get<std::string>());
        x.set_irc_specific_strings(j.at("#   IRC specific strings").get<std::string>());
        x.set_japanese_emoticons(j.at("#\tJapanese Emoticons").get<std::string>());
        x.set_kernel_exec_ls_al(j.at("Kernel.exec(\"ls -al /\")").get<std::string>());
        x.set_linda_callahan(j.at("Linda Callahan").get<std::string>());
        x.set_magenta(j.at("部落格").get<std::string>());
        x.set_mischievous(j.at("찦차를 타고 온 펲시맨과 쑛다리 똠방각하").get<std::string>());
        x.set_nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o(j.at("˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥").get<std::string>());
        x.set_nil(j.at("NIL").get<std::string>());
        x.set_nul(j.at("NUL").get<std::string>());
        x.set_null(j.at("null").get<std::string>());
        x.set_numeric_strings(j.at("#\tNumeric Strings").get<std::string>());
        x.set_o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s(j.at("Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣").get<std::string>());
        x.set_often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml(j.at("# Often forbidden to appear in various text-based file formats (e.g. XML),").get<std::string>());
        x.set_onfocus_ja_va_s_cript_alert_123__autofocus(j.at("\" onfocus=JaVaSCript:alert(123) autofocus").get<std::string>());
        x.set_or_111(j.at("' OR 1=1 -- 1").get<std::string>());
        x.set_purple(j.at("\"").get<std::string>());
        x.set_purple_script_alert_123__script(j.at("<script>alert(123)</script>").get<std::string>());
        x.set_quotation_marks(j.at("#\tQuotation Marks").get<std::string>());
        x.set_regional_indicator_symbols(j.at("#       Regional Indicator Symbols").get<std::string>());
        x.set_regional_indicator_symbols_can_be_displayed_differently_across(j.at("#       Regional Indicator Symbols can be displayed differently across").get<std::string>());
        x.set_reserved_strings(j.at("#\tReserved Strings").get<std::string>());
        x.set_script_alert_123__script(j.at("\"><script>alert(123)</script>").get<std::string>());
        x.set_script_alert_123__script_x(j.at("><script>alert(123);</script x=").get<std::string>());
        x.set_script_alert_xss_script(j.at("<<SCRIPT>alert(\"XSS\");//<</SCRIPT>").get<std::string>());
        x.set_script_src_ha_ckers_org_j(j.at("<SCRIPT SRC=//ha.ckers.org/.j>").get<std::string>());
        x.set_script_src_jscript_s_script(j.at("<script src=\"\\\\%(jscript)s\"></script>").get<std::string>());
        x.set_script_x09_javascript_alert_1__script(j.at("\"`'><script>\\x09javascript:alert(1)</script>").get<std::string>());
        x.set_script_x0_atype_text_javascript_javascript_alert_1__script(j.at("<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>").get<std::string>());
        x.set_script_x0_dtype_text_javascript_javascript_alert_1__script(j.at("<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>").get<std::string>());
        x.set_script_x21_javascript_alert_1__script(j.at("\"`'><script>\\x21javascript:alert(1)</script>").get<std::string>());
        x.set_script_x3_bjavascript_alert_1__script(j.at("\"`'><script>\\x3Bjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x85_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x87_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x8_ajavascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x_a8_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x_a9_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x_a_fjavascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e3_x80_x80_javascript_alert_1__script(j.at("\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>").get<std::string>());
        x.set_scunthorpe_problem(j.at("#\tScunthorpe Problem").get<std::string>());
        x.set_sticky(j.at("åß∂ƒ©˙∆˚¬…æ").get<std::string>());
        x.set_strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out(j.at("#   Strings that may occur on IRC clients that make security products freak out").get<std::string>());
        x.set_strings_which_are_reserved_characters_in_msdos_windows(j.at("#\tStrings which are reserved characters in MSDOS/Windows").get<std::string>());
        x.set_strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss(j.at("#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS").get<std::string>());
        x.set_strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew(j.at("#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)").get<std::string>());
        x.set_strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues(j.at("#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues").get<std::string>());
        x.set_strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric(j.at("#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric").get<std::string>());
        x.set_strings_which_may_be_used_elsewhere_in_code(j.at("#\tStrings which may be used elsewhere in code").get<std::string>());
        x.set_tentacled(j.at("(｡◕ ∀ ◕｡)").get<std::string>());
        x.set_terminal_escape_codes(j.at("#\tTerminal escape codes").get<std::string>());
        x.set_the_000(j.at("0.00").get<std::string>());
        x.set_the_01000(j.at("01000").get<std::string>());
        x.set_the_08(j.at("08").get<std::string>());
        x.set_the_09(j.at("09").get<std::string>());
        x.set_the_0__xffffffffffffffff(j.at("0xffffffffffffffff").get<std::string>());
        x.set_the_1(j.at("\U0001f60d").get<std::string>());
        x.set_the_100(j.at("$1.00").get<std::string>());
        x.set_the_1000(j.at("1,0/0,0").get<std::string>());
        x.set_the_100000(j.at("1 000.00").get<std::string>());
        x.set_the_100000000(j.at("1 000 000,00").get<std::string>());
        x.set_the_1__drop_table_users_1(j.at("1'; DROP TABLE users-- 1").get<std::string>());
        x.set_the_1__ind(j.at("1#IND").get<std::string>());
        x.set_the_1__inf(j.at("1#INF").get<std::string>());
        x.set_the_21474836481(j.at("-2147483648/-1").get<std::string>());
        x.set_the_22250738585072011__e_308(j.at("2.2250738585072011e-308").get<std::string>());
        x.set_the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers(j.at("# The next line may appear to be blank, mojibake, or dingbats in some viewers.").get<std::string>());
        x.set_the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers(j.at("# The next line may appear to be blank or mojibake in some viewers.").get<std::string>());
        x.set_the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers(j.at("# The next line may be flagged for \"trailing whitespace\" in some viewers.").get<std::string>());
        x.set_this_file_unfortunately_cannot_express_strings_containing(j.at("# This file unfortunately cannot express strings containing").get<std::string>());
        x.set_touch_tmp_blns_fail(j.at("$(touch /tmp/blns.fail)").get<std::string>());
        x.set_touch_tmp_blns_shellshock2_fail(j.at("() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }").get<std::string>());
        x.set_tyson_gay(j.at("Tyson Gay").get<std::string>());
        x.set_unicode_symbols(j.at("#\tUnicode Symbols").get<std::string>());
        x.set_x00_script_javascript_alert_1__script(j.at("'`\"><\\x00script>javascript:alert(1)</script>").get<std::string>());
        x.set_x3_cscript_javascript_alert_1__script(j.at("'`\"><\\x3Cscript>javascript:alert(1)</script>").get<std::string>());
    }

    inline void to_json(json & j, const B & x) {
        j = json::object();
        j["__ﾛ(,_,*)"] = x.get();
        j["ﷺ"] = x.get_2();
        j["１２３"] = x.get_3();
        j["<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">"] = x.get_a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1__a();
        j["<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_javascript_x00_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_javascript_x0_d_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x02_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x04_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x0_ajavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x0_djavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x0_ejavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x0_fjavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x16_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x19_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x1_ajavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x1_djavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x1_ejavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x81_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x82_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x_a9_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_expression_x5_c_javascript_alert_1__def();
        j["ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x0_aexpression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x0_dexpression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1__def();
        j["ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ"] = x.get_ambitious();
        j["# appear in input."] = x.get_appear_in_input();
        j["+++ATH0"] = x.get_ath0();
        j["' autofocus onkeyup='javascript:alert(123)"] = x.get_autofocus_onkeyup_javascript_alert_123();
        j["\t\u000b\u000c \u0085             \u200b\u2028\u2029  　"] = x.get_b();
        j["1'000.00"] = x.get_b_100000();
        j["FALSE"] = x.get_b_false();
        j["<IMG SRC=# onmouseover=\"alert('xxs')\">"] = x.get_b_img_src_onmouseover_alert_xxs();
        j["--><script>alert(123)</script>"] = x.get_b_script_alert_123__script();
        j["`touch /tmp/blns.fail`"] = x.get_b_touch_tmp_blns_fail();
        j["basement"] = x.get_basement();
        j["\U0001d54b\U0001d559\U0001d556 \U0001d562\U0001d566\U0001d55a\U0001d554\U0001d55c \U0001d553\U0001d563\U0001d560\U0001d568\U0001d55f \U0001d557\U0001d560\U0001d569 \U0001d55b\U0001d566\U0001d55e\U0001d561\U0001d564 \U0001d560\U0001d567\U0001d556\U0001d563 \U0001d565\U0001d559\U0001d556 \U0001d55d\U0001d552\U0001d56b\U0001d56a \U0001d555\U0001d560\U0001d558"] = x.get_braggadocious();
        j["But now...\u001b[20Cfor my greatest trick...\u001b[8m"] = x.get_but_now_20__cfor_my_greatest_trick_8__m();
        j["# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line."] = x.get_byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line();
        j["COM1"] = x.get_com1();
        j["COM3"] = x.get_com3();
        j["# Commonly misinterpreted as additional graphic characters."] = x.get_commonly_misinterpreted_as_additional_graphic_characters();
        j["CON"] = x.get_con();
        j["# contexts.  Divided into three groups based on (US-layout) keyboard position."] = x.get_contexts_divided_into_three_groups_based_on_us_layout_keyboard_position();
        j["#\tCredit: https://twitter.com/jifa/status/625776454479970304"] = x.get_credit_https_twitter_com_jifa_status_625776454479970304();
        j["社會科學院語學研究所"] = x.get_cunning();
        j["/dev/null; touch /tmp/blns.fail ; echo"] = x.get_dev_null_touch_tmp_blns_fail_echo();
        j["dontMakeAMap"] = x.get_dont_make_a_map();
        j["\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f"] = x.get_empty();
        j["eval(\"puts 'hello world'\")"] = x.get_eval_puts_hello_world();
        j["expression"] = x.get_expression();
        j["File:///"] = x.get_file();
        j["#\tFile Inclusion"] = x.get_file_inclusion();
        j["#"] = x.get_fluffy();
        j["<foo val=”bar“ />"] = x.get_foo_val_bar();
        j["사회과학원 어학연구소"] = x.get_frisky();
        j["# general category Cf (in Unicode 8.0.0)."] = x.get_general_category_cf_in_unicode_800();
        j["̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕"] = x.get_h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l();
        j["--help"] = x.get_help();
        j["❤️ \U0001f494 \U0001f48c \U0001f495 \U0001f49e \U0001f493 \U0001f497 \U0001f496 \U0001f498 \U0001f49d \U0001f49f \U0001f49c \U0001f49b \U0001f49a \U0001f499"] = x.get_hilarious();
        j["http://a/%%30%30"] = x.get_http_a_3030();
        j["#\tiOS Vulnerabilities"] = x.get_i_os_vulnerabilities();
        j["If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you."] = x.get_if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20__years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you();
        j["<iframe src=http://ha.ckers.org/scriptlet.html <"] = x.get_iframe_src_http_ha_ckers_org_scriptlet_html();
        j["<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>"] = x.get_img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041();
        j["<IMG SRC=\" &#14;  javascript:alert('XSS');\">"] = x.get_img_src_14__javascript_alert_xss();
        j["<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">"] = x.get_img_src_jav_x09_ascript_alert_xss();
        j["<IMG SRC= onmouseover=\"alert('xxs')\">"] = x.get_img_src_onmouseover_alert_xxs();
        j["<img src\\x00=x onerror=\"javascript:alert(1)\">"] = x.get_img_src_x00_x_onerror_javascript_alert_1();
        j["<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>"] = x.get_img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29();
        j["<img src=x onerror=\\x11\"javascript:alert(1)\">"] = x.get_img_src_x_onerror_x11_javascript_alert_1();
        j["<img src=x onerror=\\x12\"javascript:alert(1)\">"] = x.get_img_src_x_onerror_x12_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x0_aonerror_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x0_conerror_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x0_donerror_javascript_alert_1();
        j["<img \\x00src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x00_src_x_onerror_javascript_alert_1();
        j["<img \\x11src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x11_src_x_onerror_javascript_alert_1();
        j["<img \\x12src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x12_src_x_onerror_javascript_alert_1();
        j["<img \\x47src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x47_src_x_onerror_javascript_alert_1();
        j["⁰⁴⁵₀₁₂"] = x.get_indecent();
        j["Ω≈ç√∫˜µ≤≥÷"] = x.get_indigo();
        j["#   IRC specific strings"] = x.get_irc_specific_strings();
        j["#\tJapanese Emoticons"] = x.get_japanese_emoticons();
        j["Kernel.exec(\"ls -al /\")"] = x.get_kernel_exec_ls_al();
        j["Linda Callahan"] = x.get_linda_callahan();
        j["部落格"] = x.get_magenta();
        j["찦차를 타고 온 펲시맨과 쑛다리 똠방각하"] = x.get_mischievous();
        j["˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥"] = x.get_nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o();
        j["NIL"] = x.get_nil();
        j["NUL"] = x.get_nul();
        j["null"] = x.get_null();
        j["#\tNumeric Strings"] = x.get_numeric_strings();
        j["Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣"] = x.get_o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s();
        j["# Often forbidden to appear in various text-based file formats (e.g. XML),"] = x.get_often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml();
        j["\" onfocus=JaVaSCript:alert(123) autofocus"] = x.get_onfocus_ja_va_s_cript_alert_123__autofocus();
        j["' OR 1=1 -- 1"] = x.get_or_111();
        j["\""] = x.get_purple();
        j["<script>alert(123)</script>"] = x.get_purple_script_alert_123__script();
        j["#\tQuotation Marks"] = x.get_quotation_marks();
        j["#       Regional Indicator Symbols"] = x.get_regional_indicator_symbols();
        j["#       Regional Indicator Symbols can be displayed differently across"] = x.get_regional_indicator_symbols_can_be_displayed_differently_across();
        j["#\tReserved Strings"] = x.get_reserved_strings();
        j["\"><script>alert(123)</script>"] = x.get_script_alert_123__script();
        j["><script>alert(123);</script x="] = x.get_script_alert_123__script_x();
        j["<<SCRIPT>alert(\"XSS\");//<</SCRIPT>"] = x.get_script_alert_xss_script();
        j["<SCRIPT SRC=//ha.ckers.org/.j>"] = x.get_script_src_ha_ckers_org_j();
        j["<script src=\"\\\\%(jscript)s\"></script>"] = x.get_script_src_jscript_s_script();
        j["\"`'><script>\\x09javascript:alert(1)</script>"] = x.get_script_x09_javascript_alert_1__script();
        j["<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>"] = x.get_script_x0_atype_text_javascript_javascript_alert_1__script();
        j["<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>"] = x.get_script_x0_dtype_text_javascript_javascript_alert_1__script();
        j["\"`'><script>\\x21javascript:alert(1)</script>"] = x.get_script_x21_javascript_alert_1__script();
        j["\"`'><script>\\x3Bjavascript:alert(1)</script>"] = x.get_script_x3_bjavascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x85_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x87_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>"] = x.get_script_x_e2_x80_x8_ajavascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x_a8_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x_a9_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>"] = x.get_script_x_e2_x80_x_a_fjavascript_alert_1__script();
        j["\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>"] = x.get_script_x_e3_x80_x80_javascript_alert_1__script();
        j["#\tScunthorpe Problem"] = x.get_scunthorpe_problem();
        j["åß∂ƒ©˙∆˚¬…æ"] = x.get_sticky();
        j["#   Strings that may occur on IRC clients that make security products freak out"] = x.get_strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out();
        j["#\tStrings which are reserved characters in MSDOS/Windows"] = x.get_strings_which_are_reserved_characters_in_msdos_windows();
        j["#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS"] = x.get_strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss();
        j["#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)"] = x.get_strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew();
        j["#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues"] = x.get_strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues();
        j["#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric"] = x.get_strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric();
        j["#\tStrings which may be used elsewhere in code"] = x.get_strings_which_may_be_used_elsewhere_in_code();
        j["(｡◕ ∀ ◕｡)"] = x.get_tentacled();
        j["#\tTerminal escape codes"] = x.get_terminal_escape_codes();
        j["0.00"] = x.get_the_000();
        j["01000"] = x.get_the_01000();
        j["08"] = x.get_the_08();
        j["09"] = x.get_the_09();
        j["0xffffffffffffffff"] = x.get_the_0__xffffffffffffffff();
        j["\U0001f60d"] = x.get_the_1();
        j["$1.00"] = x.get_the_100();
        j["1,0/0,0"] = x.get_the_1000();
        j["1 000.00"] = x.get_the_100000();
        j["1 000 000,00"] = x.get_the_100000000();
        j["1'; DROP TABLE users-- 1"] = x.get_the_1__drop_table_users_1();
        j["1#IND"] = x.get_the_1__ind();
        j["1#INF"] = x.get_the_1__inf();
        j["-2147483648/-1"] = x.get_the_21474836481();
        j["2.2250738585072011e-308"] = x.get_the_22250738585072011__e_308();
        j["# The next line may appear to be blank, mojibake, or dingbats in some viewers."] = x.get_the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers();
        j["# The next line may appear to be blank or mojibake in some viewers."] = x.get_the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers();
        j["# The next line may be flagged for \"trailing whitespace\" in some viewers."] = x.get_the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers();
        j["# This file unfortunately cannot express strings containing"] = x.get_this_file_unfortunately_cannot_express_strings_containing();
        j["$(touch /tmp/blns.fail)"] = x.get_touch_tmp_blns_fail();
        j["() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }"] = x.get_touch_tmp_blns_shellshock2_fail();
        j["Tyson Gay"] = x.get_tyson_gay();
        j["#\tUnicode Symbols"] = x.get_unicode_symbols();
        j["'`\"><\\x00script>javascript:alert(1)</script>"] = x.get_x00_script_javascript_alert_1__script();
        j["'`\"><\\x3Cscript>javascript:alert(1)</script>"] = x.get_x3_cscript_javascript_alert_1__script();
    }

    inline void from_json(const json & j, C& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set(j.at("┬─┬ノ( º _ ºノ)").get<std::string>());
        x.set_1(j.at("مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، ").get<std::string>());
        x.set_12(j.at("\U0002070e\U00020731\U00020779\U00020c53\U00020c78\U00020c96\U00020ccf").get<std::string>());
        x.set_2(j.at("١٢٣").get<std::string>());
        x.set_7(j.at("울란바토르").get<std::string>());
        x.set_a(j.at("A:").get<std::string>());
        x.set_a_href_x00_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x03_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x06_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x07_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x0_bjavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x12_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x14_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x15_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x18_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x1_bjavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x1_cjavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x20_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x85_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x88_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x89_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x80_x8_ajavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e2_x81_x9_fjavascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_a_href_x_e3_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a(j.at("<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>").get<std::string>());
        x.set_abc_div_style_x_expression_x00_javascript_alert_1__def(j.at("ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x00_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x0_cexpression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1__def(j.at("ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF").get<std::string>());
        x.set_ambitious(j.at(".").get<std::string>());
        x.set_and_u_007__f_del(j.at("# and U+007F (DEL)").get<std::string>());
        x.set_ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some(j.at("# ASCII punctuation.  All of these characters may need to be escaped in some").get<std::string>());
        x.set_body_onload_alert_xss(j.at("<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>").get<std::string>());
        x.set_braggadocious(j.at("בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ").get<std::string>());
        x.set_c(j.at("\"'\"'\"''''\"").get<std::string>());
        x.set_c_00(j.at("-0.0").get<std::string>());
        x.set_c_000(j.at("0.0/0").get<std::string>());
        x.set_c_100(j.at("-1.00").get<std::string>());
        x.set_c_100000(j.at("1,000.00").get<std::string>());
        x.set_c_100000000(j.at("1,000,000.00").get<std::string>());
        x.set_c_1__e_02(j.at("1E+02").get<std::string>());
        x.set_c_script_alert_123__script(j.at("><script>alert(123)</script>").get<std::string>());
        x.set_c_true(j.at("true").get<std::string>());
        x.set_clock(j.at("CLOCK$").get<std::string>());
        x.set_com2(j.at("COM2").get<std::string>());
        x.set_com4(j.at("COM4").get<std::string>());
        x.set_craig_cockburn_software_specialist(j.at("Craig Cockburn, Software Specialist").get<std::string>());
        x.set_cunning(j.at("\\\\").get<std::string>());
        x.set_dcc_send_startkeylogger_000(j.at("DCC SEND STARTKEYLOGGER 0 0 0").get<std::string>());
        x.set_dont_make_a_map(j.at("dontMakeAMap").get<bool>());
        x.set_emoji(j.at("#\tEmoji").get<std::string>());
        x.set_empty(j.at("\"\"").get<std::string>());
        x.set_evaluate(j.at("evaluate").get<std::string>());
        x.set_fluffy(j.at("%").get<std::string>());
        x.set_fluffy_00(j.at("0/0").get<std::string>());
        x.set_foo_val_bar(j.at("<foo val=“bar” />").get<std::string>());
        x.set_frisky(j.at("ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃").get<std::string>());
        x.set_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o(j.at("̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟").get<std::string>());
        x.set_has_own_property(j.at("hasOwnProperty").get<std::string>());
        x.set_hilarious(j.at("--").get<std::string>());
        x.set_horniman_museum(j.at("Horniman Museum").get<std::string>());
        x.set_http_www_cum_qc_ca(j.at("http://www.cum.qc.ca/").get<std::string>());
        x.set_i_onwheel_alert_1__scroll_over_me_i(j.at("<i onwheel=alert(1)> Scroll over me </i>").get<std::string>());
        x.set_img_a_b_c_src_d_x_e_onerror_f_alert_1(j.at("<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">").get<std::string>());
        x.set_img_onmouseover_alert_xxs(j.at("<IMG onmouseover=\"alert('xxs')\">").get<std::string>());
        x.set_img_script_alert_xss_script(j.at("<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">").get<std::string>());
        x.set_img_src_javascript_alert_string_from_char_code_888383(j.at("<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>").get<std::string>());
        x.set_img_src_javascript_alert_xss(j.at("<IMG SRC=\"javascript:alert('XSS')\"").get<std::string>());
        x.set_img_src_onerror_alt_javascript_alert_1(j.at("<img src onerror /\" '\"= alt=javascript:alert(1)//\">").get<std::string>());
        x.set_img_src_x10_x_onerror_javascript_alert_1(j.at("<img src\\x10=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x12_x_onerror_javascript_alert_1(j.at("<img src\\x12=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x13_x_onerror_javascript_alert_1(j.at("<img src\\x13=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x32_x_onerror_javascript_alert_1(j.at("<img src\\x32=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x47_x_onerror_javascript_alert_1(j.at("<img src\\x47=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_onerror_alert_123(j.at("<img src=x onerror=alert(123) />").get<std::string>());
        x.set_img_src_x_onerror_x10_javascript_alert_1(j.at("<img src=x onerror=\\x10\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_onerror_x32_javascript_alert_1(j.at("<img src=x onerror=\\x32\"javascript:alert(1)\">").get<std::string>());
        x.set_img_src_x_script_javascript_alert_1__script(j.at("<img src=\"x` `<script>javascript:alert(1)</script>\"` `>").get<std::string>());
        x.set_img_src_xxx_x_x09_onerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>").get<std::string>());
        x.set_img_src_xxx_x_x20_onerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>").get<std::string>());
        x.set_img_src_xxx_x_x22_onerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>").get<std::string>());
        x.set_img_src_xxx_x_x27_onerror_javascript_alert_1(j.at("`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>").get<std::string>());
        x.set_img_x11_src_x_onerror_javascript_alert_1(j.at("<img\\x11src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_x34_src_x_onerror_javascript_alert_1(j.at("<img \\x34src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_img_x47_src_x_onerror_javascript_alert_1(j.at("<img\\x47src=x onerror=\"javascript:alert(1)\">").get<std::string>());
        x.set_indecent(j.at("-").get<std::string>());
        x.set_indigo(j.at(",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’").get<std::string>());
        x.set_infinity(j.at("Infinity").get<std::string>());
        x.set_java_s_cript_alert_123(j.at("JavaSCript:alert(123)").get<std::string>());
        x.set_lpt1(j.at("LPT1").get<std::string>());
        x.set_lt_script_gt_alert_3912339__lt_script_gt(j.at("&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;").get<std::string>());
        x.set_magenta(j.at("_").get<std::string>());
        x.set_magna_cum_laude(j.at("magna cum laude").get<std::string>());
        x.set_medieval_erection_of_parapets(j.at("medieval erection of parapets").get<std::string>());
        x.set_mischievous(j.at("ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя").get<std::string>());
        x.set_mocha(j.at("mocha").get<std::string>());
        x.set_na_n(j.at("NaN").get<std::string>());
        x.set_non_whitespace_c0_controls_u_0001__through_u_0008__u_000__e_through_u_001__f(j.at("# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,").get<std::string>());
        x.set_null(j.at("NULL").get<std::string>());
        x.set_onfocus_ja_va_s_cript_alert_123__autofocus(j.at("' onfocus=JaVaSCript:alert(123) autofocus").get<std::string>());
        x.set_or_reused_for_internal_delimiters_on_the_theory_that_they_should_never(j.at("# or reused for internal delimiters on the theory that they should never").get<std::string>());
        x.set_plaintext(j.at("<plaintext>").get<std::string>());
        x.set_power_h(j.at("Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗").get<std::string>());
        x.set_purple(j.at("\"''''\"'\"").get<std::string>());
        x.set_purple_00(j.at("0,,0").get<std::string>());
        x.set_purple_100000(j.at("1.000,00").get<std::string>());
        x.set_purple_100000000(j.at("1.000.000,00").get<std::string>());
        x.set_purple_script_alert_123__script(j.at("＜script＞alert(123)＜/script＞").get<std::string>());
        x.set_right_to_left_strings(j.at("#\tRight-To-Left Strings").get<std::string>());
        x.set_roses_are_031__mred_0__m_violets_are_034__mblue_hope_you_enjoy_terminal_hue(j.at("Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue").get<std::string>());
        x.set_s(j.at("%*.*s").get<std::string>());
        x.set_script_alert_123__script(j.at("'><script>alert(123)</script>").get<std::string>());
        x.set_script_alert_123__script_x(j.at("'><script>alert(123);</script x='").get<std::string>());
        x.set_script_javascript_alert_1__script(j.at("\"`'><script>-javascript:alert(1)</script>").get<std::string>());
        x.set_script_script_alert_123__script(j.at("< / script >< script >alert(123)< / script >").get<std::string>());
        x.set_script_src_jscript_s_script(j.at("<script src=\"/\\%(jscript)s\"></script>").get<std::string>());
        x.set_script_x0_ajavascript_alert_1__script(j.at("\"`'><script>\\x0Ajavascript:alert(1)</script>").get<std::string>());
        x.set_script_x0_bjavascript_alert_1__script(j.at("\"`'><script>\\x0Bjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x0_ctype_text_javascript_javascript_alert_1__script(j.at("<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>").get<std::string>());
        x.set_script_x20_javascript_alert_1__script(j.at("\"`'><script>\\x20javascript:alert(1)</script>").get<std::string>());
        x.set_script_x2_bjavascript_alert_1__script(j.at("\"`'><script>\\x2Bjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x2_ftype_text_javascript_javascript_alert_1__script(j.at("<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>").get<std::string>());
        x.set_script_x7_ejavascript_alert_1__script(j.at("\"`'><script>\\x7Ejavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x80_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x82_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x83_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x84_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x88_javascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>").get<std::string>());
        x.set_script_x_e2_x80_x8_bjavascript_alert_1__script(j.at("\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_ef_x_bf_x_a_ejavascript_alert_1__script(j.at("\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>").get<std::string>());
        x.set_script_x_ef_x_bf_x_b_ejavascript_alert_1__script(j.at("\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>").get<std::string>());
        x.set_scunthorpe_general_hospital(j.at("Scunthorpe General Hospital").get<std::string>());
        x.set_server_code_injection(j.at("#\tServer Code Injection").get<std::string>());
        x.set_shitake_mushrooms(j.at("shitake mushrooms").get<std::string>());
        x.set_special_characters(j.at("#\tSpecial Characters").get<std::string>());
        x.set_src_ja_va_s_cript_prompt_132(j.at("src=JaVaSCript:prompt(132)").get<std::string>());
        x.set_sticky(j.at("(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻").get<std::string>());
        x.set_strings_which_can_be_interpreted_as_numeric(j.at("#\tStrings which can be interpreted as numeric").get<std::string>());
        x.set_strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized(j.at("#\tStrings which can cause a SQL injection if inputs are not sanitized").get<std::string>());
        x.set_strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server(j.at("#\tStrings which can cause user to pull in files that should not be a part of a web server").get<std::string>());
        x.set_strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153(j.at("#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)").get<std::string>());
        x.set_strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net(j.at("#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)").get<std::string>());
        x.set_strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com(j.at("#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)").get<std::string>());
        x.set_strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf(j.at("#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)").get<std::string>());
        x.set_strings_which_punish_the_fools_who_use_cat_type_on_this_file(j.at("#\tStrings which punish the fools who use cat/type on this file").get<std::string>());
        x.set_svg_script_1231__alert_123__script(j.at("<svg><script>123<1>alert(123)</script>").get<std::string>());
        x.set_system_ls_al(j.at("System(\"ls -al /\")").get<std::string>());
        x.set_system_touch_tmp_blns_fail(j.at("@{[system \"touch /tmp/blns.fail\"]}").get<std::string>());
        x.set_tentacled(j.at("''").get<std::string>());
        x.set_test(j.at("\u2029test\u2029").get<std::string>());
        x.set_test_test(j.at("test\u2060test\u202b").get<std::string>());
        x.set_the_0(j.at("\U0001f3f30\U0001f308️").get<std::string>());
        x.set_the_00(j.at("+0.0").get<std::string>());
        x.set_the_000(j.at("0.0.0").get<std::string>());
        x.set_the_0123456789(j.at("0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \U0001f51f").get<std::string>());
        x.set_the_0__touch_tmp_blns_shellshock1_fail(j.at("() { 0; }; touch /tmp/blns.shellshock1.fail;").get<std::string>());
        x.set_the_0__xabad1_dea(j.at("0xabad1dea").get<std::string>());
        x.set_the_0__xffffffff(j.at("0xffffffff").get<std::string>());
        x.set_the_1(j.at("--1").get<std::string>());
        x.set_the_10(j.at("\U0001f435 \U0001f648 \U0001f649 \U0001f64a").get<std::string>());
        x.set_the_100(j.at("-$1.00").get<std::string>());
        x.set_the_100000(j.at("1 000,00").get<std::string>());
        x.set_the_100000000(j.at("1'000'000,00").get<std::string>());
        x.set_the_11(j.at("\U0001f47e \U0001f647 \U0001f481 \U0001f645 \U0001f646 \U0001f64b \U0001f64e \U0001f64d").get<std::string>());
        x.set_the_12(j.at("-1/2").get<std::string>());
        x.set_the_13(j.at("Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ").get<std::string>());
        x.set_the_1__e2(j.at("-1E2").get<std::string>());
        x.set_the_1__e_02(j.at("-1E+02").get<std::string>());
        x.set_the_1__ind(j.at("-1#IND").get<std::string>());
        x.set_the_3(j.at("⁰⁴⁵").get<std::string>());
        x.set_the_4(j.at("⅛⅜⅝⅞").get<std::string>());
        x.set_the_5(j.at("✋\U0001f3ff \U0001f4aa\U0001f3ff \U0001f450\U0001f3ff \U0001f64c\U0001f3ff \U0001f44f\U0001f3ff \U0001f64f\U0001f3ff").get<std::string>());
        x.set_the_6(j.at("・(￣∀￣)・:*:").get<std::string>());
        x.set_the_8(j.at("\U0001d413\U0001d421\U0001d41e \U0001d42a\U0001d42e\U0001d422\U0001d41c\U0001d424 \U0001d41b\U0001d42b\U0001d428\U0001d430\U0001d427 \U0001d41f\U0001d428\U0001d431 \U0001d423\U0001d42e\U0001d426\U0001d429\U0001d42c \U0001d428\U0001d42f\U0001d41e\U0001d42b \U0001d42d\U0001d421\U0001d41e \U0001d425\U0001d41a\U0001d433\U0001d432 \U0001d41d\U0001d428\U0001d420").get<std::string>());
        x.set_the_9(j.at("\U0001d683\U0001d691\U0001d68e \U0001d69a\U0001d69e\U0001d692\U0001d68c\U0001d694 \U0001d68b\U0001d69b\U0001d698\U0001d6a0\U0001d697 \U0001d68f\U0001d698\U0001d6a1 \U0001d693\U0001d69e\U0001d696\U0001d699\U0001d69c \U0001d698\U0001d69f\U0001d68e\U0001d69b \U0001d69d\U0001d691\U0001d68e \U0001d695\U0001d68a\U0001d6a3\U0001d6a2 \U0001d68d\U0001d698\U0001d690").get<std::string>());
        x.set_the_92233720368547758081(j.at("-9223372036854775808/-1").get<std::string>());
        x.set_title_onpropertychange_javascript_alert_1__title_title_title(j.at("<title onpropertychange=javascript:alert(1)></title><title title=>").get<std::string>());
        x.set_treated_as_whitespace_in_some_contexts(j.at("# treated as whitespace in some contexts.").get<std::string>());
        x.set_trick_unicode(j.at("#\tTrick Unicode").get<std::string>());
        x.set_undefined(j.at("undefined").get<std::string>());
        x.set_unicode_additional_control_characters_all_of_the_characters_with(j.at("# Unicode additional control characters: all of the characters with").get<std::string>());
        x.set_unicode_subscript_superscript_accents(j.at("#\tUnicode Subscript/Superscript/Accents").get<std::string>());
        x.set_unicode_upsidedown(j.at("#\tUnicode Upsidedown").get<std::string>());
        x.set_user(j.at("$USER").get<std::string>());
        x.set_version(j.at("--version").get<std::string>());
        x.set_version_800__plus_u_0009__ht_u_000__b_vt_u_000__c_ff_u_0085__nel(j.at("# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),").get<std::string>());
        x.set_whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode(j.at("# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode").get<std::string>());
        x.set_xml_version_10__encoding_iso_88591__doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo(j.at("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>").get<std::string>());
        x.set_xxe_injection_xml(j.at("#      XXE Injection (XML)").get<std::string>());
        x.set_zalgo_text(j.at("#\tZalgo Text").get<std::string>());
        x.set_zz(j.at("ZZ:").get<std::string>());
    }

    inline void to_json(json & j, const C & x) {
        j = json::object();
        j["┬─┬ノ( º _ ºノ)"] = x.get();
        j["مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، "] = x.get_1();
        j["\U0002070e\U00020731\U00020779\U00020c53\U00020c78\U00020c96\U00020ccf"] = x.get_12();
        j["١٢٣"] = x.get_2();
        j["울란바토르"] = x.get_7();
        j["A:"] = x.get_a();
        j["<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x00_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x03_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x06_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x07_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x0_bjavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x12_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x14_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x15_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x18_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x1_bjavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x1_cjavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x20_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x85_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x88_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x89_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x80_x8_ajavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e2_x81_x9_fjavascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = x.get_a_href_x_e3_x80_x80_javascript_javascript_alert_1__id_fuzzelement1_test_a();
        j["ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_expression_x00_javascript_alert_1__def();
        j["ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x00_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x0_cexpression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1__def();
        j["ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF"] = x.get_abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1__def();
        j["."] = x.get_ambitious();
        j["# and U+007F (DEL)"] = x.get_and_u_007__f_del();
        j["# ASCII punctuation.  All of these characters may need to be escaped in some"] = x.get_ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some();
        j["<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>"] = x.get_body_onload_alert_xss();
        j["בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ"] = x.get_braggadocious();
        j["\"'\"'\"''''\""] = x.get_c();
        j["-0.0"] = x.get_c_00();
        j["0.0/0"] = x.get_c_000();
        j["-1.00"] = x.get_c_100();
        j["1,000.00"] = x.get_c_100000();
        j["1,000,000.00"] = x.get_c_100000000();
        j["1E+02"] = x.get_c_1__e_02();
        j["><script>alert(123)</script>"] = x.get_c_script_alert_123__script();
        j["true"] = x.get_c_true();
        j["CLOCK$"] = x.get_clock();
        j["COM2"] = x.get_com2();
        j["COM4"] = x.get_com4();
        j["Craig Cockburn, Software Specialist"] = x.get_craig_cockburn_software_specialist();
        j["\\\\"] = x.get_cunning();
        j["DCC SEND STARTKEYLOGGER 0 0 0"] = x.get_dcc_send_startkeylogger_000();
        j["dontMakeAMap"] = x.get_dont_make_a_map();
        j["#\tEmoji"] = x.get_emoji();
        j["\"\""] = x.get_empty();
        j["evaluate"] = x.get_evaluate();
        j["%"] = x.get_fluffy();
        j["0/0"] = x.get_fluffy_00();
        j["<foo val=“bar” />"] = x.get_foo_val_bar();
        j["ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃"] = x.get_frisky();
        j["̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟"] = x.get_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o();
        j["hasOwnProperty"] = x.get_has_own_property();
        j["--"] = x.get_hilarious();
        j["Horniman Museum"] = x.get_horniman_museum();
        j["http://www.cum.qc.ca/"] = x.get_http_www_cum_qc_ca();
        j["<i onwheel=alert(1)> Scroll over me </i>"] = x.get_i_onwheel_alert_1__scroll_over_me_i();
        j["<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">"] = x.get_img_a_b_c_src_d_x_e_onerror_f_alert_1();
        j["<IMG onmouseover=\"alert('xxs')\">"] = x.get_img_onmouseover_alert_xxs();
        j["<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">"] = x.get_img_script_alert_xss_script();
        j["<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>"] = x.get_img_src_javascript_alert_string_from_char_code_888383();
        j["<IMG SRC=\"javascript:alert('XSS')\""] = x.get_img_src_javascript_alert_xss();
        j["<img src onerror /\" '\"= alt=javascript:alert(1)//\">"] = x.get_img_src_onerror_alt_javascript_alert_1();
        j["<img src\\x10=x onerror=\"javascript:alert(1)\">"] = x.get_img_src_x10_x_onerror_javascript_alert_1();
        j["<img src\\x12=x onerror=\"javascript:alert(1)\">"] = x.get_img_src_x12_x_onerror_javascript_alert_1();
        j["<img src\\x13=x onerror=\"javascript:alert(1)\">"] = x.get_img_src_x13_x_onerror_javascript_alert_1();
        j["<img src\\x32=x onerror=\"javascript:alert(1)\">"] = x.get_img_src_x32_x_onerror_javascript_alert_1();
        j["<img src\\x47=x onerror=\"javascript:alert(1)\">"] = x.get_img_src_x47_x_onerror_javascript_alert_1();
        j["<img src=x onerror=alert(123) />"] = x.get_img_src_x_onerror_alert_123();
        j["<img src=x onerror=\\x10\"javascript:alert(1)\">"] = x.get_img_src_x_onerror_x10_javascript_alert_1();
        j["<img src=x onerror=\\x32\"javascript:alert(1)\">"] = x.get_img_src_x_onerror_x32_javascript_alert_1();
        j["<img src=\"x` `<script>javascript:alert(1)</script>\"` `>"] = x.get_img_src_x_script_javascript_alert_1__script();
        j["`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x09_onerror_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x20_onerror_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x22_onerror_javascript_alert_1();
        j["`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>"] = x.get_img_src_xxx_x_x27_onerror_javascript_alert_1();
        j["<img\\x11src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x11_src_x_onerror_javascript_alert_1();
        j["<img \\x34src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x34_src_x_onerror_javascript_alert_1();
        j["<img\\x47src=x onerror=\"javascript:alert(1)\">"] = x.get_img_x47_src_x_onerror_javascript_alert_1();
        j["-"] = x.get_indecent();
        j[",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’"] = x.get_indigo();
        j["Infinity"] = x.get_infinity();
        j["JavaSCript:alert(123)"] = x.get_java_s_cript_alert_123();
        j["LPT1"] = x.get_lpt1();
        j["&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;"] = x.get_lt_script_gt_alert_3912339__lt_script_gt();
        j["_"] = x.get_magenta();
        j["magna cum laude"] = x.get_magna_cum_laude();
        j["medieval erection of parapets"] = x.get_medieval_erection_of_parapets();
        j["ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя"] = x.get_mischievous();
        j["mocha"] = x.get_mocha();
        j["NaN"] = x.get_na_n();
        j["# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,"] = x.get_non_whitespace_c0_controls_u_0001__through_u_0008__u_000__e_through_u_001__f();
        j["NULL"] = x.get_null();
        j["' onfocus=JaVaSCript:alert(123) autofocus"] = x.get_onfocus_ja_va_s_cript_alert_123__autofocus();
        j["# or reused for internal delimiters on the theory that they should never"] = x.get_or_reused_for_internal_delimiters_on_the_theory_that_they_should_never();
        j["<plaintext>"] = x.get_plaintext();
        j["Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗"] = x.get_power_h();
        j["\"''''\"'\""] = x.get_purple();
        j["0,,0"] = x.get_purple_00();
        j["1.000,00"] = x.get_purple_100000();
        j["1.000.000,00"] = x.get_purple_100000000();
        j["＜script＞alert(123)＜/script＞"] = x.get_purple_script_alert_123__script();
        j["#\tRight-To-Left Strings"] = x.get_right_to_left_strings();
        j["Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue"] = x.get_roses_are_031__mred_0__m_violets_are_034__mblue_hope_you_enjoy_terminal_hue();
        j["%*.*s"] = x.get_s();
        j["'><script>alert(123)</script>"] = x.get_script_alert_123__script();
        j["'><script>alert(123);</script x='"] = x.get_script_alert_123__script_x();
        j["\"`'><script>-javascript:alert(1)</script>"] = x.get_script_javascript_alert_1__script();
        j["< / script >< script >alert(123)< / script >"] = x.get_script_script_alert_123__script();
        j["<script src=\"/\\%(jscript)s\"></script>"] = x.get_script_src_jscript_s_script();
        j["\"`'><script>\\x0Ajavascript:alert(1)</script>"] = x.get_script_x0_ajavascript_alert_1__script();
        j["\"`'><script>\\x0Bjavascript:alert(1)</script>"] = x.get_script_x0_bjavascript_alert_1__script();
        j["<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>"] = x.get_script_x0_ctype_text_javascript_javascript_alert_1__script();
        j["\"`'><script>\\x20javascript:alert(1)</script>"] = x.get_script_x20_javascript_alert_1__script();
        j["\"`'><script>\\x2Bjavascript:alert(1)</script>"] = x.get_script_x2_bjavascript_alert_1__script();
        j["<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>"] = x.get_script_x2_ftype_text_javascript_javascript_alert_1__script();
        j["\"`'><script>\\x7Ejavascript:alert(1)</script>"] = x.get_script_x7_ejavascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x80_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x82_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x83_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x84_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>"] = x.get_script_x_e2_x80_x88_javascript_alert_1__script();
        j["\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>"] = x.get_script_x_e2_x80_x8_bjavascript_alert_1__script();
        j["\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>"] = x.get_script_x_ef_x_bf_x_a_ejavascript_alert_1__script();
        j["\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>"] = x.get_script_x_ef_x_bf_x_b_ejavascript_alert_1__script();
        j["Scunthorpe General Hospital"] = x.get_scunthorpe_general_hospital();
        j["#\tServer Code Injection"] = x.get_server_code_injection();
        j["shitake mushrooms"] = x.get_shitake_mushrooms();
        j["#\tSpecial Characters"] = x.get_special_characters();
        j["src=JaVaSCript:prompt(132)"] = x.get_src_ja_va_s_cript_prompt_132();
        j["(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻"] = x.get_sticky();
        j["#\tStrings which can be interpreted as numeric"] = x.get_strings_which_can_be_interpreted_as_numeric();
        j["#\tStrings which can cause a SQL injection if inputs are not sanitized"] = x.get_strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized();
        j["#\tStrings which can cause user to pull in files that should not be a part of a web server"] = x.get_strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server();
        j["#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)"] = x.get_strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153();
        j["#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)"] = x.get_strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net();
        j["#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)"] = x.get_strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com();
        j["#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)"] = x.get_strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf();
        j["#\tStrings which punish the fools who use cat/type on this file"] = x.get_strings_which_punish_the_fools_who_use_cat_type_on_this_file();
        j["<svg><script>123<1>alert(123)</script>"] = x.get_svg_script_1231__alert_123__script();
        j["System(\"ls -al /\")"] = x.get_system_ls_al();
        j["@{[system \"touch /tmp/blns.fail\"]}"] = x.get_system_touch_tmp_blns_fail();
        j["''"] = x.get_tentacled();
        j["\u2029test\u2029"] = x.get_test();
        j["test\u2060test\u202b"] = x.get_test_test();
        j["\U0001f3f30\U0001f308️"] = x.get_the_0();
        j["+0.0"] = x.get_the_00();
        j["0.0.0"] = x.get_the_000();
        j["0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \U0001f51f"] = x.get_the_0123456789();
        j["() { 0; }; touch /tmp/blns.shellshock1.fail;"] = x.get_the_0__touch_tmp_blns_shellshock1_fail();
        j["0xabad1dea"] = x.get_the_0__xabad1_dea();
        j["0xffffffff"] = x.get_the_0__xffffffff();
        j["--1"] = x.get_the_1();
        j["\U0001f435 \U0001f648 \U0001f649 \U0001f64a"] = x.get_the_10();
        j["-$1.00"] = x.get_the_100();
        j["1 000,00"] = x.get_the_100000();
        j["1'000'000,00"] = x.get_the_100000000();
        j["\U0001f47e \U0001f647 \U0001f481 \U0001f645 \U0001f646 \U0001f64b \U0001f64e \U0001f64d"] = x.get_the_11();
        j["-1/2"] = x.get_the_12();
        j["Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ"] = x.get_the_13();
        j["-1E2"] = x.get_the_1__e2();
        j["-1E+02"] = x.get_the_1__e_02();
        j["-1#IND"] = x.get_the_1__ind();
        j["⁰⁴⁵"] = x.get_the_3();
        j["⅛⅜⅝⅞"] = x.get_the_4();
        j["✋\U0001f3ff \U0001f4aa\U0001f3ff \U0001f450\U0001f3ff \U0001f64c\U0001f3ff \U0001f44f\U0001f3ff \U0001f64f\U0001f3ff"] = x.get_the_5();
        j["・(￣∀￣)・:*:"] = x.get_the_6();
        j["\U0001d413\U0001d421\U0001d41e \U0001d42a\U0001d42e\U0001d422\U0001d41c\U0001d424 \U0001d41b\U0001d42b\U0001d428\U0001d430\U0001d427 \U0001d41f\U0001d428\U0001d431 \U0001d423\U0001d42e\U0001d426\U0001d429\U0001d42c \U0001d428\U0001d42f\U0001d41e\U0001d42b \U0001d42d\U0001d421\U0001d41e \U0001d425\U0001d41a\U0001d433\U0001d432 \U0001d41d\U0001d428\U0001d420"] = x.get_the_8();
        j["\U0001d683\U0001d691\U0001d68e \U0001d69a\U0001d69e\U0001d692\U0001d68c\U0001d694 \U0001d68b\U0001d69b\U0001d698\U0001d6a0\U0001d697 \U0001d68f\U0001d698\U0001d6a1 \U0001d693\U0001d69e\U0001d696\U0001d699\U0001d69c \U0001d698\U0001d69f\U0001d68e\U0001d69b \U0001d69d\U0001d691\U0001d68e \U0001d695\U0001d68a\U0001d6a3\U0001d6a2 \U0001d68d\U0001d698\U0001d690"] = x.get_the_9();
        j["-9223372036854775808/-1"] = x.get_the_92233720368547758081();
        j["<title onpropertychange=javascript:alert(1)></title><title title=>"] = x.get_title_onpropertychange_javascript_alert_1__title_title_title();
        j["# treated as whitespace in some contexts."] = x.get_treated_as_whitespace_in_some_contexts();
        j["#\tTrick Unicode"] = x.get_trick_unicode();
        j["undefined"] = x.get_undefined();
        j["# Unicode additional control characters: all of the characters with"] = x.get_unicode_additional_control_characters_all_of_the_characters_with();
        j["#\tUnicode Subscript/Superscript/Accents"] = x.get_unicode_subscript_superscript_accents();
        j["#\tUnicode Upsidedown"] = x.get_unicode_upsidedown();
        j["$USER"] = x.get_user();
        j["--version"] = x.get_version();
        j["# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),"] = x.get_version_800__plus_u_0009__ht_u_000__b_vt_u_000__c_ff_u_0085__nel();
        j["# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode"] = x.get_whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode();
        j["<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>"] = x.get_xml_version_10__encoding_iso_88591__doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo();
        j["#      XXE Injection (XML)"] = x.get_xxe_injection_xml();
        j["#\tZalgo Text"] = x.get_zalgo_text();
        j["ZZ:"] = x.get_zz();
    }

    inline void from_json(const json & j, TopLevel& x) {
        if (!j.is_object()) throw std::runtime_error("Expected object");
        x.set_a(j.at("a").get<A>());
        x.set_b(j.at("b").get<B>());
        x.set_c(j.at("c").get<C>());
    }

    inline void to_json(json & j, const TopLevel & x) {
        j = json::object();
        j["a"] = x.get_a();
        j["b"] = x.get_b();
        j["c"] = x.get_c();
    }
}
