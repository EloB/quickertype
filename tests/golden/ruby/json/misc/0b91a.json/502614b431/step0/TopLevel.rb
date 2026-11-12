# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.results.first.topic.first
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

class Component < Dry::Struct
  attribute :component_name, Types::String
  attribute :uuid,           Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      component_name: d.fetch("name"),
      uuid:           d.fetch("uuid"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name" => component_name,
      "uuid" => uuid,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Result < Dry::Struct
  attribute :attachment, Types.Array(Types::Any)
  attribute :body,       Types::String
  attribute :changed,    Types::String
  attribute :component,  Types.Array(Component)
  attribute :created,    Types::String
  attribute :date,       Types::String
  attribute :image,      Types.Array(Types::Any)
  attribute :number,     Types::Nil
  attribute :teaser,     Types::Nil
  attribute :title,      Types::String
  attribute :topic,      Types.Array(Types::Any)
  attribute :url,        Types::String
  attribute :uuid,       Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)
  attribute :vuuid,      Types::String.constrained(format: /\A[0-9a-f]{8}-(?:[0-9a-f]{4}-){3}[0-9a-f]{12}\z/i)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      attachment: d.fetch("attachment"),
      body:       d.fetch("body"),
      changed:    d.fetch("changed"),
      component:  d.fetch("component").map { |x| Component.from_dynamic!(x) },
      created:    d.fetch("created"),
      date:       d.fetch("date"),
      image:      d.fetch("image"),
      number:     d.fetch("number"),
      teaser:     d.fetch("teaser"),
      title:      d.fetch("title"),
      topic:      d.fetch("topic"),
      url:        d.fetch("url"),
      uuid:       d.fetch("uuid"),
      vuuid:      d.fetch("vuuid"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "attachment" => attachment,
      "body"       => body,
      "changed"    => changed,
      "component"  => component.map { |x| x.to_dynamic },
      "created"    => created,
      "date"       => date,
      "image"      => image,
      "number"     => number,
      "teaser"     => teaser,
      "title"      => title,
      "topic"      => topic,
      "url"        => url,
      "uuid"       => uuid,
      "vuuid"      => vuuid,
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
