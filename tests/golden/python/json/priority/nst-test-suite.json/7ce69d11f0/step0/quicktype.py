from dataclasses import dataclass
from typing import Any, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def from_float(x: Any) -> float:
    assert isinstance(x, (float, int)) and not isinstance(x, bool)
    return float(x)


def to_float(x: Any) -> float:
    assert isinstance(x, (int, float))
    return x


def from_list(f: Callable[[Any], T], x: Any) -> list[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


def from_bool(x: Any) -> bool:
    assert isinstance(x, bool)
    return x


def from_none(x: Any) -> Any:
    assert x is None
    return x


def from_union(fs, x):
    for f in fs:
        try:
            return f(x)
        except:
            pass
    assert False


def is_type(t: Type[T], x: Any) -> T:
    assert isinstance(x, t)
    return x


@dataclass
class JSON:
    pass

    @staticmethod
    def from_dict(obj: Any) -> 'JSON':
        assert isinstance(obj, dict)
        return JSON()

    def to_dict(self) -> dict:
        result: dict = {}
        return result


@dataclass
class YObjectBasicJSON:
    asd: str

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectBasicJSON':
        assert isinstance(obj, dict)
        asd = from_str(obj["asd"])
        return YObjectBasicJSON(asd)

    def to_dict(self) -> dict:
        result: dict = {}
        result["asd"] = from_str(self.asd)
        return result


@dataclass
class YObjectEmptyKeyJSON:
    empty: int

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectEmptyKeyJSON':
        assert isinstance(obj, dict)
        empty = from_int(obj[""])
        return YObjectEmptyKeyJSON(empty)

    def to_dict(self) -> dict:
        result: dict = {}
        result[""] = from_int(self.empty)
        return result


@dataclass
class YObjectEscapedNullInKeyJSON:
    foo_bar: int

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectEscapedNullInKeyJSON':
        assert isinstance(obj, dict)
        foo_bar = from_int(obj["foo\u0000bar"])
        return YObjectEscapedNullInKeyJSON(foo_bar)

    def to_dict(self) -> dict:
        result: dict = {}
        result["foo\u0000bar"] = from_int(self.foo_bar)
        return result


@dataclass
class YObjectExtremeNumbersJSON:
    max: float
    min: float

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectExtremeNumbersJSON':
        assert isinstance(obj, dict)
        max = from_float(obj["max"])
        min = from_float(obj["min"])
        return YObjectExtremeNumbersJSON(max, min)

    def to_dict(self) -> dict:
        result: dict = {}
        result["max"] = to_float(self.max)
        result["min"] = to_float(self.min)
        return result


@dataclass
class YObjectJSON:
    asd: str
    dfg: str

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectJSON':
        assert isinstance(obj, dict)
        asd = from_str(obj["asd"])
        dfg = from_str(obj["dfg"])
        return YObjectJSON(asd, dfg)

    def to_dict(self) -> dict:
        result: dict = {}
        result["asd"] = from_str(self.asd)
        result["dfg"] = from_str(self.dfg)
        return result


@dataclass
class X:
    id: str

    @staticmethod
    def from_dict(obj: Any) -> 'X':
        assert isinstance(obj, dict)
        id = from_str(obj["id"])
        return X(id)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_str(self.id)
        return result


@dataclass
class YObjectLongStringsJSON:
    id: str
    x: list[X]

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectLongStringsJSON':
        assert isinstance(obj, dict)
        id = from_str(obj["id"])
        x = from_list(X.from_dict, obj["x"])
        return YObjectLongStringsJSON(id, x)

    def to_dict(self) -> dict:
        result: dict = {}
        result["id"] = from_str(self.id)
        result["x"] = from_list(lambda x: to_class(X, x), self.x)
        return result


@dataclass
class YObjectSimpleJSON:
    a: list[Any]

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectSimpleJSON':
        assert isinstance(obj, dict)
        a = from_list(lambda x: x, obj["a"])
        return YObjectSimpleJSON(a)

    def to_dict(self) -> dict:
        result: dict = {}
        result["a"] = from_list(lambda x: x, self.a)
        return result


@dataclass
class YObjectStringUnicodeJSON:
    title: str

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectStringUnicodeJSON':
        assert isinstance(obj, dict)
        title = from_str(obj["title"])
        return YObjectStringUnicodeJSON(title)

    def to_dict(self) -> dict:
        result: dict = {}
        result["title"] = from_str(self.title)
        return result


@dataclass
class YObjectWithNewlinesJSON:
    a: str

    @staticmethod
    def from_dict(obj: Any) -> 'YObjectWithNewlinesJSON':
        assert isinstance(obj, dict)
        a = from_str(obj["a"])
        return YObjectWithNewlinesJSON(a)

    def to_dict(self) -> dict:
        result: dict = {}
        result["a"] = from_str(self.a)
        return result


@dataclass
class TopLevel:
    y_array_arrays_with_spaces_json: list[list[Any]]
    y_array_empty_string_json: list[str]
    y_array_empty_json: list[Any]
    y_array_ending_with_newline_json: list[str]
    y_array_false_json: list[bool]
    y_array_heterogeneous_json: list[JSON | int | None]
    y_array_null_json: list[None]
    y_array_with_1__and_newline_json: list[int]
    y_array_with_leading_space_json: list[int]
    y_array_with_several_null_json: list[int | None]
    y_array_with_trailing_space_json: list[int]
    y_number_json: list[float]
    y_number_0_e_1_json: list[float]
    y_number_0_e1_json: list[float]
    y_number_after_space_json: list[int]
    y_number_double_close_to_zero_json: list[float]
    y_number_int_with_exp_json: list[float]
    y_number_minus_zero_json: list[int]
    y_number_negative_int_json: list[int]
    y_number_negative_one_json: list[int]
    y_number_negative_zero_json: list[int]
    y_number_real_capital_e_json: list[float]
    y_number_real_capital_e_neg_exp_json: list[float]
    y_number_real_capital_e_pos_exp_json: list[float]
    y_number_real_exponent_json: list[float]
    y_number_real_fraction_exponent_json: list[float]
    y_number_real_neg_exp_json: list[float]
    y_number_real_pos_exponent_json: list[float]
    y_number_simple_int_json: list[int]
    y_number_simple_real_json: list[float]
    y_object_json: YObjectJSON
    y_object_basic_json: YObjectBasicJSON
    y_object_empty_json: JSON
    y_object_empty_key_json: YObjectEmptyKeyJSON
    y_object_escaped_null_in_key_json: YObjectEscapedNullInKeyJSON
    y_object_extreme_numbers_json: YObjectExtremeNumbersJSON
    y_object_long_strings_json: YObjectLongStringsJSON
    y_object_simple_json: YObjectSimpleJSON
    y_object_string_unicode_json: YObjectStringUnicodeJSON
    y_object_with_newlines_json: YObjectWithNewlinesJSON
    y_string_1_2_3__bytes_utf_8__sequences_json: list[str]
    y_string_accepted_surrogate_pair_json: list[str]
    y_string_accepted_surrogate_pairs_json: list[str]
    y_string_allowed_escapes_json: list[str]
    y_string_backslash_and_u_escaped_zero_json: list[str]
    y_string_backslash_doublequotes_json: list[str]
    y_string_comments_json: list[str]
    y_string_double_escape_a_json: list[str]
    y_string_double_escape_n_json: list[str]
    y_string_escaped_control_character_json: list[str]
    y_string_escaped_noncharacter_json: list[str]
    y_string_in_array_json: list[str]
    y_string_in_array_with_leading_space_json: list[str]
    y_string_last_surrogates_1__and_2_json: list[str]
    y_string_nbsp_uescaped_json: list[str]
    y_string_non_character_in_utf_8__u_10_ffff_json: list[str]
    y_string_non_character_in_utf_8__u_1_ffff_json: list[str]
    y_string_non_character_in_utf_8__u_ffff_json: list[str]
    y_string_null_escape_json: list[str]
    y_string_one_byte_utf_8_json: list[str]
    y_string_pi_json: list[str]
    y_string_simple_ascii_json: list[str]
    y_string_space_json: str
    y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json: list[str]
    y_string_three_byte_utf_8_json: list[str]
    y_string_two_byte_utf_8_json: list[str]
    y_string_u_2028__line_sep_json: list[str]
    y_string_u_2029__par_sep_json: list[str]
    y_string_u_escape_json: list[str]
    y_string_uescaped_newline_json: list[str]
    y_string_unescaped_char_delete_json: list[str]
    y_string_unicode_json: list[str]
    y_string_unicode_escaped_backslash_json: list[str]
    y_string_unicode_2_json: list[str]
    y_string_unicode_u_10_fffe_nonchar_json: list[str]
    y_string_unicode_u_1_fffe_nonchar_json: list[str]
    y_string_unicode_u_200_b_zero_width_space_json: list[str]
    y_string_unicode_u_2064__invisible_plus_json: list[str]
    y_string_unicode_u_fdd0_nonchar_json: list[str]
    y_string_unicode_u_fffe_nonchar_json: list[str]
    y_string_unicode_escaped_double_quote_json: list[str]
    y_string_utf8_json: list[str]
    y_string_with_del_character_json: list[str]
    y_structure_lonely_false_json: bool
    y_structure_lonely_int_json: int
    y_structure_lonely_negative_real_json: float
    y_structure_lonely_string_json: str
    y_structure_lonely_true_json: bool
    y_structure_string_empty_json: str
    y_structure_trailing_newline_json: list[str]
    y_structure_true_in_array_json: list[bool]
    y_structure_whitespace_array_json: list[Any]
    y_structure_lonely_null_json: None

    @staticmethod
    def from_dict(obj: Any) -> 'TopLevel':
        assert isinstance(obj, dict)
        y_array_arrays_with_spaces_json = from_list(lambda x: from_list(lambda x: x, x), obj["y_array_arraysWithSpaces.json"])
        y_array_empty_string_json = from_list(from_str, obj["y_array_empty-string.json"])
        y_array_empty_json = from_list(lambda x: x, obj["y_array_empty.json"])
        y_array_ending_with_newline_json = from_list(from_str, obj["y_array_ending_with_newline.json"])
        y_array_false_json = from_list(from_bool, obj["y_array_false.json"])
        y_array_heterogeneous_json = from_list(lambda x: from_union([from_none, from_int, lambda x: int(from_str(x)), JSON.from_dict], x), obj["y_array_heterogeneous.json"])
        y_array_null_json = from_list(from_none, obj["y_array_null.json"])
        y_array_with_1__and_newline_json = from_list(from_int, obj["y_array_with_1_and_newline.json"])
        y_array_with_leading_space_json = from_list(from_int, obj["y_array_with_leading_space.json"])
        y_array_with_several_null_json = from_list(lambda x: from_union([from_int, from_none], x), obj["y_array_with_several_null.json"])
        y_array_with_trailing_space_json = from_list(from_int, obj["y_array_with_trailing_space.json"])
        y_number_json = from_list(from_float, obj["y_number.json"])
        y_number_0_e_1_json = from_list(from_float, obj["y_number_0e+1.json"])
        y_number_0_e1_json = from_list(from_float, obj["y_number_0e1.json"])
        y_number_after_space_json = from_list(from_int, obj["y_number_after_space.json"])
        y_number_double_close_to_zero_json = from_list(from_float, obj["y_number_double_close_to_zero.json"])
        y_number_int_with_exp_json = from_list(from_float, obj["y_number_int_with_exp.json"])
        y_number_minus_zero_json = from_list(from_int, obj["y_number_minus_zero.json"])
        y_number_negative_int_json = from_list(from_int, obj["y_number_negative_int.json"])
        y_number_negative_one_json = from_list(from_int, obj["y_number_negative_one.json"])
        y_number_negative_zero_json = from_list(from_int, obj["y_number_negative_zero.json"])
        y_number_real_capital_e_json = from_list(from_float, obj["y_number_real_capital_e.json"])
        y_number_real_capital_e_neg_exp_json = from_list(from_float, obj["y_number_real_capital_e_neg_exp.json"])
        y_number_real_capital_e_pos_exp_json = from_list(from_float, obj["y_number_real_capital_e_pos_exp.json"])
        y_number_real_exponent_json = from_list(from_float, obj["y_number_real_exponent.json"])
        y_number_real_fraction_exponent_json = from_list(from_float, obj["y_number_real_fraction_exponent.json"])
        y_number_real_neg_exp_json = from_list(from_float, obj["y_number_real_neg_exp.json"])
        y_number_real_pos_exponent_json = from_list(from_float, obj["y_number_real_pos_exponent.json"])
        y_number_simple_int_json = from_list(from_int, obj["y_number_simple_int.json"])
        y_number_simple_real_json = from_list(from_float, obj["y_number_simple_real.json"])
        y_object_json = YObjectJSON.from_dict(obj["y_object.json"])
        y_object_basic_json = YObjectBasicJSON.from_dict(obj["y_object_basic.json"])
        y_object_empty_json = JSON.from_dict(obj["y_object_empty.json"])
        y_object_empty_key_json = YObjectEmptyKeyJSON.from_dict(obj["y_object_empty_key.json"])
        y_object_escaped_null_in_key_json = YObjectEscapedNullInKeyJSON.from_dict(obj["y_object_escaped_null_in_key.json"])
        y_object_extreme_numbers_json = YObjectExtremeNumbersJSON.from_dict(obj["y_object_extreme_numbers.json"])
        y_object_long_strings_json = YObjectLongStringsJSON.from_dict(obj["y_object_long_strings.json"])
        y_object_simple_json = YObjectSimpleJSON.from_dict(obj["y_object_simple.json"])
        y_object_string_unicode_json = YObjectStringUnicodeJSON.from_dict(obj["y_object_string_unicode.json"])
        y_object_with_newlines_json = YObjectWithNewlinesJSON.from_dict(obj["y_object_with_newlines.json"])
        y_string_1_2_3__bytes_utf_8__sequences_json = from_list(from_str, obj["y_string_1_2_3_bytes_UTF-8_sequences.json"])
        y_string_accepted_surrogate_pair_json = from_list(from_str, obj["y_string_accepted_surrogate_pair.json"])
        y_string_accepted_surrogate_pairs_json = from_list(from_str, obj["y_string_accepted_surrogate_pairs.json"])
        y_string_allowed_escapes_json = from_list(from_str, obj["y_string_allowed_escapes.json"])
        y_string_backslash_and_u_escaped_zero_json = from_list(from_str, obj["y_string_backslash_and_u_escaped_zero.json"])
        y_string_backslash_doublequotes_json = from_list(from_str, obj["y_string_backslash_doublequotes.json"])
        y_string_comments_json = from_list(from_str, obj["y_string_comments.json"])
        y_string_double_escape_a_json = from_list(from_str, obj["y_string_double_escape_a.json"])
        y_string_double_escape_n_json = from_list(from_str, obj["y_string_double_escape_n.json"])
        y_string_escaped_control_character_json = from_list(from_str, obj["y_string_escaped_control_character.json"])
        y_string_escaped_noncharacter_json = from_list(from_str, obj["y_string_escaped_noncharacter.json"])
        y_string_in_array_json = from_list(from_str, obj["y_string_in_array.json"])
        y_string_in_array_with_leading_space_json = from_list(from_str, obj["y_string_in_array_with_leading_space.json"])
        y_string_last_surrogates_1__and_2_json = from_list(from_str, obj["y_string_last_surrogates_1_and_2.json"])
        y_string_nbsp_uescaped_json = from_list(from_str, obj["y_string_nbsp_uescaped.json"])
        y_string_non_character_in_utf_8__u_10_ffff_json = from_list(from_str, obj["y_string_nonCharacterInUTF-8_U+10FFFF.json"])
        y_string_non_character_in_utf_8__u_1_ffff_json = from_list(from_str, obj["y_string_nonCharacterInUTF-8_U+1FFFF.json"])
        y_string_non_character_in_utf_8__u_ffff_json = from_list(from_str, obj["y_string_nonCharacterInUTF-8_U+FFFF.json"])
        y_string_null_escape_json = from_list(from_str, obj["y_string_null_escape.json"])
        y_string_one_byte_utf_8_json = from_list(from_str, obj["y_string_one-byte-utf-8.json"])
        y_string_pi_json = from_list(from_str, obj["y_string_pi.json"])
        y_string_simple_ascii_json = from_list(from_str, obj["y_string_simple_ascii.json"])
        y_string_space_json = from_str(obj["y_string_space.json"])
        y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json = from_list(from_str, obj["y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json"])
        y_string_three_byte_utf_8_json = from_list(from_str, obj["y_string_three-byte-utf-8.json"])
        y_string_two_byte_utf_8_json = from_list(from_str, obj["y_string_two-byte-utf-8.json"])
        y_string_u_2028__line_sep_json = from_list(from_str, obj["y_string_u+2028_line_sep.json"])
        y_string_u_2029__par_sep_json = from_list(from_str, obj["y_string_u+2029_par_sep.json"])
        y_string_u_escape_json = from_list(from_str, obj["y_string_uEscape.json"])
        y_string_uescaped_newline_json = from_list(from_str, obj["y_string_uescaped_newline.json"])
        y_string_unescaped_char_delete_json = from_list(from_str, obj["y_string_unescaped_char_delete.json"])
        y_string_unicode_json = from_list(from_str, obj["y_string_unicode.json"])
        y_string_unicode_escaped_backslash_json = from_list(from_str, obj["y_string_unicodeEscapedBackslash.json"])
        y_string_unicode_2_json = from_list(from_str, obj["y_string_unicode_2.json"])
        y_string_unicode_u_10_fffe_nonchar_json = from_list(from_str, obj["y_string_unicode_U+10FFFE_nonchar.json"])
        y_string_unicode_u_1_fffe_nonchar_json = from_list(from_str, obj["y_string_unicode_U+1FFFE_nonchar.json"])
        y_string_unicode_u_200_b_zero_width_space_json = from_list(from_str, obj["y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json"])
        y_string_unicode_u_2064__invisible_plus_json = from_list(from_str, obj["y_string_unicode_U+2064_invisible_plus.json"])
        y_string_unicode_u_fdd0_nonchar_json = from_list(from_str, obj["y_string_unicode_U+FDD0_nonchar.json"])
        y_string_unicode_u_fffe_nonchar_json = from_list(from_str, obj["y_string_unicode_U+FFFE_nonchar.json"])
        y_string_unicode_escaped_double_quote_json = from_list(from_str, obj["y_string_unicode_escaped_double_quote.json"])
        y_string_utf8_json = from_list(from_str, obj["y_string_utf8.json"])
        y_string_with_del_character_json = from_list(from_str, obj["y_string_with_del_character.json"])
        y_structure_lonely_false_json = from_bool(obj["y_structure_lonely_false.json"])
        y_structure_lonely_int_json = from_int(obj["y_structure_lonely_int.json"])
        y_structure_lonely_negative_real_json = from_float(obj["y_structure_lonely_negative_real.json"])
        y_structure_lonely_string_json = from_str(obj["y_structure_lonely_string.json"])
        y_structure_lonely_true_json = from_bool(obj["y_structure_lonely_true.json"])
        y_structure_string_empty_json = from_str(obj["y_structure_string_empty.json"])
        y_structure_trailing_newline_json = from_list(from_str, obj["y_structure_trailing_newline.json"])
        y_structure_true_in_array_json = from_list(from_bool, obj["y_structure_true_in_array.json"])
        y_structure_whitespace_array_json = from_list(lambda x: x, obj["y_structure_whitespace_array.json"])
        y_structure_lonely_null_json = from_none(obj["y_structure_lonely_null.json"])
        return TopLevel(y_array_arrays_with_spaces_json, y_array_empty_string_json, y_array_empty_json, y_array_ending_with_newline_json, y_array_false_json, y_array_heterogeneous_json, y_array_null_json, y_array_with_1__and_newline_json, y_array_with_leading_space_json, y_array_with_several_null_json, y_array_with_trailing_space_json, y_number_json, y_number_0_e_1_json, y_number_0_e1_json, y_number_after_space_json, y_number_double_close_to_zero_json, y_number_int_with_exp_json, y_number_minus_zero_json, y_number_negative_int_json, y_number_negative_one_json, y_number_negative_zero_json, y_number_real_capital_e_json, y_number_real_capital_e_neg_exp_json, y_number_real_capital_e_pos_exp_json, y_number_real_exponent_json, y_number_real_fraction_exponent_json, y_number_real_neg_exp_json, y_number_real_pos_exponent_json, y_number_simple_int_json, y_number_simple_real_json, y_object_json, y_object_basic_json, y_object_empty_json, y_object_empty_key_json, y_object_escaped_null_in_key_json, y_object_extreme_numbers_json, y_object_long_strings_json, y_object_simple_json, y_object_string_unicode_json, y_object_with_newlines_json, y_string_1_2_3__bytes_utf_8__sequences_json, y_string_accepted_surrogate_pair_json, y_string_accepted_surrogate_pairs_json, y_string_allowed_escapes_json, y_string_backslash_and_u_escaped_zero_json, y_string_backslash_doublequotes_json, y_string_comments_json, y_string_double_escape_a_json, y_string_double_escape_n_json, y_string_escaped_control_character_json, y_string_escaped_noncharacter_json, y_string_in_array_json, y_string_in_array_with_leading_space_json, y_string_last_surrogates_1__and_2_json, y_string_nbsp_uescaped_json, y_string_non_character_in_utf_8__u_10_ffff_json, y_string_non_character_in_utf_8__u_1_ffff_json, y_string_non_character_in_utf_8__u_ffff_json, y_string_null_escape_json, y_string_one_byte_utf_8_json, y_string_pi_json, y_string_simple_ascii_json, y_string_space_json, y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json, y_string_three_byte_utf_8_json, y_string_two_byte_utf_8_json, y_string_u_2028__line_sep_json, y_string_u_2029__par_sep_json, y_string_u_escape_json, y_string_uescaped_newline_json, y_string_unescaped_char_delete_json, y_string_unicode_json, y_string_unicode_escaped_backslash_json, y_string_unicode_2_json, y_string_unicode_u_10_fffe_nonchar_json, y_string_unicode_u_1_fffe_nonchar_json, y_string_unicode_u_200_b_zero_width_space_json, y_string_unicode_u_2064__invisible_plus_json, y_string_unicode_u_fdd0_nonchar_json, y_string_unicode_u_fffe_nonchar_json, y_string_unicode_escaped_double_quote_json, y_string_utf8_json, y_string_with_del_character_json, y_structure_lonely_false_json, y_structure_lonely_int_json, y_structure_lonely_negative_real_json, y_structure_lonely_string_json, y_structure_lonely_true_json, y_structure_string_empty_json, y_structure_trailing_newline_json, y_structure_true_in_array_json, y_structure_whitespace_array_json, y_structure_lonely_null_json)

    def to_dict(self) -> dict:
        result: dict = {}
        result["y_array_arraysWithSpaces.json"] = from_list(lambda x: from_list(lambda x: x, x), self.y_array_arrays_with_spaces_json)
        result["y_array_empty-string.json"] = from_list(from_str, self.y_array_empty_string_json)
        result["y_array_empty.json"] = from_list(lambda x: x, self.y_array_empty_json)
        result["y_array_ending_with_newline.json"] = from_list(from_str, self.y_array_ending_with_newline_json)
        result["y_array_false.json"] = from_list(from_bool, self.y_array_false_json)
        result["y_array_heterogeneous.json"] = from_list(lambda x: from_union([lambda x: from_none((lambda x: is_type(type(None), x))(x)), lambda x: from_int((lambda x: is_type(int, x))(x)), lambda x: to_class(JSON, (lambda x: is_type(JSON, x))(x))], x), self.y_array_heterogeneous_json)
        result["y_array_null.json"] = from_list(from_none, self.y_array_null_json)
        result["y_array_with_1_and_newline.json"] = from_list(from_int, self.y_array_with_1__and_newline_json)
        result["y_array_with_leading_space.json"] = from_list(from_int, self.y_array_with_leading_space_json)
        result["y_array_with_several_null.json"] = from_list(lambda x: from_union([from_int, from_none], x), self.y_array_with_several_null_json)
        result["y_array_with_trailing_space.json"] = from_list(from_int, self.y_array_with_trailing_space_json)
        result["y_number.json"] = from_list(to_float, self.y_number_json)
        result["y_number_0e+1.json"] = from_list(to_float, self.y_number_0_e_1_json)
        result["y_number_0e1.json"] = from_list(to_float, self.y_number_0_e1_json)
        result["y_number_after_space.json"] = from_list(from_int, self.y_number_after_space_json)
        result["y_number_double_close_to_zero.json"] = from_list(to_float, self.y_number_double_close_to_zero_json)
        result["y_number_int_with_exp.json"] = from_list(to_float, self.y_number_int_with_exp_json)
        result["y_number_minus_zero.json"] = from_list(from_int, self.y_number_minus_zero_json)
        result["y_number_negative_int.json"] = from_list(from_int, self.y_number_negative_int_json)
        result["y_number_negative_one.json"] = from_list(from_int, self.y_number_negative_one_json)
        result["y_number_negative_zero.json"] = from_list(from_int, self.y_number_negative_zero_json)
        result["y_number_real_capital_e.json"] = from_list(to_float, self.y_number_real_capital_e_json)
        result["y_number_real_capital_e_neg_exp.json"] = from_list(to_float, self.y_number_real_capital_e_neg_exp_json)
        result["y_number_real_capital_e_pos_exp.json"] = from_list(to_float, self.y_number_real_capital_e_pos_exp_json)
        result["y_number_real_exponent.json"] = from_list(to_float, self.y_number_real_exponent_json)
        result["y_number_real_fraction_exponent.json"] = from_list(to_float, self.y_number_real_fraction_exponent_json)
        result["y_number_real_neg_exp.json"] = from_list(to_float, self.y_number_real_neg_exp_json)
        result["y_number_real_pos_exponent.json"] = from_list(to_float, self.y_number_real_pos_exponent_json)
        result["y_number_simple_int.json"] = from_list(from_int, self.y_number_simple_int_json)
        result["y_number_simple_real.json"] = from_list(to_float, self.y_number_simple_real_json)
        result["y_object.json"] = to_class(YObjectJSON, self.y_object_json)
        result["y_object_basic.json"] = to_class(YObjectBasicJSON, self.y_object_basic_json)
        result["y_object_empty.json"] = to_class(JSON, self.y_object_empty_json)
        result["y_object_empty_key.json"] = to_class(YObjectEmptyKeyJSON, self.y_object_empty_key_json)
        result["y_object_escaped_null_in_key.json"] = to_class(YObjectEscapedNullInKeyJSON, self.y_object_escaped_null_in_key_json)
        result["y_object_extreme_numbers.json"] = to_class(YObjectExtremeNumbersJSON, self.y_object_extreme_numbers_json)
        result["y_object_long_strings.json"] = to_class(YObjectLongStringsJSON, self.y_object_long_strings_json)
        result["y_object_simple.json"] = to_class(YObjectSimpleJSON, self.y_object_simple_json)
        result["y_object_string_unicode.json"] = to_class(YObjectStringUnicodeJSON, self.y_object_string_unicode_json)
        result["y_object_with_newlines.json"] = to_class(YObjectWithNewlinesJSON, self.y_object_with_newlines_json)
        result["y_string_1_2_3_bytes_UTF-8_sequences.json"] = from_list(from_str, self.y_string_1_2_3__bytes_utf_8__sequences_json)
        result["y_string_accepted_surrogate_pair.json"] = from_list(from_str, self.y_string_accepted_surrogate_pair_json)
        result["y_string_accepted_surrogate_pairs.json"] = from_list(from_str, self.y_string_accepted_surrogate_pairs_json)
        result["y_string_allowed_escapes.json"] = from_list(from_str, self.y_string_allowed_escapes_json)
        result["y_string_backslash_and_u_escaped_zero.json"] = from_list(from_str, self.y_string_backslash_and_u_escaped_zero_json)
        result["y_string_backslash_doublequotes.json"] = from_list(from_str, self.y_string_backslash_doublequotes_json)
        result["y_string_comments.json"] = from_list(from_str, self.y_string_comments_json)
        result["y_string_double_escape_a.json"] = from_list(from_str, self.y_string_double_escape_a_json)
        result["y_string_double_escape_n.json"] = from_list(from_str, self.y_string_double_escape_n_json)
        result["y_string_escaped_control_character.json"] = from_list(from_str, self.y_string_escaped_control_character_json)
        result["y_string_escaped_noncharacter.json"] = from_list(from_str, self.y_string_escaped_noncharacter_json)
        result["y_string_in_array.json"] = from_list(from_str, self.y_string_in_array_json)
        result["y_string_in_array_with_leading_space.json"] = from_list(from_str, self.y_string_in_array_with_leading_space_json)
        result["y_string_last_surrogates_1_and_2.json"] = from_list(from_str, self.y_string_last_surrogates_1__and_2_json)
        result["y_string_nbsp_uescaped.json"] = from_list(from_str, self.y_string_nbsp_uescaped_json)
        result["y_string_nonCharacterInUTF-8_U+10FFFF.json"] = from_list(from_str, self.y_string_non_character_in_utf_8__u_10_ffff_json)
        result["y_string_nonCharacterInUTF-8_U+1FFFF.json"] = from_list(from_str, self.y_string_non_character_in_utf_8__u_1_ffff_json)
        result["y_string_nonCharacterInUTF-8_U+FFFF.json"] = from_list(from_str, self.y_string_non_character_in_utf_8__u_ffff_json)
        result["y_string_null_escape.json"] = from_list(from_str, self.y_string_null_escape_json)
        result["y_string_one-byte-utf-8.json"] = from_list(from_str, self.y_string_one_byte_utf_8_json)
        result["y_string_pi.json"] = from_list(from_str, self.y_string_pi_json)
        result["y_string_simple_ascii.json"] = from_list(from_str, self.y_string_simple_ascii_json)
        result["y_string_space.json"] = from_str(self.y_string_space_json)
        result["y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json"] = from_list(from_str, self.y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json)
        result["y_string_three-byte-utf-8.json"] = from_list(from_str, self.y_string_three_byte_utf_8_json)
        result["y_string_two-byte-utf-8.json"] = from_list(from_str, self.y_string_two_byte_utf_8_json)
        result["y_string_u+2028_line_sep.json"] = from_list(from_str, self.y_string_u_2028__line_sep_json)
        result["y_string_u+2029_par_sep.json"] = from_list(from_str, self.y_string_u_2029__par_sep_json)
        result["y_string_uEscape.json"] = from_list(from_str, self.y_string_u_escape_json)
        result["y_string_uescaped_newline.json"] = from_list(from_str, self.y_string_uescaped_newline_json)
        result["y_string_unescaped_char_delete.json"] = from_list(from_str, self.y_string_unescaped_char_delete_json)
        result["y_string_unicode.json"] = from_list(from_str, self.y_string_unicode_json)
        result["y_string_unicodeEscapedBackslash.json"] = from_list(from_str, self.y_string_unicode_escaped_backslash_json)
        result["y_string_unicode_2.json"] = from_list(from_str, self.y_string_unicode_2_json)
        result["y_string_unicode_U+10FFFE_nonchar.json"] = from_list(from_str, self.y_string_unicode_u_10_fffe_nonchar_json)
        result["y_string_unicode_U+1FFFE_nonchar.json"] = from_list(from_str, self.y_string_unicode_u_1_fffe_nonchar_json)
        result["y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json"] = from_list(from_str, self.y_string_unicode_u_200_b_zero_width_space_json)
        result["y_string_unicode_U+2064_invisible_plus.json"] = from_list(from_str, self.y_string_unicode_u_2064__invisible_plus_json)
        result["y_string_unicode_U+FDD0_nonchar.json"] = from_list(from_str, self.y_string_unicode_u_fdd0_nonchar_json)
        result["y_string_unicode_U+FFFE_nonchar.json"] = from_list(from_str, self.y_string_unicode_u_fffe_nonchar_json)
        result["y_string_unicode_escaped_double_quote.json"] = from_list(from_str, self.y_string_unicode_escaped_double_quote_json)
        result["y_string_utf8.json"] = from_list(from_str, self.y_string_utf8_json)
        result["y_string_with_del_character.json"] = from_list(from_str, self.y_string_with_del_character_json)
        result["y_structure_lonely_false.json"] = from_bool(self.y_structure_lonely_false_json)
        result["y_structure_lonely_int.json"] = from_int(self.y_structure_lonely_int_json)
        result["y_structure_lonely_negative_real.json"] = to_float(self.y_structure_lonely_negative_real_json)
        result["y_structure_lonely_string.json"] = from_str(self.y_structure_lonely_string_json)
        result["y_structure_lonely_true.json"] = from_bool(self.y_structure_lonely_true_json)
        result["y_structure_string_empty.json"] = from_str(self.y_structure_string_empty_json)
        result["y_structure_trailing_newline.json"] = from_list(from_str, self.y_structure_trailing_newline_json)
        result["y_structure_true_in_array.json"] = from_list(from_bool, self.y_structure_true_in_array_json)
        result["y_structure_whitespace_array.json"] = from_list(lambda x: x, self.y_structure_whitespace_array_json)
        result["y_structure_lonely_null.json"] = from_none(self.y_structure_lonely_null_json)
        return result


def top_level_from_dict(s: Any) -> TopLevel:
    return TopLevel.from_dict(s)


def top_level_to_dict(x: TopLevel) -> Any:
    return to_class(TopLevel, x)
