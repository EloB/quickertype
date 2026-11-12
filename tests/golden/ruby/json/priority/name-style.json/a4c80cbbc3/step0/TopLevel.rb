# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.an_easy_one.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
end

class TopLevel < Dry::Struct
  attribute :an_easy_one,                          Types::Integer
  attribute :is_mnist_letter,                      Types::Bool
  attribute :json_string,                          Types::String
  attribute :pretty_easy_too,                      Types::Bool
  attribute :should_know_that_id_is_an_initialism, Types::String
  attribute :spaces_are_separators_too,            Types::Bool
  attribute :zsr_hh_demo3_delmatnr,                Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      an_easy_one:                          d.fetch("anEasyOne"),
      is_mnist_letter:                      d.fetch("isMNISTLetter"),
      json_string:                          d.fetch("JSONString"),
      pretty_easy_too:                      d.fetch("PrettyEasyToo"),
      should_know_that_id_is_an_initialism: d.fetch("should_know_that_id_is_an_initialism"),
      spaces_are_separators_too:            d.fetch("   spaces are separators  too  "),
      zsr_hh_demo3_delmatnr:                d.fetch("ZSR_HH_DEMO3_DELMATNR"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "anEasyOne"                            => an_easy_one,
      "isMNISTLetter"                        => is_mnist_letter,
      "JSONString"                           => json_string,
      "PrettyEasyToo"                        => pretty_easy_too,
      "should_know_that_id_is_an_initialism" => should_know_that_id_is_an_initialism,
      "   spaces are separators  too  "      => spaces_are_separators_too,
      "ZSR_HH_DEMO3_DELMATNR"                => zsr_hh_demo3_delmatnr,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
