// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::TopLevel;
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: TopLevel = serde_json::from_str(&json).unwrap();
// }

use serde::{Serialize, Deserialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TopLevel {
    pub a: A,

    pub b: B,

    pub c: C,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "PascalCase")]
pub struct A {
    #[serde(rename = "パーティーへ行かないか")]
    pub _12: String,

    #[serde(rename = "和製漢語")]
    pub _13: String,

    #[serde(rename = "田中さんにあげて下さい")]
    pub _14: String,

    #[serde(rename = "｀ｨ(´∀｀∩")]
    pub _25: String,

    #[serde(rename = "ثم نفس سقطت وبالتحديد،, جزيرتي باستخدام أن دنو. إذ هنا؟ الستار وتنصيب كان. أهّل ايطاليا، بريطانيا-فرنسا قد أخذ. سليمان، إتفاقية بين ما, يذكر الحدود أي بعد, معاملة بولندا، الإطلاق عل إيو.")]
    pub _7: String,

    #[serde(rename = "٠١٢٣٤٥٦٧٨٩")]
    pub _8: String,

    #[serde(rename = "ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็ ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็")]
    pub _9: String,

    #[serde(rename = "!@#$%^&*()`~")]
    pub a: String,

    #[serde(rename = "-0")]
    pub a_0: String,

    #[serde(rename = "00˙Ɩ$-")]
    pub a_00: String,

    #[serde(rename = "0,00")]
    pub a_000: String,

    #[serde(rename = "0.0/0.0")]
    pub a_0000: String,

    #[serde(rename = "-1")]
    pub a_1: String,

    #[serde(rename = "1/0")]
    pub a_10: String,

    #[serde(rename = "1'000'000.00")]
    pub a_100000000: String,

    #[serde(rename = "1E02")]
    pub a_1_e02: String,

    #[serde(rename = "';alert(123);t='")]
    pub a_alert_123_t: String,

    #[serde(rename = "False")]
    pub a_false: String,

    #[serde(rename = "<a href=java&#1&#2&#3&#4&#5&#6&#7&#8&#11&#12script:javascript:alert(1)>XXX</a>")]
    pub a_href_java_123456781112_script_javascript_alert_1_xxx_a: String,

    #[serde(rename = "<a href=\"javascript\\x09:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_javascript_x09_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"javascript\\x0A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_javascript_x0_a_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"javascript\\x3A:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_javascript_x3_a_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x01javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x01_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x05javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x05_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x08javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x08_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x09javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x09_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x0Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x0_cjavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x10javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x10_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x11javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x11_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x13javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x13_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x17javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x17_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x1Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x1_fjavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xC2\\xA0javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_c2_x_a0_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE1\\x9A\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e1_x9_a_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE1\\xA0\\x8Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e1_x_a0_x8_ejavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x83javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x83_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x84javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x84_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x86javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x86_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x87javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x87_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\xA8javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x_a8_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "\u{202a}\u{202a}test\u{202a}")]
    pub a_test: String,

    #[serde(rename = "TRUE")]
    pub a_true: String,

    #[serde(rename = "ABC<div style=\"x:exp\\x00ression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_exp_x00_ression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:exp\\x5Cression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_exp_x5_cression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\x09expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x09_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\x0Bexpression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x0_bexpression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\x20expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x20_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x\\x3Aexpression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x3_aexpression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xC2\\xA0expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_c2_x_a0_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x80expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x80_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x84expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x84_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x89expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x89_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x8Bexpression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x8_bexpression_javascript_alert_1_def: String,

    #[serde(rename = ";alert(123);")]
    pub alert_123: String,

    #[serde(rename = "\";alert(123);t=\"")]
    pub alert_123_t: String,

    #[serde(rename = "\\\";alert('XSS');//")]
    pub alert_xss: String,

    #[serde(rename = "-.")]
    pub ambitious: String,

    #[serde(rename = "# and U+200B (ZERO WIDTH SPACE), which are in the C categories but are often")]
    pub and_u_200_b_zero_width_space_which_are_in_the_c_categories_but_are_often: String,

    #[serde(rename = "Arsenal canal")]
    pub arsenal_canal: String,

    #[serde(rename = "\" autofocus onkeyup=\"javascript:alert(123)")]
    pub autofocus_onkeyup_javascript_alert_123: String,

    #[serde(rename = "AUX")]
    pub aux: String,

    #[serde(rename = "¡™£¢∞§¶•ªº–≠")]
    pub braggadocious: String,

    #[serde(rename = "#\tChanging length when lowercased")]
    pub changing_length_when_lowercased: String,

    #[serde(rename = "#\tCharacters which increase in length (2 to 3 bytes) when lowercased")]
    pub characters_which_increase_in_length_2_to_3_bytes_when_lowercased: String,

    #[serde(rename = "classic")]
    pub classic: String,

    #[serde(rename = "#\tCommand Injection (Ruby)")]
    pub command_injection_ruby: String,

    #[serde(rename = "<>?:\"{}|_+")]
    pub cunning: String,

    #[serde(rename = "%d")]
    pub d: String,

    #[serde(rename = "Dick Van Dyke")]
    pub dick_van_dyke: String,

    #[serde(rename = "dontMakeAMap")]
    pub dont_make_a_map: bool,

    #[serde(rename = "Dr. Herman I. Libshitz")]
    pub dr_herman_i_libshitz: String,

    #[serde(rename = " ")]
    pub empty: String,

    #[serde(rename = "$ENV{'HOME'}")]
    pub env_home: String,

    #[serde(rename = "../../../../../../../../../../../etc/hosts")]
    pub etc_hosts: String,

    #[serde(rename = "../../../../../../../../../../../etc/passwd%00")]
    pub etc_passwd_00: String,

    #[serde(rename = "'\"'")]
    pub fluffy: String,

    #[serde(rename = "{0}")]
    pub fluffy_0: String,

    #[serde(rename = "\u{2066}test\u{2067}")]
    pub fluffy_test: String,

    #[serde(rename = "#       fonts, and have a number of special behaviors")]
    pub fonts_and_have_a_number_of_special_behaviors: String,

    #[serde(rename = "<foo val=`bar' />")]
    pub foo_val_bar: String,

    #[serde(rename = "`⁄€‹›ﬁﬂ‡°·‚—±")]
    pub frisky: String,

    #[serde(rename = "-,")]
    pub hilarious: String,

    #[serde(rename = "$HOME")]
    pub home: String,

    #[serde(rename = "#\tHuman injection")]
    pub human_injection: String,

    #[serde(rename = "̡͓̞ͅI̗̘̦͝n͇͇͙v̮̫ok̲̫̙͈i̖͙̭̹̠̞n̡̻̮̣̺g̲͈͙̭͙̬͎ ̰t͔̦h̞̲e̢̤ ͍̬̲͖f̴̘͕̣è͖ẹ̥̩l͖͔͚i͓͚̦͠n͖͍̗͓̳̮g͍ ̨o͚̪͡f̘̣̬ ̖̘͖̟͙̮c҉͔̫͖͓͇͖ͅh̵̤̣͚͔á̗̼͕ͅo̼̣̥s̱͈̺̖̦̻͢.̛̖̞̠̫̰")]
    pub i_n_v_ok_i_n_g_t_h_e_f_l_i_n_g_o_f_c_h_o_s: String,

    #[serde(rename = "<!--[if<img src=x onerror=javascript:alert(1)//]> -->")]
    pub if_img_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<!--[if]><script>javascript:alert(1)</script -->")]
    pub if_script_javascript_alert_1_script: String,

    #[serde(rename = "<IMG SRC=&#106;&#97;&#118;&#97;&#115;&#99;&#114;&#105;&#112;&#116;&#58;&#97;&#108;&#101;&#114;&#116;&#40;&#39;&#88;&#83;&#83;&#39;&#41;>")]
    pub img_src_106971189711599114105112116589710810111411640398883833941: String,

    #[serde(rename = "<IMG SRC=\"jav   ascript:alert('XSS');\">")]
    pub img_src_jav_ascript_alert_xss: String,

    #[serde(rename = "<IMG SRC=\"jav&#x0A;ascript:alert('XSS');\">")]
    pub img_src_jav_x0_a_ascript_alert_xss: String,

    #[serde(rename = "<IMG SRC=\"jav&#x0D;ascript:alert('XSS');\">")]
    pub img_src_jav_x0_d_ascript_alert_xss: String,

    #[serde(rename = "<img src\\x09=x onerror=\"javascript:alert(1)\">")]
    pub img_src_x09_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src\\x11=x onerror=\"javascript:alert(1)\">")]
    pub img_src_x11_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src=x onerror=\\x00\"javascript:alert(1)\">")]
    pub img_src_x_onerror_x00_javascript_alert_1: String,

    #[serde(rename = "<img src=x onerror=\\x09\"javascript:alert(1)\">")]
    pub img_src_x_onerror_x09_javascript_alert_1: String,

    #[serde(rename = "<img src=x\\x09onerror=\"javascript:alert(1)\">")]
    pub img_src_x_x09_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src=x\\x10onerror=\"javascript:alert(1)\">")]
    pub img_src_x_x10_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src=x\\x11onerror=\"javascript:alert(1)\">")]
    pub img_src_x_x11_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src=x\\x12onerror=\"javascript:alert(1)\">")]
    pub img_src_x_x12_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src=x\\x13onerror=\"javascript:alert(1)\">")]
    pub img_src_x_x13_onerror_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x00onerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x00_onerror_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x0Bonerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x0_bonerror_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x2Fonerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x2_fonerror_javascript_alert_1: String,

    #[serde(rename = "<img \\x00src=x onerror=\"alert(1)\">")]
    pub img_x00_src_x_onerror_alert_1: String,

    #[serde(rename = "<img\\x10src=x onerror=\"javascript:alert(1)\">")]
    pub img_x10_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img\\x13src=x onerror=\"javascript:alert(1)\">")]
    pub img_x13_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img\\x32src=x onerror=\"javascript:alert(1)\">")]
    pub img_x32_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img \\x39src=x onerror=\"javascript:alert(1)\">")]
    pub img_x39_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = ",./;'[]\\-=")]
    pub indecent: String,

    #[serde(rename = ",")]
    pub indigo: String,

    #[serde(rename = "INF")]
    pub inf: String,

    #[serde(rename = "-Infinity")]
    pub infinity: String,

    #[serde(rename = "#\tInnocuous strings which may be blocked by profanity filters (https://en.wikipedia.org/wiki/Scunthorpe_problem)")]
    pub innocuous_strings_which_may_be_blocked_by_profanity_filters_https_en_wikipedia_org_wiki_scunthorpe_problem: String,

    #[serde(rename = "Jimmy Clitheroe")]
    pub jimmy_clitheroe: String,

    #[serde(rename = "Kernel.exit(1)")]
    pub kernel_exit_1: String,

    #[serde(rename = "#\tKnown CVEs and Vulnerabilities")]
    pub known_cv_es_and_vulnerabilities: String,

    #[serde(rename = "Lightwater Country Park")]
    pub lightwater_country_park: String,

    #[serde(rename = "LPT2")]
    pub lpt2: String,

    #[serde(rename = "LPT3")]
    pub lpt3: String,

    #[serde(rename = "`ls -al /`")]
    pub ls_al: String,

    #[serde(rename = "\\")]
    pub magenta: String,

    #[serde(rename = "\u{0080}\u{0081}\u{0082}\u{0083}\u{0084}\u{0086}\u{0087}\u{0088}\u{0089}\u{008a}\u{008b}\u{008c}\u{008d}\u{008e}\u{008f}\u{0090}\u{0091}\u{0092}\u{0093}\u{0094}\u{0095}\u{0096}\u{0097}\u{0098}\u{0099}\u{009a}\u{009b}\u{009c}\u{009d}\u{009e}\u{009f}")]
    pub mischievous: String,

    #[serde(rename = "#\tMSDOS/Windows Special Filenames")]
    pub msdos_windows_special_filenames: String,

    #[serde(rename = "nil")]
    pub nil: String,

    #[serde(rename = "# Non-whitespace C1 controls: U+0080 through U+0084 and U+0086 through U+009F.")]
    pub non_whitespace_c1_controls_u_0080_through_u_0084_and_u_0086_through_u_009_f: String,

    pub none: String,

    #[serde(rename = "(null)")]
    pub null: String,

    #[serde(rename = " onfocus=JaVaSCript:alert(123) autofocus")]
    pub onfocus_ja_va_s_cript_alert_123_autofocus: String,

    #[serde(rename = "' OR '1'='1")]
    pub or_11: String,

    #[serde(rename = "Penistone Community Church")]
    pub penistone_community_church: String,

    #[serde(rename = "perl -e 'print \"<IMG SRC=java\\0script:alert(\\\"XSS\\\")>\";' > out")]
    pub perl_e_print_img_src_java_0_script_alert_xss_out: String,

    #[serde(rename = "PRN")]
    pub prn: String,

    #[serde(rename = "'")]
    pub purple: String,

    #[serde(rename = "0")]
    pub purple_0: String,

    #[serde(rename = "1")]
    pub purple_1: String,

    #[serde(rename = "false")]
    pub purple_false: String,

    #[serde(rename = "\u{202b}test\u{202b}")]
    pub purple_test: String,

    #[serde(rename = "True")]
    pub purple_true: String,

    #[serde(rename = "RomansInSussex.co.uk")]
    pub romans_in_sussex_co_uk: String,

    #[serde(rename = "%s")]
    pub s: String,

    #[serde(rename = "<<< %s(un='%s') = %u")]
    pub s_un_s_u: String,

    #[serde(rename = "<sc<script>ript>alert(123)</sc</script>ript>")]
    pub sc_script_ript_alert_123_sc_script_ript: String,

    #[serde(rename = "\"><script>alert(123);</script x=\"")]
    pub script_alert_123_script_x: String,

    #[serde(rename = "#\tScript Injection")]
    pub script_injection: String,

    #[serde(rename = "</script><script>alert(123)</script>")]
    pub script_script_alert_123_script: String,

    #[serde(rename = "<SCRIPT SRC=http://ha.ckers.org/xss.js?< B >")]
    pub script_src_http_ha_ckers_org_xss_js_b: String,

    #[serde(rename = "<SCRIPT/SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>")]
    pub script_src_http_ha_ckers_org_xss_js_script: String,

    #[serde(rename = "\"`'><script>\\x00javascript:alert(1)</script>")]
    pub script_x00_javascript_alert_1_script: String,

    #[serde(rename = "<script\\x09type=\"text/javascript\">javascript:alert(1);</script>")]
    pub script_x09_type_text_javascript_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\x0Cjavascript:alert(1)</script>")]
    pub script_x0_cjavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\x0Djavascript:alert(1)</script>")]
    pub script_x0_djavascript_alert_1_script: String,

    #[serde(rename = "<script\\x20type=\"text/javascript\">javascript:alert(1);</script>")]
    pub script_x20_type_text_javascript_javascript_alert_1_script: String,

    #[serde(rename = "<script\\x3Etype=\"text/javascript\">javascript:alert(1);</script>")]
    pub script_x3_etype_text_javascript_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xC2\\x85javascript:alert(1)</script>")]
    pub script_x_c2_x85_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xC2\\xA0javascript:alert(1)</script>")]
    pub script_x_c2_x_a0_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE1\\x9A\\x80javascript:alert(1)</script>")]
    pub script_x_e1_x9_a_x80_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE1\\xA0\\x8Ejavascript:alert(1)</script>")]
    pub script_x_e1_x_a0_x8_ejavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x81javascript:alert(1)</script>")]
    pub script_x_e2_x80_x81_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x86javascript:alert(1)</script>")]
    pub script_x_e2_x80_x86_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x89javascript:alert(1)</script>")]
    pub script_x_e2_x80_x89_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x81\\x9Fjavascript:alert(1)</script>")]
    pub script_x_e2_x81_x9_fjavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xEF\\xBB\\xBFjavascript:alert(1)</script>")]
    pub script_x_ef_x_bb_x_b_fjavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xF0\\x90\\x96\\x9Ajavascript:alert(1)</script>")]
    pub script_x_f0_x90_x96_x9_ajavascript_alert_1_script: String,

    #[serde(rename = "<SCRIPT/XSS SRC=\"http://ha.ckers.org/xss.js\"></SCRIPT>")]
    pub script_xss_src_http_ha_ckers_org_xss_js_script: String,

    #[serde(rename = "#\tSQL Injection")]
    pub sql_injection: String,

    #[serde(rename = "(╯°□°）╯︵ ┻━┻)")]
    pub sticky: String,

    #[serde(rename = "#\tString which can reveal system files when parsed by a badly configured XML parser")]
    pub string_which_can_reveal_system_files_when_parsed_by_a_badly_configured_xml_parser: String,

    #[serde(rename = "#\tStrings that test for known vulnerabilities")]
    pub strings_that_test_for_known_vulnerabilities: String,

    #[serde(rename = "#\tStrings which can be accidentally expanded into different strings if evaluated in the wrong context, e.g. used as a printf format string or via Perl or shell eval. Might expose sensitive data from the program doing the interpolation, or might just represent the wrong string.")]
    pub strings_which_can_be_accidentally_expanded_into_different_strings_if_evaluated_in_the_wrong_context_e_g_used_as_a_printf_format_string_or_via_perl_or_shell_eval_might_expose_sensitive_data_from_the_program_doing_the_interpolation_or_might_just_represent_the_wrong_string: String,

    #[serde(rename = "#\tStrings which can call system commands within Ruby/Rails applications")]
    pub strings_which_can_call_system_commands_within_ruby_rails_applications: String,

    #[serde(rename = "#\tStrings which consists of Japanese-style emoticons which are popular on the web")]
    pub strings_which_consists_of_japanese_style_emoticons_which_are_popular_on_the_web: String,

    #[serde(rename = "#\tStrings which contain bold/italic/etc. versions of normal characters")]
    pub strings_which_contain_bold_italic_etc_versions_of_normal_characters: String,

    #[serde(rename = "#\tStrings which contain common unicode symbols (e.g. smart quotes)")]
    pub strings_which_contain_common_unicode_symbols_e_g_smart_quotes: String,

    #[serde(rename = "#\tStrings which contain Emoji; should be the same behavior as two-byte characters, but not always")]
    pub strings_which_contain_emoji_should_be_the_same_behavior_as_two_byte_characters_but_not_always: String,

    #[serde(rename = "#\tStrings which contain misplaced quotation marks; can cause encoding errors")]
    pub strings_which_contain_misplaced_quotation_marks_can_cause_encoding_errors: String,

    #[serde(rename = "#\tStrings which contain unicode subscripts/superscripts; can cause rendering issues")]
    pub strings_which_contain_unicode_subscripts_superscripts_can_cause_rendering_issues: String,

    #[serde(rename = "#\tStrings which crashed iMessage in various versions of iOS")]
    pub strings_which_crashed_i_message_in_various_versions_of_i_os: String,

    #[serde(rename = "#\tStrings which may cause human to reinterpret worldview")]
    pub strings_which_may_cause_human_to_reinterpret_worldview: String,

    #[serde(rename = "Super Bowl XXX")]
    pub super_bowl_xxx: String,

    #[serde(rename = "( ͡° ͜ʖ ͡°)")]
    pub tentacled: String,

    #[serde(rename = "הָיְתָהtestالصفحات التّحول")]
    pub test: String,

    #[serde(rename = "</textarea><script>alert(123)</script>")]
    pub textarea_script_alert_123_script: String,

    #[serde(rename = "+0")]
    pub the_0: String,

    #[serde(rename = "0..0")]
    pub the_00: String,

    #[serde(rename = "0,0,0")]
    pub the_000: String,

    #[serde(rename = "0,0/0,0")]
    pub the_0000: String,

    #[serde(rename = "0x0")]
    pub the_0_x0: String,

    #[serde(rename = "\u{00ad}\u{0600}\u{0601}\u{0602}\u{0603}\u{0604}\u{0605}\u{061c}\u{06dd}\u{070f}\u{180e}\u{200b}\u{200c}\u{200d}\u{200e}\u{200f}\u{202a}\u{202b}\u{202c}\u{202d}\u{202e}\u{2060}\u{2061}\u{2062}\u{2063}\u{2064}\u{2066}\u{2067}\u{2068}\u{2069}\u{206a}\u{206b}\u{206c}\u{206d}\u{206e}\u{206f}\u{feff}\u{fff9}\u{fffa}\u{fffb}\u{0110bd}\u{01bca0}\u{01bca1}\u{01bca2}\u{01bca3}\u{01d173}\u{01d174}\u{01d175}\u{01d176}\u{01d177}\u{01d178}\u{01d179}\u{01d17a}\u{0e0001}\u{0e0020}\u{0e0021}\u{0e0022}\u{0e0023}\u{0e0024}\u{0e0025}\u{0e0026}\u{0e0027}\u{0e0028}\u{0e0029}\u{0e002a}\u{0e002b}\u{0e002c}\u{0e002d}\u{0e002e}\u{0e002f}\u{0e0030}\u{0e0031}\u{0e0032}\u{0e0033}\u{0e0034}\u{0e0035}\u{0e0036}\u{0e0037}\u{0e0038}\u{0e0039}\u{0e003a}\u{0e003b}\u{0e003c}\u{0e003d}\u{0e003e}\u{0e003f}\u{0e0040}\u{0e0041}\u{0e0042}\u{0e0043}\u{0e0044}\u{0e0045}\u{0e0046}\u{0e0047}\u{0e0048}\u{0e0049}\u{0e004a}\u{0e004b}\u{0e004c}\u{0e004d}\u{0e004e}\u{0e004f}\u{0e0050}\u{0e0051}\u{0e0052}\u{0e0053}\u{0e0054}\u{0e0055}\u{0e0056}\u{0e0057}\u{0e0058}\u{0e0059}\u{0e005a}\u{0e005b}\u{0e005c}\u{0e005d}\u{0e005e}\u{0e005f}\u{0e0060}\u{0e0061}\u{0e0062}\u{0e0063}\u{0e0064}\u{0e0065}\u{0e0066}\u{0e0067}\u{0e0068}\u{0e0069}\u{0e006a}\u{0e006b}\u{0e006c}\u{0e006d}\u{0e006e}\u{0e006f}\u{0e0070}\u{0e0071}\u{0e0072}\u{0e0073}\u{0e0074}\u{0e0075}\u{0e0076}\u{0e0077}\u{0e0078}\u{0e0079}\u{0e007a}\u{0e007b}\u{0e007c}\u{0e007d}\u{0e007e}\u{0e007f}")]
    pub the_1: String,

    #[serde(rename = "₀₁₂")]
    pub the_10: String,

    #[serde(rename = "1.00")]
    pub the_100: String,

    #[serde(rename = "1.0/0.0")]
    pub the_1000: String,

    #[serde(rename = "1'000,00")]
    pub the_100000: String,

    #[serde(rename = "1 000 000.00")]
    pub the_100000000: String,

    #[serde(rename = "⒯⒣⒠ ⒬⒰⒤⒞⒦ ⒝⒭⒪⒲⒩ ⒡⒪⒳ ⒥⒰⒨⒫⒮ ⒪⒱⒠⒭ ⒯⒣⒠ ⒧⒜⒵⒴ ⒟⒪⒢")]
    pub the_11: String,

    #[serde(rename = "1/2")]
    pub the_12: String,

    #[serde(rename = "123456789012345678901234567890123456789")]
    pub the_123456789012345678901234567890123456789: String,

    #[serde(rename = "\u{01d47b}\u{01d489}\u{01d486} \u{01d492}\u{01d496}\u{01d48a}\u{01d484}\u{01d48c} \u{01d483}\u{01d493}\u{01d490}\u{01d498}\u{01d48f} \u{01d487}\u{01d490}\u{01d499} \u{01d48b}\u{01d496}\u{01d48e}\u{01d491}\u{01d494} \u{01d490}\u{01d497}\u{01d486}\u{01d493} \u{01d495}\u{01d489}\u{01d486} \u{01d48d}\u{01d482}\u{01d49b}\u{01d49a} \u{01d485}\u{01d490}\u{01d488}")]
    pub the_15: String,

    #[serde(rename = "\u{01d4e3}\u{01d4f1}\u{01d4ee} \u{01d4fa}\u{01d4fe}\u{01d4f2}\u{01d4ec}\u{01d4f4} \u{01d4eb}\u{01d4fb}\u{01d4f8}\u{01d500}\u{01d4f7} \u{01d4ef}\u{01d4f8}\u{01d501} \u{01d4f3}\u{01d4fe}\u{01d4f6}\u{01d4f9}\u{01d4fc} \u{01d4f8}\u{01d4ff}\u{01d4ee}\u{01d4fb} \u{01d4fd}\u{01d4f1}\u{01d4ee} \u{01d4f5}\u{01d4ea}\u{01d503}\u{01d502} \u{01d4ed}\u{01d4f8}\u{01d4f0}")]
    pub the_16: String,

    #[serde(rename = "\u{01d57f}\u{01d58d}\u{01d58a} \u{01d596}\u{01d59a}\u{01d58e}\u{01d588}\u{01d590} \u{01d587}\u{01d597}\u{01d594}\u{01d59c}\u{01d593} \u{01d58b}\u{01d594}\u{01d59d} \u{01d58f}\u{01d59a}\u{01d592}\u{01d595}\u{01d598} \u{01d594}\u{01d59b}\u{01d58a}\u{01d597} \u{01d599}\u{01d58d}\u{01d58a} \u{01d591}\u{01d586}\u{01d59f}\u{01d59e} \u{01d589}\u{01d594}\u{01d58c}")]
    pub the_17: String,

    #[serde(rename = "\u{01f1fa}\u{01f1f8}\u{01f1f7}\u{01f1fa}\u{01f1f8} \u{01f1e6}\u{01f1eb}\u{01f1e6}\u{01f1f2}\u{01f1f8}")]
    pub the_18: String,

    #[serde(rename = "\u{01f1fa}\u{01f1f8}\u{01f1f7}\u{01f1fa}\u{01f1f8}\u{01f1e6}")]
    pub the_19: String,

    #[serde(rename = "1;DROP TABLE users")]
    pub the_1_drop_table_users: String,

    #[serde(rename = "-1E02")]
    pub the_1_e02: String,

    #[serde(rename = "1E2")]
    pub the_1_e2: String,

    #[serde(rename = "1#QNAN")]
    pub the_1_qnan: String,

    #[serde(rename = "1#SNAN")]
    pub the_1_snan: String,

    #[serde(rename = "¸˛Ç◊ı˜Â¯˘¿")]
    pub the_2: String,

    #[serde(rename = "\u{01f1fa}\u{01f1f8}\u{01f1f7}\u{01f1fa}\u{01f1f8}\u{01f1e6}\u{01f1eb}\u{01f1e6}\u{01f1f2}")]
    pub the_20: String,

    #[serde(rename = "\u{01f469}\u{01f3fd}")]
    pub the_21: String,

    #[serde(rename = "\u{01f6be} \u{01f192} \u{01f193} \u{01f195} \u{01f196} \u{01f197} \u{01f199} \u{01f3e7}")]
    pub the_22: String,

    #[serde(rename = "﷽")]
    pub the_23: String,

    #[serde(rename = "\u{feff}")]
    pub the_24: String,

    #[serde(rename = "ﾟ･✿ヾ╲(｡◕‿◕｡)╱✿･ﾟ")]
    pub the_26: String,

    #[serde(rename = "\u{fffe}")]
    pub the_27: String,

    #[serde(rename = "Œ„´‰ˇÁ¨ˆØ∏”’")]
    pub the_3: String,

    #[serde(rename = "œ∑´®†¥¨ˆøπ“‘")]
    pub the_4: String,

    #[serde(rename = "Ⱥ")]
    pub the_5: String,

    #[serde(rename = "Ⱦ")]
    pub the_6: String,

    #[serde(rename = "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999")]
    pub the_999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999: String,

    #[serde(rename = "# The next two lines may appear to be blank or mojibake in some viewers.")]
    pub the_next_two_lines_may_appear_to_be_blank_or_mojibake_in_some_viewers: String,

    #[serde(rename = "The quic\u{0008}\u{0008}\u{0008}\u{0008}\u{0008}\u{0008}k brown fo\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}\u{0007}x... [Beeeep]")]
    pub the_quic_k_brown_fo_x_beeeep: String,

    #[serde(rename = "#\tTwo-Byte Characters")]
    pub two_byte_characters: String,

    #[serde(rename = "# U+0000, U+000A, or U+000D (NUL, LF, CR).")]
    pub u_0000_u_000_a_or_u_000_d_nul_lf_cr: String,

    #[serde(rename = "<u oncopy=alert()> Copy me</u>")]
    pub u_oncopy_alert_copy_me_u: String,

    #[serde(rename = "undef")]
    pub undef: String,

    #[serde(rename = "#\tUnicode font")]
    pub unicode_font: String,

    #[serde(rename = "#\tUnicode Numbers")]
    pub unicode_numbers: String,

    #[serde(rename = "#\tUnwanted Interpolation")]
    pub unwanted_interpolation: String,

    #[serde(rename = "%x('ls -al /')")]
    pub x_ls_al: String,

    #[serde(rename = "Z̮̞̠͙͔ͅḀ̗̞͈̻̗Ḷ͙͎̯̹̞͓G̻O̭̗̮")]
    pub z_g_o: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "SCREAMING_SNAKE_CASE")]
pub struct B {
    #[serde(rename = "ﷺ")]
    pub _2: String,

    #[serde(rename = "１２３")]
    pub _3: String,

    #[serde(rename = "__ﾛ(,_,*)")]
    pub _underscore: String,

    #[serde(rename = "<a href=http://foo.bar/#x=`y></a><img alt=\"`><img src=x:x onerror=javascript:alert(1)></a>\">")]
    pub a_href_http_foo_bar_x_y_a_img_alt_img_src_x_x_onerror_javascript_alert_1_a: String,

    #[serde(rename = "<a href=\"javascript\\x00:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_javascript_x00_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"javascript\\x0D:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_javascript_x0_d_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x02javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x02_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x04javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x04_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x0Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x0_ajavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x0Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x0_djavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x0Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x0_ejavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x0Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x0_fjavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x16javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x16_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x19javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x19_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x1Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x1_ajavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x1Djavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x1_djavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x1Ejavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x1_ejavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x81javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x81_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x82javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x82_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\xA9javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x_a9_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\xAFjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x_a_fjavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "ABC<div style=\"x:expression\\x5C(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_expression_x5_c_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\x0Aexpression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x0_aexpression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\x0Dexpression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x0_dexpression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x82expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x82_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x83expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x83_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x85expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x85_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x87expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x87_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x8Aexpression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x8_aexpression_javascript_alert_1_def: String,

    #[serde(rename = "ヽ༼ຈل͜ຈ༽ﾉ ヽ༼ຈل͜ຈ༽ﾉ")]
    pub ambitious: String,

    #[serde(rename = "# appear in input.")]
    pub appear_in_input: String,

    #[serde(rename = "+++ATH0")]
    pub ath0: String,

    #[serde(rename = "' autofocus onkeyup='javascript:alert(123)")]
    pub autofocus_onkeyup_javascript_alert_123: String,

    #[serde(rename = "\t\u{000b}\u{000c} \u{0085}             \u{200b}\u{2028}\u{2029}  　")]
    pub b: String,

    #[serde(rename = "1'000.00")]
    pub b_100000: String,

    #[serde(rename = "FALSE")]
    pub b_false: String,

    #[serde(rename = "<IMG SRC=# onmouseover=\"alert('xxs')\">")]
    pub b_img_src_onmouseover_alert_xxs: String,

    #[serde(rename = "--><script>alert(123)</script>")]
    pub b_script_alert_123_script: String,

    #[serde(rename = "`touch /tmp/blns.fail`")]
    pub b_touch_tmp_blns_fail: String,

    #[serde(rename = "basement")]
    pub basement: String,

    #[serde(rename = "\u{01d54b}\u{01d559}\u{01d556} \u{01d562}\u{01d566}\u{01d55a}\u{01d554}\u{01d55c} \u{01d553}\u{01d563}\u{01d560}\u{01d568}\u{01d55f} \u{01d557}\u{01d560}\u{01d569} \u{01d55b}\u{01d566}\u{01d55e}\u{01d561}\u{01d564} \u{01d560}\u{01d567}\u{01d556}\u{01d563} \u{01d565}\u{01d559}\u{01d556} \u{01d55d}\u{01d552}\u{01d56b}\u{01d56a} \u{01d555}\u{01d560}\u{01d558}")]
    pub braggadocious: String,

    #[serde(rename = "But now...\u{001b}[20Cfor my greatest trick...\u{001b}[8m")]
    pub but_now_20_cfor_my_greatest_trick_8_m: String,

    #[serde(rename = "# \"Byte order marks\", U+FEFF and U+FFFE, each on its own line.")]
    pub byte_order_marks_u_feff_and_u_fffe_each_on_its_own_line: String,

    pub com1: String,

    pub com3: String,

    #[serde(rename = "# Commonly misinterpreted as additional graphic characters.")]
    pub commonly_misinterpreted_as_additional_graphic_characters: String,

    pub con: String,

    #[serde(rename = "# contexts.  Divided into three groups based on (US-layout) keyboard position.")]
    pub contexts_divided_into_three_groups_based_on_us_layout_keyboard_position: String,

    #[serde(rename = "#\tCredit: https://twitter.com/jifa/status/625776454479970304")]
    pub credit_https_twitter_com_jifa_status_625776454479970304: String,

    #[serde(rename = "社會科學院語學研究所")]
    pub cunning: String,

    #[serde(rename = "/dev/null; touch /tmp/blns.fail ; echo")]
    pub dev_null_touch_tmp_blns_fail_echo: String,

    #[serde(rename = "dontMakeAMap")]
    pub dont_make_a_map: bool,

    #[serde(rename = "\u{0001}\u{0002}\u{0003}\u{0004}\u{0005}\u{0006}\u{0007}\u{0008}\u{000e}\u{000f}\u{0010}\u{0011}\u{0012}\u{0013}\u{0014}\u{0015}\u{0016}\u{0017}\u{0018}\u{0019}\u{001a}\u{001b}\u{001c}\u{001d}\u{001e}\u{001f}\u{007f}")]
    pub empty: String,

    #[serde(rename = "eval(\"puts 'hello world'\")")]
    pub eval_puts_hello_world: String,

    #[serde(rename = "expression")]
    pub expression: String,

    #[serde(rename = "File:///")]
    pub file: String,

    #[serde(rename = "#\tFile Inclusion")]
    pub file_inclusion: String,

    #[serde(rename = "#")]
    pub fluffy: String,

    #[serde(rename = "<foo val=”bar“ />")]
    pub foo_val_bar: String,

    #[serde(rename = "사회과학원 어학연구소")]
    pub frisky: String,

    #[serde(rename = "# general category Cf (in Unicode 8.0.0).")]
    pub general_category_cf_in_unicode_800: String,

    #[serde(rename = "̦H̬̤̗̤͝e͜ ̜̥̝̻͍̟́w̕h̖̯͓o̝͙̖͎̱̮ ҉̺̙̞̟͈W̷̼̭a̺̪͍į͈͕̭͙̯̜t̶̼̮s̘͙͖̕ ̠̫̠B̻͍͙͉̳ͅe̵h̵̬͇̫͙i̹͓̳̳̮͎̫̕n͟d̴̪̜̖ ̰͉̩͇͙̲͞ͅT͖̼͓̪͢h͏͓̮̻e̬̝̟ͅ ̤̹̝W͙̞̝͔͇͝ͅa͏͓͔̹̼̣l̴͔̰̤̟͔ḽ̫.͕")]
    pub h_e_w_h_o_w_a_t_s_b_e_h_i_n_d_t_h_e_w_a_l: String,

    #[serde(rename = "--help")]
    pub help: String,

    #[serde(rename = "❤️ \u{01f494} \u{01f48c} \u{01f495} \u{01f49e} \u{01f493} \u{01f497} \u{01f496} \u{01f498} \u{01f49d} \u{01f49f} \u{01f49c} \u{01f49b} \u{01f49a} \u{01f499}")]
    pub hilarious: String,

    #[serde(rename = "http://a/%%30%30")]
    pub http_a_3030: String,

    #[serde(rename = "#\tiOS Vulnerabilities")]
    pub i_os_vulnerabilities: String,

    #[serde(rename = "If you're reading this, you've been in a coma for almost 20 years now. We're trying a new technique. We don't know where this message will end up in your dream, but we hope it works. Please wake up, we miss you.")]
    pub if_you_re_reading_this_you_ve_been_in_a_coma_for_almost_20_years_now_we_re_trying_a_new_technique_we_don_t_know_where_this_message_will_end_up_in_your_dream_but_we_hope_it_works_please_wake_up_we_miss_you: String,

    #[serde(rename = "<iframe src=http://ha.ckers.org/scriptlet.html <")]
    pub iframe_src_http_ha_ckers_org_scriptlet_html: String,

    #[serde(rename = "<IMG SRC=&#0000106&#0000097&#0000118&#0000097&#0000115&#0000099&#0000114&#0000105&#0000112&#0000116&#0000058&#0000097&#0000108&#0000101&#0000114&#0000116&#0000040&#0000039&#0000088&#0000083&#0000083&#0000039&#0000041>")]
    pub img_src_00001060000097000011800000970000115000009900001140000105000011200001160000058000009700001080000101000011400001160000040000003900000880000083000008300000390000041: String,

    #[serde(rename = "<IMG SRC=\" &#14;  javascript:alert('XSS');\">")]
    pub img_src_14_javascript_alert_xss: String,

    #[serde(rename = "<IMG SRC=\"jav&#x09;ascript:alert('XSS');\">")]
    pub img_src_jav_x09_ascript_alert_xss: String,

    #[serde(rename = "<IMG SRC= onmouseover=\"alert('xxs')\">")]
    pub img_src_onmouseover_alert_xxs: String,

    #[serde(rename = "<img src\\x00=x onerror=\"javascript:alert(1)\">")]
    pub img_src_x00_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<IMG SRC=&#x6A&#x61&#x76&#x61&#x73&#x63&#x72&#x69&#x70&#x74&#x3A&#x61&#x6C&#x65&#x72&#x74&#x28&#x27&#x58&#x53&#x53&#x27&#x29>")]
    pub img_src_x6_a_x61_x76_x61_x73_x63_x72_x69_x70_x74_x3_a_x61_x6_c_x65_x72_x74_x28_x27_x58_x53_x53_x27_x29: String,

    #[serde(rename = "<img src=x onerror=\\x11\"javascript:alert(1)\">")]
    pub img_src_x_onerror_x11_javascript_alert_1: String,

    #[serde(rename = "<img src=x onerror=\\x12\"javascript:alert(1)\">")]
    pub img_src_x_onerror_x12_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x0Aonerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x0_aonerror_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x0Conerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x0_conerror_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x0Donerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x0_donerror_javascript_alert_1: String,

    #[serde(rename = "<img \\x00src=x onerror=\"javascript:alert(1)\">")]
    pub img_x00_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img \\x11src=x onerror=\"javascript:alert(1)\">")]
    pub img_x11_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img \\x12src=x onerror=\"javascript:alert(1)\">")]
    pub img_x12_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img \\x47src=x onerror=\"javascript:alert(1)\">")]
    pub img_x47_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "⁰⁴⁵₀₁₂")]
    pub indecent: String,

    #[serde(rename = "Ω≈ç√∫˜µ≤≥÷")]
    pub indigo: String,

    #[serde(rename = "#   IRC specific strings")]
    pub irc_specific_strings: String,

    #[serde(rename = "#\tJapanese Emoticons")]
    pub japanese_emoticons: String,

    #[serde(rename = "Kernel.exec(\"ls -al /\")")]
    pub kernel_exec_ls_al: String,

    #[serde(rename = "Linda Callahan")]
    pub linda_callahan: String,

    #[serde(rename = "部落格")]
    pub magenta: String,

    #[serde(rename = "찦차를 타고 온 펲시맨과 쑛다리 똠방각하")]
    pub mischievous: String,

    #[serde(rename = "˙ɐnbᴉlɐ ɐuƃɐɯ ǝɹolop ʇǝ ǝɹoqɐl ʇn ʇunpᴉpᴉɔuᴉ ɹodɯǝʇ poɯsnᴉǝ op pǝs 'ʇᴉlǝ ƃuᴉɔsᴉdᴉpɐ ɹnʇǝʇɔǝsuoɔ 'ʇǝɯɐ ʇᴉs ɹolop ɯnsdᴉ ɯǝɹo˥")]
    pub nbl_u_olop_oql_n_unppu_od_posn_op_ps_l_usdp_nsuo_s_olop_nsd_o: String,

    pub nil: String,

    pub nul: String,

    #[serde(rename = "null")]
    pub null: String,

    #[serde(rename = "#\tNumeric Strings")]
    pub numeric_strings: String,

    #[serde(rename = "Ṱ̺̺̕o͞ ̷i̲̬͇̪͙n̝̗͕v̟̜̘̦͟o̶̙̰̠kè͚̮̺̪̹̱̤ ̖t̝͕̳̣̻̪͞h̼͓̲̦̳̘̲e͇̣̰̦̬͎ ̢̼̻̱̘h͚͎͙̜̣̲ͅi̦̲̣̰̤v̻͍e̺̭̳̪̰-m̢iͅn̖̺̞̲̯̰d̵̼̟͙̩̼̘̳ ̞̥̱̳̭r̛̗̘e͙p͠r̼̞̻̭̗e̺̠̣͟s̘͇̳͍̝͉e͉̥̯̞̲͚̬͜ǹ̬͎͎̟̖͇̤t͍̬̤͓̼̭͘ͅi̪̱n͠g̴͉ ͏͉ͅc̬̟h͡a̫̻̯͘o̫̟̖͍̙̝͉s̗̦̲.̨̹͈̣")]
    pub o_i_n_v_o_k_t_h_e_h_i_v_e_m_i_n_d_r_e_p_r_e_s_e_t_i_n_g_c_h_a_o_s: String,

    #[serde(rename = "# Often forbidden to appear in various text-based file formats (e.g. XML),")]
    pub often_forbidden_to_appear_in_various_text_based_file_formats_e_g_xml: String,

    #[serde(rename = "\" onfocus=JaVaSCript:alert(123) autofocus")]
    pub onfocus_ja_va_s_cript_alert_123_autofocus: String,

    #[serde(rename = "' OR 1=1 -- 1")]
    pub or_111: String,

    #[serde(rename = "\"")]
    pub purple: String,

    #[serde(rename = "<script>alert(123)</script>")]
    pub purple_script_alert_123_script: String,

    #[serde(rename = "#\tQuotation Marks")]
    pub quotation_marks: String,

    #[serde(rename = "#       Regional Indicator Symbols")]
    pub regional_indicator_symbols: String,

    #[serde(rename = "#       Regional Indicator Symbols can be displayed differently across")]
    pub regional_indicator_symbols_can_be_displayed_differently_across: String,

    #[serde(rename = "#\tReserved Strings")]
    pub reserved_strings: String,

    #[serde(rename = "\"><script>alert(123)</script>")]
    pub script_alert_123_script: String,

    #[serde(rename = "><script>alert(123);</script x=")]
    pub script_alert_123_script_x: String,

    #[serde(rename = "<<SCRIPT>alert(\"XSS\");//<</SCRIPT>")]
    pub script_alert_xss_script: String,

    #[serde(rename = "<SCRIPT SRC=//ha.ckers.org/.j>")]
    pub script_src_ha_ckers_org_j: String,

    #[serde(rename = "<script src=\"\\\\%(jscript)s\"></script>")]
    pub script_src_jscript_s_script: String,

    #[serde(rename = "\"`'><script>\\x09javascript:alert(1)</script>")]
    pub script_x09_javascript_alert_1_script: String,

    #[serde(rename = "<script\\x0Atype=\"text/javascript\">javascript:alert(1);</script>")]
    pub script_x0_atype_text_javascript_javascript_alert_1_script: String,

    #[serde(rename = "<script\\x0Dtype=\"text/javascript\">javascript:alert(1);</script>")]
    pub script_x0_dtype_text_javascript_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\x21javascript:alert(1)</script>")]
    pub script_x21_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\x3Bjavascript:alert(1)</script>")]
    pub script_x3_bjavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x85javascript:alert(1)</script>")]
    pub script_x_e2_x80_x85_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x87javascript:alert(1)</script>")]
    pub script_x_e2_x80_x87_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x8Ajavascript:alert(1)</script>")]
    pub script_x_e2_x80_x8_ajavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\xA8javascript:alert(1)</script>")]
    pub script_x_e2_x80_x_a8_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\xA9javascript:alert(1)</script>")]
    pub script_x_e2_x80_x_a9_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\xAFjavascript:alert(1)</script>")]
    pub script_x_e2_x80_x_a_fjavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE3\\x80\\x80javascript:alert(1)</script>")]
    pub script_x_e3_x80_x80_javascript_alert_1_script: String,

    #[serde(rename = "#\tScunthorpe Problem")]
    pub scunthorpe_problem: String,

    #[serde(rename = "åß∂ƒ©˙∆˚¬…æ")]
    pub sticky: String,

    #[serde(rename = "#   Strings that may occur on IRC clients that make security products freak out")]
    pub strings_that_may_occur_on_irc_clients_that_make_security_products_freak_out: String,

    #[serde(rename = "#\tStrings which are reserved characters in MSDOS/Windows")]
    pub strings_which_are_reserved_characters_in_msdos_windows: String,

    #[serde(rename = "#\tStrings which attempt to invoke a benign script injection; shows vulnerability to XSS")]
    pub strings_which_attempt_to_invoke_a_benign_script_injection_shows_vulnerability_to_xss: String,

    #[serde(rename = "#\tStrings which contain text that should be rendered RTL if possible (e.g. Arabic, Hebrew)")]
    pub strings_which_contain_text_that_should_be_rendered_rtl_if_possible_e_g_arabic_hebrew: String,

    #[serde(rename = "#\tStrings which contain two-byte characters: can cause rendering issues or character-length issues")]
    pub strings_which_contain_two_byte_characters_can_cause_rendering_issues_or_character_length_issues: String,

    #[serde(rename = "#\tStrings which contain unicode numbers; if the code is localized, it should see the input as numeric")]
    pub strings_which_contain_unicode_numbers_if_the_code_is_localized_it_should_see_the_input_as_numeric: String,

    #[serde(rename = "#\tStrings which may be used elsewhere in code")]
    pub strings_which_may_be_used_elsewhere_in_code: String,

    #[serde(rename = "(｡◕ ∀ ◕｡)")]
    pub tentacled: String,

    #[serde(rename = "#\tTerminal escape codes")]
    pub terminal_escape_codes: String,

    #[serde(rename = "0.00")]
    pub the_000: String,

    #[serde(rename = "01000")]
    pub the_01000: String,

    #[serde(rename = "08")]
    pub the_08: String,

    #[serde(rename = "09")]
    pub the_09: String,

    #[serde(rename = "0xffffffffffffffff")]
    pub the_0_xffffffffffffffff: String,

    #[serde(rename = "\u{01f60d}")]
    pub the_1: String,

    #[serde(rename = "$1.00")]
    pub the_100: String,

    #[serde(rename = "1,0/0,0")]
    pub the_1000: String,

    #[serde(rename = "1 000.00")]
    pub the_100000: String,

    #[serde(rename = "1 000 000,00")]
    pub the_100000000: String,

    #[serde(rename = "1'; DROP TABLE users-- 1")]
    pub the_1_drop_table_users_1: String,

    #[serde(rename = "1#IND")]
    pub the_1_ind: String,

    #[serde(rename = "1#INF")]
    pub the_1_inf: String,

    #[serde(rename = "-2147483648/-1")]
    pub the_21474836481: String,

    #[serde(rename = "2.2250738585072011e-308")]
    pub the_22250738585072011_e_308: String,

    #[serde(rename = "# The next line may appear to be blank, mojibake, or dingbats in some viewers.")]
    pub the_next_line_may_appear_to_be_blank_mojibake_or_dingbats_in_some_viewers: String,

    #[serde(rename = "# The next line may appear to be blank or mojibake in some viewers.")]
    pub the_next_line_may_appear_to_be_blank_or_mojibake_in_some_viewers: String,

    #[serde(rename = "# The next line may be flagged for \"trailing whitespace\" in some viewers.")]
    pub the_next_line_may_be_flagged_for_trailing_whitespace_in_some_viewers: String,

    #[serde(rename = "# This file unfortunately cannot express strings containing")]
    pub this_file_unfortunately_cannot_express_strings_containing: String,

    #[serde(rename = "$(touch /tmp/blns.fail)")]
    pub touch_tmp_blns_fail: String,

    #[serde(rename = "() { _; } >_[$($())] { touch /tmp/blns.shellshock2.fail; }")]
    pub touch_tmp_blns_shellshock2_fail: String,

    #[serde(rename = "Tyson Gay")]
    pub tyson_gay: String,

    #[serde(rename = "#\tUnicode Symbols")]
    pub unicode_symbols: String,

    #[serde(rename = "'`\"><\\x00script>javascript:alert(1)</script>")]
    pub x00_script_javascript_alert_1_script: String,

    #[serde(rename = "'`\"><\\x3Cscript>javascript:alert(1)</script>")]
    pub x3_cscript_javascript_alert_1_script: String,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct C {
    #[serde(rename = "مُنَاقَشَةُ سُبُلِ اِسْتِخْدَامِ اللُّغَةِ فِي النُّظُمِ الْقَائِمَةِ وَفِيم يَخُصَّ التَّطْبِيقَاتُ الْحاسُوبِيَّةُ، ")]
    pub _1: String,

    #[serde(rename = "\u{02070e}\u{020731}\u{020779}\u{020c53}\u{020c78}\u{020c96}\u{020ccf}")]
    pub _12: String,

    #[serde(rename = "١٢٣")]
    pub _2: String,

    #[serde(rename = "울란바토르")]
    pub _7: String,

    #[serde(rename = "┬─┬ノ( º _ ºノ)")]
    pub _underscore: String,

    #[serde(rename = "A:")]
    pub a: String,

    #[serde(rename = "<a href=\"\\x00javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x00_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x03javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x03_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x06javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x06_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x07javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x07_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x0Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x0_bjavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x12javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x12_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x14javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x14_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x15javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x15_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x18javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x18_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x1Bjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x1_bjavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x1Cjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x1_cjavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\x20javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x20_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x85javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x85_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x88javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x88_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x89javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x89_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x80\\x8Ajavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x80_x8_ajavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE2\\x81\\x9Fjavascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e2_x81_x9_fjavascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "<a href=\"\\xE3\\x80\\x80javascript:javascript:alert(1)\" id=\"fuzzelement1\">test</a>")]
    pub a_href_x_e3_x80_x80_javascript_javascript_alert_1_id_fuzzelement1_test_a: String,

    #[serde(rename = "ABC<div style=\"x:expression\\x00(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_expression_x00_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\x00expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x00_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\x0Cexpression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x0_cexpression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x81expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x81_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x86expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x86_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE2\\x80\\x88expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e2_x80_x88_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xE3\\x80\\x80expression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_e3_x80_x80_expression_javascript_alert_1_def: String,

    #[serde(rename = "ABC<div style=\"x:\\xEF\\xBB\\xBFexpression(javascript:alert(1)\">DEF")]
    pub abc_div_style_x_x_ef_x_bb_x_b_fexpression_javascript_alert_1_def: String,

    #[serde(rename = ".")]
    pub ambitious: String,

    #[serde(rename = "# and U+007F (DEL)")]
    pub and_u_007_f_del: String,

    #[serde(rename = "# ASCII punctuation.  All of these characters may need to be escaped in some")]
    pub ascii_punctuation_all_of_these_characters_may_need_to_be_escaped_in_some: String,

    #[serde(rename = "<BODY onload!#$%&()*~+-_.,:;?@[/|\\]^`=alert(\"XSS\")>")]
    pub body_onload_alert_xss: String,

    #[serde(rename = "בְּרֵאשִׁית, בָּרָא אֱלֹהִים, אֵת הַשָּׁמַיִם, וְאֵת הָאָרֶץ")]
    pub braggadocious: String,

    #[serde(rename = "\"'\"'\"''''\"")]
    pub c: String,

    #[serde(rename = "-0.0")]
    pub c_00: String,

    #[serde(rename = "0.0/0")]
    pub c_000: String,

    #[serde(rename = "-1.00")]
    pub c_100: String,

    #[serde(rename = "1,000.00")]
    pub c_100000: String,

    #[serde(rename = "1,000,000.00")]
    pub c_100000000: String,

    #[serde(rename = "1E+02")]
    pub c_1_e_02: String,

    #[serde(rename = "><script>alert(123)</script>")]
    pub c_script_alert_123_script: String,

    #[serde(rename = "true")]
    pub c_true: String,

    #[serde(rename = "CLOCK$")]
    pub clock: String,

    #[serde(rename = "COM2")]
    pub com2: String,

    #[serde(rename = "COM4")]
    pub com4: String,

    #[serde(rename = "Craig Cockburn, Software Specialist")]
    pub craig_cockburn_software_specialist: String,

    #[serde(rename = "\\\\")]
    pub cunning: String,

    #[serde(rename = "DCC SEND STARTKEYLOGGER 0 0 0")]
    pub dcc_send_startkeylogger_000: String,

    pub dont_make_a_map: bool,

    #[serde(rename = "#\tEmoji")]
    pub emoji: String,

    #[serde(rename = "\"\"")]
    pub empty: String,

    pub evaluate: String,

    #[serde(rename = "%")]
    pub fluffy: String,

    #[serde(rename = "0/0")]
    pub fluffy_00: String,

    #[serde(rename = "<foo val=“bar” />")]
    pub foo_val_bar: String,

    #[serde(rename = "ÅÍÎÏ˝ÓÔ\u{f8ff}ÒÚÆ☃")]
    pub frisky: String,

    #[serde(rename = "̗̺͖̹̯͓Ṯ̤͍̥͇͈h̲́e͏͓̼̗̙̼̣͔ ͇̜̱̠͓͍ͅN͕͠e̗̱z̘̝̜̺͙p̤̺̹͍̯͚e̠̻̠͜r̨̤͍̺̖͔̖̖d̠̟̭̬̝͟i̦͖̩͓͔̤a̠̗̬͉̙n͚͜ ̻̞̰͚ͅh̵͉i̳̞v̢͇ḙ͎͟-҉̭̩̼͔m̤̭̫i͕͇̝̦n̗͙ḍ̟ ̯̲͕͞ǫ̟̯̰̲͙̻̝f ̪̰̰̗̖̭̘͘c̦͍̲̞͍̩̙ḥ͚a̮͎̟̙͜ơ̩̹͎s̤.̝̝ ҉Z̡̖̜͖̰̣͉̜a͖̰͙̬͡l̲̫̳͍̩g̡̟̼̱͚̞̬ͅo̗͜.̟")]
    pub h_e_n_e_z_p_e_r_d_i_a_n_h_i_v_m_i_n_f_c_a_s_z_a_l_g_o: String,

    pub has_own_property: String,

    #[serde(rename = "--")]
    pub hilarious: String,

    #[serde(rename = "Horniman Museum")]
    pub horniman_museum: String,

    #[serde(rename = "http://www.cum.qc.ca/")]
    pub http_www_cum_qc_ca: String,

    #[serde(rename = "<i onwheel=alert(1)> Scroll over me </i>")]
    pub i_onwheel_alert_1_scroll_over_me_i: String,

    #[serde(rename = "<img[a][b][c]src[d]=x[e]onerror=[f]\"alert(1)\">")]
    pub img_a_b_c_src_d_x_e_onerror_f_alert_1: String,

    #[serde(rename = "<IMG onmouseover=\"alert('xxs')\">")]
    pub img_onmouseover_alert_xxs: String,

    #[serde(rename = "<IMG \"\"\"><SCRIPT>alert(\"XSS\")</SCRIPT>\">")]
    pub img_script_alert_xss_script: String,

    #[serde(rename = "<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>")]
    pub img_src_javascript_alert_string_from_char_code_888383: String,

    #[serde(rename = "<IMG SRC=\"javascript:alert('XSS')\"")]
    pub img_src_javascript_alert_xss: String,

    #[serde(rename = "<img src onerror /\" '\"= alt=javascript:alert(1)//\">")]
    pub img_src_onerror_alt_javascript_alert_1: String,

    #[serde(rename = "<img src\\x10=x onerror=\"javascript:alert(1)\">")]
    pub img_src_x10_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src\\x12=x onerror=\"javascript:alert(1)\">")]
    pub img_src_x12_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src\\x13=x onerror=\"javascript:alert(1)\">")]
    pub img_src_x13_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src\\x32=x onerror=\"javascript:alert(1)\">")]
    pub img_src_x32_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src\\x47=x onerror=\"javascript:alert(1)\">")]
    pub img_src_x47_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img src=x onerror=alert(123) />")]
    pub img_src_x_onerror_alert_123: String,

    #[serde(rename = "<img src=x onerror=\\x10\"javascript:alert(1)\">")]
    pub img_src_x_onerror_x10_javascript_alert_1: String,

    #[serde(rename = "<img src=x onerror=\\x32\"javascript:alert(1)\">")]
    pub img_src_x_onerror_x32_javascript_alert_1: String,

    #[serde(rename = "<img src=\"x` `<script>javascript:alert(1)</script>\"` `>")]
    pub img_src_x_script_javascript_alert_1_script: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x09onerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x09_onerror_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x20onerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x20_onerror_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x22onerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x22_onerror_javascript_alert_1: String,

    #[serde(rename = "`\"'><img src=xxx:x \\x27onerror=javascript:alert(1)>")]
    pub img_src_xxx_x_x27_onerror_javascript_alert_1: String,

    #[serde(rename = "<img\\x11src=x onerror=\"javascript:alert(1)\">")]
    pub img_x11_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img \\x34src=x onerror=\"javascript:alert(1)\">")]
    pub img_x34_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "<img\\x47src=x onerror=\"javascript:alert(1)\">")]
    pub img_x47_src_x_onerror_javascript_alert_1: String,

    #[serde(rename = "-")]
    pub indecent: String,

    #[serde(rename = ",。・:*:・゜’( ☻ ω ☻ )。・:*:・゜’")]
    pub indigo: String,

    #[serde(rename = "Infinity")]
    pub infinity: String,

    #[serde(rename = "JavaSCript:alert(123)")]
    pub java_s_cript_alert_123: String,

    #[serde(rename = "LPT1")]
    pub lpt1: String,

    #[serde(rename = "&lt;script&gt;alert(&#39;123&#39;);&lt;/script&gt;")]
    pub lt_script_gt_alert_3912339_lt_script_gt: String,

    #[serde(rename = "_")]
    pub magenta: String,

    #[serde(rename = "magna cum laude")]
    pub magna_cum_laude: String,

    #[serde(rename = "medieval erection of parapets")]
    pub medieval_erection_of_parapets: String,

    #[serde(rename = "ЁЂЃЄЅІЇЈЉЊЋЌЍЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя")]
    pub mischievous: String,

    pub mocha: String,

    #[serde(rename = "NaN")]
    pub na_n: String,

    #[serde(rename = "# Non-whitespace C0 controls: U+0001 through U+0008, U+000E through U+001F,")]
    pub non_whitespace_c0_controls_u_0001_through_u_0008_u_000_e_through_u_001_f: String,

    #[serde(rename = "NULL")]
    pub null: String,

    #[serde(rename = "' onfocus=JaVaSCript:alert(123) autofocus")]
    pub onfocus_ja_va_s_cript_alert_123_autofocus: String,

    #[serde(rename = "# or reused for internal delimiters on the theory that they should never")]
    pub or_reused_for_internal_delimiters_on_the_theory_that_they_should_never: String,

    #[serde(rename = "<plaintext>")]
    pub plaintext: String,

    #[serde(rename = "Powerلُلُصّبُلُلصّبُررً ॣ ॣh ॣ ॣ冗")]
    pub power_h: String,

    #[serde(rename = "\"''''\"'\"")]
    pub purple: String,

    #[serde(rename = "0,,0")]
    pub purple_00: String,

    #[serde(rename = "1.000,00")]
    pub purple_100000: String,

    #[serde(rename = "1.000.000,00")]
    pub purple_100000000: String,

    #[serde(rename = "＜script＞alert(123)＜/script＞")]
    pub purple_script_alert_123_script: String,

    #[serde(rename = "#\tRight-To-Left Strings")]
    pub right_to_left_strings: String,

    #[serde(rename = "Roses are \u{001b}[0;31mred\u{001b}[0m, violets are \u{001b}[0;34mblue. Hope you enjoy terminal hue")]
    pub roses_are_031_mred_0_m_violets_are_034_mblue_hope_you_enjoy_terminal_hue: String,

    #[serde(rename = "%*.*s")]
    pub s: String,

    #[serde(rename = "'><script>alert(123)</script>")]
    pub script_alert_123_script: String,

    #[serde(rename = "'><script>alert(123);</script x='")]
    pub script_alert_123_script_x: String,

    #[serde(rename = "\"`'><script>-javascript:alert(1)</script>")]
    pub script_javascript_alert_1_script: String,

    #[serde(rename = "< / script >< script >alert(123)< / script >")]
    pub script_script_alert_123_script: String,

    #[serde(rename = "<script src=\"/\\%(jscript)s\"></script>")]
    pub script_src_jscript_s_script: String,

    #[serde(rename = "\"`'><script>\\x0Ajavascript:alert(1)</script>")]
    pub script_x0_ajavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\x0Bjavascript:alert(1)</script>")]
    pub script_x0_bjavascript_alert_1_script: String,

    #[serde(rename = "<script\\x0Ctype=\"text/javascript\">javascript:alert(1);</script>")]
    pub script_x0_ctype_text_javascript_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\x20javascript:alert(1)</script>")]
    pub script_x20_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\x2Bjavascript:alert(1)</script>")]
    pub script_x2_bjavascript_alert_1_script: String,

    #[serde(rename = "<script\\x2Ftype=\"text/javascript\">javascript:alert(1);</script>")]
    pub script_x2_ftype_text_javascript_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\x7Ejavascript:alert(1)</script>")]
    pub script_x7_ejavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x80javascript:alert(1)</script>")]
    pub script_x_e2_x80_x80_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x82javascript:alert(1)</script>")]
    pub script_x_e2_x80_x82_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x83javascript:alert(1)</script>")]
    pub script_x_e2_x80_x83_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x84javascript:alert(1)</script>")]
    pub script_x_e2_x80_x84_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x88javascript:alert(1)</script>")]
    pub script_x_e2_x80_x88_javascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xE2\\x80\\x8Bjavascript:alert(1)</script>")]
    pub script_x_e2_x80_x8_bjavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xEF\\xBF\\xAEjavascript:alert(1)</script>")]
    pub script_x_ef_x_bf_x_a_ejavascript_alert_1_script: String,

    #[serde(rename = "\"`'><script>\\xEF\\xBF\\xBEjavascript:alert(1)</script>")]
    pub script_x_ef_x_bf_x_b_ejavascript_alert_1_script: String,

    #[serde(rename = "Scunthorpe General Hospital")]
    pub scunthorpe_general_hospital: String,

    #[serde(rename = "#\tServer Code Injection")]
    pub server_code_injection: String,

    #[serde(rename = "shitake mushrooms")]
    pub shitake_mushrooms: String,

    #[serde(rename = "#\tSpecial Characters")]
    pub special_characters: String,

    #[serde(rename = "src=JaVaSCript:prompt(132)")]
    pub src_ja_va_s_cript_prompt_132: String,

    #[serde(rename = "(ﾉಥ益ಥ）ﾉ\u{feff} ┻━┻")]
    pub sticky: String,

    #[serde(rename = "#\tStrings which can be interpreted as numeric")]
    pub strings_which_can_be_interpreted_as_numeric: String,

    #[serde(rename = "#\tStrings which can cause a SQL injection if inputs are not sanitized")]
    pub strings_which_can_cause_a_sql_injection_if_inputs_are_not_sanitized: String,

    #[serde(rename = "#\tStrings which can cause user to pull in files that should not be a part of a web server")]
    pub strings_which_can_cause_user_to_pull_in_files_that_should_not_be_a_part_of_a_web_server: String,

    #[serde(rename = "#\tStrings which can cause user to run code on server as a privileged user (c.f. https://news.ycombinator.com/item?id=7665153)")]
    pub strings_which_can_cause_user_to_run_code_on_server_as_a_privileged_user_c_f_https_news_ycombinator_com_item_id_7665153: String,

    #[serde(rename = "#\tStrings which contain \"corrupted\" text. The corruption will not appear in non-HTML text, however. (via http://www.eeemo.net)")]
    pub strings_which_contain_corrupted_text_the_corruption_will_not_appear_in_non_html_text_however_via_http_www_eeemo_net: String,

    #[serde(rename = "#\tStrings which contain unicode with an \"upsidedown\" effect (via http://www.upsidedowntext.com)")]
    pub strings_which_contain_unicode_with_an_upsidedown_effect_via_http_www_upsidedowntext_com: String,

    #[serde(rename = "#\tStrings which contain unicode with unusual properties (e.g. Right-to-left override) (c.f. http://www.unicode.org/charts/PDF/U2000.pdf)")]
    pub strings_which_contain_unicode_with_unusual_properties_e_g_right_to_left_override_c_f_http_www_unicode_org_charts_pdf_u2000_pdf: String,

    #[serde(rename = "#\tStrings which punish the fools who use cat/type on this file")]
    pub strings_which_punish_the_fools_who_use_cat_type_on_this_file: String,

    #[serde(rename = "<svg><script>123<1>alert(123)</script>")]
    pub svg_script_1231_alert_123_script: String,

    #[serde(rename = "System(\"ls -al /\")")]
    pub system_ls_al: String,

    #[serde(rename = "@{[system \"touch /tmp/blns.fail\"]}")]
    pub system_touch_tmp_blns_fail: String,

    #[serde(rename = "''")]
    pub tentacled: String,

    #[serde(rename = "\u{2029}test\u{2029}")]
    pub test: String,

    #[serde(rename = "test\u{2060}test\u{202b}")]
    pub test_test: String,

    #[serde(rename = "\u{01f3f3}0\u{01f308}️")]
    pub the_0: String,

    #[serde(rename = "+0.0")]
    pub the_00: String,

    #[serde(rename = "0.0.0")]
    pub the_000: String,

    #[serde(rename = "0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ \u{01f51f}")]
    pub the_0123456789: String,

    #[serde(rename = "() { 0; }; touch /tmp/blns.shellshock1.fail;")]
    pub the_0_touch_tmp_blns_shellshock1_fail: String,

    #[serde(rename = "0xabad1dea")]
    pub the_0_xabad1_dea: String,

    #[serde(rename = "0xffffffff")]
    pub the_0_xffffffff: String,

    #[serde(rename = "--1")]
    pub the_1: String,

    #[serde(rename = "\u{01f435} \u{01f648} \u{01f649} \u{01f64a}")]
    pub the_10: String,

    #[serde(rename = "-$1.00")]
    pub the_100: String,

    #[serde(rename = "1 000,00")]
    pub the_100000: String,

    #[serde(rename = "1'000'000,00")]
    pub the_100000000: String,

    #[serde(rename = "\u{01f47e} \u{01f647} \u{01f481} \u{01f645} \u{01f646} \u{01f64b} \u{01f64e} \u{01f64d}")]
    pub the_11: String,

    #[serde(rename = "-1/2")]
    pub the_12: String,

    #[serde(rename = "Ｔｈｅ ｑｕｉｃｋ ｂｒｏｗｎ ｆｏｘ ｊｕｍｐｓ ｏｖｅｒ ｔｈｅ ｌａｚｙ ｄｏｇ")]
    pub the_13: String,

    #[serde(rename = "-1E2")]
    pub the_1_e2: String,

    #[serde(rename = "-1E+02")]
    pub the_1_e_02: String,

    #[serde(rename = "-1#IND")]
    pub the_1_ind: String,

    #[serde(rename = "⁰⁴⁵")]
    pub the_3: String,

    #[serde(rename = "⅛⅜⅝⅞")]
    pub the_4: String,

    #[serde(rename = "✋\u{01f3ff} \u{01f4aa}\u{01f3ff} \u{01f450}\u{01f3ff} \u{01f64c}\u{01f3ff} \u{01f44f}\u{01f3ff} \u{01f64f}\u{01f3ff}")]
    pub the_5: String,

    #[serde(rename = "・(￣∀￣)・:*:")]
    pub the_6: String,

    #[serde(rename = "\u{01d413}\u{01d421}\u{01d41e} \u{01d42a}\u{01d42e}\u{01d422}\u{01d41c}\u{01d424} \u{01d41b}\u{01d42b}\u{01d428}\u{01d430}\u{01d427} \u{01d41f}\u{01d428}\u{01d431} \u{01d423}\u{01d42e}\u{01d426}\u{01d429}\u{01d42c} \u{01d428}\u{01d42f}\u{01d41e}\u{01d42b} \u{01d42d}\u{01d421}\u{01d41e} \u{01d425}\u{01d41a}\u{01d433}\u{01d432} \u{01d41d}\u{01d428}\u{01d420}")]
    pub the_8: String,

    #[serde(rename = "\u{01d683}\u{01d691}\u{01d68e} \u{01d69a}\u{01d69e}\u{01d692}\u{01d68c}\u{01d694} \u{01d68b}\u{01d69b}\u{01d698}\u{01d6a0}\u{01d697} \u{01d68f}\u{01d698}\u{01d6a1} \u{01d693}\u{01d69e}\u{01d696}\u{01d699}\u{01d69c} \u{01d698}\u{01d69f}\u{01d68e}\u{01d69b} \u{01d69d}\u{01d691}\u{01d68e} \u{01d695}\u{01d68a}\u{01d6a3}\u{01d6a2} \u{01d68d}\u{01d698}\u{01d690}")]
    pub the_9: String,

    #[serde(rename = "-9223372036854775808/-1")]
    pub the_92233720368547758081: String,

    #[serde(rename = "<title onpropertychange=javascript:alert(1)></title><title title=>")]
    pub title_onpropertychange_javascript_alert_1_title_title_title: String,

    #[serde(rename = "# treated as whitespace in some contexts.")]
    pub treated_as_whitespace_in_some_contexts: String,

    #[serde(rename = "#\tTrick Unicode")]
    pub trick_unicode: String,

    pub undefined: String,

    #[serde(rename = "# Unicode additional control characters: all of the characters with")]
    pub unicode_additional_control_characters_all_of_the_characters_with: String,

    #[serde(rename = "#\tUnicode Subscript/Superscript/Accents")]
    pub unicode_subscript_superscript_accents: String,

    #[serde(rename = "#\tUnicode Upsidedown")]
    pub unicode_upsidedown: String,

    #[serde(rename = "$USER")]
    pub user: String,

    #[serde(rename = "--version")]
    pub version: String,

    #[serde(rename = "# version 8.0.0), plus U+0009 (HT), U+000B (VT), U+000C (FF), U+0085 (NEL),")]
    pub version_800_plus_u_0009_ht_u_000_b_vt_u_000_c_ff_u_0085_nel: String,

    #[serde(rename = "# Whitespace: all of the characters with category Zs, Zl, or Zp (in Unicode")]
    pub whitespace_all_of_the_characters_with_category_zs_zl_or_zp_in_unicode: String,

    #[serde(rename = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><!DOCTYPE foo [ <!ELEMENT foo ANY ><!ENTITY xxe SYSTEM \"file:///etc/passwd\" >]><foo>&xxe;</foo>")]
    pub xml_version_10_encoding_iso_88591_doctype_foo_element_foo_any_entity_xxe_system_file_etc_passwd_foo_xxe_foo: String,

    #[serde(rename = "#      XXE Injection (XML)")]
    pub xxe_injection_xml: String,

    #[serde(rename = "#\tZalgo Text")]
    pub zalgo_text: String,

    #[serde(rename = "ZZ:")]
    pub zz: String,
}
