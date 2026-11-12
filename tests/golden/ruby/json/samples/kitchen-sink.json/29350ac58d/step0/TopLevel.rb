# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.tuples.first.first
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

class DifferentThingClass < Dry::Struct
  attribute :different_thing_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      different_thing_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name" => different_thing_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DifferentThingElement < Dry::Struct
  attribute :different_thing_class, DifferentThingClass.optional
  attribute :integer,               Types::Integer.optional
  attribute :string,                Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = DifferentThingClass.from_dynamic!(d)
      if schema.key(:different_thing_class).type.right.valid? value
        return new(different_thing_class: value, integer: nil, string: nil)
      end
    rescue
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, different_thing_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, different_thing_class: nil, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if different_thing_class != nil
      different_thing_class.to_dynamic
    elsif integer != nil
      integer
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class IntOrString < Dry::Struct
  attribute :integer, Types::Integer.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer: nil)
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
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PersonElement < Dry::Struct
  attribute :int_or_string,  Types.Instance(IntOrString)
  attribute :optional_value, Types::Bool.optional
  attribute :person_name,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      int_or_string:  IntOrString.from_dynamic!(d.fetch("intOrString")),
      optional_value: d.key?("optionalValue") ? Types::Bool[d["optionalValue"]] : nil,
      person_name:    d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "intOrString"   => int_or_string.to_dynamic,
      "optionalValue" => optional_value,
      "name"          => person_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Person1 < Dry::Struct
  attribute :int_or_string, Types::Integer
  attribute :person_name,   Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      int_or_string: d.fetch("intOrString"),
      person_name:   d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "intOrString" => int_or_string,
      "name"        => person_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :boolean_value,      Types::Bool
  attribute :date_value,         Types::String
  attribute :different_things,   Types.Array(Types.Instance(DifferentThingElement))
  attribute :double_value,       Types::Double
  attribute :int_value,          Types::Integer
  attribute :map_value,          Types::Hash.meta(of: Types::Integer.optional)
  attribute :name_with_spaces,   Types::Nil
  attribute :null_value,         Types::Nil
  attribute :nullable_map_value, Types::Hash.meta(of: Types::Integer.optional)
  attribute :people,             Types.Array(PersonElement)
  attribute :person,             Person1
  attribute :string_value,       Types::String
  attribute :tuples,             Types.Array(Types.Array(Types.Instance(IntOrString)))
  attribute :uuid_value,         Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      boolean_value:      d.fetch("booleanValue"),
      date_value:         d.fetch("dateValue"),
      different_things:   d.fetch("differentThings").map { |x| DifferentThingElement.from_dynamic!(x) },
      double_value:       d.fetch("doubleValue"),
      int_value:          d.fetch("intValue"),
      map_value:          Types::Hash[d.fetch("mapValue")].map { |k, v| [k, v] }.to_h,
      name_with_spaces:   d.fetch("name with spaces"),
      null_value:         d.fetch("nullValue"),
      nullable_map_value: Types::Hash[d.fetch("nullableMapValue")].map { |k, v| [k, v] }.to_h,
      people:             d.fetch("people").map { |x| PersonElement.from_dynamic!(x) },
      person:             Person1.from_dynamic!(d.fetch("person")),
      string_value:       d.fetch("stringValue"),
      tuples:             d.fetch("tuples").map { |x| x.map { |x| IntOrString.from_dynamic!(x) } },
      uuid_value:         d.fetch("uuidValue"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "booleanValue"     => boolean_value,
      "dateValue"        => date_value,
      "differentThings"  => different_things.map { |x| x.to_dynamic },
      "doubleValue"      => double_value,
      "intValue"         => int_value,
      "mapValue"         => map_value,
      "name with spaces" => name_with_spaces,
      "nullValue"        => null_value,
      "nullableMapValue" => nullable_map_value,
      "people"           => people.map { |x| x.to_dynamic },
      "person"           => person.to_dynamic,
      "stringValue"      => string_value,
      "tuples"           => tuples.map { |x| x.map { |x| x.to_dynamic } },
      "uuidValue"        => uuid_value,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
