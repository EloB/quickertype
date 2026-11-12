require "json"

class TopLevel
  include JSON::Serializable

  property open : Array(Open)

  property tuple : Array(Open)
end

alias Open = Int64 | Bool
