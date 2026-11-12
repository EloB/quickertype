require "json"

# Postman collection
class TopLevel
  include JSON::Serializable

  property item : Array(TopLevel)?

  property name : String?

  property response : Array(Response)?
end

class Response
  include JSON::Serializable

  property body : String?
end
