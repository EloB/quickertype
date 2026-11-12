require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "copyWith")]
  property copy_with : Int64

  property name : String
end
