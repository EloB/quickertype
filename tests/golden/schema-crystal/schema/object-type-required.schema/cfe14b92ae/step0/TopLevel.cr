require "json"

class TopLevel
  include JSON::Serializable

  property empty : Empty

  property foo : String

  property bar : String?
end

class Empty
  include JSON::Serializable

end
