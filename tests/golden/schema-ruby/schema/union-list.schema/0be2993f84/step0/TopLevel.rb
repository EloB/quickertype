# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.list
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Hash   = Strict::Hash
  Double = Strict::Float | Strict::Integer
end

# (forward declaration)
class UnionListClass < Dry::Struct; end

class UnionList < Dry::Struct
  attribute :double,           Types::Double.optional
  attribute :union_list_class, UnionListClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_list_class: nil)
    end
    begin
      value = UnionListClass.from_dynamic!(d)
      if schema.key(:union_list_class).type.right.valid? value
        return new(union_list_class: value, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif union_list_class != nil
      union_list_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnionListClass < Dry::Struct
  attribute :union_list_next, Types.Instance(UnionList)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      union_list_next: UnionList.from_dynamic!(d.fetch("next")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "next" => union_list_next.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :list, Types.Instance(UnionList)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      list: UnionList.from_dynamic!(d.fetch("list")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "list" => list.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
