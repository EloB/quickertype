from dataclasses import dataclass
from typing import Any, TypeVar, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_stringified_bool(x: str) -> bool:
    if x == "true":
        return True
    if x == "false":
        return False
    assert False


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


@dataclass
class A:
    empty: str
    onfocus_ja_va_s_cript_alert_123_autofocus: str
    a: str
    autofocus_onkeyup_javascript_alert_123: str
    alert_123_t: str
    script_alert_123_script_x: str
    script_x00_javascript_alert_1_script: str
    script_x0_cjavascript_alert_1_script: str
    script_x0_djavascript_alert_1_script: str
    script_x_c2_x85_javascript_alert_1_script: str
    script_x_c2_x_a0_javascript_alert_1_script: str
    script_x_e1_x9_a_x80_javascript_alert_1_script: str
    script_x_e1_x_a0_x8_ejavascript_alert_1_script: str
    script_x_e2_x80_x81_javascript_alert_1_script: str
    script_x_e2_x80_x86_javascript_alert_1_script: str
    script_x_e2_x80_x89_javascript_alert_1_script: str
    script_x_e2_x81_x9_fjavascript_alert_1_script: str
    script_x_ef_x_bb_x_b_fjavascript_alert_1_script: str
    script_x_f0_x90_x96_x9_ajavascript_alert_1_script: str
    changing_length_when_lowercased: str
    characters_which_increase_in_length_2_to_3_bytes_when_lowercased: str
    command_injection_ruby: str
    human_injection: str
    innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem: str
    known_cv_es_and_vulnerabilities: str
    msdos_windows_special_filenames: str
    sql_injection: str
    script_injection: str
    string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser: str
    strings_that_test_for_known_vulnerabilities: str
    strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string: str
    strings_which_can_call_system_commands_within_ruby_rails_applications: str
    strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web: str
    strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always: str
    strings_which_contain_bold_italic_etc_versions_of_normal_characters: str
    strings_which_contain_common_unicode_symbols_e_g_smart_quotes: str
    strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors: str
    strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues: str
    strings_which_crashed_i_message_in_various_versions_of_i_os: str
    strings_which_may_cause_human_to_reinterpret_worldview: str
    two_byte_characters: str
    unicode_numbers: str
    unicode_font: str
    unwanted_interpolation: str
    fonts_and_have_a_number_of_special_behaviors: str
    non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f: str
    the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers: str
    u_0000_u_000_a_or_u_000_d_nul_lf_cr: str
    and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often: str
    env_home: str
    home: str
    d: str
    s: str
    x_ls_al: str
    purple: str
    or_11: str
    fluffy: str
    a_alert_123_t: str
    ʖ: str
    null: str
    tentacled: str
    the_0: str
    sticky: str
    indigo: str
    indecent: str
    hilarious: str
    a_0: str
    the_1: int
    the_1_e02: str
    infinity: str
    etc_hosts: str
    etc_passwd_00: str
    purple_0: int
    the_000: str
    the_0000: str
    a_000: str
    the_00: str
    a_0000: str
    the_00_ɩ: str
    the_0_x0: str
    a_1: int
    the_100000000: str
    the_1_qnan: str
    the_1_snan: str
    a_100000000: str
    the_100000: str
    the_1000: str
    the_100: str
    the_10: str
    the_12: str
    the_123456789012345678901234567890123456789: str
    the_1_drop_table_users: str
    a_1_e02: str
    the_1_e2: str
    the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999: str
    alert_123: str
    if_img_src_x_onerror_javascript_alert_1: str
    if_script_javascript_alert_1_script: str
    script_script_alert_123_script: str
    textarea_script_alert_123_script: str
    s_un_s_u: str
    ambitious: str
    img_src_jav_ascript_alert_xss: str
    img_src_jav_x0_a_ascript_alert_xss: str
    img_src_jav_x0_d_ascript_alert_xss: str
    img_src_106971189711599114105112116589710810111411640398883833941: str
    script_src_http_ha_ckers_org_xss_js_b: str
    script_src_http_ha_ckers_org_xss_js_script: str
    script_xss_src_http_ha_ckers_org_xss_js_script: str
    a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_java_123456781112_script_javascript_alert_1_xxx_a: str
    foo_val_bar: str
    img_x00_src_x_onerror_alert_1: str
    img_x39_src_x_onerror_javascript_alert_1: str
    img_src_x_onerror_x00_javascript_alert_1: str
    img_src_x_onerror_x09_javascript_alert_1: str
    img_src_x_x09_onerror_javascript_alert_1: str
    img_src_x_x10_onerror_javascript_alert_1: str
    img_src_x_x11_onerror_javascript_alert_1: str
    img_src_x_x12_onerror_javascript_alert_1: str
    img_src_x_x13_onerror_javascript_alert_1: str
    img_src_x09_x_onerror_javascript_alert_1: str
    img_src_x11_x_onerror_javascript_alert_1: str
    img_x10_src_x_onerror_javascript_alert_1: str
    img_x13_src_x_onerror_javascript_alert_1: str
    img_x32_src_x_onerror_javascript_alert_1: str
    sc_script_ript_alert_123_sc_script_ript: str
    script_x09_type_text_javascript_javascript_alert_1_script: str
    script_x20_type_text_javascript_javascript_alert_1_script: str
    script_x3_etype_text_javascript_javascript_alert_1_script: str
    u_oncopy_alert_copy_me_u: str
    abc_div_style_x_x09_expression_javascript_alert_1_def: str
    abc_div_style_x_x0_bexpression_javascript_alert_1_def: str
    abc_div_style_x_x20_expression_javascript_alert_1_def: str
    abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def: str
    abc_div_style_x_exp_x00_ression_javascript_alert_1_def: str
    abc_div_style_x_exp_x5_cression_javascript_alert_1_def: str
    abc_div_style_x_x3_aexpression_javascript_alert_1_def: str
    aux: str
    arsenal_canal: str
    dick_van_dyke: str
    dr_herman_i_libshitz: str
    false: str
    inf: str
    jimmy_clitheroe: str
    kernel_exit_1: str
    lpt2: str
    lpt3: str
    lightwater_country_park: str
    none: str
    prn: str
    penistone_community_church: str
    romans_in_sussex_co_uk: str
    super_bowl_xxx: str
    true: str
    the_quic_k_brown_fo_x_beeeep: str
    a_true: str
    z_ḁ_ḷ_g_o: str
    cunning: str
    alert_xss: str
    img_src_xxx_x_x00_onerror_javascript_alert_1: str
    img_src_xxx_x_x0_bonerror_javascript_alert_1: str
    img_src_xxx_x_x2_fonerror_javascript_alert_1: str
    ls_al: str
    ﬁﬂ: str
    classic: str
    dont_make_a_map: bool
    a_false: bool
    nil: str
    perl_e_print_img_src_java_0_script_alert_xss_out: str
    undef: str
    fluffy_0: str
    magenta: str
    ªº: str
    frisky: str
    ç_ı_â: str
    œ_á_ø: str
    œ_øπ: str
    ⱥ: str
    ⱦ: str
    i_n_v_ok_i_n_g_t_h_e_f_è_ẹ_l_i_n_g_o_f_c_h_á_o_s: str
    הָיְתָה_test_الصفحاتالتّحول: str
    ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهّلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو: str
    the_٠١٢٣٤٥٦٧٨٩: str
    ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็: str
    test: str
    a_test: str
    purple_test: str
    mischievous: str
    braggadocious: str
    パーティーへ行かないか: str
    和製漢語: str
    田中さんにあげて下さい: str
    the_2: str
    the_3: str
    the_4: str
    the_5: str
    the_6: str
    the_7: str
    the_8: str
    the_9: str
    the_11: str
    the_13: str
    ｨ: str
    the_14: str
    the_15: str

    @staticmethod
    def from_dict(obj: Any) -> 'A':
        assert isinstance(obj, dict)
        empty = from_str(obj[" "])
        onfocus_ja_va_s_cript_alert_123_autofocus = from_str(obj[" onfocus=JaVaSCript:alert(123) autofocus"])
        a = from_str(obj["!@#$%^&*()`~"])
        autofocus_onkeyup_javascript_alert_123 = from_str(obj["\" autofocus onkeyup=\"javascript:alert(123)"])
        alert_123_t = from_str(obj["\";alert(123);t=\""])
        script_alert_123_script_x = from_str(obj["\"><script>alert(123);</script x=\""])
        script_x00_javascript_alert_1_script = from_str(obj["\"`'><script>\\x00javascript:alert(1)</script>"])
        script_x0_cjavascript_alert_1_script = from_str(obj["\"`'><script>\\x0Cjavascript:alert(1)</script>"])
        script_x0_djavascript_alert_1_script = from_str(obj["\"`'><script>\\x0Djavascript:alert(1)</script>"])
        script_x_c2_x85_javascript_alert_1_script = from_str(obj["\"`'><script>\\xC2\\x85javascript:alert(1)</script>"])
        script_x_c2_x_a0_javascript_alert_1_script = from_str(obj["\"`'><script>\\xC2\\xA0javascript:alert(1)</script>"])
        script_x_e1_x9_a_x80_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>"])
        script_x_e1_x_a0_x8_ejavascript_alert_1_script = from_str(obj["\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>"])
        script_x_e2_x80_x81_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>"])
        script_x_e2_x80_x86_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>"])
        script_x_e2_x80_x89_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>"])
        script_x_e2_x81_x9_fjavascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>"])
        script_x_ef_x_bb_x_b_fjavascript_alert_1_script = from_str(obj["\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>"])
        script_x_f0_x90_x96_x9_ajavascript_alert_1_script = from_str(obj["\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>"])
        changing_length_when_lowercased = from_str(obj["#\tChanging length when lowercased"])
        characters_which_increase_in_length_2_to_3_bytes_when_lowercased = from_str(obj["#\tCharacters which increase in length (2 to 3 bytes) when lowercased"])
        command_injection_ruby = from_str(obj["#\tCommand Injection (Ruby)"])
        human_injection = from_str(obj["#\tHuman injection"])
        innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem = from_str(obj["#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)"])
        known_cv_es_and_vulnerabilities = from_str(obj["#\tKnown CVEs and Vulnerabilities"])
        msdos_windows_special_filenames = from_str(obj["#\tMSDOS/Windows Special Filenames"])
        sql_injection = from_str(obj["#\tSQL Injection"])
        script_injection = from_str(obj["#\tScript Injection"])
        string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser = from_str(obj["#\tString which can reveal system files when parsed by a badly configured XML parser"])
        strings_that_test_for_known_vulnerabilities = from_str(obj["#\tStrings that test for known vulnerabilities"])
        strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string = from_str(obj["#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string."])
        strings_which_can_call_system_commands_within_ruby_rails_applications = from_str(obj["#\tStrings which can call system commands within Ruby/Rails applications"])
        strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web = from_str(obj["#\tStrings which consists of Japanese-style emoticons which are popular on the web"])
        strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always = from_str(obj["#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always"])
        strings_which_contain_bold_italic_etc_versions_of_normal_characters = from_str(obj["#\tStrings which contain bold/italic/etc. versions of normal characters"])
        strings_which_contain_common_unicode_symbols_e_g_smart_quotes = from_str(obj["#\tStrings which contain common unicode symbols (e.g. smart quotes)"])
        strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors = from_str(obj["#\tStrings which contain misplaced quotation marks; can cause encoding errors"])
        strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues = from_str(obj["#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues"])
        strings_which_crashed_i_message_in_various_versions_of_i_os = from_str(obj["#\tStrings which crashed iMessage in various versions of iOS"])
        strings_which_may_cause_human_to_reinterpret_worldview = from_str(obj["#\tStrings which may cause human to reinterpret worldview"])
        two_byte_characters = from_str(obj["#\tTwo-Byte Characters"])
        unicode_numbers = from_str(obj["#\tUnicode Numbers"])
        unicode_font = from_str(obj["#\tUnicode font"])
        unwanted_interpolation = from_str(obj["#\tUnwanted Interpolation"])
        fonts_and_have_a_number_of_special_behaviors = from_str(obj["#       fonts, and have a number of special behaviors"])
        non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f = from_str(obj["# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F."])
        the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers = from_str(obj["# The next two lines may appear to be blank or mojibake in some viewers."])
        u_0000_u_000_a_or_u_000_d_nul_lf_cr = from_str(obj["# U+0000, U+000A, or U+000D (NUL, LF, CR)."])
        and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often = from_str(obj["# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often"])
        env_home = from_str(obj["$ENV{'HOME'}"])
        home = from_str(obj["$HOME"])
        d = from_str(obj["%d"])
        s = from_str(obj["%s"])
        x_ls_al = from_str(obj["%x('ls -al /')"])
        purple = from_str(obj["'"])
        or_11 = from_str(obj["' OR '1'='1"])
        fluffy = from_str(obj["'\"'"])
        a_alert_123_t = from_str(obj["';alert(123);t='"])
        ʖ = from_str(obj["( ͡° ͜ʖ ͡°)"])
        null = from_str(obj["(null)"])
        tentacled = from_str(obj["(╯°□°）╯︵ ┻━┻)"])
        the_0 = from_str(obj["+0"])
        sticky = from_str(obj[","])
        indigo = from_str(obj[",./;'[]\\-="])
        indecent = from_str(obj["-,"])
        hilarious = from_str(obj["-."])
        a_0 = from_str(obj["-0"])
        the_1 = int(from_str(obj["-1"]))
        the_1_e02 = from_str(obj["-1E02"])
        infinity = from_str(obj["-Infinity"])
        etc_hosts = from_str(obj["../../../../../../../../../../../etc/hosts"])
        etc_passwd_00 = from_str(obj["../../../../../../../../../../../etc/passwd%00"])
        purple_0 = int(from_str(obj["0"]))
        the_000 = from_str(obj["0,0,0"])
        the_0000 = from_str(obj["0,0/0,0"])
        a_000 = from_str(obj["0,00"])
        the_00 = from_str(obj["0..0"])
        a_0000 = from_str(obj["0.0/0.0"])
        the_00_ɩ = from_str(obj["00˙Ɩ$-"])
        the_0_x0 = from_str(obj["0x0"])
        a_1 = int(from_str(obj["1"]))
        the_100000000 = from_str(obj["1 000 000.00"])
        the_1_qnan = from_str(obj["1#QNAN"])
        the_1_snan = from_str(obj["1#SNAN"])
        a_100000000 = from_str(obj["1'000'000.00"])
        the_100000 = from_str(obj["1'000,00"])
        the_1000 = from_str(obj["1.0/0.0"])
        the_100 = from_str(obj["1.00"])
        the_10 = from_str(obj["1/0"])
        the_12 = from_str(obj["1/2"])
        the_123456789012345678901234567890123456789 = from_str(obj["123456789012345678901234567890123456789"])
        the_1_drop_table_users = from_str(obj["1;DROP TABLE users"])
        a_1_e02 = from_str(obj["1E02"])
        the_1_e2 = from_str(obj["1E2"])
        the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 = from_str(obj["999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"])
        alert_123 = from_str(obj[";alert(123);"])
        if_img_src_x_onerror_javascript_alert_1 = from_str(obj["<!--[if<img src=x onerror=javascript:alert(1)//]> -->"])
        if_script_javascript_alert_1_script = from_str(obj["<!--[if]><script>javascript:alert(1)</script -->"])
        script_script_alert_123_script = from_str(obj["</script><script>alert(123)</script>"])
        textarea_script_alert_123_script = from_str(obj["</textarea><script>alert(123)</script>"])
        s_un_s_u = from_str(obj["<<< %s(un='%s') = %u"])
        ambitious = from_str(obj["<>?:\"{}|_+"])
        img_src_jav_ascript_alert_xss = from_str(obj["<IMG SRC=\"jav   ascript:alert('XSS');\">"])
        img_src_jav_x0_a_ascript_alert_xss = from_str(obj["<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">"])
        img_src_jav_x0_d_ascript_alert_xss = from_str(obj["<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">"])
        img_src_106971189711599114105112116589710810111411640398883833941 = from_str(obj["<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>"])
        script_src_http_ha_ckers_org_xss_js_b = from_str(obj["<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >"])
        script_src_http_ha_ckers_org_xss_js_script = from_str(obj["<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"])
        script_xss_src_http_ha_ckers_org_xss_js_script = from_str(obj["<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"])
        a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_java_123456781112_script_javascript_alert_1_xxx_a = from_str(obj["<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>"])
        foo_val_bar = from_str(obj["<foo val=`bar' />"])
        img_x00_src_x_onerror_alert_1 = from_str(obj["<img \\x00src=x onerror=\"alert(1)\">"])
        img_x39_src_x_onerror_javascript_alert_1 = from_str(obj["<img \\x39src=x onerror=\"javascript:alert(1)\">"])
        img_src_x_onerror_x00_javascript_alert_1 = from_str(obj["<img src=x onerror=\\x00\"javascript:alert(1)\">"])
        img_src_x_onerror_x09_javascript_alert_1 = from_str(obj["<img src=x onerror=\\x09\"javascript:alert(1)\">"])
        img_src_x_x09_onerror_javascript_alert_1 = from_str(obj["<img src=x\\x09onerror=\"javascript:alert(1)\">"])
        img_src_x_x10_onerror_javascript_alert_1 = from_str(obj["<img src=x\\x10onerror=\"javascript:alert(1)\">"])
        img_src_x_x11_onerror_javascript_alert_1 = from_str(obj["<img src=x\\x11onerror=\"javascript:alert(1)\">"])
        img_src_x_x12_onerror_javascript_alert_1 = from_str(obj["<img src=x\\x12onerror=\"javascript:alert(1)\">"])
        img_src_x_x13_onerror_javascript_alert_1 = from_str(obj["<img src=x\\x13onerror=\"javascript:alert(1)\">"])
        img_src_x09_x_onerror_javascript_alert_1 = from_str(obj["<img src\\x09=x onerror=\"javascript:alert(1)\">"])
        img_src_x11_x_onerror_javascript_alert_1 = from_str(obj["<img src\\x11=x onerror=\"javascript:alert(1)\">"])
        img_x10_src_x_onerror_javascript_alert_1 = from_str(obj["<img\\x10src=x onerror=\"javascript:alert(1)\">"])
        img_x13_src_x_onerror_javascript_alert_1 = from_str(obj["<img\\x13src=x onerror=\"javascript:alert(1)\">"])
        img_x32_src_x_onerror_javascript_alert_1 = from_str(obj["<img\\x32src=x onerror=\"javascript:alert(1)\">"])
        sc_script_ript_alert_123_sc_script_ript = from_str(obj["<sc<script>ript>alert(123)</sc</script>ript>"])
        script_x09_type_text_javascript_javascript_alert_1_script = from_str(obj["<script\\x09type=\"text/javascript\">javascript:alert(1);</script>"])
        script_x20_type_text_javascript_javascript_alert_1_script = from_str(obj["<script\\x20type=\"text/javascript\">javascript:alert(1);</script>"])
        script_x3_etype_text_javascript_javascript_alert_1_script = from_str(obj["<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>"])
        u_oncopy_alert_copy_me_u = from_str(obj["<u oncopy=alert()> Copy me</u>"])
        abc_div_style_x_x09_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x0_bexpression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x20_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF"])
        abc_div_style_x_exp_x00_ression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF"])
        abc_div_style_x_exp_x5_cression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x3_aexpression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF"])
        aux = from_str(obj["AUX"])
        arsenal_canal = from_str(obj["Arsenal canal"])
        dick_van_dyke = from_str(obj["Dick Van Dyke"])
        dr_herman_i_libshitz = from_str(obj["Dr. Herman I. Libshitz"])
        false = from_str(obj["False"])
        inf = from_str(obj["INF"])
        jimmy_clitheroe = from_str(obj["Jimmy Clitheroe"])
        kernel_exit_1 = from_str(obj["Kernel.exit(1)"])
        lpt2 = from_str(obj["LPT2"])
        lpt3 = from_str(obj["LPT3"])
        lightwater_country_park = from_str(obj["Lightwater Country Park"])
        none = from_str(obj["None"])
        prn = from_str(obj["PRN"])
        penistone_community_church = from_str(obj["Penistone Community Church"])
        romans_in_sussex_co_uk = from_str(obj["RomansInSussex.co.uk"])
        super_bowl_xxx = from_str(obj["Super Bowl XXX"])
        true = from_str(obj["TRUE"])
        the_quic_k_brown_fo_x_beeeep = from_str(obj["The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]"])
        a_true = from_str(obj["True"])
        z_ḁ_ḷ_g_o = from_str(obj["Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮"])
        cunning = from_str(obj["\\"])
        alert_xss = from_str(obj["\\\";alert('XSS');//"])
        img_src_xxx_x_x00_onerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>"])
        img_src_xxx_x_x0_bonerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>"])
        img_src_xxx_x_x2_fonerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>"])
        ls_al = from_str(obj["`ls -al /`"])
        ﬁﬂ = from_str(obj["`⁄€‹›ﬁﬂ‡°·‚—±"])
        classic = from_str(obj["classic"])
        dont_make_a_map = from_bool(obj["dontMakeAMap"])
        a_false = from_stringified_bool(from_str(obj["false"]))
        nil = from_str(obj["nil"])
        perl_e_print_img_src_java_0_script_alert_xss_out = from_str(obj["perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out"])
        undef = from_str(obj["undef"])
        fluffy_0 = from_str(obj["{0}"])
        magenta = from_str(obj["\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f"])
        ªº = from_str(obj["¡™£¢∞§¶•ªº–≠"])
        frisky = from_str(obj["\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\U000110bd\U0001bca0\U0001bca1\U0001bca2\U0001bca3\U0001d173\U0001d174\U0001d175\U0001d176\U0001d177\U0001d178\U0001d179\U0001d17a\U000e0001\U000e0020\U000e0021\U000e0022\U000e0023\U000e0024\U000e0025\U000e0026\U000e0027\U000e0028\U000e0029\U000e002a\U000e002b\U000e002c\U000e002d\U000e002e\U000e002f\U000e0030\U000e0031\U000e0032\U000e0033\U000e0034\U000e0035\U000e0036\U000e0037\U000e0038\U000e0039\U000e003a\U000e003b\U000e003c\U000e003d\U000e003e\U000e003f\U000e0040\U000e0041\U000e0042\U000e0043\U000e0044\U000e0045\U000e0046\U000e0047\U000e0048\U000e0049\U000e004a\U000e004b\U000e004c\U000e004d\U000e004e\U000e004f\U000e0050\U000e0051\U000e0052\U000e0053\U000e0054\U000e0055\U000e0056\U000e0057\U000e0058\U000e0059\U000e005a\U000e005b\U000e005c\U000e005d\U000e005e\U000e005f\U000e0060\U000e0061\U000e0062\U000e0063\U000e0064\U000e0065\U000e0066\U000e0067\U000e0068\U000e0069\U000e006a\U000e006b\U000e006c\U000e006d\U000e006e\U000e006f\U000e0070\U000e0071\U000e0072\U000e0073\U000e0074\U000e0075\U000e0076\U000e0077\U000e0078\U000e0079\U000e007a\U000e007b\U000e007c\U000e007d\U000e007e\U000e007f"])
        ç_ı_â = from_str(obj["¸˛Ç◊ı˜Â¯˘¿"])
        œ_á_ø = from_str(obj["Œ„´‰ˇÁ¨ˆØ∏”’"])
        œ_øπ = from_str(obj["œ∑´®†¥¨ˆøπ“‘"])
        ⱥ = from_str(obj["Ⱥ"])
        ⱦ = from_str(obj["Ⱦ"])
        i_n_v_ok_i_n_g_t_h_e_f_è_ẹ_l_i_n_g_o_f_c_h_á_o_s = from_str(obj["̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰"])
        הָיְתָה_test_الصفحاتالتّحول = from_str(obj["הָיְתָהtestالصفحات التّحول"])
        ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهّلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو = from_str(obj["ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو."])
        the_٠١٢٣٤٥٦٧٨٩ = from_str(obj["٠١٢٣٤٥٦٧٨٩"])
        ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ = from_str(obj["ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็"])
        test = from_str(obj["\u202a\u202atest\u202a"])
        a_test = from_str(obj["\u202btest\u202b"])
        purple_test = from_str(obj["\u2066test\u2067"])
        mischievous = from_str(obj["₀₁₂"])
        braggadocious = from_str(obj["⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢"])
        パーティーへ行かないか = from_str(obj["パーティーへ行かないか"])
        和製漢語 = from_str(obj["和製漢語"])
        田中さんにあげて下さい = from_str(obj["田中さんにあげて下さい"])
        the_2 = from_str(obj["\U0001d47b\U0001d489\U0001d486 \U0001d492\U0001d496\U0001d48a\U0001d484\U0001d48c \U0001d483\U0001d493\U0001d490\U0001d498\U0001d48f \U0001d487\U0001d490\U0001d499 \U0001d48b\U0001d496\U0001d48e\U0001d491\U0001d494 \U0001d490\U0001d497\U0001d486\U0001d493 \U0001d495\U0001d489\U0001d486 \U0001d48d\U0001d482\U0001d49b\U0001d49a \U0001d485\U0001d490\U0001d488"])
        the_3 = from_str(obj["\U0001d4e3\U0001d4f1\U0001d4ee \U0001d4fa\U0001d4fe\U0001d4f2\U0001d4ec\U0001d4f4 \U0001d4eb\U0001d4fb\U0001d4f8\U0001d500\U0001d4f7 \U0001d4ef\U0001d4f8\U0001d501 \U0001d4f3\U0001d4fe\U0001d4f6\U0001d4f9\U0001d4fc \U0001d4f8\U0001d4ff\U0001d4ee\U0001d4fb \U0001d4fd\U0001d4f1\U0001d4ee \U0001d4f5\U0001d4ea\U0001d503\U0001d502 \U0001d4ed\U0001d4f8\U0001d4f0"])
        the_4 = from_str(obj["\U0001d57f\U0001d58d\U0001d58a \U0001d596\U0001d59a\U0001d58e\U0001d588\U0001d590 \U0001d587\U0001d597\U0001d594\U0001d59c\U0001d593 \U0001d58b\U0001d594\U0001d59d \U0001d58f\U0001d59a\U0001d592\U0001d595\U0001d598 \U0001d594\U0001d59b\U0001d58a\U0001d597 \U0001d599\U0001d58d\U0001d58a \U0001d591\U0001d586\U0001d59f\U0001d59e \U0001d589\U0001d594\U0001d58c"])
        the_5 = from_str(obj["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8 \U0001f1e6\U0001f1eb\U0001f1e6\U0001f1f2\U0001f1f8"])
        the_6 = from_str(obj["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8\U0001f1e6"])
        the_7 = from_str(obj["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8\U0001f1e6\U0001f1eb\U0001f1e6\U0001f1f2"])
        the_8 = from_str(obj["\U0001f469\U0001f3fd"])
        the_9 = from_str(obj["\U0001f6be \U0001f192 \U0001f193 \U0001f195 \U0001f196 \U0001f197 \U0001f199 \U0001f3e7"])
        the_11 = from_str(obj["﷽"])
        the_13 = from_str(obj["\ufeff"])
        ｨ = from_str(obj["｀ｨ(´∀｀∩"])
        the_14 = from_str(obj["ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ"])
        the_15 = from_str(obj["\ufffe"])
        return A(empty, onfocus_ja_va_s_cript_alert_123_autofocus, a, autofocus_onkeyup_javascript_alert_123, alert_123_t, script_alert_123_script_x, script_x00_javascript_alert_1_script, script_x0_cjavascript_alert_1_script, script_x0_djavascript_alert_1_script, script_x_c2_x85_javascript_alert_1_script, script_x_c2_x_a0_javascript_alert_1_script, script_x_e1_x9_a_x80_javascript_alert_1_script, script_x_e1_x_a0_x8_ejavascript_alert_1_script, script_x_e2_x80_x81_javascript_alert_1_script, script_x_e2_x80_x86_javascript_alert_1_script, script_x_e2_x80_x89_javascript_alert_1_script, script_x_e2_x81_x9_fjavascript_alert_1_script, script_x_ef_x_bb_x_b_fjavascript_alert_1_script, script_x_f0_x90_x96_x9_ajavascript_alert_1_script, changing_length_when_lowercased, characters_which_increase_in_length_2_to_3_bytes_when_lowercased, command_injection_ruby, human_injection, innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem, known_cv_es_and_vulnerabilities, msdos_windows_special_filenames, sql_injection, script_injection, string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser, strings_that_test_for_known_vulnerabilities, strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string, strings_which_can_call_system_commands_within_ruby_rails_applications, strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web, strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always, strings_which_contain_bold_italic_etc_versions_of_normal_characters, strings_which_contain_common_unicode_symbols_e_g_smart_quotes, strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors, strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues, strings_which_crashed_i_message_in_various_versions_of_i_os, strings_which_may_cause_human_to_reinterpret_worldview, two_byte_characters, unicode_numbers, unicode_font, unwanted_interpolation, fonts_and_have_a_number_of_special_behaviors, non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f, the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers, u_0000_u_000_a_or_u_000_d_nul_lf_cr, and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often, env_home, home, d, s, x_ls_al, purple, or_11, fluffy, a_alert_123_t, ʖ, null, tentacled, the_0, sticky, indigo, indecent, hilarious, a_0, the_1, the_1_e02, infinity, etc_hosts, etc_passwd_00, purple_0, the_000, the_0000, a_000, the_00, a_0000, the_00_ɩ, the_0_x0, a_1, the_100000000, the_1_qnan, the_1_snan, a_100000000, the_100000, the_1000, the_100, the_10, the_12, the_123456789012345678901234567890123456789, the_1_drop_table_users, a_1_e02, the_1_e2, the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999, alert_123, if_img_src_x_onerror_javascript_alert_1, if_script_javascript_alert_1_script, script_script_alert_123_script, textarea_script_alert_123_script, s_un_s_u, ambitious, img_src_jav_ascript_alert_xss, img_src_jav_x0_a_ascript_alert_xss, img_src_jav_x0_d_ascript_alert_xss, img_src_106971189711599114105112116589710810111411640398883833941, script_src_http_ha_ckers_org_xss_js_b, script_src_http_ha_ckers_org_xss_js_script, script_xss_src_http_ha_ckers_org_xss_js_script, a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a, a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a, a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a, a_href_java_123456781112_script_javascript_alert_1_xxx_a, foo_val_bar, img_x00_src_x_onerror_alert_1, img_x39_src_x_onerror_javascript_alert_1, img_src_x_onerror_x00_javascript_alert_1, img_src_x_onerror_x09_javascript_alert_1, img_src_x_x09_onerror_javascript_alert_1, img_src_x_x10_onerror_javascript_alert_1, img_src_x_x11_onerror_javascript_alert_1, img_src_x_x12_onerror_javascript_alert_1, img_src_x_x13_onerror_javascript_alert_1, img_src_x09_x_onerror_javascript_alert_1, img_src_x11_x_onerror_javascript_alert_1, img_x10_src_x_onerror_javascript_alert_1, img_x13_src_x_onerror_javascript_alert_1, img_x32_src_x_onerror_javascript_alert_1, sc_script_ript_alert_123_sc_script_ript, script_x09_type_text_javascript_javascript_alert_1_script, script_x20_type_text_javascript_javascript_alert_1_script, script_x3_etype_text_javascript_javascript_alert_1_script, u_oncopy_alert_copy_me_u, abc_div_style_x_x09_expression_javascript_alert_1_def, abc_div_style_x_x0_bexpression_javascript_alert_1_def, abc_div_style_x_x20_expression_javascript_alert_1_def, abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def, abc_div_style_x_exp_x00_ression_javascript_alert_1_def, abc_div_style_x_exp_x5_cression_javascript_alert_1_def, abc_div_style_x_x3_aexpression_javascript_alert_1_def, aux, arsenal_canal, dick_van_dyke, dr_herman_i_libshitz, false, inf, jimmy_clitheroe, kernel_exit_1, lpt2, lpt3, lightwater_country_park, none, prn, penistone_community_church, romans_in_sussex_co_uk, super_bowl_xxx, true, the_quic_k_brown_fo_x_beeeep, a_true, z_ḁ_ḷ_g_o, cunning, alert_xss, img_src_xxx_x_x00_onerror_javascript_alert_1, img_src_xxx_x_x0_bonerror_javascript_alert_1, img_src_xxx_x_x2_fonerror_javascript_alert_1, ls_al, ﬁﬂ, classic, dont_make_a_map, a_false, nil, perl_e_print_img_src_java_0_script_alert_xss_out, undef, fluffy_0, magenta, ªº, frisky, ç_ı_â, œ_á_ø, œ_øπ, ⱥ, ⱦ, i_n_v_ok_i_n_g_t_h_e_f_è_ẹ_l_i_n_g_o_f_c_h_á_o_s, הָיְתָה_test_الصفحاتالتّحول, ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهّلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو, the_٠١٢٣٤٥٦٧٨٩, ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็, test, a_test, purple_test, mischievous, braggadocious, パーティーへ行かないか, 和製漢語, 田中さんにあげて下さい, the_2, the_3, the_4, the_5, the_6, the_7, the_8, the_9, the_11, the_13, ｨ, the_14, the_15)

    def to_dict(self) -> dict:
        result: dict = {}
        result[" "] = from_str(self.empty)
        result[" onfocus=JaVaSCript:alert(123) autofocus"] = from_str(self.onfocus_ja_va_s_cript_alert_123_autofocus)
        result["!@#$%^&*()`~"] = from_str(self.a)
        result["\" autofocus onkeyup=\"javascript:alert(123)"] = from_str(self.autofocus_onkeyup_javascript_alert_123)
        result["\";alert(123);t=\""] = from_str(self.alert_123_t)
        result["\"><script>alert(123);</script x=\""] = from_str(self.script_alert_123_script_x)
        result["\"`'><script>\\x00javascript:alert(1)</script>"] = from_str(self.script_x00_javascript_alert_1_script)
        result["\"`'><script>\\x0Cjavascript:alert(1)</script>"] = from_str(self.script_x0_cjavascript_alert_1_script)
        result["\"`'><script>\\x0Djavascript:alert(1)</script>"] = from_str(self.script_x0_djavascript_alert_1_script)
        result["\"`'><script>\\xC2\\x85javascript:alert(1)</script>"] = from_str(self.script_x_c2_x85_javascript_alert_1_script)
        result["\"`'><script>\\xC2\\xA0javascript:alert(1)</script>"] = from_str(self.script_x_c2_x_a0_javascript_alert_1_script)
        result["\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>"] = from_str(self.script_x_e1_x9_a_x80_javascript_alert_1_script)
        result["\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>"] = from_str(self.script_x_e1_x_a0_x8_ejavascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x81_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x86_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x89_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>"] = from_str(self.script_x_e2_x81_x9_fjavascript_alert_1_script)
        result["\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>"] = from_str(self.script_x_ef_x_bb_x_b_fjavascript_alert_1_script)
        result["\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>"] = from_str(self.script_x_f0_x90_x96_x9_ajavascript_alert_1_script)
        result["#\tChanging length when lowercased"] = from_str(self.changing_length_when_lowercased)
        result["#\tCharacters which increase in length (2 to 3 bytes) when lowercased"] = from_str(self.characters_which_increase_in_length_2_to_3_bytes_when_lowercased)
        result["#\tCommand Injection (Ruby)"] = from_str(self.command_injection_ruby)
        result["#\tHuman injection"] = from_str(self.human_injection)
        result["#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)"] = from_str(self.innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem)
        result["#\tKnown CVEs and Vulnerabilities"] = from_str(self.known_cv_es_and_vulnerabilities)
        result["#\tMSDOS/Windows Special Filenames"] = from_str(self.msdos_windows_special_filenames)
        result["#\tSQL Injection"] = from_str(self.sql_injection)
        result["#\tScript Injection"] = from_str(self.script_injection)
        result["#\tString which can reveal system files when parsed by a badly configured XML parser"] = from_str(self.string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser)
        result["#\tStrings that test for known vulnerabilities"] = from_str(self.strings_that_test_for_known_vulnerabilities)
        result["#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string."] = from_str(self.strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string)
        result["#\tStrings which can call system commands within Ruby/Rails applications"] = from_str(self.strings_which_can_call_system_commands_within_ruby_rails_applications)
        result["#\tStrings which consists of Japanese-style emoticons which are popular on the web"] = from_str(self.strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web)
        result["#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always"] = from_str(self.strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always)
        result["#\tStrings which contain bold/italic/etc. versions of normal characters"] = from_str(self.strings_which_contain_bold_italic_etc_versions_of_normal_characters)
        result["#\tStrings which contain common unicode symbols (e.g. smart quotes)"] = from_str(self.strings_which_contain_common_unicode_symbols_e_g_smart_quotes)
        result["#\tStrings which contain misplaced quotation marks; can cause encoding errors"] = from_str(self.strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors)
        result["#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues"] = from_str(self.strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues)
        result["#\tStrings which crashed iMessage in various versions of iOS"] = from_str(self.strings_which_crashed_i_message_in_various_versions_of_i_os)
        result["#\tStrings which may cause human to reinterpret worldview"] = from_str(self.strings_which_may_cause_human_to_reinterpret_worldview)
        result["#\tTwo-Byte Characters"] = from_str(self.two_byte_characters)
        result["#\tUnicode Numbers"] = from_str(self.unicode_numbers)
        result["#\tUnicode font"] = from_str(self.unicode_font)
        result["#\tUnwanted Interpolation"] = from_str(self.unwanted_interpolation)
        result["#       fonts, and have a number of special behaviors"] = from_str(self.fonts_and_have_a_number_of_special_behaviors)
        result["# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F."] = from_str(self.non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f)
        result["# The next two lines may appear to be blank or mojibake in some viewers."] = from_str(self.the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers)
        result["# U+0000, U+000A, or U+000D (NUL, LF, CR)."] = from_str(self.u_0000_u_000_a_or_u_000_d_nul_lf_cr)
        result["# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often"] = from_str(self.and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often)
        result["$ENV{'HOME'}"] = from_str(self.env_home)
        result["$HOME"] = from_str(self.home)
        result["%d"] = from_str(self.d)
        result["%s"] = from_str(self.s)
        result["%x('ls -al /')"] = from_str(self.x_ls_al)
        result["'"] = from_str(self.purple)
        result["' OR '1'='1"] = from_str(self.or_11)
        result["'\"'"] = from_str(self.fluffy)
        result["';alert(123);t='"] = from_str(self.a_alert_123_t)
        result["( ͡° ͜ʖ ͡°)"] = from_str(self.ʖ)
        result["(null)"] = from_str(self.null)
        result["(╯°□°）╯︵ ┻━┻)"] = from_str(self.tentacled)
        result["+0"] = from_str(self.the_0)
        result[","] = from_str(self.sticky)
        result[",./;'[]\\-="] = from_str(self.indigo)
        result["-,"] = from_str(self.indecent)
        result["-."] = from_str(self.hilarious)
        result["-0"] = from_str(self.a_0)
        result["-1"] = from_str(str(self.the_1))
        result["-1E02"] = from_str(self.the_1_e02)
        result["-Infinity"] = from_str(self.infinity)
        result["../../../../../../../../../../../etc/hosts"] = from_str(self.etc_hosts)
        result["../../../../../../../../../../../etc/passwd%00"] = from_str(self.etc_passwd_00)
        result["0"] = from_str(str(self.purple_0))
        result["0,0,0"] = from_str(self.the_000)
        result["0,0/0,0"] = from_str(self.the_0000)
        result["0,00"] = from_str(self.a_000)
        result["0..0"] = from_str(self.the_00)
        result["0.0/0.0"] = from_str(self.a_0000)
        result["00˙Ɩ$-"] = from_str(self.the_00_ɩ)
        result["0x0"] = from_str(self.the_0_x0)
        result["1"] = from_str(str(self.a_1))
        result["1 000 000.00"] = from_str(self.the_100000000)
        result["1#QNAN"] = from_str(self.the_1_qnan)
        result["1#SNAN"] = from_str(self.the_1_snan)
        result["1'000'000.00"] = from_str(self.a_100000000)
        result["1'000,00"] = from_str(self.the_100000)
        result["1.0/0.0"] = from_str(self.the_1000)
        result["1.00"] = from_str(self.the_100)
        result["1/0"] = from_str(self.the_10)
        result["1/2"] = from_str(self.the_12)
        result["123456789012345678901234567890123456789"] = from_str(self.the_123456789012345678901234567890123456789)
        result["1;DROP TABLE users"] = from_str(self.the_1_drop_table_users)
        result["1E02"] = from_str(self.a_1_e02)
        result["1E2"] = from_str(self.the_1_e2)
        result["999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"] = from_str(self.the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999)
        result[";alert(123);"] = from_str(self.alert_123)
        result["<!--[if<img src=x onerror=javascript:alert(1)//]> -->"] = from_str(self.if_img_src_x_onerror_javascript_alert_1)
        result["<!--[if]><script>javascript:alert(1)</script -->"] = from_str(self.if_script_javascript_alert_1_script)
        result["</script><script>alert(123)</script>"] = from_str(self.script_script_alert_123_script)
        result["</textarea><script>alert(123)</script>"] = from_str(self.textarea_script_alert_123_script)
        result["<<< %s(un='%s') = %u"] = from_str(self.s_un_s_u)
        result["<>?:\"{}|_+"] = from_str(self.ambitious)
        result["<IMG SRC=\"jav   ascript:alert('XSS');\">"] = from_str(self.img_src_jav_ascript_alert_xss)
        result["<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">"] = from_str(self.img_src_jav_x0_a_ascript_alert_xss)
        result["<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">"] = from_str(self.img_src_jav_x0_d_ascript_alert_xss)
        result["<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>"] = from_str(self.img_src_106971189711599114105112116589710810111411640398883833941)
        result["<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >"] = from_str(self.script_src_http_ha_ckers_org_xss_js_b)
        result["<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"] = from_str(self.script_src_http_ha_ckers_org_xss_js_script)
        result["<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>"] = from_str(self.script_xss_src_http_ha_ckers_org_xss_js_script)
        result["<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>"] = from_str(self.a_href_java_123456781112_script_javascript_alert_1_xxx_a)
        result["<foo val=`bar' />"] = from_str(self.foo_val_bar)
        result["<img \\x00src=x onerror=\"alert(1)\">"] = from_str(self.img_x00_src_x_onerror_alert_1)
        result["<img \\x39src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x39_src_x_onerror_javascript_alert_1)
        result["<img src=x onerror=\\x00\"javascript:alert(1)\">"] = from_str(self.img_src_x_onerror_x00_javascript_alert_1)
        result["<img src=x onerror=\\x09\"javascript:alert(1)\">"] = from_str(self.img_src_x_onerror_x09_javascript_alert_1)
        result["<img src=x\\x09onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x_x09_onerror_javascript_alert_1)
        result["<img src=x\\x10onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x_x10_onerror_javascript_alert_1)
        result["<img src=x\\x11onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x_x11_onerror_javascript_alert_1)
        result["<img src=x\\x12onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x_x12_onerror_javascript_alert_1)
        result["<img src=x\\x13onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x_x13_onerror_javascript_alert_1)
        result["<img src\\x09=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x09_x_onerror_javascript_alert_1)
        result["<img src\\x11=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x11_x_onerror_javascript_alert_1)
        result["<img\\x10src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x10_src_x_onerror_javascript_alert_1)
        result["<img\\x13src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x13_src_x_onerror_javascript_alert_1)
        result["<img\\x32src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x32_src_x_onerror_javascript_alert_1)
        result["<sc<script>ript>alert(123)</sc</script>ript>"] = from_str(self.sc_script_ript_alert_123_sc_script_ript)
        result["<script\\x09type=\"text/javascript\">javascript:alert(1);</script>"] = from_str(self.script_x09_type_text_javascript_javascript_alert_1_script)
        result["<script\\x20type=\"text/javascript\">javascript:alert(1);</script>"] = from_str(self.script_x20_type_text_javascript_javascript_alert_1_script)
        result["<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>"] = from_str(self.script_x3_etype_text_javascript_javascript_alert_1_script)
        result["<u oncopy=alert()> Copy me</u>"] = from_str(self.u_oncopy_alert_copy_me_u)
        result["ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x09_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x0_bexpression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x20_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def)
        result["ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_exp_x00_ression_javascript_alert_1_def)
        result["ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_exp_x5_cression_javascript_alert_1_def)
        result["ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x3_aexpression_javascript_alert_1_def)
        result["AUX"] = from_str(self.aux)
        result["Arsenal canal"] = from_str(self.arsenal_canal)
        result["Dick Van Dyke"] = from_str(self.dick_van_dyke)
        result["Dr. Herman I. Libshitz"] = from_str(self.dr_herman_i_libshitz)
        result["False"] = from_str(self.false)
        result["INF"] = from_str(self.inf)
        result["Jimmy Clitheroe"] = from_str(self.jimmy_clitheroe)
        result["Kernel.exit(1)"] = from_str(self.kernel_exit_1)
        result["LPT2"] = from_str(self.lpt2)
        result["LPT3"] = from_str(self.lpt3)
        result["Lightwater Country Park"] = from_str(self.lightwater_country_park)
        result["None"] = from_str(self.none)
        result["PRN"] = from_str(self.prn)
        result["Penistone Community Church"] = from_str(self.penistone_community_church)
        result["RomansInSussex.co.uk"] = from_str(self.romans_in_sussex_co_uk)
        result["Super Bowl XXX"] = from_str(self.super_bowl_xxx)
        result["TRUE"] = from_str(self.true)
        result["The quic\u0008\u0008\u0008\u0008\u0008\u0008k brown fo\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007\u0007x... [Beeeep]"] = from_str(self.the_quic_k_brown_fo_x_beeeep)
        result["True"] = from_str(self.a_true)
        result["Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮"] = from_str(self.z_ḁ_ḷ_g_o)
        result["\\"] = from_str(self.cunning)
        result["\\\";alert('XSS');//"] = from_str(self.alert_xss)
        result["`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x00_onerror_javascript_alert_1)
        result["`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x0_bonerror_javascript_alert_1)
        result["`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x2_fonerror_javascript_alert_1)
        result["`ls -al /`"] = from_str(self.ls_al)
        result["`⁄€‹›ﬁﬂ‡°·‚—±"] = from_str(self.ﬁﬂ)
        result["classic"] = from_str(self.classic)
        result["dontMakeAMap"] = from_bool(self.dont_make_a_map)
        result["false"] = from_str(str(self.a_false).lower())
        result["nil"] = from_str(self.nil)
        result["perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out"] = from_str(self.perl_e_print_img_src_java_0_script_alert_xss_out)
        result["undef"] = from_str(self.undef)
        result["{0}"] = from_str(self.fluffy_0)
        result["\u0080\u0081\u0082\u0083\u0084\u0086\u0087\u0088\u0089\u008a\u008b\u008c\u008d\u008e\u008f\u0090\u0091\u0092\u0093\u0094\u0095\u0096\u0097\u0098\u0099\u009a\u009b\u009c\u009d\u009e\u009f"] = from_str(self.magenta)
        result["¡™£¢∞§¶•ªº–≠"] = from_str(self.ªº)
        result["\u00ad\u0600\u0601\u0602\u0603\u0604\u0605\u061c\u06dd\u070f\u180e\u200b\u200c\u200d\u200e\u200f\u202a\u202b\u202c\u202d\u202e\u2060\u2061\u2062\u2063\u2064\u2066\u2067\u2068\u2069\u206a\u206b\u206c\u206d\u206e\u206f\ufeff\ufff9\ufffa\ufffb\U000110bd\U0001bca0\U0001bca1\U0001bca2\U0001bca3\U0001d173\U0001d174\U0001d175\U0001d176\U0001d177\U0001d178\U0001d179\U0001d17a\U000e0001\U000e0020\U000e0021\U000e0022\U000e0023\U000e0024\U000e0025\U000e0026\U000e0027\U000e0028\U000e0029\U000e002a\U000e002b\U000e002c\U000e002d\U000e002e\U000e002f\U000e0030\U000e0031\U000e0032\U000e0033\U000e0034\U000e0035\U000e0036\U000e0037\U000e0038\U000e0039\U000e003a\U000e003b\U000e003c\U000e003d\U000e003e\U000e003f\U000e0040\U000e0041\U000e0042\U000e0043\U000e0044\U000e0045\U000e0046\U000e0047\U000e0048\U000e0049\U000e004a\U000e004b\U000e004c\U000e004d\U000e004e\U000e004f\U000e0050\U000e0051\U000e0052\U000e0053\U000e0054\U000e0055\U000e0056\U000e0057\U000e0058\U000e0059\U000e005a\U000e005b\U000e005c\U000e005d\U000e005e\U000e005f\U000e0060\U000e0061\U000e0062\U000e0063\U000e0064\U000e0065\U000e0066\U000e0067\U000e0068\U000e0069\U000e006a\U000e006b\U000e006c\U000e006d\U000e006e\U000e006f\U000e0070\U000e0071\U000e0072\U000e0073\U000e0074\U000e0075\U000e0076\U000e0077\U000e0078\U000e0079\U000e007a\U000e007b\U000e007c\U000e007d\U000e007e\U000e007f"] = from_str(self.frisky)
        result["¸˛Ç◊ı˜Â¯˘¿"] = from_str(self.ç_ı_â)
        result["Œ„´‰ˇÁ¨ˆØ∏”’"] = from_str(self.œ_á_ø)
        result["œ∑´®†¥¨ˆøπ“‘"] = from_str(self.œ_øπ)
        result["Ⱥ"] = from_str(self.ⱥ)
        result["Ⱦ"] = from_str(self.ⱦ)
        result["̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰"] = from_str(self.i_n_v_ok_i_n_g_t_h_e_f_è_ẹ_l_i_n_g_o_f_c_h_á_o_s)
        result["הָיְתָהtestالصفحات التّحول"] = from_str(self.הָיְתָה_test_الصفحاتالتّحول)
        result["ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو."] = from_str(self.ثمنفسسقطتوبالتحديدجزيرتيباستخدامأندنوإذهناالستاروتنصيبكانأهّلايطاليابريطانيافرنساقدأخذسليمانإتفاقيةبينمايذكرالحدودأيبعدمعاملةبولنداالإطلاقعلإيو)
        result["٠١٢٣٤٥٦٧٨٩"] = from_str(self.the_٠١٢٣٤٥٦٧٨٩)
        result["ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็"] = from_str(self.ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็)
        result["\u202a\u202atest\u202a"] = from_str(self.test)
        result["\u202btest\u202b"] = from_str(self.a_test)
        result["\u2066test\u2067"] = from_str(self.purple_test)
        result["₀₁₂"] = from_str(self.mischievous)
        result["⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢"] = from_str(self.braggadocious)
        result["パーティーへ行かないか"] = from_str(self.パーティーへ行かないか)
        result["和製漢語"] = from_str(self.和製漢語)
        result["田中さんにあげて下さい"] = from_str(self.田中さんにあげて下さい)
        result["\U0001d47b\U0001d489\U0001d486 \U0001d492\U0001d496\U0001d48a\U0001d484\U0001d48c \U0001d483\U0001d493\U0001d490\U0001d498\U0001d48f \U0001d487\U0001d490\U0001d499 \U0001d48b\U0001d496\U0001d48e\U0001d491\U0001d494 \U0001d490\U0001d497\U0001d486\U0001d493 \U0001d495\U0001d489\U0001d486 \U0001d48d\U0001d482\U0001d49b\U0001d49a \U0001d485\U0001d490\U0001d488"] = from_str(self.the_2)
        result["\U0001d4e3\U0001d4f1\U0001d4ee \U0001d4fa\U0001d4fe\U0001d4f2\U0001d4ec\U0001d4f4 \U0001d4eb\U0001d4fb\U0001d4f8\U0001d500\U0001d4f7 \U0001d4ef\U0001d4f8\U0001d501 \U0001d4f3\U0001d4fe\U0001d4f6\U0001d4f9\U0001d4fc \U0001d4f8\U0001d4ff\U0001d4ee\U0001d4fb \U0001d4fd\U0001d4f1\U0001d4ee \U0001d4f5\U0001d4ea\U0001d503\U0001d502 \U0001d4ed\U0001d4f8\U0001d4f0"] = from_str(self.the_3)
        result["\U0001d57f\U0001d58d\U0001d58a \U0001d596\U0001d59a\U0001d58e\U0001d588\U0001d590 \U0001d587\U0001d597\U0001d594\U0001d59c\U0001d593 \U0001d58b\U0001d594\U0001d59d \U0001d58f\U0001d59a\U0001d592\U0001d595\U0001d598 \U0001d594\U0001d59b\U0001d58a\U0001d597 \U0001d599\U0001d58d\U0001d58a \U0001d591\U0001d586\U0001d59f\U0001d59e \U0001d589\U0001d594\U0001d58c"] = from_str(self.the_4)
        result["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8 \U0001f1e6\U0001f1eb\U0001f1e6\U0001f1f2\U0001f1f8"] = from_str(self.the_5)
        result["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8\U0001f1e6"] = from_str(self.the_6)
        result["\U0001f1fa\U0001f1f8\U0001f1f7\U0001f1fa\U0001f1f8\U0001f1e6\U0001f1eb\U0001f1e6\U0001f1f2"] = from_str(self.the_7)
        result["\U0001f469\U0001f3fd"] = from_str(self.the_8)
        result["\U0001f6be \U0001f192 \U0001f193 \U0001f195 \U0001f196 \U0001f197 \U0001f199 \U0001f3e7"] = from_str(self.the_9)
        result["﷽"] = from_str(self.the_11)
        result["\ufeff"] = from_str(self.the_13)
        result["｀ｨ(´∀｀∩"] = from_str(self.ｨ)
        result["ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ"] = from_str(self.the_14)
        result["\ufffe"] = from_str(self.the_15)
        return result


@dataclass
class B:
    empty: str
    b: str
    purple: str
    onfocus_ja_va_s_cript_alert_123_autofocus: str
    script_alert_123_script: str
    script_x09_javascript_alert_1_script: str
    script_x21_javascript_alert_1_script: str
    script_x3_bjavascript_alert_1_script: str
    script_x_e2_x80_x85_javascript_alert_1_script: str
    script_x_e2_x80_x87_javascript_alert_1_script: str
    script_x_e2_x80_x8_ajavascript_alert_1_script: str
    script_x_e2_x80_x_a8_javascript_alert_1_script: str
    script_x_e2_x80_x_a9_javascript_alert_1_script: str
    script_x_e2_x80_x_a_fjavascript_alert_1_script: str
    script_x_e3_x80_x80_javascript_alert_1_script: str
    fluffy: str
    credit_https_twitter_com_jifa_status_625776454479970304: str
    file_inclusion: str
    japanese_emoticons: str
    numeric_strings: str
    quotation_marks: str
    reserved_strings: str
    scunthorpe_problem: str
    strings_which_are_reserved_characters_in_msdos_windows: str
    strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss: str
    strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew: str
    strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues: str
    strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric: str
    strings_which_may_be_used_elsewhere_in_code: str
    terminal_escape_codes: str
    unicode_symbols: str
    i_os_vulnerabilities: str
    regional_indicator_symbols: str
    regional_indicator_symbols_can_be_displayed_differently_across: str
    irc_specific_strings: str
    strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out: str
    byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line: str
    commonly_misinterpreted_as_additional_graphic_characters: str
    often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml: str
    the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers: str
    the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers: str
    the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers: str
    this_file_unfortunately_cannot_express_strings_containing: str
    appear_in_input: str
    contexts_divided_into_three_groups_based_on_us_layout_keyboard_position: str
    general_category_cf_in_unicode_800: str
    touch_tmp_blns_fail: str
    the_100: str
    or_111: str
    autofocus_onkeyup_javascript_alert_123: str
    x00_script_javascript_alert_1_script: str
    x3_cscript_javascript_alert_1_script: str
    touch_tmp_blns_shellshock2_fail: str
    tentacled: str
    ath0: str
    b_script_alert_123_script: str
    help: str
    the_21474836481: str
    dev_null_touch_tmp_blns_fail_echo: str
    the_000: str
    the_01000: str
    the_08: str
    the_09: str
    the_0_xffffffffffffffff: str
    the_100000000: str
    the_100000: str
    the_1_ind: str
    the_1_inf: str
    b_100000: str
    the_1_drop_table_users_1: str
    the_1000: str
    the_22250738585072011_e_308: str
    script_alert_xss_script: str
    img_src_onmouseover_alert_xxs: str
    img_src_14_javascript_alert_xss: str
    img_src_jav_x09_ascript_alert_xss: str
    b_img_src_onmouseover_alert_xxs: str
    img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041: str
    img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29: str
    script_src_ha_ckers_org_j: str
    a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a: str
    foo_val_bar: str
    iframe_src_http_ha_ckers_org_scriptlet_html: str
    img_x00_src_x_onerror_javascript_alert_1: str
    img_x11_src_x_onerror_javascript_alert_1: str
    img_x12_src_x_onerror_javascript_alert_1: str
    img_x47_src_x_onerror_javascript_alert_1: str
    img_src_x_onerror_x11_javascript_alert_1: str
    img_src_x_onerror_x12_javascript_alert_1: str
    img_src_x00_x_onerror_javascript_alert_1: str
    script_src_jscript_s_script: str
    purple_script_alert_123_script: str
    script_x0_atype_text_javascript_javascript_alert_1_script: str
    script_x0_dtype_text_javascript_javascript_alert_1_script: str
    script_alert_123_script_x: str
    abc_div_style_x_x0_aexpression_javascript_alert_1_def: str
    abc_div_style_x_x0_dexpression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def: str
    abc_div_style_x_expression_x5_c_javascript_alert_1_def: str
    but_now_20_cfor_my_greatest_trick_8_m: str
    com1: str
    com3: str
    con: str
    false: str
    file: str
    if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you: str
    kernel_exec_ls_al: str
    linda_callahan: str
    nil: str
    nul: str
    tyson_gay: str
    ﾛ_: str
    img_src_xxx_x_x0_aonerror_javascript_alert_1: str
    img_src_xxx_x_x0_conerror_javascript_alert_1: str
    img_src_xxx_x_x0_donerror_javascript_alert_1: str
    b_touch_tmp_blns_fail: str
    basement: str
    dont_make_a_map: bool
    eval_puts_hello_world: str
    expression: str
    http_a_3030: str
    null: str
    åß_ƒ_æ: str
    ɐnbᴉlɐ_ɐuƃɐɯ_ǝɹolop_ʇǝ_ǝɹoqɐl_ʇn_ʇunpᴉpᴉɔuᴉ_ɹodɯǝʇ_poɯsnᴉǝ_op_pǝs_ʇᴉlǝ_ƃuᴉɔsᴉdᴉpɐ_ɹnʇǝʇɔǝsuoɔ_ʇǝɯɐ_ʇᴉs_ɹolop_ɯnsdᴉ_ɯǝɹo: str
    h_e_w_h_o_w_a_į_t_s_b_e_h_i_n_d_t_h_e_w_a_l_ḽ: str
    ω_ç_µ: str
    ṱ_o_i_n_v_o_kè_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_ǹ_t_i_n_g_c_h_a_o_s: str
    sticky: str
    indigo: str
    ຈل͜ຈﾉヽຈل͜ຈﾉ: str
    社會科學院語學研究所: str
    部落格: str
    사회과학원어학연구소: str
    찦차를타고온펲시맨과쑛다리똠방각하: str
    indecent: str
    hilarious: str
    ambitious: str
    the_１２３: str

    @staticmethod
    def from_dict(obj: Any) -> 'B':
        assert isinstance(obj, dict)
        empty = from_str(obj["\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f"])
        b = from_str(obj["\t\u000b\u000c \u0085             \u200b\u2028\u2029  　"])
        purple = from_str(obj["\""])
        onfocus_ja_va_s_cript_alert_123_autofocus = from_str(obj["\" onfocus=JaVaSCript:alert(123) autofocus"])
        script_alert_123_script = from_str(obj["\"><script>alert(123)</script>"])
        script_x09_javascript_alert_1_script = from_str(obj["\"`'><script>\\x09javascript:alert(1)</script>"])
        script_x21_javascript_alert_1_script = from_str(obj["\"`'><script>\\x21javascript:alert(1)</script>"])
        script_x3_bjavascript_alert_1_script = from_str(obj["\"`'><script>\\x3Bjavascript:alert(1)</script>"])
        script_x_e2_x80_x85_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>"])
        script_x_e2_x80_x87_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>"])
        script_x_e2_x80_x8_ajavascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>"])
        script_x_e2_x80_x_a8_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>"])
        script_x_e2_x80_x_a9_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>"])
        script_x_e2_x80_x_a_fjavascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>"])
        script_x_e3_x80_x80_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>"])
        fluffy = from_str(obj["#"])
        credit_https_twitter_com_jifa_status_625776454479970304 = from_str(obj["#\tCredit: https://twitter.com/jifa/status/625776454479970304"])
        file_inclusion = from_str(obj["#\tFile Inclusion"])
        japanese_emoticons = from_str(obj["#\tJapanese Emoticons"])
        numeric_strings = from_str(obj["#\tNumeric Strings"])
        quotation_marks = from_str(obj["#\tQuotation Marks"])
        reserved_strings = from_str(obj["#\tReserved Strings"])
        scunthorpe_problem = from_str(obj["#\tScunthorpe Problem"])
        strings_which_are_reserved_characters_in_msdos_windows = from_str(obj["#\tStrings which are reserved characters in MSDOS/Windows"])
        strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss = from_str(obj["#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS"])
        strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew = from_str(obj["#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)"])
        strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues = from_str(obj["#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues"])
        strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric = from_str(obj["#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric"])
        strings_which_may_be_used_elsewhere_in_code = from_str(obj["#\tStrings which may be used elsewhere in code"])
        terminal_escape_codes = from_str(obj["#\tTerminal escape codes"])
        unicode_symbols = from_str(obj["#\tUnicode Symbols"])
        i_os_vulnerabilities = from_str(obj["#\tiOS Vulnerabilities"])
        regional_indicator_symbols = from_str(obj["#       Regional Indicator Symbols"])
        regional_indicator_symbols_can_be_displayed_differently_across = from_str(obj["#       Regional Indicator Symbols can be displayed differently across"])
        irc_specific_strings = from_str(obj["#   IRC specific strings"])
        strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out = from_str(obj["#   Strings that may occur on IRC clients that make security products freak out"])
        byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line = from_str(obj["# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line."])
        commonly_misinterpreted_as_additional_graphic_characters = from_str(obj["# Commonly misinterpreted as additional graphic characters."])
        often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml = from_str(obj["# Often forbidden to appear in various text-based file formats (e.g. XML),"])
        the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers = from_str(obj["# The next line may appear to be blank or mojibake in some viewers."])
        the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers = from_str(obj["# The next line may appear to be blank, mojibake, or dingbats in some viewers."])
        the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers = from_str(obj["# The next line may be flagged for \"trailing whitespace\" in some viewers."])
        this_file_unfortunately_cannot_express_strings_containing = from_str(obj["# This file unfortunately cannot express strings containing"])
        appear_in_input = from_str(obj["# appear in input."])
        contexts_divided_into_three_groups_based_on_us_layout_keyboard_position = from_str(obj["# contexts.  Divided into three groups based on (US-layout) keyboard position."])
        general_category_cf_in_unicode_800 = from_str(obj["# general category Cf (in Unicode 8.0.0)."])
        touch_tmp_blns_fail = from_str(obj["$(touch /tmp/blns.fail)"])
        the_100 = from_str(obj["$1.00"])
        or_111 = from_str(obj["' OR 1=1 -- 1"])
        autofocus_onkeyup_javascript_alert_123 = from_str(obj["' autofocus onkeyup='javascript:alert(123)"])
        x00_script_javascript_alert_1_script = from_str(obj["'`\"><\\x00script>javascript:alert(1)</script>"])
        x3_cscript_javascript_alert_1_script = from_str(obj["'`\"><\\x3Cscript>javascript:alert(1)</script>"])
        touch_tmp_blns_shellshock2_fail = from_str(obj["() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }"])
        tentacled = from_str(obj["(｡◕ ∀ ◕｡)"])
        ath0 = from_str(obj["+++ATH0"])
        b_script_alert_123_script = from_str(obj["--><script>alert(123)</script>"])
        help = from_str(obj["--help"])
        the_21474836481 = from_str(obj["-2147483648/-1"])
        dev_null_touch_tmp_blns_fail_echo = from_str(obj["/dev/null; touch /tmp/blns.fail ; echo"])
        the_000 = from_str(obj["0.00"])
        the_01000 = from_str(obj["01000"])
        the_08 = from_str(obj["08"])
        the_09 = from_str(obj["09"])
        the_0_xffffffffffffffff = from_str(obj["0xffffffffffffffff"])
        the_100000000 = from_str(obj["1 000 000,00"])
        the_100000 = from_str(obj["1 000.00"])
        the_1_ind = from_str(obj["1#IND"])
        the_1_inf = from_str(obj["1#INF"])
        b_100000 = from_str(obj["1'000.00"])
        the_1_drop_table_users_1 = from_str(obj["1'; DROP TABLE users-- 1"])
        the_1000 = from_str(obj["1,0/0,0"])
        the_22250738585072011_e_308 = from_str(obj["2.2250738585072011e-308"])
        script_alert_xss_script = from_str(obj["<<SCRIPT>alert(\"XSS\");//<</SCRIPT>"])
        img_src_onmouseover_alert_xxs = from_str(obj["<IMG SRC= onmouseover=\"alert('xxs')\">"])
        img_src_14_javascript_alert_xss = from_str(obj["<IMG SRC=\" &#14;  javascript:alert('XSS');\">"])
        img_src_jav_x09_ascript_alert_xss = from_str(obj["<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">"])
        b_img_src_onmouseover_alert_xxs = from_str(obj["<IMG SRC=# onmouseover=\"alert('xxs')\">"])
        img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041 = from_str(obj["<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>"])
        img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29 = from_str(obj["<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>"])
        script_src_ha_ckers_org_j = from_str(obj["<SCRIPT SRC=//ha.ckers.org/.j>"])
        a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a = from_str(obj["<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">"])
        foo_val_bar = from_str(obj["<foo val=”bar“ />"])
        iframe_src_http_ha_ckers_org_scriptlet_html = from_str(obj["<iframe src=http://ha.ckers.org/scriptlet.html <"])
        img_x00_src_x_onerror_javascript_alert_1 = from_str(obj["<img \\x00src=x onerror=\"javascript:alert(1)\">"])
        img_x11_src_x_onerror_javascript_alert_1 = from_str(obj["<img \\x11src=x onerror=\"javascript:alert(1)\">"])
        img_x12_src_x_onerror_javascript_alert_1 = from_str(obj["<img \\x12src=x onerror=\"javascript:alert(1)\">"])
        img_x47_src_x_onerror_javascript_alert_1 = from_str(obj["<img \\x47src=x onerror=\"javascript:alert(1)\">"])
        img_src_x_onerror_x11_javascript_alert_1 = from_str(obj["<img src=x onerror=\\x11\"javascript:alert(1)\">"])
        img_src_x_onerror_x12_javascript_alert_1 = from_str(obj["<img src=x onerror=\\x12\"javascript:alert(1)\">"])
        img_src_x00_x_onerror_javascript_alert_1 = from_str(obj["<img src\\x00=x onerror=\"javascript:alert(1)\">"])
        script_src_jscript_s_script = from_str(obj["<script src=\"\\\\%(jscript)s\"></script>"])
        purple_script_alert_123_script = from_str(obj["<script>alert(123)</script>"])
        script_x0_atype_text_javascript_javascript_alert_1_script = from_str(obj["<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>"])
        script_x0_dtype_text_javascript_javascript_alert_1_script = from_str(obj["<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>"])
        script_alert_123_script_x = from_str(obj["><script>alert(123);</script x="])
        abc_div_style_x_x0_aexpression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x0_dexpression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF"])
        abc_div_style_x_expression_x5_c_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF"])
        but_now_20_cfor_my_greatest_trick_8_m = from_str(obj["But now...\u001b[20Cfor my greatest trick...\u001b[8m"])
        com1 = from_str(obj["COM1"])
        com3 = from_str(obj["COM3"])
        con = from_str(obj["CON"])
        false = from_str(obj["FALSE"])
        file = from_str(obj["File:///"])
        if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you = from_str(obj["If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you."])
        kernel_exec_ls_al = from_str(obj["Kernel.exec(\"ls -al /\")"])
        linda_callahan = from_str(obj["Linda Callahan"])
        nil = from_str(obj["NIL"])
        nul = from_str(obj["NUL"])
        tyson_gay = from_str(obj["Tyson Gay"])
        ﾛ_ = from_str(obj["__ﾛ(,_,*)"])
        img_src_xxx_x_x0_aonerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>"])
        img_src_xxx_x_x0_conerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>"])
        img_src_xxx_x_x0_donerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>"])
        b_touch_tmp_blns_fail = from_str(obj["`touch /tmp/blns.fail`"])
        basement = from_str(obj["basement"])
        dont_make_a_map = from_bool(obj["dontMakeAMap"])
        eval_puts_hello_world = from_str(obj["eval(\"puts 'hello world'\")"])
        expression = from_str(obj["expression"])
        http_a_3030 = from_str(obj["http://a/%%30%30"])
        null = from_str(obj["null"])
        åß_ƒ_æ = from_str(obj["åß∂ƒ©˙∆˚¬…æ"])
        ɐnbᴉlɐ_ɐuƃɐɯ_ǝɹolop_ʇǝ_ǝɹoqɐl_ʇn_ʇunpᴉpᴉɔuᴉ_ɹodɯǝʇ_poɯsnᴉǝ_op_pǝs_ʇᴉlǝ_ƃuᴉɔsᴉdᴉpɐ_ɹnʇǝʇɔǝsuoɔ_ʇǝɯɐ_ʇᴉs_ɹolop_ɯnsdᴉ_ɯǝɹo = from_str(obj["˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥"])
        h_e_w_h_o_w_a_į_t_s_b_e_h_i_n_d_t_h_e_w_a_l_ḽ = from_str(obj["̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕"])
        ω_ç_µ = from_str(obj["Ω≈ç√∫˜µ≤≥÷"])
        ṱ_o_i_n_v_o_kè_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_ǹ_t_i_n_g_c_h_a_o_s = from_str(obj["Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣"])
        sticky = from_str(obj["⁰⁴⁵₀₁₂"])
        indigo = from_str(obj["❤️ \U0001f494 \U0001f48c \U0001f495 \U0001f49e \U0001f493 \U0001f497 \U0001f496 \U0001f498 \U0001f49d \U0001f49f \U0001f49c \U0001f49b \U0001f49a \U0001f499"])
        ຈل͜ຈﾉヽຈل͜ຈﾉ = from_str(obj["ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ"])
        社會科學院語學研究所 = from_str(obj["社會科學院語學研究所"])
        部落格 = from_str(obj["部落格"])
        사회과학원어학연구소 = from_str(obj["사회과학원 어학연구소"])
        찦차를타고온펲시맨과쑛다리똠방각하 = from_str(obj["찦차를 타고 온 펲시맨과 쑛다리 똠방각하"])
        indecent = from_str(obj["\U0001d54b\U0001d559\U0001d556 \U0001d562\U0001d566\U0001d55a\U0001d554\U0001d55c \U0001d553\U0001d563\U0001d560\U0001d568\U0001d55f \U0001d557\U0001d560\U0001d569 \U0001d55b\U0001d566\U0001d55e\U0001d561\U0001d564 \U0001d560\U0001d567\U0001d556\U0001d563 \U0001d565\U0001d559\U0001d556 \U0001d55d\U0001d552\U0001d56b\U0001d56a \U0001d555\U0001d560\U0001d558"])
        hilarious = from_str(obj["\U0001f60d"])
        ambitious = from_str(obj["ﷺ"])
        the_１２３ = from_str(obj["１２３"])
        return B(empty, b, purple, onfocus_ja_va_s_cript_alert_123_autofocus, script_alert_123_script, script_x09_javascript_alert_1_script, script_x21_javascript_alert_1_script, script_x3_bjavascript_alert_1_script, script_x_e2_x80_x85_javascript_alert_1_script, script_x_e2_x80_x87_javascript_alert_1_script, script_x_e2_x80_x8_ajavascript_alert_1_script, script_x_e2_x80_x_a8_javascript_alert_1_script, script_x_e2_x80_x_a9_javascript_alert_1_script, script_x_e2_x80_x_a_fjavascript_alert_1_script, script_x_e3_x80_x80_javascript_alert_1_script, fluffy, credit_https_twitter_com_jifa_status_625776454479970304, file_inclusion, japanese_emoticons, numeric_strings, quotation_marks, reserved_strings, scunthorpe_problem, strings_which_are_reserved_characters_in_msdos_windows, strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss, strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew, strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues, strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric, strings_which_may_be_used_elsewhere_in_code, terminal_escape_codes, unicode_symbols, i_os_vulnerabilities, regional_indicator_symbols, regional_indicator_symbols_can_be_displayed_differently_across, irc_specific_strings, strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out, byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line, commonly_misinterpreted_as_additional_graphic_characters, often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml, the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers, the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers, the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers, this_file_unfortunately_cannot_express_strings_containing, appear_in_input, contexts_divided_into_three_groups_based_on_us_layout_keyboard_position, general_category_cf_in_unicode_800, touch_tmp_blns_fail, the_100, or_111, autofocus_onkeyup_javascript_alert_123, x00_script_javascript_alert_1_script, x3_cscript_javascript_alert_1_script, touch_tmp_blns_shellshock2_fail, tentacled, ath0, b_script_alert_123_script, help, the_21474836481, dev_null_touch_tmp_blns_fail_echo, the_000, the_01000, the_08, the_09, the_0_xffffffffffffffff, the_100000000, the_100000, the_1_ind, the_1_inf, b_100000, the_1_drop_table_users_1, the_1000, the_22250738585072011_e_308, script_alert_xss_script, img_src_onmouseover_alert_xxs, img_src_14_javascript_alert_xss, img_src_jav_x09_ascript_alert_xss, b_img_src_onmouseover_alert_xxs, img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041, img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29, script_src_ha_ckers_org_j, a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a, a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a, a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a, foo_val_bar, iframe_src_http_ha_ckers_org_scriptlet_html, img_x00_src_x_onerror_javascript_alert_1, img_x11_src_x_onerror_javascript_alert_1, img_x12_src_x_onerror_javascript_alert_1, img_x47_src_x_onerror_javascript_alert_1, img_src_x_onerror_x11_javascript_alert_1, img_src_x_onerror_x12_javascript_alert_1, img_src_x00_x_onerror_javascript_alert_1, script_src_jscript_s_script, purple_script_alert_123_script, script_x0_atype_text_javascript_javascript_alert_1_script, script_x0_dtype_text_javascript_javascript_alert_1_script, script_alert_123_script_x, abc_div_style_x_x0_aexpression_javascript_alert_1_def, abc_div_style_x_x0_dexpression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def, abc_div_style_x_expression_x5_c_javascript_alert_1_def, but_now_20_cfor_my_greatest_trick_8_m, com1, com3, con, false, file, if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you, kernel_exec_ls_al, linda_callahan, nil, nul, tyson_gay, ﾛ_, img_src_xxx_x_x0_aonerror_javascript_alert_1, img_src_xxx_x_x0_conerror_javascript_alert_1, img_src_xxx_x_x0_donerror_javascript_alert_1, b_touch_tmp_blns_fail, basement, dont_make_a_map, eval_puts_hello_world, expression, http_a_3030, null, åß_ƒ_æ, ɐnbᴉlɐ_ɐuƃɐɯ_ǝɹolop_ʇǝ_ǝɹoqɐl_ʇn_ʇunpᴉpᴉɔuᴉ_ɹodɯǝʇ_poɯsnᴉǝ_op_pǝs_ʇᴉlǝ_ƃuᴉɔsᴉdᴉpɐ_ɹnʇǝʇɔǝsuoɔ_ʇǝɯɐ_ʇᴉs_ɹolop_ɯnsdᴉ_ɯǝɹo, h_e_w_h_o_w_a_į_t_s_b_e_h_i_n_d_t_h_e_w_a_l_ḽ, ω_ç_µ, ṱ_o_i_n_v_o_kè_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_ǹ_t_i_n_g_c_h_a_o_s, sticky, indigo, ຈل͜ຈﾉヽຈل͜ຈﾉ, 社會科學院語學研究所, 部落格, 사회과학원어학연구소, 찦차를타고온펲시맨과쑛다리똠방각하, indecent, hilarious, ambitious, the_１２３)

    def to_dict(self) -> dict:
        result: dict = {}
        result["\u0001\u0002\u0003\u0004\u0005\u0006\u0007\u0008\u000e\u000f\u0010\u0011\u0012\u0013\u0014\u0015\u0016\u0017\u0018\u0019\u001a\u001b\u001c\u001d\u001e\u001f\u007f"] = from_str(self.empty)
        result["\t\u000b\u000c \u0085             \u200b\u2028\u2029  　"] = from_str(self.b)
        result["\""] = from_str(self.purple)
        result["\" onfocus=JaVaSCript:alert(123) autofocus"] = from_str(self.onfocus_ja_va_s_cript_alert_123_autofocus)
        result["\"><script>alert(123)</script>"] = from_str(self.script_alert_123_script)
        result["\"`'><script>\\x09javascript:alert(1)</script>"] = from_str(self.script_x09_javascript_alert_1_script)
        result["\"`'><script>\\x21javascript:alert(1)</script>"] = from_str(self.script_x21_javascript_alert_1_script)
        result["\"`'><script>\\x3Bjavascript:alert(1)</script>"] = from_str(self.script_x3_bjavascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x85_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x87_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x8_ajavascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x_a8_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x_a9_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x_a_fjavascript_alert_1_script)
        result["\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>"] = from_str(self.script_x_e3_x80_x80_javascript_alert_1_script)
        result["#"] = from_str(self.fluffy)
        result["#\tCredit: https://twitter.com/jifa/status/625776454479970304"] = from_str(self.credit_https_twitter_com_jifa_status_625776454479970304)
        result["#\tFile Inclusion"] = from_str(self.file_inclusion)
        result["#\tJapanese Emoticons"] = from_str(self.japanese_emoticons)
        result["#\tNumeric Strings"] = from_str(self.numeric_strings)
        result["#\tQuotation Marks"] = from_str(self.quotation_marks)
        result["#\tReserved Strings"] = from_str(self.reserved_strings)
        result["#\tScunthorpe Problem"] = from_str(self.scunthorpe_problem)
        result["#\tStrings which are reserved characters in MSDOS/Windows"] = from_str(self.strings_which_are_reserved_characters_in_msdos_windows)
        result["#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS"] = from_str(self.strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss)
        result["#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)"] = from_str(self.strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew)
        result["#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues"] = from_str(self.strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues)
        result["#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric"] = from_str(self.strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric)
        result["#\tStrings which may be used elsewhere in code"] = from_str(self.strings_which_may_be_used_elsewhere_in_code)
        result["#\tTerminal escape codes"] = from_str(self.terminal_escape_codes)
        result["#\tUnicode Symbols"] = from_str(self.unicode_symbols)
        result["#\tiOS Vulnerabilities"] = from_str(self.i_os_vulnerabilities)
        result["#       Regional Indicator Symbols"] = from_str(self.regional_indicator_symbols)
        result["#       Regional Indicator Symbols can be displayed differently across"] = from_str(self.regional_indicator_symbols_can_be_displayed_differently_across)
        result["#   IRC specific strings"] = from_str(self.irc_specific_strings)
        result["#   Strings that may occur on IRC clients that make security products freak out"] = from_str(self.strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out)
        result["# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line."] = from_str(self.byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line)
        result["# Commonly misinterpreted as additional graphic characters."] = from_str(self.commonly_misinterpreted_as_additional_graphic_characters)
        result["# Often forbidden to appear in various text-based file formats (e.g. XML),"] = from_str(self.often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml)
        result["# The next line may appear to be blank or mojibake in some viewers."] = from_str(self.the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers)
        result["# The next line may appear to be blank, mojibake, or dingbats in some viewers."] = from_str(self.the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers)
        result["# The next line may be flagged for \"trailing whitespace\" in some viewers."] = from_str(self.the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers)
        result["# This file unfortunately cannot express strings containing"] = from_str(self.this_file_unfortunately_cannot_express_strings_containing)
        result["# appear in input."] = from_str(self.appear_in_input)
        result["# contexts.  Divided into three groups based on (US-layout) keyboard position."] = from_str(self.contexts_divided_into_three_groups_based_on_us_layout_keyboard_position)
        result["# general category Cf (in Unicode 8.0.0)."] = from_str(self.general_category_cf_in_unicode_800)
        result["$(touch /tmp/blns.fail)"] = from_str(self.touch_tmp_blns_fail)
        result["$1.00"] = from_str(self.the_100)
        result["' OR 1=1 -- 1"] = from_str(self.or_111)
        result["' autofocus onkeyup='javascript:alert(123)"] = from_str(self.autofocus_onkeyup_javascript_alert_123)
        result["'`\"><\\x00script>javascript:alert(1)</script>"] = from_str(self.x00_script_javascript_alert_1_script)
        result["'`\"><\\x3Cscript>javascript:alert(1)</script>"] = from_str(self.x3_cscript_javascript_alert_1_script)
        result["() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }"] = from_str(self.touch_tmp_blns_shellshock2_fail)
        result["(｡◕ ∀ ◕｡)"] = from_str(self.tentacled)
        result["+++ATH0"] = from_str(self.ath0)
        result["--><script>alert(123)</script>"] = from_str(self.b_script_alert_123_script)
        result["--help"] = from_str(self.help)
        result["-2147483648/-1"] = from_str(self.the_21474836481)
        result["/dev/null; touch /tmp/blns.fail ; echo"] = from_str(self.dev_null_touch_tmp_blns_fail_echo)
        result["0.00"] = from_str(self.the_000)
        result["01000"] = from_str(self.the_01000)
        result["08"] = from_str(self.the_08)
        result["09"] = from_str(self.the_09)
        result["0xffffffffffffffff"] = from_str(self.the_0_xffffffffffffffff)
        result["1 000 000,00"] = from_str(self.the_100000000)
        result["1 000.00"] = from_str(self.the_100000)
        result["1#IND"] = from_str(self.the_1_ind)
        result["1#INF"] = from_str(self.the_1_inf)
        result["1'000.00"] = from_str(self.b_100000)
        result["1'; DROP TABLE users-- 1"] = from_str(self.the_1_drop_table_users_1)
        result["1,0/0,0"] = from_str(self.the_1000)
        result["2.2250738585072011e-308"] = from_str(self.the_22250738585072011_e_308)
        result["<<SCRIPT>alert(\"XSS\");//<</SCRIPT>"] = from_str(self.script_alert_xss_script)
        result["<IMG SRC= onmouseover=\"alert('xxs')\">"] = from_str(self.img_src_onmouseover_alert_xxs)
        result["<IMG SRC=\" &#14;  javascript:alert('XSS');\">"] = from_str(self.img_src_14_javascript_alert_xss)
        result["<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">"] = from_str(self.img_src_jav_x09_ascript_alert_xss)
        result["<IMG SRC=# onmouseover=\"alert('xxs')\">"] = from_str(self.b_img_src_onmouseover_alert_xxs)
        result["<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>"] = from_str(self.img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041)
        result["<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>"] = from_str(self.img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29)
        result["<SCRIPT SRC=//ha.ckers.org/.j>"] = from_str(self.script_src_ha_ckers_org_j)
        result["<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">"] = from_str(self.a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a)
        result["<foo val=”bar“ />"] = from_str(self.foo_val_bar)
        result["<iframe src=http://ha.ckers.org/scriptlet.html <"] = from_str(self.iframe_src_http_ha_ckers_org_scriptlet_html)
        result["<img \\x00src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x00_src_x_onerror_javascript_alert_1)
        result["<img \\x11src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x11_src_x_onerror_javascript_alert_1)
        result["<img \\x12src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x12_src_x_onerror_javascript_alert_1)
        result["<img \\x47src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x47_src_x_onerror_javascript_alert_1)
        result["<img src=x onerror=\\x11\"javascript:alert(1)\">"] = from_str(self.img_src_x_onerror_x11_javascript_alert_1)
        result["<img src=x onerror=\\x12\"javascript:alert(1)\">"] = from_str(self.img_src_x_onerror_x12_javascript_alert_1)
        result["<img src\\x00=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x00_x_onerror_javascript_alert_1)
        result["<script src=\"\\\\%(jscript)s\"></script>"] = from_str(self.script_src_jscript_s_script)
        result["<script>alert(123)</script>"] = from_str(self.purple_script_alert_123_script)
        result["<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>"] = from_str(self.script_x0_atype_text_javascript_javascript_alert_1_script)
        result["<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>"] = from_str(self.script_x0_dtype_text_javascript_javascript_alert_1_script)
        result["><script>alert(123);</script x="] = from_str(self.script_alert_123_script_x)
        result["ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x0_aexpression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x0_dexpression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def)
        result["ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_expression_x5_c_javascript_alert_1_def)
        result["But now...\u001b[20Cfor my greatest trick...\u001b[8m"] = from_str(self.but_now_20_cfor_my_greatest_trick_8_m)
        result["COM1"] = from_str(self.com1)
        result["COM3"] = from_str(self.com3)
        result["CON"] = from_str(self.con)
        result["FALSE"] = from_str(self.false)
        result["File:///"] = from_str(self.file)
        result["If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you."] = from_str(self.if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you)
        result["Kernel.exec(\"ls -al /\")"] = from_str(self.kernel_exec_ls_al)
        result["Linda Callahan"] = from_str(self.linda_callahan)
        result["NIL"] = from_str(self.nil)
        result["NUL"] = from_str(self.nul)
        result["Tyson Gay"] = from_str(self.tyson_gay)
        result["__ﾛ(,_,*)"] = from_str(self.ﾛ_)
        result["`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x0_aonerror_javascript_alert_1)
        result["`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x0_conerror_javascript_alert_1)
        result["`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x0_donerror_javascript_alert_1)
        result["`touch /tmp/blns.fail`"] = from_str(self.b_touch_tmp_blns_fail)
        result["basement"] = from_str(self.basement)
        result["dontMakeAMap"] = from_bool(self.dont_make_a_map)
        result["eval(\"puts 'hello world'\")"] = from_str(self.eval_puts_hello_world)
        result["expression"] = from_str(self.expression)
        result["http://a/%%30%30"] = from_str(self.http_a_3030)
        result["null"] = from_str(self.null)
        result["åß∂ƒ©˙∆˚¬…æ"] = from_str(self.åß_ƒ_æ)
        result["˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥"] = from_str(self.ɐnbᴉlɐ_ɐuƃɐɯ_ǝɹolop_ʇǝ_ǝɹoqɐl_ʇn_ʇunpᴉpᴉɔuᴉ_ɹodɯǝʇ_poɯsnᴉǝ_op_pǝs_ʇᴉlǝ_ƃuᴉɔsᴉdᴉpɐ_ɹnʇǝʇɔǝsuoɔ_ʇǝɯɐ_ʇᴉs_ɹolop_ɯnsdᴉ_ɯǝɹo)
        result["̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕"] = from_str(self.h_e_w_h_o_w_a_į_t_s_b_e_h_i_n_d_t_h_e_w_a_l_ḽ)
        result["Ω≈ç√∫˜µ≤≥÷"] = from_str(self.ω_ç_µ)
        result["Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣"] = from_str(self.ṱ_o_i_n_v_o_kè_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_ǹ_t_i_n_g_c_h_a_o_s)
        result["⁰⁴⁵₀₁₂"] = from_str(self.sticky)
        result["❤️ \U0001f494 \U0001f48c \U0001f495 \U0001f49e \U0001f493 \U0001f497 \U0001f496 \U0001f498 \U0001f49d \U0001f49f \U0001f49c \U0001f49b \U0001f49a \U0001f499"] = from_str(self.indigo)
        result["ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ"] = from_str(self.ຈل͜ຈﾉヽຈل͜ຈﾉ)
        result["社會科學院語學研究所"] = from_str(self.社會科學院語學研究所)
        result["部落格"] = from_str(self.部落格)
        result["사회과학원 어학연구소"] = from_str(self.사회과학원어학연구소)
        result["찦차를 타고 온 펲시맨과 쑛다리 똠방각하"] = from_str(self.찦차를타고온펲시맨과쑛다리똠방각하)
        result["\U0001d54b\U0001d559\U0001d556 \U0001d562\U0001d566\U0001d55a\U0001d554\U0001d55c \U0001d553\U0001d563\U0001d560\U0001d568\U0001d55f \U0001d557\U0001d560\U0001d569 \U0001d55b\U0001d566\U0001d55e\U0001d561\U0001d564 \U0001d560\U0001d567\U0001d556\U0001d563 \U0001d565\U0001d559\U0001d556 \U0001d55d\U0001d552\U0001d56b\U0001d56a \U0001d555\U0001d560\U0001d558"] = from_str(self.indecent)
        result["\U0001f60d"] = from_str(self.hilarious)
        result["ﷺ"] = from_str(self.ambitious)
        result["１２３"] = from_str(self.the_１２３)
        return result


@dataclass
class C:
    empty: str
    c: str
    purple: str
    script_javascript_alert_1_script: str
    script_x0_ajavascript_alert_1_script: str
    script_x0_bjavascript_alert_1_script: str
    script_x20_javascript_alert_1_script: str
    script_x2_bjavascript_alert_1_script: str
    script_x7_ejavascript_alert_1_script: str
    script_x_e2_x80_x80_javascript_alert_1_script: str
    script_x_e2_x80_x82_javascript_alert_1_script: str
    script_x_e2_x80_x83_javascript_alert_1_script: str
    script_x_e2_x80_x84_javascript_alert_1_script: str
    script_x_e2_x80_x88_javascript_alert_1_script: str
    script_x_e2_x80_x8_bjavascript_alert_1_script: str
    script_x_ef_x_bf_x_a_ejavascript_alert_1_script: str
    script_x_ef_x_bf_x_b_ejavascript_alert_1_script: str
    emoji: str
    right_to_left_strings: str
    server_code_injection: str
    special_characters: str
    strings_which_can_be_interpreted_as_numeric: str
    strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized: str
    strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server: str
    strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153: str
    strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net: str
    strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com: str
    strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf: str
    strings_which_punish_the_fools_who_use_cat_type_on_this_file: str
    trick_unicode: str
    unicode_subscript_superscript_accents: str
    unicode_upsidedown: str
    zalgo_text: str
    xxe_injection_xml: str
    ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some: str
    non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f: str
    unicode_additional_control_characters_all_of_the_characters_with: str
    whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode: str
    and_u_007_f_del: str
    or_reused_for_internal_delimiters_on_the_theory_that_they_should_never: str
    treated_as_whitespace_in_some_contexts: str
    version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel: str
    user: str
    fluffy: str
    s: str
    lt_script_gt_alert_3912339_lt_script_gt: str
    onfocus_ja_va_s_cript_alert_123_autofocus: str
    tentacled: str
    script_alert_123_script_x: str
    script_alert_123_script: str
    the_0_touch_tmp_blns_shellshock1_fail: str
    ﾉಥ益ಥﾉ: str
    the_00: str
    ω: str
    sticky: str
    the_100: str
    indigo: str
    the_1: str
    version: str
    c_00: str
    the_1_ind: str
    c_100: str
    the_12: str
    the_1_e_02: str
    the_1_e2: str
    the_92233720368547758081: str
    indecent: str
    purple_00: str
    the_000: str
    c_000: str
    fluffy_00: str
    the_0_xabad1_dea: str
    the_0_xffffffff: str
    the_0️1️2️3️4️5️6️7️8️9️: str
    the_100000: str
    the_100000000: str
    c_100000000: str
    c_100000: str
    purple_100000: str
    purple_100000000: str
    c_1_e_02: str
    script_script_alert_123_script: str
    xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo: str
    body_onload_alert_xss: str
    img_script_alert_xss_script: str
    img_src_javascript_alert_xss: str
    img_src_javascript_alert_string_from_char_code_888383: str
    img_onmouseover_alert_xxs: str
    a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a: str
    a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a: str
    foo_val_bar: str
    i_onwheel_alert_1_scroll_over_me_i: str
    img_x34_src_x_onerror_javascript_alert_1: str
    img_src_onerror_alt_javascript_alert_1: str
    img_src_x_script_javascript_alert_1_script: str
    img_src_x_onerror_x10_javascript_alert_1: str
    img_src_x_onerror_x32_javascript_alert_1: str
    img_src_x_onerror_alert_123: str
    img_src_x10_x_onerror_javascript_alert_1: str
    img_src_x12_x_onerror_javascript_alert_1: str
    img_src_x13_x_onerror_javascript_alert_1: str
    img_src_x32_x_onerror_javascript_alert_1: str
    img_src_x47_x_onerror_javascript_alert_1: str
    img_a_b_c_src_d_x_e_onerror_f_alert_1: str
    img_x11_src_x_onerror_javascript_alert_1: str
    img_x47_src_x_onerror_javascript_alert_1: str
    plaintext: str
    script_src_jscript_s_script: str
    script_x0_ctype_text_javascript_javascript_alert_1_script: str
    script_x2_ftype_text_javascript_javascript_alert_1_script: str
    svg_script_1231_alert_123_script: str
    title_onpropertychange_javascript_alert_1_title_title_title: str
    c_script_alert_123_script: str
    system_touch_tmp_blns_fail: str
    a: str
    abc_div_style_x_x00_expression_javascript_alert_1_def: str
    abc_div_style_x_x0_cexpression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def: str
    abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def: str
    abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def: str
    abc_div_style_x_expression_x00_javascript_alert_1_def: str
    clock: str
    com2: str
    com4: str
    craig_cockburn_software_specialist: str
    dcc_send_startkeylogger_000: str
    horniman_museum: str
    infinity: str
    java_s_cript_alert_123: str
    lpt1: str
    null: str
    na_n: str
    power_لُلُصّبُلُلصّبُررًॣॣ_h_冗: str
    roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue: str
    scunthorpe_general_hospital: str
    system_ls_al: str
    zz: str
    hilarious: str
    ambitious: str
    img_src_xxx_x_x09_onerror_javascript_alert_1: str
    img_src_xxx_x_x20_onerror_javascript_alert_1: str
    img_src_xxx_x_x22_onerror_javascript_alert_1: str
    img_src_xxx_x_x27_onerror_javascript_alert_1: str
    dont_make_a_map: bool
    evaluate: str
    has_own_property: str
    http_www_cum_qc_ca: str
    magna_cum_laude: str
    medieval_erection_of_parapets: str
    mocha: str
    shitake_mushrooms: str
    src_ja_va_s_cript_prompt_132: str
    test_test: str
    true: bool
    undefined: str
    åíîï_óô_òúæ: str
    ṯ_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_ḙ_m_i_n_ḍ_ǫ_f_c_ḥ_a_ơ_s_z_a_l_g_o: str
    ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэю_яабвгдежзийклмнопрстуфхцчшщъыьэюя: str
    בְּרֵאשִׁיתבָּרָאאֱלֹהִיםאֵתהַשָּׁמַיִםוְאֵתהָאָרֶץ: str
    مُنَاقَشَةُسُبُلِاِسْتِخْدَامِاللُّغَةِفِيالنُّظُمِالْقَائِمَةِوَفِيميَخُصَّالتَّطْبِيقَاتُالْحاسُوبِيَّةُ: str
    the_١٢٣: str
    test: str
    cunning: str
    magenta: str
    ノº_ºノ: str
    frisky: str
    mischievous: str
    울란바토르: str
    braggadocious: str
    the_2: str
    the_0️: str
    the_3: str
    the_4: str
    the__1: str
    purple_script_alert_123_script: str
    ｔｈｅ_ｑｕｉｃｋ_ｂｒｏｗｎ_ｆｏｘ_ｊｕｍｐｓ_ｏｖｅｒ_ｔｈｅ_ｌａｚｙ_ｄｏｇ: str

    @staticmethod
    def from_dict(obj: Any) -> 'C':
        assert isinstance(obj, dict)
        empty = from_str(obj["\"\""])
        c = from_str(obj["\"'\"'\"''''\""])
        purple = from_str(obj["\"''''\"'\""])
        script_javascript_alert_1_script = from_str(obj["\"`'><script>-javascript:alert(1)</script>"])
        script_x0_ajavascript_alert_1_script = from_str(obj["\"`'><script>\\x0Ajavascript:alert(1)</script>"])
        script_x0_bjavascript_alert_1_script = from_str(obj["\"`'><script>\\x0Bjavascript:alert(1)</script>"])
        script_x20_javascript_alert_1_script = from_str(obj["\"`'><script>\\x20javascript:alert(1)</script>"])
        script_x2_bjavascript_alert_1_script = from_str(obj["\"`'><script>\\x2Bjavascript:alert(1)</script>"])
        script_x7_ejavascript_alert_1_script = from_str(obj["\"`'><script>\\x7Ejavascript:alert(1)</script>"])
        script_x_e2_x80_x80_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>"])
        script_x_e2_x80_x82_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>"])
        script_x_e2_x80_x83_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>"])
        script_x_e2_x80_x84_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>"])
        script_x_e2_x80_x88_javascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>"])
        script_x_e2_x80_x8_bjavascript_alert_1_script = from_str(obj["\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>"])
        script_x_ef_x_bf_x_a_ejavascript_alert_1_script = from_str(obj["\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>"])
        script_x_ef_x_bf_x_b_ejavascript_alert_1_script = from_str(obj["\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>"])
        emoji = from_str(obj["#\tEmoji"])
        right_to_left_strings = from_str(obj["#\tRight-To-Left Strings"])
        server_code_injection = from_str(obj["#\tServer Code Injection"])
        special_characters = from_str(obj["#\tSpecial Characters"])
        strings_which_can_be_interpreted_as_numeric = from_str(obj["#\tStrings which can be interpreted as numeric"])
        strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized = from_str(obj["#\tStrings which can cause a SQL injection if inputs are not sanitized"])
        strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server = from_str(obj["#\tStrings which can cause user to pull in files that should not be a part of a web server"])
        strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153 = from_str(obj["#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)"])
        strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net = from_str(obj["#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)"])
        strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com = from_str(obj["#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)"])
        strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf = from_str(obj["#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)"])
        strings_which_punish_the_fools_who_use_cat_type_on_this_file = from_str(obj["#\tStrings which punish the fools who use cat/type on this file"])
        trick_unicode = from_str(obj["#\tTrick Unicode"])
        unicode_subscript_superscript_accents = from_str(obj["#\tUnicode Subscript/Superscript/Accents"])
        unicode_upsidedown = from_str(obj["#\tUnicode Upsidedown"])
        zalgo_text = from_str(obj["#\tZalgo Text"])
        xxe_injection_xml = from_str(obj["#      XXE Injection (XML)"])
        ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some = from_str(obj["# ASCII punctuation.  All of these characters may need to be escaped in some"])
        non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f = from_str(obj["# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,"])
        unicode_additional_control_characters_all_of_the_characters_with = from_str(obj["# Unicode additional control characters: all of the characters with"])
        whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode = from_str(obj["# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode"])
        and_u_007_f_del = from_str(obj["# and U+007F (DEL)"])
        or_reused_for_internal_delimiters_on_the_theory_that_they_should_never = from_str(obj["# or reused for internal delimiters on the theory that they should never"])
        treated_as_whitespace_in_some_contexts = from_str(obj["# treated as whitespace in some contexts."])
        version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel = from_str(obj["# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),"])
        user = from_str(obj["$USER"])
        fluffy = from_str(obj["%"])
        s = from_str(obj["%*.*s"])
        lt_script_gt_alert_3912339_lt_script_gt = from_str(obj["&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;"])
        onfocus_ja_va_s_cript_alert_123_autofocus = from_str(obj["' onfocus=JaVaSCript:alert(123) autofocus"])
        tentacled = from_str(obj["''"])
        script_alert_123_script_x = from_str(obj["'><script>alert(123);</script x='"])
        script_alert_123_script = from_str(obj["'><script>alert(123)</script>"])
        the_0_touch_tmp_blns_shellshock1_fail = from_str(obj["() { 0; }; touch /tmp/blns.shellshock1.fail;"])
        ﾉಥ益ಥﾉ = from_str(obj["(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻"])
        the_00 = from_str(obj["+0.0"])
        ω = from_str(obj[",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’"])
        sticky = from_str(obj["-"])
        the_100 = from_str(obj["-$1.00"])
        indigo = from_str(obj["--"])
        the_1 = from_str(obj["--1"])
        version = from_str(obj["--version"])
        c_00 = from_str(obj["-0.0"])
        the_1_ind = from_str(obj["-1#IND"])
        c_100 = from_str(obj["-1.00"])
        the_12 = from_str(obj["-1/2"])
        the_1_e_02 = from_str(obj["-1E+02"])
        the_1_e2 = from_str(obj["-1E2"])
        the_92233720368547758081 = from_str(obj["-9223372036854775808/-1"])
        indecent = from_str(obj["."])
        purple_00 = from_str(obj["0,,0"])
        the_000 = from_str(obj["0.0.0"])
        c_000 = from_str(obj["0.0/0"])
        fluffy_00 = from_str(obj["0/0"])
        the_0_xabad1_dea = from_str(obj["0xabad1dea"])
        the_0_xffffffff = from_str(obj["0xffffffff"])
        the_0️1️2️3️4️5️6️7️8️9️ = from_str(obj["0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \U0001f51f"])
        the_100000 = from_str(obj["1 000,00"])
        the_100000000 = from_str(obj["1'000'000,00"])
        c_100000000 = from_str(obj["1,000,000.00"])
        c_100000 = from_str(obj["1,000.00"])
        purple_100000 = from_str(obj["1.000,00"])
        purple_100000000 = from_str(obj["1.000.000,00"])
        c_1_e_02 = from_str(obj["1E+02"])
        script_script_alert_123_script = from_str(obj["< / script >< script >alert(123)< / script >"])
        xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo = from_str(obj["<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>"])
        body_onload_alert_xss = from_str(obj["<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>"])
        img_script_alert_xss_script = from_str(obj["<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">"])
        img_src_javascript_alert_xss = from_str(obj["<IMG SRC=\"javascript:alert('XSS')\""])
        img_src_javascript_alert_string_from_char_code_888383 = from_str(obj["<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>"])
        img_onmouseover_alert_xxs = from_str(obj["<IMG onmouseover=\"alert('xxs')\">"])
        a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a = from_str(obj["<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"])
        foo_val_bar = from_str(obj["<foo val=“bar” />"])
        i_onwheel_alert_1_scroll_over_me_i = from_str(obj["<i onwheel=alert(1)> Scroll over me </i>"])
        img_x34_src_x_onerror_javascript_alert_1 = from_str(obj["<img \\x34src=x onerror=\"javascript:alert(1)\">"])
        img_src_onerror_alt_javascript_alert_1 = from_str(obj["<img src onerror /\" '\"= alt=javascript:alert(1)//\">"])
        img_src_x_script_javascript_alert_1_script = from_str(obj["<img src=\"x` `<script>javascript:alert(1)</script>\"` `>"])
        img_src_x_onerror_x10_javascript_alert_1 = from_str(obj["<img src=x onerror=\\x10\"javascript:alert(1)\">"])
        img_src_x_onerror_x32_javascript_alert_1 = from_str(obj["<img src=x onerror=\\x32\"javascript:alert(1)\">"])
        img_src_x_onerror_alert_123 = from_str(obj["<img src=x onerror=alert(123) />"])
        img_src_x10_x_onerror_javascript_alert_1 = from_str(obj["<img src\\x10=x onerror=\"javascript:alert(1)\">"])
        img_src_x12_x_onerror_javascript_alert_1 = from_str(obj["<img src\\x12=x onerror=\"javascript:alert(1)\">"])
        img_src_x13_x_onerror_javascript_alert_1 = from_str(obj["<img src\\x13=x onerror=\"javascript:alert(1)\">"])
        img_src_x32_x_onerror_javascript_alert_1 = from_str(obj["<img src\\x32=x onerror=\"javascript:alert(1)\">"])
        img_src_x47_x_onerror_javascript_alert_1 = from_str(obj["<img src\\x47=x onerror=\"javascript:alert(1)\">"])
        img_a_b_c_src_d_x_e_onerror_f_alert_1 = from_str(obj["<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">"])
        img_x11_src_x_onerror_javascript_alert_1 = from_str(obj["<img\\x11src=x onerror=\"javascript:alert(1)\">"])
        img_x47_src_x_onerror_javascript_alert_1 = from_str(obj["<img\\x47src=x onerror=\"javascript:alert(1)\">"])
        plaintext = from_str(obj["<plaintext>"])
        script_src_jscript_s_script = from_str(obj["<script src=\"/\\%(jscript)s\"></script>"])
        script_x0_ctype_text_javascript_javascript_alert_1_script = from_str(obj["<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>"])
        script_x2_ftype_text_javascript_javascript_alert_1_script = from_str(obj["<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>"])
        svg_script_1231_alert_123_script = from_str(obj["<svg><script>123<1>alert(123)</script>"])
        title_onpropertychange_javascript_alert_1_title_title_title = from_str(obj["<title onpropertychange=javascript:alert(1)></title><title title=>"])
        c_script_alert_123_script = from_str(obj["><script>alert(123)</script>"])
        system_touch_tmp_blns_fail = from_str(obj["@{[system \"touch /tmp/blns.fail\"]}"])
        a = from_str(obj["A:"])
        abc_div_style_x_x00_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x0_cexpression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF"])
        abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF"])
        abc_div_style_x_expression_x00_javascript_alert_1_def = from_str(obj["ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF"])
        clock = from_str(obj["CLOCK$"])
        com2 = from_str(obj["COM2"])
        com4 = from_str(obj["COM4"])
        craig_cockburn_software_specialist = from_str(obj["Craig Cockburn, Software Specialist"])
        dcc_send_startkeylogger_000 = from_str(obj["DCC SEND STARTKEYLOGGER 0 0 0"])
        horniman_museum = from_str(obj["Horniman Museum"])
        infinity = from_str(obj["Infinity"])
        java_s_cript_alert_123 = from_str(obj["JavaSCript:alert(123)"])
        lpt1 = from_str(obj["LPT1"])
        null = from_str(obj["NULL"])
        na_n = from_str(obj["NaN"])
        power_لُلُصّبُلُلصّبُررًॣॣ_h_冗 = from_str(obj["Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗"])
        roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue = from_str(obj["Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue"])
        scunthorpe_general_hospital = from_str(obj["Scunthorpe General Hospital"])
        system_ls_al = from_str(obj["System(\"ls -al /\")"])
        zz = from_str(obj["ZZ:"])
        hilarious = from_str(obj["\\\\"])
        ambitious = from_str(obj["_"])
        img_src_xxx_x_x09_onerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>"])
        img_src_xxx_x_x20_onerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>"])
        img_src_xxx_x_x22_onerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>"])
        img_src_xxx_x_x27_onerror_javascript_alert_1 = from_str(obj["`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>"])
        dont_make_a_map = from_bool(obj["dontMakeAMap"])
        evaluate = from_str(obj["evaluate"])
        has_own_property = from_str(obj["hasOwnProperty"])
        http_www_cum_qc_ca = from_str(obj["http://www.cum.qc.ca/"])
        magna_cum_laude = from_str(obj["magna cum laude"])
        medieval_erection_of_parapets = from_str(obj["medieval erection of parapets"])
        mocha = from_str(obj["mocha"])
        shitake_mushrooms = from_str(obj["shitake mushrooms"])
        src_ja_va_s_cript_prompt_132 = from_str(obj["src=JaVaSCript:prompt(132)"])
        test_test = from_str(obj["test\u2060test\u202b"])
        true = from_stringified_bool(from_str(obj["true"]))
        undefined = from_str(obj["undefined"])
        åíîï_óô_òúæ = from_str(obj["ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃"])
        ṯ_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_ḙ_m_i_n_ḍ_ǫ_f_c_ḥ_a_ơ_s_z_a_l_g_o = from_str(obj["̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟"])
        ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэю_яабвгдежзийклмнопрстуфхцчшщъыьэюя = from_str(obj["ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя"])
        בְּרֵאשִׁיתבָּרָאאֱלֹהִיםאֵתהַשָּׁמַיִםוְאֵתהָאָרֶץ = from_str(obj["בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ"])
        مُنَاقَشَةُسُبُلِاِسْتِخْدَامِاللُّغَةِفِيالنُّظُمِالْقَائِمَةِوَفِيميَخُصَّالتَّطْبِيقَاتُالْحاسُوبِيَّةُ = from_str(obj["مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، "])
        the_١٢٣ = from_str(obj["١٢٣"])
        test = from_str(obj["\u2029test\u2029"])
        cunning = from_str(obj["⁰⁴⁵"])
        magenta = from_str(obj["⅛⅜⅝⅞"])
        ノº_ºノ = from_str(obj["┬─┬ノ( º _ ºノ)"])
        frisky = from_str(obj["✋\U0001f3ff \U0001f4aa\U0001f3ff \U0001f450\U0001f3ff \U0001f64c\U0001f3ff \U0001f44f\U0001f3ff \U0001f64f\U0001f3ff"])
        mischievous = from_str(obj["・(￣∀￣)・:*:"])
        울란바토르 = from_str(obj["울란바토르"])
        braggadocious = from_str(obj["\U0001d413\U0001d421\U0001d41e \U0001d42a\U0001d42e\U0001d422\U0001d41c\U0001d424 \U0001d41b\U0001d42b\U0001d428\U0001d430\U0001d427 \U0001d41f\U0001d428\U0001d431 \U0001d423\U0001d42e\U0001d426\U0001d429\U0001d42c \U0001d428\U0001d42f\U0001d41e\U0001d42b \U0001d42d\U0001d421\U0001d41e \U0001d425\U0001d41a\U0001d433\U0001d432 \U0001d41d\U0001d428\U0001d420"])
        the_2 = from_str(obj["\U0001d683\U0001d691\U0001d68e \U0001d69a\U0001d69e\U0001d692\U0001d68c\U0001d694 \U0001d68b\U0001d69b\U0001d698\U0001d6a0\U0001d697 \U0001d68f\U0001d698\U0001d6a1 \U0001d693\U0001d69e\U0001d696\U0001d699\U0001d69c \U0001d698\U0001d69f\U0001d68e\U0001d69b \U0001d69d\U0001d691\U0001d68e \U0001d695\U0001d68a\U0001d6a3\U0001d6a2 \U0001d68d\U0001d698\U0001d690"])
        the_0️ = from_str(obj["\U0001f3f30\U0001f308️"])
        the_3 = from_str(obj["\U0001f435 \U0001f648 \U0001f649 \U0001f64a"])
        the_4 = from_str(obj["\U0001f47e \U0001f647 \U0001f481 \U0001f645 \U0001f646 \U0001f64b \U0001f64e \U0001f64d"])
        the__1 = from_str(obj["\U0002070e\U00020731\U00020779\U00020c53\U00020c78\U00020c96\U00020ccf"])
        purple_script_alert_123_script = from_str(obj["＜script＞alert(123)＜/script＞"])
        ｔｈｅ_ｑｕｉｃｋ_ｂｒｏｗｎ_ｆｏｘ_ｊｕｍｐｓ_ｏｖｅｒ_ｔｈｅ_ｌａｚｙ_ｄｏｇ = from_str(obj["Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ"])
        return C(empty, c, purple, script_javascript_alert_1_script, script_x0_ajavascript_alert_1_script, script_x0_bjavascript_alert_1_script, script_x20_javascript_alert_1_script, script_x2_bjavascript_alert_1_script, script_x7_ejavascript_alert_1_script, script_x_e2_x80_x80_javascript_alert_1_script, script_x_e2_x80_x82_javascript_alert_1_script, script_x_e2_x80_x83_javascript_alert_1_script, script_x_e2_x80_x84_javascript_alert_1_script, script_x_e2_x80_x88_javascript_alert_1_script, script_x_e2_x80_x8_bjavascript_alert_1_script, script_x_ef_x_bf_x_a_ejavascript_alert_1_script, script_x_ef_x_bf_x_b_ejavascript_alert_1_script, emoji, right_to_left_strings, server_code_injection, special_characters, strings_which_can_be_interpreted_as_numeric, strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized, strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server, strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153, strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net, strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com, strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf, strings_which_punish_the_fools_who_use_cat_type_on_this_file, trick_unicode, unicode_subscript_superscript_accents, unicode_upsidedown, zalgo_text, xxe_injection_xml, ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some, non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f, unicode_additional_control_characters_all_of_the_characters_with, whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode, and_u_007_f_del, or_reused_for_internal_delimiters_on_the_theory_that_they_should_never, treated_as_whitespace_in_some_contexts, version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel, user, fluffy, s, lt_script_gt_alert_3912339_lt_script_gt, onfocus_ja_va_s_cript_alert_123_autofocus, tentacled, script_alert_123_script_x, script_alert_123_script, the_0_touch_tmp_blns_shellshock1_fail, ﾉಥ益ಥﾉ, the_00, ω, sticky, the_100, indigo, the_1, version, c_00, the_1_ind, c_100, the_12, the_1_e_02, the_1_e2, the_92233720368547758081, indecent, purple_00, the_000, c_000, fluffy_00, the_0_xabad1_dea, the_0_xffffffff, the_0️1️2️3️4️5️6️7️8️9️, the_100000, the_100000000, c_100000000, c_100000, purple_100000, purple_100000000, c_1_e_02, script_script_alert_123_script, xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo, body_onload_alert_xss, img_script_alert_xss_script, img_src_javascript_alert_xss, img_src_javascript_alert_string_from_char_code_888383, img_onmouseover_alert_xxs, a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a, a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a, foo_val_bar, i_onwheel_alert_1_scroll_over_me_i, img_x34_src_x_onerror_javascript_alert_1, img_src_onerror_alt_javascript_alert_1, img_src_x_script_javascript_alert_1_script, img_src_x_onerror_x10_javascript_alert_1, img_src_x_onerror_x32_javascript_alert_1, img_src_x_onerror_alert_123, img_src_x10_x_onerror_javascript_alert_1, img_src_x12_x_onerror_javascript_alert_1, img_src_x13_x_onerror_javascript_alert_1, img_src_x32_x_onerror_javascript_alert_1, img_src_x47_x_onerror_javascript_alert_1, img_a_b_c_src_d_x_e_onerror_f_alert_1, img_x11_src_x_onerror_javascript_alert_1, img_x47_src_x_onerror_javascript_alert_1, plaintext, script_src_jscript_s_script, script_x0_ctype_text_javascript_javascript_alert_1_script, script_x2_ftype_text_javascript_javascript_alert_1_script, svg_script_1231_alert_123_script, title_onpropertychange_javascript_alert_1_title_title_title, c_script_alert_123_script, system_touch_tmp_blns_fail, a, abc_div_style_x_x00_expression_javascript_alert_1_def, abc_div_style_x_x0_cexpression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def, abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def, abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def, abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def, abc_div_style_x_expression_x00_javascript_alert_1_def, clock, com2, com4, craig_cockburn_software_specialist, dcc_send_startkeylogger_000, horniman_museum, infinity, java_s_cript_alert_123, lpt1, null, na_n, power_لُلُصّبُلُلصّبُررًॣॣ_h_冗, roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue, scunthorpe_general_hospital, system_ls_al, zz, hilarious, ambitious, img_src_xxx_x_x09_onerror_javascript_alert_1, img_src_xxx_x_x20_onerror_javascript_alert_1, img_src_xxx_x_x22_onerror_javascript_alert_1, img_src_xxx_x_x27_onerror_javascript_alert_1, dont_make_a_map, evaluate, has_own_property, http_www_cum_qc_ca, magna_cum_laude, medieval_erection_of_parapets, mocha, shitake_mushrooms, src_ja_va_s_cript_prompt_132, test_test, true, undefined, åíîï_óô_òúæ, ṯ_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_ḙ_m_i_n_ḍ_ǫ_f_c_ḥ_a_ơ_s_z_a_l_g_o, ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэю_яабвгдежзийклмнопрстуфхцчшщъыьэюя, בְּרֵאשִׁיתבָּרָאאֱלֹהִיםאֵתהַשָּׁמַיִםוְאֵתהָאָרֶץ, مُنَاقَشَةُسُبُلِاِسْتِخْدَامِاللُّغَةِفِيالنُّظُمِالْقَائِمَةِوَفِيميَخُصَّالتَّطْبِيقَاتُالْحاسُوبِيَّةُ, the_١٢٣, test, cunning, magenta, ノº_ºノ, frisky, mischievous, 울란바토르, braggadocious, the_2, the_0️, the_3, the_4, the__1, purple_script_alert_123_script, ｔｈｅ_ｑｕｉｃｋ_ｂｒｏｗｎ_ｆｏｘ_ｊｕｍｐｓ_ｏｖｅｒ_ｔｈｅ_ｌａｚｙ_ｄｏｇ)

    def to_dict(self) -> dict:
        result: dict = {}
        result["\"\""] = from_str(self.empty)
        result["\"'\"'\"''''\""] = from_str(self.c)
        result["\"''''\"'\""] = from_str(self.purple)
        result["\"`'><script>-javascript:alert(1)</script>"] = from_str(self.script_javascript_alert_1_script)
        result["\"`'><script>\\x0Ajavascript:alert(1)</script>"] = from_str(self.script_x0_ajavascript_alert_1_script)
        result["\"`'><script>\\x0Bjavascript:alert(1)</script>"] = from_str(self.script_x0_bjavascript_alert_1_script)
        result["\"`'><script>\\x20javascript:alert(1)</script>"] = from_str(self.script_x20_javascript_alert_1_script)
        result["\"`'><script>\\x2Bjavascript:alert(1)</script>"] = from_str(self.script_x2_bjavascript_alert_1_script)
        result["\"`'><script>\\x7Ejavascript:alert(1)</script>"] = from_str(self.script_x7_ejavascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x80_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x82_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x83_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x84_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x88_javascript_alert_1_script)
        result["\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>"] = from_str(self.script_x_e2_x80_x8_bjavascript_alert_1_script)
        result["\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>"] = from_str(self.script_x_ef_x_bf_x_a_ejavascript_alert_1_script)
        result["\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>"] = from_str(self.script_x_ef_x_bf_x_b_ejavascript_alert_1_script)
        result["#\tEmoji"] = from_str(self.emoji)
        result["#\tRight-To-Left Strings"] = from_str(self.right_to_left_strings)
        result["#\tServer Code Injection"] = from_str(self.server_code_injection)
        result["#\tSpecial Characters"] = from_str(self.special_characters)
        result["#\tStrings which can be interpreted as numeric"] = from_str(self.strings_which_can_be_interpreted_as_numeric)
        result["#\tStrings which can cause a SQL injection if inputs are not sanitized"] = from_str(self.strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized)
        result["#\tStrings which can cause user to pull in files that should not be a part of a web server"] = from_str(self.strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server)
        result["#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)"] = from_str(self.strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153)
        result["#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)"] = from_str(self.strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net)
        result["#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)"] = from_str(self.strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com)
        result["#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)"] = from_str(self.strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf)
        result["#\tStrings which punish the fools who use cat/type on this file"] = from_str(self.strings_which_punish_the_fools_who_use_cat_type_on_this_file)
        result["#\tTrick Unicode"] = from_str(self.trick_unicode)
        result["#\tUnicode Subscript/Superscript/Accents"] = from_str(self.unicode_subscript_superscript_accents)
        result["#\tUnicode Upsidedown"] = from_str(self.unicode_upsidedown)
        result["#\tZalgo Text"] = from_str(self.zalgo_text)
        result["#      XXE Injection (XML)"] = from_str(self.xxe_injection_xml)
        result["# ASCII punctuation.  All of these characters may need to be escaped in some"] = from_str(self.ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some)
        result["# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,"] = from_str(self.non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f)
        result["# Unicode additional control characters: all of the characters with"] = from_str(self.unicode_additional_control_characters_all_of_the_characters_with)
        result["# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode"] = from_str(self.whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode)
        result["# and U+007F (DEL)"] = from_str(self.and_u_007_f_del)
        result["# or reused for internal delimiters on the theory that they should never"] = from_str(self.or_reused_for_internal_delimiters_on_the_theory_that_they_should_never)
        result["# treated as whitespace in some contexts."] = from_str(self.treated_as_whitespace_in_some_contexts)
        result["# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),"] = from_str(self.version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel)
        result["$USER"] = from_str(self.user)
        result["%"] = from_str(self.fluffy)
        result["%*.*s"] = from_str(self.s)
        result["&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;"] = from_str(self.lt_script_gt_alert_3912339_lt_script_gt)
        result["' onfocus=JaVaSCript:alert(123) autofocus"] = from_str(self.onfocus_ja_va_s_cript_alert_123_autofocus)
        result["''"] = from_str(self.tentacled)
        result["'><script>alert(123);</script x='"] = from_str(self.script_alert_123_script_x)
        result["'><script>alert(123)</script>"] = from_str(self.script_alert_123_script)
        result["() { 0; }; touch /tmp/blns.shellshock1.fail;"] = from_str(self.the_0_touch_tmp_blns_shellshock1_fail)
        result["(ﾉಥ益ಥ）ﾉ\ufeff ┻━┻"] = from_str(self.ﾉಥ益ಥﾉ)
        result["+0.0"] = from_str(self.the_00)
        result[",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’"] = from_str(self.ω)
        result["-"] = from_str(self.sticky)
        result["-$1.00"] = from_str(self.the_100)
        result["--"] = from_str(self.indigo)
        result["--1"] = from_str(self.the_1)
        result["--version"] = from_str(self.version)
        result["-0.0"] = from_str(self.c_00)
        result["-1#IND"] = from_str(self.the_1_ind)
        result["-1.00"] = from_str(self.c_100)
        result["-1/2"] = from_str(self.the_12)
        result["-1E+02"] = from_str(self.the_1_e_02)
        result["-1E2"] = from_str(self.the_1_e2)
        result["-9223372036854775808/-1"] = from_str(self.the_92233720368547758081)
        result["."] = from_str(self.indecent)
        result["0,,0"] = from_str(self.purple_00)
        result["0.0.0"] = from_str(self.the_000)
        result["0.0/0"] = from_str(self.c_000)
        result["0/0"] = from_str(self.fluffy_00)
        result["0xabad1dea"] = from_str(self.the_0_xabad1_dea)
        result["0xffffffff"] = from_str(self.the_0_xffffffff)
        result["0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \U0001f51f"] = from_str(self.the_0️1️2️3️4️5️6️7️8️9️)
        result["1 000,00"] = from_str(self.the_100000)
        result["1'000'000,00"] = from_str(self.the_100000000)
        result["1,000,000.00"] = from_str(self.c_100000000)
        result["1,000.00"] = from_str(self.c_100000)
        result["1.000,00"] = from_str(self.purple_100000)
        result["1.000.000,00"] = from_str(self.purple_100000000)
        result["1E+02"] = from_str(self.c_1_e_02)
        result["< / script >< script >alert(123)< / script >"] = from_str(self.script_script_alert_123_script)
        result["<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>"] = from_str(self.xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo)
        result["<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>"] = from_str(self.body_onload_alert_xss)
        result["<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">"] = from_str(self.img_script_alert_xss_script)
        result["<IMG SRC=\"javascript:alert('XSS')\""] = from_str(self.img_src_javascript_alert_xss)
        result["<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>"] = from_str(self.img_src_javascript_alert_string_from_char_code_888383)
        result["<IMG onmouseover=\"alert('xxs')\">"] = from_str(self.img_onmouseover_alert_xxs)
        result["<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>"] = from_str(self.a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a)
        result["<foo val=“bar” />"] = from_str(self.foo_val_bar)
        result["<i onwheel=alert(1)> Scroll over me </i>"] = from_str(self.i_onwheel_alert_1_scroll_over_me_i)
        result["<img \\x34src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x34_src_x_onerror_javascript_alert_1)
        result["<img src onerror /\" '\"= alt=javascript:alert(1)//\">"] = from_str(self.img_src_onerror_alt_javascript_alert_1)
        result["<img src=\"x` `<script>javascript:alert(1)</script>\"` `>"] = from_str(self.img_src_x_script_javascript_alert_1_script)
        result["<img src=x onerror=\\x10\"javascript:alert(1)\">"] = from_str(self.img_src_x_onerror_x10_javascript_alert_1)
        result["<img src=x onerror=\\x32\"javascript:alert(1)\">"] = from_str(self.img_src_x_onerror_x32_javascript_alert_1)
        result["<img src=x onerror=alert(123) />"] = from_str(self.img_src_x_onerror_alert_123)
        result["<img src\\x10=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x10_x_onerror_javascript_alert_1)
        result["<img src\\x12=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x12_x_onerror_javascript_alert_1)
        result["<img src\\x13=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x13_x_onerror_javascript_alert_1)
        result["<img src\\x32=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x32_x_onerror_javascript_alert_1)
        result["<img src\\x47=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_src_x47_x_onerror_javascript_alert_1)
        result["<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">"] = from_str(self.img_a_b_c_src_d_x_e_onerror_f_alert_1)
        result["<img\\x11src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x11_src_x_onerror_javascript_alert_1)
        result["<img\\x47src=x onerror=\"javascript:alert(1)\">"] = from_str(self.img_x47_src_x_onerror_javascript_alert_1)
        result["<plaintext>"] = from_str(self.plaintext)
        result["<script src=\"/\\%(jscript)s\"></script>"] = from_str(self.script_src_jscript_s_script)
        result["<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>"] = from_str(self.script_x0_ctype_text_javascript_javascript_alert_1_script)
        result["<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>"] = from_str(self.script_x2_ftype_text_javascript_javascript_alert_1_script)
        result["<svg><script>123<1>alert(123)</script>"] = from_str(self.svg_script_1231_alert_123_script)
        result["<title onpropertychange=javascript:alert(1)></title><title title=>"] = from_str(self.title_onpropertychange_javascript_alert_1_title_title_title)
        result["><script>alert(123)</script>"] = from_str(self.c_script_alert_123_script)
        result["@{[system \"touch /tmp/blns.fail\"]}"] = from_str(self.system_touch_tmp_blns_fail)
        result["A:"] = from_str(self.a)
        result["ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x00_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x0_cexpression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def)
        result["ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def)
        result["ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF"] = from_str(self.abc_div_style_x_expression_x00_javascript_alert_1_def)
        result["CLOCK$"] = from_str(self.clock)
        result["COM2"] = from_str(self.com2)
        result["COM4"] = from_str(self.com4)
        result["Craig Cockburn, Software Specialist"] = from_str(self.craig_cockburn_software_specialist)
        result["DCC SEND STARTKEYLOGGER 0 0 0"] = from_str(self.dcc_send_startkeylogger_000)
        result["Horniman Museum"] = from_str(self.horniman_museum)
        result["Infinity"] = from_str(self.infinity)
        result["JavaSCript:alert(123)"] = from_str(self.java_s_cript_alert_123)
        result["LPT1"] = from_str(self.lpt1)
        result["NULL"] = from_str(self.null)
        result["NaN"] = from_str(self.na_n)
        result["Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗"] = from_str(self.power_لُلُصّبُلُلصّبُررًॣॣ_h_冗)
        result["Roses are \u001b[0;31mred\u001b[0m, violets are \u001b[0;34mblue. Hope you enjoy terminal hue"] = from_str(self.roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue)
        result["Scunthorpe General Hospital"] = from_str(self.scunthorpe_general_hospital)
        result["System(\"ls -al /\")"] = from_str(self.system_ls_al)
        result["ZZ:"] = from_str(self.zz)
        result["\\\\"] = from_str(self.hilarious)
        result["_"] = from_str(self.ambitious)
        result["`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x09_onerror_javascript_alert_1)
        result["`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x20_onerror_javascript_alert_1)
        result["`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x22_onerror_javascript_alert_1)
        result["`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>"] = from_str(self.img_src_xxx_x_x27_onerror_javascript_alert_1)
        result["dontMakeAMap"] = from_bool(self.dont_make_a_map)
        result["evaluate"] = from_str(self.evaluate)
        result["hasOwnProperty"] = from_str(self.has_own_property)
        result["http://www.cum.qc.ca/"] = from_str(self.http_www_cum_qc_ca)
        result["magna cum laude"] = from_str(self.magna_cum_laude)
        result["medieval erection of parapets"] = from_str(self.medieval_erection_of_parapets)
        result["mocha"] = from_str(self.mocha)
        result["shitake mushrooms"] = from_str(self.shitake_mushrooms)
        result["src=JaVaSCript:prompt(132)"] = from_str(self.src_ja_va_s_cript_prompt_132)
        result["test\u2060test\u202b"] = from_str(self.test_test)
        result["true"] = from_str(str(self.true).lower())
        result["undefined"] = from_str(self.undefined)
        result["ÅÍÎÏ˝ÓÔ\uf8ffÒÚÆ☃"] = from_str(self.åíîï_óô_òúæ)
        result["̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟"] = from_str(self.ṯ_h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_ḙ_m_i_n_ḍ_ǫ_f_c_ḥ_a_ơ_s_z_a_l_g_o)
        result["ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя"] = from_str(self.ёђѓєѕіїјљњћќѝўџабвгдежзийклмнопрстуфхцчшщъыьэю_яабвгдежзийклмнопрстуфхцчшщъыьэюя)
        result["בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ"] = from_str(self.בְּרֵאשִׁיתבָּרָאאֱלֹהִיםאֵתהַשָּׁמַיִםוְאֵתהָאָרֶץ)
        result["مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، "] = from_str(self.مُنَاقَشَةُسُبُلِاِسْتِخْدَامِاللُّغَةِفِيالنُّظُمِالْقَائِمَةِوَفِيميَخُصَّالتَّطْبِيقَاتُالْحاسُوبِيَّةُ)
        result["١٢٣"] = from_str(self.the_١٢٣)
        result["\u2029test\u2029"] = from_str(self.test)
        result["⁰⁴⁵"] = from_str(self.cunning)
        result["⅛⅜⅝⅞"] = from_str(self.magenta)
        result["┬─┬ノ( º _ ºノ)"] = from_str(self.ノº_ºノ)
        result["✋\U0001f3ff \U0001f4aa\U0001f3ff \U0001f450\U0001f3ff \U0001f64c\U0001f3ff \U0001f44f\U0001f3ff \U0001f64f\U0001f3ff"] = from_str(self.frisky)
        result["・(￣∀￣)・:*:"] = from_str(self.mischievous)
        result["울란바토르"] = from_str(self.울란바토르)
        result["\U0001d413\U0001d421\U0001d41e \U0001d42a\U0001d42e\U0001d422\U0001d41c\U0001d424 \U0001d41b\U0001d42b\U0001d428\U0001d430\U0001d427 \U0001d41f\U0001d428\U0001d431 \U0001d423\U0001d42e\U0001d426\U0001d429\U0001d42c \U0001d428\U0001d42f\U0001d41e\U0001d42b \U0001d42d\U0001d421\U0001d41e \U0001d425\U0001d41a\U0001d433\U0001d432 \U0001d41d\U0001d428\U0001d420"] = from_str(self.braggadocious)
        result["\U0001d683\U0001d691\U0001d68e \U0001d69a\U0001d69e\U0001d692\U0001d68c\U0001d694 \U0001d68b\U0001d69b\U0001d698\U0001d6a0\U0001d697 \U0001d68f\U0001d698\U0001d6a1 \U0001d693\U0001d69e\U0001d696\U0001d699\U0001d69c \U0001d698\U0001d69f\U0001d68e\U0001d69b \U0001d69d\U0001d691\U0001d68e \U0001d695\U0001d68a\U0001d6a3\U0001d6a2 \U0001d68d\U0001d698\U0001d690"] = from_str(self.the_2)
        result["\U0001f3f30\U0001f308️"] = from_str(self.the_0️)
        result["\U0001f435 \U0001f648 \U0001f649 \U0001f64a"] = from_str(self.the_3)
        result["\U0001f47e \U0001f647 \U0001f481 \U0001f645 \U0001f646 \U0001f64b \U0001f64e \U0001f64d"] = from_str(self.the_4)
        result["\U0002070e\U00020731\U00020779\U00020c53\U00020c78\U00020c96\U00020ccf"] = from_str(self.the__1)
        result["＜script＞alert(123)＜/script＞"] = from_str(self.purple_script_alert_123_script)
        result["Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ"] = from_str(self.ｔｈｅ_ｑｕｉｃｋ_ｂｒｏｗｎ_ｆｏｘ_ｊｕｍｐｓ_ｏｖｅｒ_ｔｈｅ_ｌａｚｙ_ｄｏｇ)
        return result


@dataclass
class TopLevel:
    a: A
    b: B
    c: C

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        a = A.from_dict(obj["a"])
        b = B.from_dict(obj["b"])
        c = C.from_dict(obj["c"])
        return TopLevel(a, b, c)

    def to_dict(self) -> dict:
        result: dict = {}
        result["a"] = to_class(A, self.a)
        result["b"] = to_class(B, self.b)
        result["c"] = to_class(C, self.c)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
