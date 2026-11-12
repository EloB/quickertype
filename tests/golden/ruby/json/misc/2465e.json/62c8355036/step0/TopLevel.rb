# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.schemes.first
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
end

class Annotations < Dry::Struct
  attribute :annotations_type, Types::String
  attribute :description,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      annotations_type: d.fetch("type"),
      description:      d.fetch("description"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"        => annotations_type,
      "description" => description,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Properties < Dry::Struct
  attribute :annotations,         Annotations
  attribute :datatype_properties, Annotations
  attribute :id,                  Annotations
  attribute :label,               Annotations
  attribute :properties_type,     Annotations
  attribute :sub_class_of,        Annotations

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      annotations:         Annotations.from_dynamic!(d.fetch("annotations")),
      datatype_properties: Annotations.from_dynamic!(d.fetch("datatype_properties")),
      id:                  Annotations.from_dynamic!(d.fetch("id")),
      label:               Annotations.from_dynamic!(d.fetch("label")),
      properties_type:     Annotations.from_dynamic!(d.fetch("type")),
      sub_class_of:        Annotations.from_dynamic!(d.fetch("sub_class_of")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "annotations"         => annotations.to_dynamic,
      "datatype_properties" => datatype_properties.to_dynamic,
      "id"                  => id.to_dynamic,
      "label"               => label.to_dynamic,
      "type"                => properties_type.to_dynamic,
      "sub_class_of"        => sub_class_of.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Taxonomy < Dry::Struct
  attribute :properties, Properties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      properties: Properties.from_dynamic!(d.fetch("properties")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "properties" => properties.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Definitions < Dry::Struct
  attribute :taxonomy, Taxonomy

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      taxonomy: Taxonomy.from_dynamic!(d.fetch("Taxonomy")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Taxonomy" => taxonomy.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Info < Dry::Struct
  attribute :description, Types::String
  attribute :title,       Types::String
  attribute :version,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description: d.fetch("description"),
      title:       d.fetch("title"),
      version:     d.fetch("version"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "description" => description,
      "title"       => title,
      "version"     => version,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Parameter < Dry::Struct
  attribute :description,      Types::String
  attribute :parameter_format, Types::String
  attribute :parameter_in,     Types::String
  attribute :parameter_name,   Types::String
  attribute :parameter_type,   Types::String
  attribute :required,         Types::Bool

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description:      d.fetch("description"),
      parameter_format: d.fetch("format"),
      parameter_in:     d.fetch("in"),
      parameter_name:   d.fetch("name"),
      parameter_type:   d.fetch("type"),
      required:         d.fetch("required"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "description" => description,
      "format"      => parameter_format,
      "in"          => parameter_in,
      "name"        => parameter_name,
      "type"        => parameter_type,
      "required"    => required,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Schema < Dry::Struct
  attribute :ref, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ref: d.fetch("$ref"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "$ref" => ref,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class The200N < Dry::Struct
  attribute :description, Types::String
  attribute :schema,      Schema

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description: d.fetch("description"),
      schema:      Schema.from_dynamic!(d.fetch("schema")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "description" => description,
      "schema"      => schema.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Responses < Dry::Struct
  attribute :the_200, The200N

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      the_200: The200N.from_dynamic!(d.fetch("200")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "200" => the_200.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Get < Dry::Struct
  attribute :description, Types::String
  attribute :parameters,  Types.Array(Parameter)
  attribute :responses,   Responses
  attribute :summary,     Types::String
  attribute :tags,        Types.Array(Types::String)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description: d.fetch("description"),
      parameters:  d.fetch("parameters").map { |x| Parameter.from_dynamic!(x) },
      responses:   Responses.from_dynamic!(d.fetch("responses")),
      summary:     d.fetch("summary"),
      tags:        d.fetch("tags"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "description" => description,
      "parameters"  => parameters.map { |x| x.to_dynamic },
      "responses"   => responses.to_dynamic,
      "summary"     => summary,
      "tags"        => tags,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ItaTaxonomiesSearch < Dry::Struct
  attribute :get, Get

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      get: Get.from_dynamic!(d.fetch("get")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "get" => get.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Paths < Dry::Struct
  attribute :ita_taxonomies_search, ItaTaxonomiesSearch

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ita_taxonomies_search: ItaTaxonomiesSearch.from_dynamic!(d.fetch("/ita_taxonomies/search")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "/ita_taxonomies/search" => ita_taxonomies_search.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :base_path,   Types::String
  attribute :definitions, Definitions
  attribute :host,        Types::String
  attribute :info,        Info
  attribute :paths,       Paths
  attribute :produces,    Types.Array(Types::String)
  attribute :schemes,     Types.Array(Types::String)
  attribute :swagger,     Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      base_path:   d.fetch("basePath"),
      definitions: Definitions.from_dynamic!(d.fetch("definitions")),
      host:        d.fetch("host"),
      info:        Info.from_dynamic!(d.fetch("info")),
      paths:       Paths.from_dynamic!(d.fetch("paths")),
      produces:    d.fetch("produces"),
      schemes:     d.fetch("schemes"),
      swagger:     d.fetch("swagger"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "basePath"    => base_path,
      "definitions" => definitions.to_dynamic,
      "host"        => host,
      "info"        => info.to_dynamic,
      "paths"       => paths.to_dynamic,
      "produces"    => produces,
      "schemes"     => schemes,
      "swagger"     => swagger,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
