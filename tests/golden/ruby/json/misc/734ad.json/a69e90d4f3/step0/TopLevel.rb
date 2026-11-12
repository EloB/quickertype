# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.results.first.acronym.nil?
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
  Status  = Strict::String.enum("active", "inactive")
end

class Facets < Dry::Struct

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

module Status
  Active   = "active"
  Inactive = "inactive"
end

class Result < Dry::Struct
  attribute :acronym,                     Types::String.optional
  attribute :activity_consult_committees, Types::String
  attribute :activity_eu_legislative,     Types::String
  attribute :activity_expert_groups,      Types::String
  attribute :activity_high_level_groups,  Types::String
  attribute :activity_industry_forums,    Types::String
  attribute :activity_inter_groups,       Types::String
  attribute :activity_other,              Types::String.optional
  attribute :activity_relevant_comm,      Types::String
  attribute :be_office_country,           Types::String.optional
  attribute :be_office_lat,               Types::Double.optional.optional
  attribute :be_office_lon,               Types::Double.optional.optional
  attribute :be_office_phone,             Types::String.optional
  attribute :be_office_post_code,         Types::String.optional.optional
  attribute :be_office_postbox,           Types::String.optional.optional
  attribute :be_office_street,            Types::String.optional
  attribute :be_office_town,              Types::String.optional
  attribute :code_of_conduct,             Types::String
  attribute :contact_country,             Types::Integer
  attribute :created_at,                  Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :entity,                      Types::String
  attribute :goals,                       Types::String
  attribute :head,                        Types::String
  attribute :head_office_country,         Types::String
  attribute :head_office_lat,             Types::Double.optional
  attribute :head_office_lon,             Types::Double.optional
  attribute :head_office_phone,           Types::String
  attribute :head_office_post_code,       Types::String.optional
  attribute :head_office_postbox,         Types::String.optional
  attribute :head_office_street,          Types::String
  attribute :head_office_town,            Types::String
  attribute :id,                          Types::String
  attribute :identification_code,         Types::String
  attribute :info_members,                Types::String
  attribute :last_update_date,            Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :legal,                       Types::String
  attribute :legal_status,                Types::String
  attribute :main_category,               Types::Integer
  attribute :main_category_title,         Types::String
  attribute :members,                     Types::Integer
  attribute :members_100,                 Types::Integer.optional
  attribute :members_25,                  Types::Integer.optional
  attribute :members_50,                  Types::Integer.optional
  attribute :members_75,                  Types::Integer.optional
  attribute :members_fte,                 Types::Double
  attribute :native_name,                 Types::Nil
  attribute :networking,                  Types::String.optional
  attribute :number_of_natural_persons,   Types::Integer.optional
  attribute :other_code_of_conduct,       Types::String.optional
  attribute :registration_date,           Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :result_name,                 Types::String
  attribute :status,                      Types::Status
  attribute :structure_members,           Types::String
  attribute :sub_category,                Types::Integer
  attribute :sub_category_title,          Types::String
  attribute :updated_at,                  Types::String.constrained(format: /\A\d{4}-\d\d-\d\dT\d\d:\d\d:\d\d(?:\.\d+)?(?:Z|[+-]\d\d:\d\d)\z/i)
  attribute :uri,                         Types::String
  attribute :web_site_url,                Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      acronym:                     d.fetch("acronym"),
      activity_consult_committees: d.fetch("activity_consult_committees"),
      activity_eu_legislative:     d.fetch("activity_eu_legislative"),
      activity_expert_groups:      d.fetch("activity_expert_groups"),
      activity_high_level_groups:  d.fetch("activity_high_level_groups"),
      activity_industry_forums:    d.fetch("activity_industry_forums"),
      activity_inter_groups:       d.fetch("activity_inter_groups"),
      activity_other:              d.fetch("activity_other"),
      activity_relevant_comm:      d.fetch("activity_relevant_comm"),
      be_office_country:           d.key?("be_office_country") ? Types::String[d["be_office_country"]] : nil,
      be_office_lat:               d["be_office_lat"],
      be_office_lon:               d["be_office_lon"],
      be_office_phone:             d.key?("be_office_phone") ? Types::String[d["be_office_phone"]] : nil,
      be_office_post_code:         d["be_office_post_code"],
      be_office_postbox:           d["be_office_postbox"],
      be_office_street:            d.key?("be_office_street") ? Types::String[d["be_office_street"]] : nil,
      be_office_town:              d.key?("be_office_town") ? Types::String[d["be_office_town"]] : nil,
      code_of_conduct:             d.fetch("code_of_conduct"),
      contact_country:             d.fetch("contact_country"),
      created_at:                  d.fetch("created_at"),
      entity:                      d.fetch("entity"),
      goals:                       d.fetch("goals"),
      head:                        d.fetch("head"),
      head_office_country:         d.fetch("head_office_country"),
      head_office_lat:             d.fetch("head_office_lat"),
      head_office_lon:             d.fetch("head_office_lon"),
      head_office_phone:           d.fetch("head_office_phone"),
      head_office_post_code:       d.fetch("head_office_post_code"),
      head_office_postbox:         d.fetch("head_office_postbox"),
      head_office_street:          d.fetch("head_office_street"),
      head_office_town:            d.fetch("head_office_town"),
      id:                          d.fetch("id"),
      identification_code:         d.fetch("identification_code"),
      info_members:                d.fetch("info_members"),
      last_update_date:            d.fetch("last_update_date"),
      legal:                       d.fetch("legal"),
      legal_status:                d.fetch("legal_status"),
      main_category:               d.fetch("main_category"),
      main_category_title:         d.fetch("main_category_title"),
      members:                     d.fetch("members"),
      members_100:                 d.fetch("members_100"),
      members_25:                  d.fetch("members_25"),
      members_50:                  d.fetch("members_50"),
      members_75:                  d.fetch("members_75"),
      members_fte:                 d.fetch("members_fte"),
      native_name:                 d.fetch("native_name"),
      networking:                  d.fetch("networking"),
      number_of_natural_persons:   d.fetch("number_of_natural_persons"),
      other_code_of_conduct:       d.fetch("other_code_of_conduct"),
      registration_date:           d.fetch("registration_date"),
      result_name:                 d.fetch("name"),
      status:                      d.fetch("status"),
      structure_members:           d.fetch("structure_members"),
      sub_category:                d.fetch("sub_category"),
      sub_category_title:          d.fetch("sub_category_title"),
      updated_at:                  d.fetch("updated_at"),
      uri:                         d.fetch("uri"),
      web_site_url:                d.fetch("web_site_url"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "acronym"                     => acronym,
      "activity_consult_committees" => activity_consult_committees,
      "activity_eu_legislative"     => activity_eu_legislative,
      "activity_expert_groups"      => activity_expert_groups,
      "activity_high_level_groups"  => activity_high_level_groups,
      "activity_industry_forums"    => activity_industry_forums,
      "activity_inter_groups"       => activity_inter_groups,
      "activity_other"              => activity_other,
      "activity_relevant_comm"      => activity_relevant_comm,
      "be_office_country"           => be_office_country,
      "be_office_lat"               => be_office_lat,
      "be_office_lon"               => be_office_lon,
      "be_office_phone"             => be_office_phone,
      "be_office_post_code"         => be_office_post_code,
      "be_office_postbox"           => be_office_postbox,
      "be_office_street"            => be_office_street,
      "be_office_town"              => be_office_town,
      "code_of_conduct"             => code_of_conduct,
      "contact_country"             => contact_country,
      "created_at"                  => created_at,
      "entity"                      => entity,
      "goals"                       => goals,
      "head"                        => head,
      "head_office_country"         => head_office_country,
      "head_office_lat"             => head_office_lat,
      "head_office_lon"             => head_office_lon,
      "head_office_phone"           => head_office_phone,
      "head_office_post_code"       => head_office_post_code,
      "head_office_postbox"         => head_office_postbox,
      "head_office_street"          => head_office_street,
      "head_office_town"            => head_office_town,
      "id"                          => id,
      "identification_code"         => identification_code,
      "info_members"                => info_members,
      "last_update_date"            => last_update_date,
      "legal"                       => legal,
      "legal_status"                => legal_status,
      "main_category"               => main_category,
      "main_category_title"         => main_category_title,
      "members"                     => members,
      "members_100"                 => members_100,
      "members_25"                  => members_25,
      "members_50"                  => members_50,
      "members_75"                  => members_75,
      "members_fte"                 => members_fte,
      "native_name"                 => native_name,
      "networking"                  => networking,
      "number_of_natural_persons"   => number_of_natural_persons,
      "other_code_of_conduct"       => other_code_of_conduct,
      "registration_date"           => registration_date,
      "name"                        => result_name,
      "status"                      => status,
      "structure_members"           => structure_members,
      "sub_category"                => sub_category,
      "sub_category_title"          => sub_category_title,
      "updated_at"                  => updated_at,
      "uri"                         => uri,
      "web_site_url"                => web_site_url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :count,          Types::Integer
  attribute :facets,         Facets
  attribute :limit,          Types::Integer
  attribute :offset,         Types::Integer
  attribute :previous,       Types::Bool
  attribute :results,        Types.Array(Result)
  attribute :top_level_next, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:          d.fetch("count"),
      facets:         Facets.from_dynamic!(d.fetch("facets")),
      limit:          d.fetch("limit"),
      offset:         d.fetch("offset"),
      previous:       d.fetch("previous"),
      results:        d.fetch("results").map { |x| Result.from_dynamic!(x) },
      top_level_next: d.fetch("next"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"    => count,
      "facets"   => facets.to_dynamic,
      "limit"    => limit,
      "offset"   => offset,
      "previous" => previous,
      "results"  => results.map { |x| x.to_dynamic },
      "next"     => top_level_next,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
