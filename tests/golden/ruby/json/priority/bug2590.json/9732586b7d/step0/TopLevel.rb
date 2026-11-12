# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.invoices.first.created_at.nil?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Nil    = Strict::Nil
  Hash   = Strict::Hash
  String = Strict::String
end

class Invoice < Dry::Struct
  attribute :created_at,   Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i).optional
  attribute :due_date,     Types::String.optional
  attribute :invoice_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      created_at:   d.fetch("createdAt"),
      due_date:     d.fetch("dueDate"),
      invoice_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "createdAt" => created_at,
      "dueDate"   => due_date,
      "name"      => invoice_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :invoices, Types.Array(Invoice)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      invoices: d.fetch("invoices").map { |x| Invoice.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "invoices" => invoices.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
