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
  Type   = Strict::String.enum("string")
end

module Type
  String = "string"
end

class ClickURL < Dry::Struct
  attribute :click_url_type, Types::Type
  attribute :description,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      click_url_type: d.fetch("type"),
      description:    d.fetch("description"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"        => click_url_type,
      "description" => description,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Properties < Dry::Struct
  attribute :click_url,       ClickURL
  attribute :country,         ClickURL
  attribute :description,     ClickURL
  attribute :expiration_date, ClickURL
  attribute :id,              ClickURL
  attribute :industry,        ClickURL
  attribute :report_type,     ClickURL
  attribute :source_industry, ClickURL
  attribute :title,           ClickURL
  attribute :url,             ClickURL

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      click_url:       ClickURL.from_dynamic!(d.fetch("click_url")),
      country:         ClickURL.from_dynamic!(d.fetch("country")),
      description:     ClickURL.from_dynamic!(d.fetch("description")),
      expiration_date: ClickURL.from_dynamic!(d.fetch("expiration_date")),
      id:              ClickURL.from_dynamic!(d.fetch("id")),
      industry:        ClickURL.from_dynamic!(d.fetch("industry")),
      report_type:     ClickURL.from_dynamic!(d.fetch("report_type")),
      source_industry: ClickURL.from_dynamic!(d.fetch("source_industry")),
      title:           ClickURL.from_dynamic!(d.fetch("title")),
      url:             ClickURL.from_dynamic!(d.fetch("url")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "click_url"       => click_url.to_dynamic,
      "country"         => country.to_dynamic,
      "description"     => description.to_dynamic,
      "expiration_date" => expiration_date.to_dynamic,
      "id"              => id.to_dynamic,
      "industry"        => industry.to_dynamic,
      "report_type"     => report_type.to_dynamic,
      "source_industry" => source_industry.to_dynamic,
      "title"           => title.to_dynamic,
      "url"             => url.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Report < Dry::Struct
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
  attribute :report, Report

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      report: Report.from_dynamic!(d.fetch("Report")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Report" => report.to_dynamic,
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
  attribute :parameter_format, Types::Type
  attribute :parameter_in,     Types::String
  attribute :parameter_name,   Types::String
  attribute :parameter_type,   Types::Type
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

class Items < Dry::Struct
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

class Schema < Dry::Struct
  attribute :items,       Items
  attribute :schema_type, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      items:       Items.from_dynamic!(d.fetch("items")),
      schema_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "items" => items.to_dynamic,
      "type"  => schema_type,
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

class MarketResearchLibrarySearch < Dry::Struct
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
  attribute :market_research_library_search, MarketResearchLibrarySearch

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      market_research_library_search: MarketResearchLibrarySearch.from_dynamic!(d.fetch("/market_research_library/search")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "/market_research_library/search" => market_research_library_search.to_dynamic,
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
