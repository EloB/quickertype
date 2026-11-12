# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.errors
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

class Datum < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :null,   Types::Nil.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, double: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
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

class Errors < Dry::Struct

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

class TopLevel < Dry::Struct
  attribute :code,           Types::String
  attribute :column_names,   Types.Array(Types::String)
  attribute :data,           Types.Array(Types.Array(Types.Instance(Datum)))
  attribute :description,    Types::String
  attribute :display_url,    Types::String
  attribute :errors,         Errors
  attribute :frequency,      Types::String
  attribute :from_date,      Types::String
  attribute :id,             Types::Integer
  attribute :premium,        Types::Bool
  attribute :source_code,    Types::String
  attribute :source_name,    Types::String
  attribute :to_date,        Types::String
  attribute :top_level_name, Types::String
  attribute :top_level_type, Types::String
  attribute :updated_at,     Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :urlize_name,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      code:           d.fetch("code"),
      column_names:   d.fetch("column_names"),
      data:           d.fetch("data").map { |x| x.map { |x| Datum.from_dynamic!(x) } },
      description:    d.fetch("description"),
      display_url:    d.fetch("display_url"),
      errors:         Errors.from_dynamic!(d.fetch("errors")),
      frequency:      d.fetch("frequency"),
      from_date:      d.fetch("from_date"),
      id:             d.fetch("id"),
      premium:        d.fetch("premium"),
      source_code:    d.fetch("source_code"),
      source_name:    d.fetch("source_name"),
      to_date:        d.fetch("to_date"),
      top_level_name: d.fetch("name"),
      top_level_type: d.fetch("type"),
      updated_at:     d.fetch("updated_at"),
      urlize_name:    d.fetch("urlize_name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "code"         => code,
      "column_names" => column_names,
      "data"         => data.map { |x| x.map { |x| x.to_dynamic } },
      "description"  => description,
      "display_url"  => display_url,
      "errors"       => errors.to_dynamic,
      "frequency"    => frequency,
      "from_date"    => from_date,
      "id"           => id,
      "premium"      => premium,
      "source_code"  => source_code,
      "source_name"  => source_name,
      "to_date"      => to_date,
      "name"         => top_level_name,
      "type"         => top_level_type,
      "updated_at"   => updated_at,
      "urlize_name"  => urlize_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
