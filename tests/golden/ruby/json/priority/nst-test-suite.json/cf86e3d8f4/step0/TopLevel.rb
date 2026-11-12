# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.y_structure_whitespace_array_json.first
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class YObjectEmptyJSONClass < Dry::Struct

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YArrayHeterogeneousJSON < Dry::Struct
  attribute :integer,                   Types::Integer.optional
  attribute :null,                      Types::Nil.optional
  attribute :string,                    Types::String.optional
  attribute :y_object_empty_json_class, YObjectEmptyJSONClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, y_object_empty_json_class: nil, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, y_object_empty_json_class: nil, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, y_object_empty_json_class: nil, integer: nil, null: nil)
    end
    begin
      value = YObjectEmptyJSONClass.from_dynamic!(d)
      if schema.key(:y_object_empty_json_class).type.right.valid? value
        return new(y_object_empty_json_class: value, integer: nil, null: nil, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif string != nil
      string
    elsif y_object_empty_json_class != nil
      y_object_empty_json_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectBasicJSON < Dry::Struct
  attribute :asd, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      asd: d.fetch("asd"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "asd" => asd,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectEmptyKeyJSON < Dry::Struct
  attribute :empty, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      empty: d.fetch(""),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "" => empty,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectEscapedNullInKeyJSON < Dry::Struct
  attribute :foo_bar, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      foo_bar: d.fetch("foo\u{0}bar"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "foo\u{0}bar" => foo_bar,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectExtremeNumbersJSON < Dry::Struct
  attribute :max, Types::Double
  attribute :min, Types::Double

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      max: d.fetch("max"),
      min: d.fetch("min"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "max" => max,
      "min" => min,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectJSON < Dry::Struct
  attribute :asd, Types::String
  attribute :dfg, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      asd: d.fetch("asd"),
      dfg: d.fetch("dfg"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "asd" => asd,
      "dfg" => dfg,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class X < Dry::Struct
  attribute :id, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id: d.fetch("id"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id" => id,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectLongStringsJSON < Dry::Struct
  attribute :id, Types::String
  attribute :x,  Types.Array(X)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id: d.fetch("id"),
      x:  d.fetch("x").map { |x| X.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id" => id,
      "x"  => x.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectSimpleJSON < Dry::Struct
  attribute :a, Types.Array(Types::Any)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      a: d.fetch("a"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "a" => a,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectStringUnicodeJSON < Dry::Struct
  attribute :title, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      title: d.fetch("title"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "title" => title,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class YObjectWithNewlinesJSON < Dry::Struct
  attribute :a, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      a: d.fetch("a"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "a" => a,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :y_array_arrays_with_spaces_json,                          Types.Array(Types.Array(Types::Any))
  attribute :y_array_empty_json,                                       Types.Array(Types::Any)
  attribute :y_array_empty_string_json,                                Types.Array(Types::String)
  attribute :y_array_ending_with_newline_json,                         Types.Array(Types::String)
  attribute :y_array_false_json,                                       Types.Array(Types::Bool)
  attribute :y_array_heterogeneous_json,                               Types.Array(Types.Instance(YArrayHeterogeneousJSON))
  attribute :y_array_null_json,                                        Types.Array(Types::Nil)
  attribute :y_array_with_1__and_newline_json,                         Types.Array(Types::Integer)
  attribute :y_array_with_leading_space_json,                          Types.Array(Types::Integer)
  attribute :y_array_with_several_null_json,                           Types.Array(Types::Integer.optional)
  attribute :y_array_with_trailing_space_json,                         Types.Array(Types::Integer)
  attribute :y_number_0_e1_json,                                       Types.Array(Types::Double)
  attribute :y_number_0_e_1_json,                                      Types.Array(Types::Double)
  attribute :y_number_after_space_json,                                Types.Array(Types::Integer)
  attribute :y_number_double_close_to_zero_json,                       Types.Array(Types::Double)
  attribute :y_number_int_with_exp_json,                               Types.Array(Types::Double)
  attribute :y_number_json,                                            Types.Array(Types::Double)
  attribute :y_number_minus_zero_json,                                 Types.Array(Types::Integer)
  attribute :y_number_negative_int_json,                               Types.Array(Types::Integer)
  attribute :y_number_negative_one_json,                               Types.Array(Types::Integer)
  attribute :y_number_negative_zero_json,                              Types.Array(Types::Integer)
  attribute :y_number_real_capital_e_json,                             Types.Array(Types::Double)
  attribute :y_number_real_capital_e_neg_exp_json,                     Types.Array(Types::Double)
  attribute :y_number_real_capital_e_pos_exp_json,                     Types.Array(Types::Double)
  attribute :y_number_real_exponent_json,                              Types.Array(Types::Double)
  attribute :y_number_real_fraction_exponent_json,                     Types.Array(Types::Double)
  attribute :y_number_real_neg_exp_json,                               Types.Array(Types::Double)
  attribute :y_number_real_pos_exponent_json,                          Types.Array(Types::Double)
  attribute :y_number_simple_int_json,                                 Types.Array(Types::Integer)
  attribute :y_number_simple_real_json,                                Types.Array(Types::Double)
  attribute :y_object_basic_json,                                      YObjectBasicJSON
  attribute :y_object_empty_json,                                      YObjectEmptyJSONClass
  attribute :y_object_empty_key_json,                                  YObjectEmptyKeyJSON
  attribute :y_object_escaped_null_in_key_json,                        YObjectEscapedNullInKeyJSON
  attribute :y_object_extreme_numbers_json,                            YObjectExtremeNumbersJSON
  attribute :y_object_json,                                            YObjectJSON
  attribute :y_object_long_strings_json,                               YObjectLongStringsJSON
  attribute :y_object_simple_json,                                     YObjectSimpleJSON
  attribute :y_object_string_unicode_json,                             YObjectStringUnicodeJSON
  attribute :y_object_with_newlines_json,                              YObjectWithNewlinesJSON
  attribute :y_string_1_2_3__bytes_utf_8__sequences_json,              Types.Array(Types::String)
  attribute :y_string_accepted_surrogate_pair_json,                    Types.Array(Types::String)
  attribute :y_string_accepted_surrogate_pairs_json,                   Types.Array(Types::String)
  attribute :y_string_allowed_escapes_json,                            Types.Array(Types::String)
  attribute :y_string_backslash_and_u_escaped_zero_json,               Types.Array(Types::String)
  attribute :y_string_backslash_doublequotes_json,                     Types.Array(Types::String)
  attribute :y_string_comments_json,                                   Types.Array(Types::String)
  attribute :y_string_double_escape_a_json,                            Types.Array(Types::String)
  attribute :y_string_double_escape_n_json,                            Types.Array(Types::String)
  attribute :y_string_escaped_control_character_json,                  Types.Array(Types::String)
  attribute :y_string_escaped_noncharacter_json,                       Types.Array(Types::String)
  attribute :y_string_in_array_json,                                   Types.Array(Types::String)
  attribute :y_string_in_array_with_leading_space_json,                Types.Array(Types::String)
  attribute :y_string_last_surrogates_1__and_2_json,                   Types.Array(Types::String)
  attribute :y_string_nbsp_uescaped_json,                              Types.Array(Types::String)
  attribute :y_string_non_character_in_utf_8__u_10_ffff_json,          Types.Array(Types::String)
  attribute :y_string_non_character_in_utf_8__u_1_ffff_json,           Types.Array(Types::String)
  attribute :y_string_non_character_in_utf_8__u_ffff_json,             Types.Array(Types::String)
  attribute :y_string_null_escape_json,                                Types.Array(Types::String)
  attribute :y_string_one_byte_utf_8_json,                             Types.Array(Types::String)
  attribute :y_string_pi_json,                                         Types.Array(Types::String)
  attribute :y_string_simple_ascii_json,                               Types.Array(Types::String)
  attribute :y_string_space_json,                                      Types::String
  attribute :y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json, Types.Array(Types::String)
  attribute :y_string_three_byte_utf_8_json,                           Types.Array(Types::String)
  attribute :y_string_two_byte_utf_8_json,                             Types.Array(Types::String)
  attribute :y_string_u_2028__line_sep_json,                           Types.Array(Types::String)
  attribute :y_string_u_2029__par_sep_json,                            Types.Array(Types::String)
  attribute :y_string_u_escape_json,                                   Types.Array(Types::String)
  attribute :y_string_uescaped_newline_json,                           Types.Array(Types::String)
  attribute :y_string_unescaped_char_delete_json,                      Types.Array(Types::String)
  attribute :y_string_unicode_2_json,                                  Types.Array(Types::String)
  attribute :y_string_unicode_escaped_backslash_json,                  Types.Array(Types::String)
  attribute :y_string_unicode_escaped_double_quote_json,               Types.Array(Types::String)
  attribute :y_string_unicode_json,                                    Types.Array(Types::String)
  attribute :y_string_unicode_u_10_fffe_nonchar_json,                  Types.Array(Types::String)
  attribute :y_string_unicode_u_1_fffe_nonchar_json,                   Types.Array(Types::String)
  attribute :y_string_unicode_u_200_b_zero_width_space_json,           Types.Array(Types::String)
  attribute :y_string_unicode_u_2064__invisible_plus_json,             Types.Array(Types::String)
  attribute :y_string_unicode_u_fdd0_nonchar_json,                     Types.Array(Types::String)
  attribute :y_string_unicode_u_fffe_nonchar_json,                     Types.Array(Types::String)
  attribute :y_string_utf8_json,                                       Types.Array(Types::String)
  attribute :y_string_with_del_character_json,                         Types.Array(Types::String)
  attribute :y_structure_lonely_false_json,                            Types::Bool
  attribute :y_structure_lonely_int_json,                              Types::Integer
  attribute :y_structure_lonely_negative_real_json,                    Types::Double
  attribute :y_structure_lonely_null_json,                             Types::Nil
  attribute :y_structure_lonely_string_json,                           Types::String
  attribute :y_structure_lonely_true_json,                             Types::Bool
  attribute :y_structure_string_empty_json,                            Types::String
  attribute :y_structure_trailing_newline_json,                        Types.Array(Types::String)
  attribute :y_structure_true_in_array_json,                           Types.Array(Types::Bool)
  attribute :y_structure_whitespace_array_json,                        Types.Array(Types::Any)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      y_array_arrays_with_spaces_json:                          d.fetch("y_array_arraysWithSpaces.json"),
      y_array_empty_json:                                       d.fetch("y_array_empty.json"),
      y_array_empty_string_json:                                d.fetch("y_array_empty-string.json"),
      y_array_ending_with_newline_json:                         d.fetch("y_array_ending_with_newline.json"),
      y_array_false_json:                                       d.fetch("y_array_false.json"),
      y_array_heterogeneous_json:                               d.fetch("y_array_heterogeneous.json").map { |x| YArrayHeterogeneousJSON.from_dynamic!(x) },
      y_array_null_json:                                        d.fetch("y_array_null.json"),
      y_array_with_1__and_newline_json:                         d.fetch("y_array_with_1_and_newline.json"),
      y_array_with_leading_space_json:                          d.fetch("y_array_with_leading_space.json"),
      y_array_with_several_null_json:                           d.fetch("y_array_with_several_null.json"),
      y_array_with_trailing_space_json:                         d.fetch("y_array_with_trailing_space.json"),
      y_number_0_e1_json:                                       d.fetch("y_number_0e1.json"),
      y_number_0_e_1_json:                                      d.fetch("y_number_0e+1.json"),
      y_number_after_space_json:                                d.fetch("y_number_after_space.json"),
      y_number_double_close_to_zero_json:                       d.fetch("y_number_double_close_to_zero.json"),
      y_number_int_with_exp_json:                               d.fetch("y_number_int_with_exp.json"),
      y_number_json:                                            d.fetch("y_number.json"),
      y_number_minus_zero_json:                                 d.fetch("y_number_minus_zero.json"),
      y_number_negative_int_json:                               d.fetch("y_number_negative_int.json"),
      y_number_negative_one_json:                               d.fetch("y_number_negative_one.json"),
      y_number_negative_zero_json:                              d.fetch("y_number_negative_zero.json"),
      y_number_real_capital_e_json:                             d.fetch("y_number_real_capital_e.json"),
      y_number_real_capital_e_neg_exp_json:                     d.fetch("y_number_real_capital_e_neg_exp.json"),
      y_number_real_capital_e_pos_exp_json:                     d.fetch("y_number_real_capital_e_pos_exp.json"),
      y_number_real_exponent_json:                              d.fetch("y_number_real_exponent.json"),
      y_number_real_fraction_exponent_json:                     d.fetch("y_number_real_fraction_exponent.json"),
      y_number_real_neg_exp_json:                               d.fetch("y_number_real_neg_exp.json"),
      y_number_real_pos_exponent_json:                          d.fetch("y_number_real_pos_exponent.json"),
      y_number_simple_int_json:                                 d.fetch("y_number_simple_int.json"),
      y_number_simple_real_json:                                d.fetch("y_number_simple_real.json"),
      y_object_basic_json:                                      YObjectBasicJSON.from_dynamic!(d.fetch("y_object_basic.json")),
      y_object_empty_json:                                      YObjectEmptyJSONClass.from_dynamic!(d.fetch("y_object_empty.json")),
      y_object_empty_key_json:                                  YObjectEmptyKeyJSON.from_dynamic!(d.fetch("y_object_empty_key.json")),
      y_object_escaped_null_in_key_json:                        YObjectEscapedNullInKeyJSON.from_dynamic!(d.fetch("y_object_escaped_null_in_key.json")),
      y_object_extreme_numbers_json:                            YObjectExtremeNumbersJSON.from_dynamic!(d.fetch("y_object_extreme_numbers.json")),
      y_object_json:                                            YObjectJSON.from_dynamic!(d.fetch("y_object.json")),
      y_object_long_strings_json:                               YObjectLongStringsJSON.from_dynamic!(d.fetch("y_object_long_strings.json")),
      y_object_simple_json:                                     YObjectSimpleJSON.from_dynamic!(d.fetch("y_object_simple.json")),
      y_object_string_unicode_json:                             YObjectStringUnicodeJSON.from_dynamic!(d.fetch("y_object_string_unicode.json")),
      y_object_with_newlines_json:                              YObjectWithNewlinesJSON.from_dynamic!(d.fetch("y_object_with_newlines.json")),
      y_string_1_2_3__bytes_utf_8__sequences_json:              d.fetch("y_string_1_2_3_bytes_UTF-8_sequences.json"),
      y_string_accepted_surrogate_pair_json:                    d.fetch("y_string_accepted_surrogate_pair.json"),
      y_string_accepted_surrogate_pairs_json:                   d.fetch("y_string_accepted_surrogate_pairs.json"),
      y_string_allowed_escapes_json:                            d.fetch("y_string_allowed_escapes.json"),
      y_string_backslash_and_u_escaped_zero_json:               d.fetch("y_string_backslash_and_u_escaped_zero.json"),
      y_string_backslash_doublequotes_json:                     d.fetch("y_string_backslash_doublequotes.json"),
      y_string_comments_json:                                   d.fetch("y_string_comments.json"),
      y_string_double_escape_a_json:                            d.fetch("y_string_double_escape_a.json"),
      y_string_double_escape_n_json:                            d.fetch("y_string_double_escape_n.json"),
      y_string_escaped_control_character_json:                  d.fetch("y_string_escaped_control_character.json"),
      y_string_escaped_noncharacter_json:                       d.fetch("y_string_escaped_noncharacter.json"),
      y_string_in_array_json:                                   d.fetch("y_string_in_array.json"),
      y_string_in_array_with_leading_space_json:                d.fetch("y_string_in_array_with_leading_space.json"),
      y_string_last_surrogates_1__and_2_json:                   d.fetch("y_string_last_surrogates_1_and_2.json"),
      y_string_nbsp_uescaped_json:                              d.fetch("y_string_nbsp_uescaped.json"),
      y_string_non_character_in_utf_8__u_10_ffff_json:          d.fetch("y_string_nonCharacterInUTF-8_U+10FFFF.json"),
      y_string_non_character_in_utf_8__u_1_ffff_json:           d.fetch("y_string_nonCharacterInUTF-8_U+1FFFF.json"),
      y_string_non_character_in_utf_8__u_ffff_json:             d.fetch("y_string_nonCharacterInUTF-8_U+FFFF.json"),
      y_string_null_escape_json:                                d.fetch("y_string_null_escape.json"),
      y_string_one_byte_utf_8_json:                             d.fetch("y_string_one-byte-utf-8.json"),
      y_string_pi_json:                                         d.fetch("y_string_pi.json"),
      y_string_simple_ascii_json:                               d.fetch("y_string_simple_ascii.json"),
      y_string_space_json:                                      d.fetch("y_string_space.json"),
      y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json: d.fetch("y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json"),
      y_string_three_byte_utf_8_json:                           d.fetch("y_string_three-byte-utf-8.json"),
      y_string_two_byte_utf_8_json:                             d.fetch("y_string_two-byte-utf-8.json"),
      y_string_u_2028__line_sep_json:                           d.fetch("y_string_u+2028_line_sep.json"),
      y_string_u_2029__par_sep_json:                            d.fetch("y_string_u+2029_par_sep.json"),
      y_string_u_escape_json:                                   d.fetch("y_string_uEscape.json"),
      y_string_uescaped_newline_json:                           d.fetch("y_string_uescaped_newline.json"),
      y_string_unescaped_char_delete_json:                      d.fetch("y_string_unescaped_char_delete.json"),
      y_string_unicode_2_json:                                  d.fetch("y_string_unicode_2.json"),
      y_string_unicode_escaped_backslash_json:                  d.fetch("y_string_unicodeEscapedBackslash.json"),
      y_string_unicode_escaped_double_quote_json:               d.fetch("y_string_unicode_escaped_double_quote.json"),
      y_string_unicode_json:                                    d.fetch("y_string_unicode.json"),
      y_string_unicode_u_10_fffe_nonchar_json:                  d.fetch("y_string_unicode_U+10FFFE_nonchar.json"),
      y_string_unicode_u_1_fffe_nonchar_json:                   d.fetch("y_string_unicode_U+1FFFE_nonchar.json"),
      y_string_unicode_u_200_b_zero_width_space_json:           d.fetch("y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json"),
      y_string_unicode_u_2064__invisible_plus_json:             d.fetch("y_string_unicode_U+2064_invisible_plus.json"),
      y_string_unicode_u_fdd0_nonchar_json:                     d.fetch("y_string_unicode_U+FDD0_nonchar.json"),
      y_string_unicode_u_fffe_nonchar_json:                     d.fetch("y_string_unicode_U+FFFE_nonchar.json"),
      y_string_utf8_json:                                       d.fetch("y_string_utf8.json"),
      y_string_with_del_character_json:                         d.fetch("y_string_with_del_character.json"),
      y_structure_lonely_false_json:                            d.fetch("y_structure_lonely_false.json"),
      y_structure_lonely_int_json:                              d.fetch("y_structure_lonely_int.json"),
      y_structure_lonely_negative_real_json:                    d.fetch("y_structure_lonely_negative_real.json"),
      y_structure_lonely_null_json:                             d.fetch("y_structure_lonely_null.json"),
      y_structure_lonely_string_json:                           d.fetch("y_structure_lonely_string.json"),
      y_structure_lonely_true_json:                             d.fetch("y_structure_lonely_true.json"),
      y_structure_string_empty_json:                            d.fetch("y_structure_string_empty.json"),
      y_structure_trailing_newline_json:                        d.fetch("y_structure_trailing_newline.json"),
      y_structure_true_in_array_json:                           d.fetch("y_structure_true_in_array.json"),
      y_structure_whitespace_array_json:                        d.fetch("y_structure_whitespace_array.json"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "y_array_arraysWithSpaces.json"                          => y_array_arrays_with_spaces_json,
      "y_array_empty.json"                                     => y_array_empty_json,
      "y_array_empty-string.json"                              => y_array_empty_string_json,
      "y_array_ending_with_newline.json"                       => y_array_ending_with_newline_json,
      "y_array_false.json"                                     => y_array_false_json,
      "y_array_heterogeneous.json"                             => y_array_heterogeneous_json.map { |x| x.to_dynamic },
      "y_array_null.json"                                      => y_array_null_json,
      "y_array_with_1_and_newline.json"                        => y_array_with_1__and_newline_json,
      "y_array_with_leading_space.json"                        => y_array_with_leading_space_json,
      "y_array_with_several_null.json"                         => y_array_with_several_null_json,
      "y_array_with_trailing_space.json"                       => y_array_with_trailing_space_json,
      "y_number_0e1.json"                                      => y_number_0_e1_json,
      "y_number_0e+1.json"                                     => y_number_0_e_1_json,
      "y_number_after_space.json"                              => y_number_after_space_json,
      "y_number_double_close_to_zero.json"                     => y_number_double_close_to_zero_json,
      "y_number_int_with_exp.json"                             => y_number_int_with_exp_json,
      "y_number.json"                                          => y_number_json,
      "y_number_minus_zero.json"                               => y_number_minus_zero_json,
      "y_number_negative_int.json"                             => y_number_negative_int_json,
      "y_number_negative_one.json"                             => y_number_negative_one_json,
      "y_number_negative_zero.json"                            => y_number_negative_zero_json,
      "y_number_real_capital_e.json"                           => y_number_real_capital_e_json,
      "y_number_real_capital_e_neg_exp.json"                   => y_number_real_capital_e_neg_exp_json,
      "y_number_real_capital_e_pos_exp.json"                   => y_number_real_capital_e_pos_exp_json,
      "y_number_real_exponent.json"                            => y_number_real_exponent_json,
      "y_number_real_fraction_exponent.json"                   => y_number_real_fraction_exponent_json,
      "y_number_real_neg_exp.json"                             => y_number_real_neg_exp_json,
      "y_number_real_pos_exponent.json"                        => y_number_real_pos_exponent_json,
      "y_number_simple_int.json"                               => y_number_simple_int_json,
      "y_number_simple_real.json"                              => y_number_simple_real_json,
      "y_object_basic.json"                                    => y_object_basic_json.to_dynamic,
      "y_object_empty.json"                                    => y_object_empty_json.to_dynamic,
      "y_object_empty_key.json"                                => y_object_empty_key_json.to_dynamic,
      "y_object_escaped_null_in_key.json"                      => y_object_escaped_null_in_key_json.to_dynamic,
      "y_object_extreme_numbers.json"                          => y_object_extreme_numbers_json.to_dynamic,
      "y_object.json"                                          => y_object_json.to_dynamic,
      "y_object_long_strings.json"                             => y_object_long_strings_json.to_dynamic,
      "y_object_simple.json"                                   => y_object_simple_json.to_dynamic,
      "y_object_string_unicode.json"                           => y_object_string_unicode_json.to_dynamic,
      "y_object_with_newlines.json"                            => y_object_with_newlines_json.to_dynamic,
      "y_string_1_2_3_bytes_UTF-8_sequences.json"              => y_string_1_2_3__bytes_utf_8__sequences_json,
      "y_string_accepted_surrogate_pair.json"                  => y_string_accepted_surrogate_pair_json,
      "y_string_accepted_surrogate_pairs.json"                 => y_string_accepted_surrogate_pairs_json,
      "y_string_allowed_escapes.json"                          => y_string_allowed_escapes_json,
      "y_string_backslash_and_u_escaped_zero.json"             => y_string_backslash_and_u_escaped_zero_json,
      "y_string_backslash_doublequotes.json"                   => y_string_backslash_doublequotes_json,
      "y_string_comments.json"                                 => y_string_comments_json,
      "y_string_double_escape_a.json"                          => y_string_double_escape_a_json,
      "y_string_double_escape_n.json"                          => y_string_double_escape_n_json,
      "y_string_escaped_control_character.json"                => y_string_escaped_control_character_json,
      "y_string_escaped_noncharacter.json"                     => y_string_escaped_noncharacter_json,
      "y_string_in_array.json"                                 => y_string_in_array_json,
      "y_string_in_array_with_leading_space.json"              => y_string_in_array_with_leading_space_json,
      "y_string_last_surrogates_1_and_2.json"                  => y_string_last_surrogates_1__and_2_json,
      "y_string_nbsp_uescaped.json"                            => y_string_nbsp_uescaped_json,
      "y_string_nonCharacterInUTF-8_U+10FFFF.json"             => y_string_non_character_in_utf_8__u_10_ffff_json,
      "y_string_nonCharacterInUTF-8_U+1FFFF.json"              => y_string_non_character_in_utf_8__u_1_ffff_json,
      "y_string_nonCharacterInUTF-8_U+FFFF.json"               => y_string_non_character_in_utf_8__u_ffff_json,
      "y_string_null_escape.json"                              => y_string_null_escape_json,
      "y_string_one-byte-utf-8.json"                           => y_string_one_byte_utf_8_json,
      "y_string_pi.json"                                       => y_string_pi_json,
      "y_string_simple_ascii.json"                             => y_string_simple_ascii_json,
      "y_string_space.json"                                    => y_string_space_json,
      "y_string_surrogates_U+1D11E_MUSICAL_SYMBOL_G_CLEF.json" => y_string_surrogates_u_1_d11_e_musical_symbol_g_clef_json,
      "y_string_three-byte-utf-8.json"                         => y_string_three_byte_utf_8_json,
      "y_string_two-byte-utf-8.json"                           => y_string_two_byte_utf_8_json,
      "y_string_u+2028_line_sep.json"                          => y_string_u_2028__line_sep_json,
      "y_string_u+2029_par_sep.json"                           => y_string_u_2029__par_sep_json,
      "y_string_uEscape.json"                                  => y_string_u_escape_json,
      "y_string_uescaped_newline.json"                         => y_string_uescaped_newline_json,
      "y_string_unescaped_char_delete.json"                    => y_string_unescaped_char_delete_json,
      "y_string_unicode_2.json"                                => y_string_unicode_2_json,
      "y_string_unicodeEscapedBackslash.json"                  => y_string_unicode_escaped_backslash_json,
      "y_string_unicode_escaped_double_quote.json"             => y_string_unicode_escaped_double_quote_json,
      "y_string_unicode.json"                                  => y_string_unicode_json,
      "y_string_unicode_U+10FFFE_nonchar.json"                 => y_string_unicode_u_10_fffe_nonchar_json,
      "y_string_unicode_U+1FFFE_nonchar.json"                  => y_string_unicode_u_1_fffe_nonchar_json,
      "y_string_unicode_U+200B_ZERO_WIDTH_SPACE.json"          => y_string_unicode_u_200_b_zero_width_space_json,
      "y_string_unicode_U+2064_invisible_plus.json"            => y_string_unicode_u_2064__invisible_plus_json,
      "y_string_unicode_U+FDD0_nonchar.json"                   => y_string_unicode_u_fdd0_nonchar_json,
      "y_string_unicode_U+FFFE_nonchar.json"                   => y_string_unicode_u_fffe_nonchar_json,
      "y_string_utf8.json"                                     => y_string_utf8_json,
      "y_string_with_del_character.json"                       => y_string_with_del_character_json,
      "y_structure_lonely_false.json"                          => y_structure_lonely_false_json,
      "y_structure_lonely_int.json"                            => y_structure_lonely_int_json,
      "y_structure_lonely_negative_real.json"                  => y_structure_lonely_negative_real_json,
      "y_structure_lonely_null.json"                           => y_structure_lonely_null_json,
      "y_structure_lonely_string.json"                         => y_structure_lonely_string_json,
      "y_structure_lonely_true.json"                           => y_structure_lonely_true_json,
      "y_structure_string_empty.json"                          => y_structure_string_empty_json,
      "y_structure_trailing_newline.json"                      => y_structure_trailing_newline_json,
      "y_structure_true_in_array.json"                         => y_structure_true_in_array_json,
      "y_structure_whitespace_array.json"                      => y_structure_whitespace_array_json,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
