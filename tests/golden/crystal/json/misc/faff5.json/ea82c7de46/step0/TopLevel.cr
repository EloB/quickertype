require "json"

class TopLevel
  include JSON::Serializable

  property response : Response
end

class Response
  include JSON::Serializable

  property player_count : Int64

  property result : Int64
end
