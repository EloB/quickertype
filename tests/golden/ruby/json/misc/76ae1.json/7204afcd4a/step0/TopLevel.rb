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

  Bool       = Strict::Bool
  Hash       = Strict::Hash
  String     = Strict::String
  FormatEnum = Strict::String.enum("string")
  In         = Strict::String.enum("query")
  SchemaType = Strict::String.enum("array")
end

module FormatEnum
  String = "string"
end

class Property < Dry::Struct
  attribute :description,   Types::String
  attribute :property_type, Types::FormatEnum

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description:   d.fetch("description"),
      property_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "description" => description,
      "type"        => property_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Article < Dry::Struct
  attribute :properties, Types::Hash.meta(of: Property)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      properties: Types::Hash[d.fetch("properties")].map { |k, v| [k, Property.from_dynamic!(v)] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "properties" => properties.map { |k, v| [k, v.to_dynamic] }.to_h,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DeMinimisProperties < Dry::Struct
  attribute :countries,           Property
  attribute :country,             Property
  attribute :de_minimis_currency, Property
  attribute :de_minimis_value,    Property
  attribute :notes,               Property
  attribute :vat_amount,          Property
  attribute :vat_currency,        Property

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      countries:           Property.from_dynamic!(d.fetch("countries")),
      country:             Property.from_dynamic!(d.fetch("country")),
      de_minimis_currency: Property.from_dynamic!(d.fetch("de_minimis_currency")),
      de_minimis_value:    Property.from_dynamic!(d.fetch("de_minimis_value")),
      notes:               Property.from_dynamic!(d.fetch("notes")),
      vat_amount:          Property.from_dynamic!(d.fetch("vat_amount")),
      vat_currency:        Property.from_dynamic!(d.fetch("vat_currency")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "countries"           => countries.to_dynamic,
      "country"             => country.to_dynamic,
      "de_minimis_currency" => de_minimis_currency.to_dynamic,
      "de_minimis_value"    => de_minimis_value.to_dynamic,
      "notes"               => notes.to_dynamic,
      "vat_amount"          => vat_amount.to_dynamic,
      "vat_currency"        => vat_currency.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DeMinimis < Dry::Struct
  attribute :properties, DeMinimisProperties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      properties: DeMinimisProperties.from_dynamic!(d.fetch("properties")),
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

class FAQProperties < Dry::Struct
  attribute :answer,               Property
  attribute :countries,            Property
  attribute :first_published_date, Property
  attribute :id,                   Property
  attribute :industries,           Property
  attribute :last_published_date,  Property
  attribute :question,             Property
  attribute :topics,               Property
  attribute :trade_regions,        Property
  attribute :url,                  Property
  attribute :world_regions,        Property

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      answer:               Property.from_dynamic!(d.fetch("answer")),
      countries:            Property.from_dynamic!(d.fetch("countries")),
      first_published_date: Property.from_dynamic!(d.fetch("first_published_date")),
      id:                   Property.from_dynamic!(d.fetch("id")),
      industries:           Property.from_dynamic!(d.fetch("industries")),
      last_published_date:  Property.from_dynamic!(d.fetch("last_published_date")),
      question:             Property.from_dynamic!(d.fetch("question")),
      topics:               Property.from_dynamic!(d.fetch("topics")),
      trade_regions:        Property.from_dynamic!(d.fetch("trade_regions")),
      url:                  Property.from_dynamic!(d.fetch("url")),
      world_regions:        Property.from_dynamic!(d.fetch("world_regions")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "answer"               => answer.to_dynamic,
      "countries"            => countries.to_dynamic,
      "first_published_date" => first_published_date.to_dynamic,
      "id"                   => id.to_dynamic,
      "industries"           => industries.to_dynamic,
      "last_published_date"  => last_published_date.to_dynamic,
      "question"             => question.to_dynamic,
      "topics"               => topics.to_dynamic,
      "trade_regions"        => trade_regions.to_dynamic,
      "url"                  => url.to_dynamic,
      "world_regions"        => world_regions.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FAQ < Dry::Struct
  attribute :properties, FAQProperties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      properties: FAQProperties.from_dynamic!(d.fetch("properties")),
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

class ReportProperties < Dry::Struct
  attribute :countries,       Property
  attribute :description,     Property
  attribute :expiration_date, Property
  attribute :id,              Property
  attribute :industries,      Property
  attribute :ita_industries,  Property
  attribute :report_type,     Property
  attribute :title,           Property
  attribute :url,             Property

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      countries:       Property.from_dynamic!(d.fetch("countries")),
      description:     Property.from_dynamic!(d.fetch("description")),
      expiration_date: Property.from_dynamic!(d.fetch("expiration_date")),
      id:              Property.from_dynamic!(d.fetch("id")),
      industries:      Property.from_dynamic!(d.fetch("industries")),
      ita_industries:  Property.from_dynamic!(d.fetch("ita_industries")),
      report_type:     Property.from_dynamic!(d.fetch("report_type")),
      title:           Property.from_dynamic!(d.fetch("title")),
      url:             Property.from_dynamic!(d.fetch("url")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "countries"       => countries.to_dynamic,
      "description"     => description.to_dynamic,
      "expiration_date" => expiration_date.to_dynamic,
      "id"              => id.to_dynamic,
      "industries"      => industries.to_dynamic,
      "ita_industries"  => ita_industries.to_dynamic,
      "report_type"     => report_type.to_dynamic,
      "title"           => title.to_dynamic,
      "url"             => url.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Report < Dry::Struct
  attribute :properties, ReportProperties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      properties: ReportProperties.from_dynamic!(d.fetch("properties")),
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

class TaxonomyProperties < Dry::Struct
  attribute :annotations,         Property
  attribute :datatype_properties, Property
  attribute :id,                  Property
  attribute :label,               Property
  attribute :properties_type,     Property
  attribute :sub_class_of,        Property

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      annotations:         Property.from_dynamic!(d.fetch("annotations")),
      datatype_properties: Property.from_dynamic!(d.fetch("datatype_properties")),
      id:                  Property.from_dynamic!(d.fetch("id")),
      label:               Property.from_dynamic!(d.fetch("label")),
      properties_type:     Property.from_dynamic!(d.fetch("type")),
      sub_class_of:        Property.from_dynamic!(d.fetch("sub_class_of")),
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
  attribute :properties, TaxonomyProperties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      properties: TaxonomyProperties.from_dynamic!(d.fetch("properties")),
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
  attribute :article,             Article
  attribute :center,              Article
  attribute :de_minimis,          DeMinimis
  attribute :event,               Article
  attribute :faq,                 FAQ
  attribute :lead,                Article
  attribute :list,                Article
  attribute :market_intelligence, Article
  attribute :office,              Article
  attribute :provider,            Article
  attribute :rate,                Article
  attribute :report,              Report
  attribute :taxonomy,            Taxonomy

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      article:             Article.from_dynamic!(d.fetch("Article")),
      center:              Article.from_dynamic!(d.fetch("Center")),
      de_minimis:          DeMinimis.from_dynamic!(d.fetch("DeMinimis")),
      event:               Article.from_dynamic!(d.fetch("Event")),
      faq:                 FAQ.from_dynamic!(d.fetch("FAQ")),
      lead:                Article.from_dynamic!(d.fetch("Lead")),
      list:                Article.from_dynamic!(d.fetch("List")),
      market_intelligence: Article.from_dynamic!(d.fetch("MarketIntelligence")),
      office:              Article.from_dynamic!(d.fetch("Office")),
      provider:            Article.from_dynamic!(d.fetch("Provider")),
      rate:                Article.from_dynamic!(d.fetch("Rate")),
      report:              Report.from_dynamic!(d.fetch("Report")),
      taxonomy:            Taxonomy.from_dynamic!(d.fetch("Taxonomy")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Article"            => article.to_dynamic,
      "Center"             => center.to_dynamic,
      "DeMinimis"          => de_minimis.to_dynamic,
      "Event"              => event.to_dynamic,
      "FAQ"                => faq.to_dynamic,
      "Lead"               => lead.to_dynamic,
      "List"               => list.to_dynamic,
      "MarketIntelligence" => market_intelligence.to_dynamic,
      "Office"             => office.to_dynamic,
      "Provider"           => provider.to_dynamic,
      "Rate"               => rate.to_dynamic,
      "Report"             => report.to_dynamic,
      "Taxonomy"           => taxonomy.to_dynamic,
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

module In
  Query = "query"
end

class Parameter < Dry::Struct
  attribute :description,      Types::String
  attribute :parameter_format, Types::FormatEnum
  attribute :parameter_in,     Types::In
  attribute :parameter_name,   Types::String
  attribute :parameter_type,   Types::FormatEnum
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

class ItemsClass < Dry::Struct
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

class The200_1 < Dry::Struct
  attribute :description, Types::String
  attribute :schema,      ItemsClass

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description: d.fetch("description"),
      schema:      ItemsClass.from_dynamic!(d.fetch("schema")),
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

class Responses1 < Dry::Struct
  attribute :the_200, The200_1

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      the_200: The200_1.from_dynamic!(d.fetch("200")),
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

class BusinessServiceProvidersSearchGet < Dry::Struct
  attribute :description, Types::String
  attribute :parameters,  Types.Array(Parameter)
  attribute :responses,   Responses1
  attribute :summary,     Types::String
  attribute :tags,        Types.Array(Types::String)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description: d.fetch("description"),
      parameters:  d.fetch("parameters").map { |x| Parameter.from_dynamic!(x) },
      responses:   Responses1.from_dynamic!(d.fetch("responses")),
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

class BusinessServiceProvidersSearchClass < Dry::Struct
  attribute :get, BusinessServiceProvidersSearchGet

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      get: BusinessServiceProvidersSearchGet.from_dynamic!(d.fetch("get")),
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

module SchemaType
  Array = "array"
end

class Schema1 < Dry::Struct
  attribute :items,       ItemsClass
  attribute :schema_type, Types::SchemaType

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      items:       ItemsClass.from_dynamic!(d.fetch("items")),
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

class The200_2 < Dry::Struct
  attribute :description, Types::String
  attribute :schema,      Schema1

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description: d.fetch("description"),
      schema:      Schema1.from_dynamic!(d.fetch("schema")),
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

class Responses2 < Dry::Struct
  attribute :the_200, The200_2

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      the_200: The200_2.from_dynamic!(d.fetch("200")),
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

class ConsolidatedScreeningListSearchGet < Dry::Struct
  attribute :description, Types::String
  attribute :parameters,  Types.Array(Parameter)
  attribute :responses,   Responses2
  attribute :summary,     Types::String
  attribute :tags,        Types.Array(Types::String)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      description: d.fetch("description"),
      parameters:  d.fetch("parameters").map { |x| Parameter.from_dynamic!(x) },
      responses:   Responses2.from_dynamic!(d.fetch("responses")),
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

class ConsolidatedScreeningListSearchClass < Dry::Struct
  attribute :get, ConsolidatedScreeningListSearchGet

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      get: ConsolidatedScreeningListSearchGet.from_dynamic!(d.fetch("get")),
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
  attribute :business_service_providers_search,  BusinessServiceProvidersSearchClass
  attribute :consolidated_screening_list_search, ConsolidatedScreeningListSearchClass
  attribute :de_minimis_search,                  ConsolidatedScreeningListSearchClass
  attribute :ita_faqs_search,                    ConsolidatedScreeningListSearchClass
  attribute :ita_office_locations_search,        ConsolidatedScreeningListSearchClass
  attribute :ita_taxonomies_search,              BusinessServiceProvidersSearchClass
  attribute :ita_zipcode_to_post_search,         BusinessServiceProvidersSearchClass
  attribute :market_intelligence_search,         ConsolidatedScreeningListSearchClass
  attribute :market_research_library_search,     ConsolidatedScreeningListSearchClass
  attribute :tariff_rates_search,                ConsolidatedScreeningListSearchClass
  attribute :trade_articles_search,              ConsolidatedScreeningListSearchClass
  attribute :trade_events_search,                ConsolidatedScreeningListSearchClass
  attribute :trade_leads_search,                 ConsolidatedScreeningListSearchClass

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      business_service_providers_search:  BusinessServiceProvidersSearchClass.from_dynamic!(d.fetch("/business_service_providers/search")),
      consolidated_screening_list_search: ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/consolidated_screening_list/search")),
      de_minimis_search:                  ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/de_minimis/search")),
      ita_faqs_search:                    ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/ita_faqs/search")),
      ita_office_locations_search:        ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/ita_office_locations/search")),
      ita_taxonomies_search:              BusinessServiceProvidersSearchClass.from_dynamic!(d.fetch("/ita_taxonomies/search")),
      ita_zipcode_to_post_search:         BusinessServiceProvidersSearchClass.from_dynamic!(d.fetch("/ita_zipcode_to_post/search")),
      market_intelligence_search:         ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/market_intelligence/search")),
      market_research_library_search:     ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/market_research_library/search")),
      tariff_rates_search:                ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/tariff_rates/search")),
      trade_articles_search:              ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/trade_articles/search")),
      trade_events_search:                ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/trade_events/search")),
      trade_leads_search:                 ConsolidatedScreeningListSearchClass.from_dynamic!(d.fetch("/trade_leads/search")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "/business_service_providers/search"  => business_service_providers_search.to_dynamic,
      "/consolidated_screening_list/search" => consolidated_screening_list_search.to_dynamic,
      "/de_minimis/search"                  => de_minimis_search.to_dynamic,
      "/ita_faqs/search"                    => ita_faqs_search.to_dynamic,
      "/ita_office_locations/search"        => ita_office_locations_search.to_dynamic,
      "/ita_taxonomies/search"              => ita_taxonomies_search.to_dynamic,
      "/ita_zipcode_to_post/search"         => ita_zipcode_to_post_search.to_dynamic,
      "/market_intelligence/search"         => market_intelligence_search.to_dynamic,
      "/market_research_library/search"     => market_research_library_search.to_dynamic,
      "/tariff_rates/search"                => tariff_rates_search.to_dynamic,
      "/trade_articles/search"              => trade_articles_search.to_dynamic,
      "/trade_events/search"                => trade_events_search.to_dynamic,
      "/trade_leads/search"                 => trade_leads_search.to_dynamic,
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
