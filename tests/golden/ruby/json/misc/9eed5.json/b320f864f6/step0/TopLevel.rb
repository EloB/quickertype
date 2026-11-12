# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "[…]"
#   puts top_level.first.text.first.media_type
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Nil     = Strict::Nil
  Hash    = Strict::Hash
  String  = Strict::String
  Keyword = Strict::String.enum("special-purpose", "osi-approved")
end

class Identifier < Dry::Struct
  attribute :identifier, Types::String
  attribute :scheme,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      identifier: d.fetch("identifier"),
      scheme:     d.fetch("scheme"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "identifier" => identifier,
      "scheme"     => scheme,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Keyword
  SpecialPurpose = "special-purpose"
  OSIApproved    = "osi-approved"
end

class Link < Dry::Struct
  attribute :note, Types::String
  attribute :url,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      note: d.fetch("note"),
      url:  d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "note" => note,
      "url"  => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Text < Dry::Struct
  attribute :media_type, Types::String
  attribute :title,      Types::String
  attribute :url,        Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      media_type: d.fetch("media_type"),
      title:      d.fetch("title"),
      url:        d.fetch("url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "media_type" => media_type,
      "title"      => title,
      "url"        => url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevelElement < Dry::Struct
  attribute :id,             Types::String
  attribute :identifiers,    Types.Array(Identifier)
  attribute :keywords,       Types.Array(Types::Keyword)
  attribute :links,          Types.Array(Link)
  attribute :other_names,    Types.Array(Types::Any)
  attribute :superseded_by,  Types::Nil
  attribute :text,           Types.Array(Text)
  attribute :top_level_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      id:             d.fetch("id"),
      identifiers:    d.fetch("identifiers").map { |x| Identifier.from_dynamic!(x) },
      keywords:       d.fetch("keywords"),
      links:          d.fetch("links").map { |x| Link.from_dynamic!(x) },
      other_names:    d.fetch("other_names"),
      superseded_by:  d.fetch("superseded_by"),
      text:           d.fetch("text").map { |x| Text.from_dynamic!(x) },
      top_level_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "id"            => id,
      "identifiers"   => identifiers.map { |x| x.to_dynamic },
      "keywords"      => keywords,
      "links"         => links.map { |x| x.to_dynamic },
      "other_names"   => other_names,
      "superseded_by" => superseded_by,
      "text"          => text.map { |x| x.to_dynamic },
      "name"          => top_level_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel
  def self.from_json!(json)
    top_level = JSON.parse(json, quirks_mode: true).map { |x| TopLevelElement.from_dynamic!(x) }
    top_level.define_singleton_method(:to_json) do
      JSON.generate(self.map { |x| x.to_dynamic })
    end
    top_level
  end
end
