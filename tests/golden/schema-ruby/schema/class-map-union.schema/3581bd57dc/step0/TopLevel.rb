# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.union&["…"]
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
  Double  = Strict::Float | Strict::Integer
end

class UnionClass < Dry::Struct
  attribute :quux, Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      quux: d.key?("quux") ? Types::Integer[d["quux"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "quux" => quux,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionValue < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :double,      Types::Double.optional
  attribute :string,      Types::String.optional
  attribute :union_class, UnionClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, union_class: nil, double: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, union_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, union_class: nil, double: nil)
    end
    begin
      value = UnionClass.from_dynamic!(d)
      if schema.key(:union_class).type.right.valid? value
        return new(union_class: value, bool: nil, double: nil, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif double != nil
      double
    elsif string != nil
      string
    elsif union_class != nil
      union_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :union, Types::Hash.meta(of: Types.Instance(UnionValue)).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      union: d.key?("union") ? Types::Hash[d["union"]].map { |k, v| [k, UnionValue.from_dynamic!(v)] }.to_h : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "union" => union&.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
