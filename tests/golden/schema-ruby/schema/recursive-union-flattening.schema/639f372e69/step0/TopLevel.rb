# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "…"
#   puts top_level
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

# (forward declaration)
class XClass < Dry::Struct; end

class X < Dry::Struct
  attribute :anything_map, Types::Hash.meta(of: Types::Any).optional
  attribute :bool,         Types::Bool.optional
  attribute :double,       Types::Double.optional
  attribute :null,         Types::Nil.optional
  attribute :string,       Types::String.optional
  attribute :union_array,  Types.Array(Types.Instance(XElement)).optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Any[v]] }.to_h
      if schema.key(:anything_map).type.right.valid? value
        return new(anything_map: value, union_array: nil, bool: nil, double: nil, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, union_array: nil, double: nil, anything_map: nil, null: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_array: nil, bool: nil, anything_map: nil, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, union_array: nil, bool: nil, double: nil, anything_map: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, union_array: nil, bool: nil, double: nil, anything_map: nil, null: nil)
    end
    begin
      value = d.map { |x| XElement.from_dynamic!(x) }
      if schema.key(:union_array).type.right.valid? value
        return new(union_array: value, bool: nil, double: nil, anything_map: nil, null: nil, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if anything_map != nil
      anything_map
    elsif bool != nil
      bool
    elsif double != nil
      double
    elsif string != nil
      string
    elsif union_array != nil
      union_array.map { |x| x.to_dynamic }
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class XElement < Dry::Struct
  attribute :anything_array, Types.Array(Types::Any).optional
  attribute :bool,           Types::Bool.optional
  attribute :double,         Types::Double.optional
  attribute :null,           Types::Nil.optional
  attribute :string,         Types::String.optional
  attribute :x_class,        XClass.optional

  def self.from_dynamic!(d)
    if schema.key(:anything_array).type.right.valid? d
      return new(anything_array: d, bool: nil, x_class: nil, double: nil, null: nil, string: nil)
    end
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, anything_array: nil, x_class: nil, double: nil, null: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, anything_array: nil, bool: nil, x_class: nil, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, anything_array: nil, bool: nil, x_class: nil, double: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, anything_array: nil, bool: nil, x_class: nil, double: nil, null: nil)
    end
    begin
      value = XClass.from_dynamic!(d)
      if schema.key(:x_class).type.right.valid? value
        return new(x_class: value, anything_array: nil, bool: nil, double: nil, null: nil, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if anything_array != nil
      anything_array
    elsif bool != nil
      bool
    elsif double != nil
      double
    elsif string != nil
      string
    elsif x_class != nil
      x_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class XClass < Dry::Struct
  attribute :x, Types.Instance(X).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      x: d["x"] ? X.from_dynamic!(d["x"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "x" => x&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelClass < Dry::Struct
  attribute :x, Types.Instance(X).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      x: d["x"] ? X.from_dynamic!(d["x"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "x" => x&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelElement < Dry::Struct
  attribute :anything_array,  Types.Array(Types::Any).optional
  attribute :bool,            Types::Bool.optional
  attribute :double,          Types::Double.optional
  attribute :null,            Types::Nil.optional
  attribute :string,          Types::String.optional
  attribute :top_level_class, TopLevelClass.optional

  def self.from_dynamic!(d)
    if schema.key(:anything_array).type.right.valid? d
      return new(anything_array: d, bool: nil, top_level_class: nil, double: nil, null: nil, string: nil)
    end
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, anything_array: nil, top_level_class: nil, double: nil, null: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, anything_array: nil, bool: nil, top_level_class: nil, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, anything_array: nil, bool: nil, top_level_class: nil, double: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, anything_array: nil, bool: nil, top_level_class: nil, double: nil, null: nil)
    end
    begin
      value = TopLevelClass.from_dynamic!(d)
      if schema.key(:top_level_class).type.right.valid? value
        return new(top_level_class: value, anything_array: nil, bool: nil, double: nil, null: nil, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if anything_array != nil
      anything_array
    elsif bool != nil
      bool
    elsif double != nil
      double
    elsif string != nil
      string
    elsif top_level_class != nil
      top_level_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :anything_map, Types::Hash.meta(of: Types::Any).optional
  attribute :bool,         Types::Bool.optional
  attribute :double,       Types::Double.optional
  attribute :integer,      Types::Integer.optional
  attribute :null,         Types::Nil.optional
  attribute :string,       Types::String.optional
  attribute :union_array,  Types.Array(Types.Instance(TopLevelElement)).optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Any[v]] }.to_h
      if schema.key(:anything_map).type.right.valid? value
        return new(anything_map: value, union_array: nil, bool: nil, double: nil, integer: nil, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, union_array: nil, double: nil, integer: nil, anything_map: nil, null: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_array: nil, bool: nil, integer: nil, anything_map: nil, null: nil, string: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, union_array: nil, bool: nil, double: nil, anything_map: nil, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, union_array: nil, bool: nil, double: nil, integer: nil, anything_map: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, union_array: nil, bool: nil, double: nil, integer: nil, anything_map: nil, null: nil)
    end
    begin
      value = d.map { |x| TopLevelElement.from_dynamic!(x) }
      if schema.key(:union_array).type.right.valid? value
        return new(union_array: value, bool: nil, double: nil, integer: nil, anything_map: nil, null: nil, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if anything_map != nil
      anything_map
    elsif bool != nil
      bool
    elsif double != nil
      double
    elsif integer != nil
      integer
    elsif string != nil
      string
    elsif union_array != nil
      union_array.map { |x| x.to_dynamic }
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
