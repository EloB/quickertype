require "json"

class TopLevel
  include JSON::Serializable

  property data : Hash(String, Datum)

  property description : Description
end

class Datum
  include JSON::Serializable

  property anomaly : String

  property value : String
end

class Description
  include JSON::Serializable

  property base_period : String

  property missing : Int64

  property title : String
end
