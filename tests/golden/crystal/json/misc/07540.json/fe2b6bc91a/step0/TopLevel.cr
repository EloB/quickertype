require "json"

class TopLevel
  include JSON::Serializable

  property cookies : Cookies
end

class Cookies
  include JSON::Serializable

end
