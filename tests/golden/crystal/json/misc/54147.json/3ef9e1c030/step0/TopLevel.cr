require "json"

class TopLevel
  include JSON::Serializable

  property args : Args

  property data : String

  property files : Args

  property form : Args

  property headers : Headers

  property origin : String

  property url : String
end

class Args
  include JSON::Serializable

end

class Headers
  include JSON::Serializable

  @[JSON::Field(key: "Accept-Encoding")]
  property accept_encoding : String

  @[JSON::Field(key: "Connection")]
  property connection : String

  @[JSON::Field(key: "Host")]
  property host : String

  @[JSON::Field(key: "User-Agent")]
  property user_agent : String
end
