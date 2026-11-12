# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.results.series.first.data.first.footnotes
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Hash    = Strict::Hash
  String  = Strict::String
end

class Footnote < Dry::Struct
  attribute :code, Types::String.optional
  attribute :text, Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      code: d.key?("code") ? Types::String[d["code"]] : nil,
      text: d.key?("text") ? Types::String[d["text"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "code" => code,
      "text" => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Datum < Dry::Struct
  attribute :footnotes,   Types.Array(Footnote)
  attribute :period,      Types::String
  attribute :period_name, Types::String
  attribute :value,       Types::String
  attribute :year,        Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      footnotes:   d.fetch("footnotes").map { |x| Footnote.from_dynamic!(x) },
      period:      d.fetch("period"),
      period_name: d.fetch("periodName"),
      value:       d.fetch("value"),
      year:        d.fetch("year"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "footnotes"  => footnotes.map { |x| x.to_dynamic },
      "period"     => period,
      "periodName" => period_name,
      "value"      => value,
      "year"       => year,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Series < Dry::Struct
  attribute :data,      Types.Array(Datum)
  attribute :series_id, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      data:      d.fetch("data").map { |x| Datum.from_dynamic!(x) },
      series_id: d.fetch("seriesID"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "data"     => data.map { |x| x.to_dynamic },
      "seriesID" => series_id,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Results < Dry::Struct
  attribute :series, Types.Array(Series)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      series: d.fetch("series").map { |x| Series.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "series" => series.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :message,       Types.Array(Types::Any)
  attribute :response_time, Types::Integer
  attribute :results,       Results
  attribute :status,        Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      message:       d.fetch("message"),
      response_time: d.fetch("responseTime"),
      results:       Results.from_dynamic!(d.fetch("Results")),
      status:        d.fetch("status"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "message"      => message,
      "responseTime" => response_time,
      "Results"      => results.to_dynamic,
      "status"       => status,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
