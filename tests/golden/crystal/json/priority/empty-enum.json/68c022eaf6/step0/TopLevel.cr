require "json"

class TopLevel
  include JSON::Serializable

  property foo : Array(Foo)
end

class Foo
  include JSON::Serializable

  property bar : String?
end
