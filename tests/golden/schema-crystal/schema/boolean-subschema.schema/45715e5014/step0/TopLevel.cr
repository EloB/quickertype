require "json"

class TopLevel
  include JSON::Serializable

  property disallowed : JSON::Any?

  property empty : Array(JSON::Any?)

  property foo : String

  property impossible : JSON::Any?
end
