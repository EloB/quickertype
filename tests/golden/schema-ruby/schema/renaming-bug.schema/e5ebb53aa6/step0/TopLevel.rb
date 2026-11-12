# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.vehicles&.first.vehicle_type&.vehicle_type_name == Name::Truck
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Bool   = Strict::Bool
  Hash   = Strict::Hash
  String = Strict::String
  Double = Strict::Float | Strict::Integer
  Axis   = Strict::String.enum("X", "Y", "Z", "XY", "YZ", "ZX")
  Name   = Strict::String.enum("truck", "bus", "car", "van", "train", "Bike", "Aeroplane", "Jeep", "Trolley")
end

class Color < Dry::Struct
  attribute :rgb, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      rgb: d.key?("rgb") ? Types::Double[d["rgb"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "rgb" => rgb,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CircularShape < Dry::Struct
  attribute :shape_name, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      shape_name: d.key?("shapeName") ? Types::String[d["shapeName"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "shapeName" => shape_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Part < Dry::Struct
  attribute :depth,  Types::String.optional
  attribute :length, Types::String.optional
  attribute :width,  Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      depth:  d.key?("depth") ? Types::String[d["depth"]] : nil,
      length: d.key?("length") ? Types::String[d["length"]] : nil,
      width:  d.key?("width") ? Types::String[d["width"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "depth"  => depth,
      "length" => length,
      "width"  => width,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RectShape < Dry::Struct
  attribute :parts, Types.Array(Part).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      parts: d.key?("parts") ? d["parts"].map { |x| Part.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "parts" => parts&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Geometry < Dry::Struct
  attribute :rect_shape,     RectShape.optional
  attribute :circular_shape, Types.Array(CircularShape).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      rect_shape:     d.key?("rectShape") ? RectShape.from_dynamic!(d["rectShape"]) : nil,
      circular_shape: d.key?("circularShape") ? d["circularShape"].map { |x| CircularShape.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "rectShape"     => rect_shape&.to_dynamic,
      "circularShape" => circular_shape&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class History < Dry::Struct
  attribute :history_class, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      history_class: d.key?("class") ? Types::String[d["class"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "class" => history_class,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Shape < Dry::Struct
  attribute :geometry, Geometry.optional
  attribute :history,  History.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      geometry: d.key?("geometry") ? Geometry.from_dynamic!(d["geometry"]) : nil,
      history:  d.key?("history") ? History.from_dynamic!(d["history"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "geometry" => geometry&.to_dynamic,
      "history"  => history&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Berry < Dry::Struct
  attribute :color,      Color.optional
  attribute :berry_name, Types::String.constrained(min_size: 1).optional
  attribute :shapes,     Types.Array(Shape).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      color:      d.key?("color") ? Color.from_dynamic!(d["color"]) : nil,
      berry_name: d.key?("name") ? Types::String.constrained(min_size: 1)[d["name"]] : nil,
      shapes:     d.key?("shapes") ? d["shapes"].map { |x| Shape.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "color"  => color&.to_dynamic,
      "name"   => berry_name,
      "shapes" => shapes&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fruit < Dry::Struct
  attribute :apple,   Types::Bool.optional
  attribute :berries, Types.Array(Berry).optional
  attribute :orange,  Types::Bool.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      apple:   d.key?("apple") ? Types::Bool[d["apple"]] : nil,
      berries: d.key?("berries") ? d["berries"].map { |x| Berry.from_dynamic!(x) } : nil,
      orange:  d.key?("orange") ? Types::Bool[d["orange"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "apple"   => apple,
      "berries" => berries&.map { |x| x.to_dynamic },
      "orange"  => orange,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Limit < Dry::Struct
  attribute :maximum, Types::Double.optional
  attribute :minimum, Types::Double.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      maximum: d.key?("maximum") ? Types::Double[d["maximum"]] : nil,
      minimum: d.key?("minimum") ? Types::Double[d["minimum"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "maximum" => maximum,
      "minimum" => minimum,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Speed < Dry::Struct
  attribute :velocity, Limit.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      velocity: d.key?("velocity") ? Limit.from_dynamic!(d["velocity"]) : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "velocity" => velocity&.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Axis
  X  = "X"
  Y  = "Y"
  Z  = "Z"
  Xy = "XY"
  Yz = "YZ"
  Zx = "ZX"
end

module Name
  Truck     = "truck"
  Bus       = "bus"
  Car       = "car"
  Van       = "van"
  Train     = "train"
  Bike      = "Bike"
  Aeroplane = "Aeroplane"
  Jeep      = "Jeep"
  Trolley   = "Trolley"
end

class VehicleType < Dry::Struct
  attribute :vehicle_type_name, Types::Name.optional
  attribute :width,             Types::Axis.optional
  attribute :length,            Types::Axis.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      vehicle_type_name: d.key?("name") ? Types::Name[d["name"]] : nil,
      width:             d.key?("width") ? Types::Axis[d["width"]] : nil,
      length:            d.key?("length") ? Types::Axis[d["length"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name"   => vehicle_type_name,
      "width"  => width,
      "length" => length,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Vehicle < Dry::Struct
  attribute :brand,        Types::String.optional
  attribute :id,           Types::String.constrained(min_size: 1).optional
  attribute :speed,        Speed.optional
  attribute :sub_module,   Types::Bool.optional
  attribute :vehicle_type, VehicleType.optional
  attribute :year,         Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      brand:        d.key?("brand") ? Types::String[d["brand"]] : nil,
      id:           d.key?("id") ? Types::String.constrained(min_size: 1)[d["id"]] : nil,
      speed:        d.key?("speed") ? Speed.from_dynamic!(d["speed"]) : nil,
      sub_module:   d.key?("subModule") ? Types::Bool[d["subModule"]] : nil,
      vehicle_type: d.key?("type") ? VehicleType.from_dynamic!(d["type"]) : nil,
      year:         d.key?("year") ? Types::String[d["year"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "brand"     => brand,
      "id"        => id,
      "speed"     => speed&.to_dynamic,
      "subModule" => sub_module,
      "type"      => vehicle_type&.to_dynamic,
      "year"      => year,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :version,  Types::String.constrained(format: Regexp.new("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$")).optional
  attribute :fruits,   Types.Array(Fruit).optional
  attribute :vehicles, Types.Array(Vehicle).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      version:  d.key?("version") ? Types::String.constrained(format: Regexp.new("^\\d{1,5}.{1}\\d{1,5}.{1}\\d{1,5}$"))[d["version"]] : nil,
      fruits:   d.key?("fruits") ? d["fruits"].map { |x| Fruit.from_dynamic!(x) } : nil,
      vehicles: d.key?("vehicles") ? d["vehicles"].map { |x| Vehicle.from_dynamic!(x) } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "version"  => version,
      "fruits"   => fruits&.map { |x| x.to_dynamic },
      "vehicles" => vehicles&.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
