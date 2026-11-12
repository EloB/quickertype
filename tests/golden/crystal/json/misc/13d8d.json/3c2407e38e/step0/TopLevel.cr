require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property category : String

  property context : String

  property id : Int64

  property location : Location

  property location_subtype : String

  property location_type : String

  property month : String

  property outcome_status : OutcomeStatus

  property persistent_id : String
end

class Location
  include JSON::Serializable

  property latitude : String

  property longitude : String

  property street : Street
end

class Street
  include JSON::Serializable

  property id : Int64

  property name : String
end

class OutcomeStatus
  include JSON::Serializable

  property category : String

  property date : String
end
