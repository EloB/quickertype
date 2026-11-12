require "json"

class TopLevel
  include JSON::Serializable

  property mixed : Array(MixedElement?)
end

class MixedClass
  include JSON::Serializable

  property nested : String
end

alias MixedElement = Int64 | MixedClass | Bool | String
