require "json"

class TopLevel
  include JSON::Serializable

  property city : String

  property delay : String

  @[JSON::Field(key: "IATA")]
  property iata : String

  @[JSON::Field(key: "ICAO")]
  property icao : String

  property name : String

  property state : String

  property status : Status

  property weather : Weather
end

class Status
  include JSON::Serializable

  @[JSON::Field(key: "avgDelay")]
  property avg_delay : String

  @[JSON::Field(key: "closureBegin")]
  property closure_begin : String

  @[JSON::Field(key: "closureEnd")]
  property closure_end : String

  @[JSON::Field(key: "endTime")]
  property end_time : String

  @[JSON::Field(key: "maxDelay")]
  property max_delay : String

  @[JSON::Field(key: "minDelay")]
  property min_delay : String

  property reason : String

  @[JSON::Field(key: "type")]
  property status_type : String

  property trend : String
end

class Weather
  include JSON::Serializable

  property meta : Meta

  property temp : String

  property visibility : Float64

  property weather : String

  property wind : String
end

class Meta
  include JSON::Serializable

  property credit : String

  property updated : String

  property url : String
end
