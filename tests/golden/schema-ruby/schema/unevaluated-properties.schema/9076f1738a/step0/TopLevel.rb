# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.config&.settings&["…"].first.key
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

class ClosedClass < Dry::Struct

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

class Closed < Dry::Struct
  attribute :anything_array, Types.Array(Types::Any).optional
  attribute :bool,           Types::Bool.optional
  attribute :closed_class,   ClosedClass.optional
  attribute :double,         Types::Double.optional
  attribute :integer,        Types::Integer.optional
  attribute :null,           Types::Nil.optional
  attribute :string,         Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:anything_array).type.right.valid? d
      return new(anything_array: d, bool: nil, closed_class: nil, double: nil, integer: nil, null: nil, string: nil)
    end
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, anything_array: nil, closed_class: nil, double: nil, integer: nil, null: nil, string: nil)
    end
    begin
      value = ClosedClass.from_dynamic!(d)
      if schema.key(:closed_class).type.right.valid? value
        return new(closed_class: value, anything_array: nil, bool: nil, double: nil, integer: nil, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, anything_array: nil, bool: nil, closed_class: nil, integer: nil, null: nil, string: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, anything_array: nil, bool: nil, closed_class: nil, double: nil, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, anything_array: nil, bool: nil, closed_class: nil, double: nil, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, anything_array: nil, bool: nil, closed_class: nil, double: nil, integer: nil, null: nil)
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
    elsif closed_class != nil
      closed_class.to_dynamic
    elsif double != nil
      double
    elsif integer != nil
      integer
    elsif string != nil
      string
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Item < Dry::Struct
  attribute :key,   Types::String
  attribute :value, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      key:   d.fetch("key"),
      value: d.fetch("value"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "key"   => key,
      "value" => value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Config < Dry::Struct
  attribute :closed,      Types.Instance(Closed).optional
  attribute :config_name, Types::String.optional
  attribute :settings,    Types::Hash.meta(of: Types.Array(Item)).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      closed:      d["closed"] ? Closed.from_dynamic!(d["closed"]) : nil,
      config_name: d.key?("name") ? Types::String[d["name"]] : nil,
      settings:    d.key?("settings") ? Types::Hash[d["settings"]].map { |k, v| [k, v.map { |x| Item.from_dynamic!(x) }] }.to_h : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "closed"   => closed&.to_dynamic,
      "name"     => config_name,
      "settings" => settings&.map { |k, v| [k, v.map { |x| x.to_dynamic }] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :config, Config.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      config: d.key?("config") ? Config.from_dynamic!(d["config"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "config" => config&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
