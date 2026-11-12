# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.results.first.location.administrative_area
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class ResponseInfo < Dry::Struct
  attribute :developer_message, Types::String
  attribute :status,            Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      developer_message: d.fetch("developerMessage"),
      status:            d.fetch("status"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "developerMessage" => developer_message,
      "status"           => status,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Resultset < Dry::Struct
  attribute :count,    Types::Integer
  attribute :page,     Types::Integer
  attribute :pagesize, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      count:    d.fetch("count"),
      page:     d.fetch("page"),
      pagesize: d.fetch("pagesize"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "count"    => count,
      "page"     => page,
      "pagesize" => pagesize,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Metadata < Dry::Struct
  attribute :execution_time, Types::Double
  attribute :response_info,  ResponseInfo
  attribute :resultset,      Resultset

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      execution_time: d.fetch("executionTime"),
      response_info:  ResponseInfo.from_dynamic!(d.fetch("responseInfo")),
      resultset:      Resultset.from_dynamic!(d.fetch("resultset")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "executionTime" => execution_time,
      "responseInfo"  => response_info.to_dynamic,
      "resultset"     => resultset.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class HiringOrg < Dry::Struct
  attribute :hiring_org_name, Types::String
  attribute :uuid,            Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      hiring_org_name: d.fetch("name"),
      uuid:            d.fetch("uuid"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name" => hiring_org_name,
      "uuid" => uuid,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Location < Dry::Struct
  attribute :administrative_area,    Types::String
  attribute :country,                Types::String
  attribute :fax_number,             Types::String
  attribute :locality,               Types::String
  attribute :mobile_number,          Types::String
  attribute :phone_number,           Types::String
  attribute :phone_number_extension, Types::String
  attribute :postal_code,            Types::String
  attribute :sub_premise,            Types::Nil
  attribute :thoroughfare,           Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      administrative_area:    d.fetch("administrative_area"),
      country:                d.fetch("country"),
      fax_number:             d.fetch("fax_number"),
      locality:               d.fetch("locality"),
      mobile_number:          d.fetch("mobile_number"),
      phone_number:           d.fetch("phone_number"),
      phone_number_extension: d.fetch("phone_number_extension"),
      postal_code:            d.fetch("postal_code"),
      sub_premise:            d.fetch("sub_premise"),
      thoroughfare:           d.fetch("thoroughfare"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "administrative_area"    => administrative_area,
      "country"                => country,
      "fax_number"             => fax_number,
      "locality"               => locality,
      "mobile_number"          => mobile_number,
      "phone_number"           => phone_number,
      "phone_number_extension" => phone_number_extension,
      "postal_code"            => postal_code,
      "sub_premise"            => sub_premise,
      "thoroughfare"           => thoroughfare,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Result < Dry::Struct
  attribute :about_office,        Types::String
  attribute :application_process, Types::String
  attribute :body,                Types::String
  attribute :changed,             Types::String
  attribute :created,             Types::String
  attribute :deadline,            Types::Nil
  attribute :hiring_office,       Types::Nil
  attribute :hiring_org,          HiringOrg
  attribute :job_id,              Types::Nil
  attribute :language,            Types::String
  attribute :location,            Location
  attribute :num_positions,       Types::String
  attribute :position,            Types::String
  attribute :practice_area,       Types::String
  attribute :qualifications,      Types::String
  attribute :relocation_expenses, Types::Nil
  attribute :salary,              Types::String
  attribute :title,               Types::String
  attribute :travel,              Types::String
  attribute :url,                 Types::String
  attribute :uuid,                Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)
  attribute :vuuid,               Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      about_office:        d.fetch("about_office"),
      application_process: d.fetch("application_process"),
      body:                d.fetch("body"),
      changed:             d.fetch("changed"),
      created:             d.fetch("created"),
      deadline:            d.fetch("deadline"),
      hiring_office:       d.fetch("hiring_office"),
      hiring_org:          HiringOrg.from_dynamic!(d.fetch("hiring_org")),
      job_id:              d.fetch("job_id"),
      language:            d.fetch("language"),
      location:            Location.from_dynamic!(d.fetch("location")),
      num_positions:       d.fetch("num_positions"),
      position:            d.fetch("position"),
      practice_area:       d.fetch("practice_area"),
      qualifications:      d.fetch("qualifications"),
      relocation_expenses: d.fetch("relocation_expenses"),
      salary:              d.fetch("salary"),
      title:               d.fetch("title"),
      travel:              d.fetch("travel"),
      url:                 d.fetch("url"),
      uuid:                d.fetch("uuid"),
      vuuid:               d.fetch("vuuid"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "about_office"        => about_office,
      "application_process" => application_process,
      "body"                => body,
      "changed"             => changed,
      "created"             => created,
      "deadline"            => deadline,
      "hiring_office"       => hiring_office,
      "hiring_org"          => hiring_org.to_dynamic,
      "job_id"              => job_id,
      "language"            => language,
      "location"            => location.to_dynamic,
      "num_positions"       => num_positions,
      "position"            => position,
      "practice_area"       => practice_area,
      "qualifications"      => qualifications,
      "relocation_expenses" => relocation_expenses,
      "salary"              => salary,
      "title"               => title,
      "travel"              => travel,
      "url"                 => url,
      "uuid"                => uuid,
      "vuuid"               => vuuid,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :metadata, Metadata
  attribute :results,  Types.Array(Result)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      metadata: Metadata.from_dynamic!(d.fetch("metadata")),
      results:  d.fetch("results").map { |x| Result.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "metadata" => metadata.to_dynamic,
      "results"  => results.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
