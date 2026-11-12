require "json"

class TopLevel
  include JSON::Serializable

  property tuple : Array(TupleElement)
end

alias TupleElement = Int64 | Bool
