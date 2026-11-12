# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.opt_double
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class TopLevel < Dry::Struct
  attribute :opt_double,   Types::Double.constrained(gteq: 0.5, lteq: 99.5).optional
  attribute :opt_int,      Types::Integer.constrained(gteq: 0, lteq: 100).optional
  attribute :opt_pattern,  Types::String.constrained(format: Regexp.new("^[a-z]+$")).optional
  attribute :opt_string,   Types::String.constrained(min_size: 3, max_size: 10).optional
  attribute :req_zero_min, Types::Integer.constrained(gteq: 0, lteq: 100)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      opt_double:   d.key?("optDouble") ? Types::Double.constrained(gteq: 0.5, lteq: 99.5)[d["optDouble"]] : nil,
      opt_int:      d.key?("optInt") ? Types::Integer.constrained(gteq: 0, lteq: 100)[d["optInt"]] : nil,
      opt_pattern:  d.key?("optPattern") ? Types::String.constrained(format: Regexp.new("^[a-z]+$"))[d["optPattern"]] : nil,
      opt_string:   d.key?("optString") ? Types::String.constrained(min_size: 3, max_size: 10)[d["optString"]] : nil,
      req_zero_min: d.fetch("reqZeroMin"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "optDouble"  => opt_double,
      "optInt"     => opt_int,
      "optPattern" => opt_pattern,
      "optString"  => opt_string,
      "reqZeroMin" => req_zero_min,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
