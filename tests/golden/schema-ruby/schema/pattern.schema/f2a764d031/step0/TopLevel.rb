# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.reg_exp&.pattern3
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  String = Strict::String
end

class RegExp < Dry::Struct
  attribute :pattern3, Types::String.constrained(format: Regexp.new("d[.]*"))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      pattern3: d.fetch("pattern3"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "pattern3" => pattern3,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :pattern1, Types::String.constrained(format: Regexp.new("a[.]*"))
  attribute :pattern2, Types::String.constrained(format: Regexp.new("b[.]*"))
  attribute :reg_exp,  RegExp.optional
  attribute :union,    Types::String.constrained(format: Regexp.new("(b[.]*)|(c[.]*)"))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      pattern1: d.fetch("pattern1"),
      pattern2: d.fetch("pattern2"),
      reg_exp:  d.key?("RegExp") ? RegExp.from_dynamic!(d["RegExp"]) : nil,
      union:    d.fetch("union"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "pattern1" => pattern1,
      "pattern2" => pattern2,
      "RegExp"   => reg_exp&.to_dynamic,
      "union"    => union,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
