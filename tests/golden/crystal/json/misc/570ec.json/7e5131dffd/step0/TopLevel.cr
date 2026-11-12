require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property id : String

  property identifiers : Array(Identifier)

  property keywords : Array(String)

  property links : Array(LinkElement)

  property name : String

  property other_names : Array(OtherName)

  property superseded_by : Nil

  property text : Array(Text)
end

class Identifier
  include JSON::Serializable

  property identifier : String

  property scheme : String
end

class LinkElement
  include JSON::Serializable

  property note : String

  property url : String
end

class OtherName
  include JSON::Serializable

  property name : String

  property note : String?
end

class Text
  include JSON::Serializable

  property media_type : String

  property title : String

  property url : String
end
