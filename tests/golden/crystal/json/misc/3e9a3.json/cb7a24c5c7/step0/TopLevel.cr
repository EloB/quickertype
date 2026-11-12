require "json"

class TopLevel
  include JSON::Serializable

  property message : Array(JSON::Any?)

  @[JSON::Field(key: "responseTime")]
  property response_time : Int64

  @[JSON::Field(key: "Results")]
  property results : Results

  property status : String
end

class Results
  include JSON::Serializable

  property series : Array(Series)
end

class Series
  include JSON::Serializable

  property data : Array(Datum)

  @[JSON::Field(key: "seriesID")]
  property series_id : String
end

class Datum
  include JSON::Serializable

  property footnotes : Array(Footnote)

  property period : String

  @[JSON::Field(key: "periodName")]
  property period_name : String

  property value : String

  property year : String
end

class Footnote
  include JSON::Serializable

  property code : String?

  property text : String?
end
