require "json"

class TopLevel
  include JSON::Serializable

  property states : Array(StateElement)
end

class StateElement
  include JSON::Serializable

  property state : StateState
end

class StateState
  include JSON::Serializable

  property state_id : String

  property state_name : String
end
