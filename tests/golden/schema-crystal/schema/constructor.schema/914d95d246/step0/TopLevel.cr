require "json"

class TopLevel
  include JSON::Serializable

  property constructor : UnionConstructor?
end

class Constructor
  include JSON::Serializable

end

alias UnionConstructor = Constructor | Float64
