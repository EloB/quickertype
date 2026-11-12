require "json"

class TopLevel
  include JSON::Serializable

  property data : Hash(String, String)

  property description : Description
end

class Description
  include JSON::Serializable

  property base_period : String

  property missing : String

  property title : String

  property units : String
end
