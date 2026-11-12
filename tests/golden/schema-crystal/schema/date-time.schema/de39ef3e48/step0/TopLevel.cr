require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "complex-union-array")]
  property complex_union_array : Array(ComplexUnionArray)

  property date : String

  @[JSON::Field(key: "date-time")]
  property date_time : String

  @[JSON::Field(key: "local-date-class")]
  property local_date_class : LocalDate?

  @[JSON::Field(key: "offset-date-time-class")]
  property offset_date_time_class : OffsetDateTime?

  @[JSON::Field(key: "offset-time-class")]
  property offset_time_class : OffsetTime?

  property time : String

  @[JSON::Field(key: "union-array")]
  property union_array : Array(String)
end

class LocalDate
  include JSON::Serializable

end

class OffsetDateTime
  include JSON::Serializable

end

class OffsetTime
  include JSON::Serializable

end

alias ComplexUnionArray = Int64 | String
