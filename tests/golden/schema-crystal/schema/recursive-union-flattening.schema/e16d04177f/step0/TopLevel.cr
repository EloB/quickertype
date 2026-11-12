require "json"

class TopLevelClass
  include JSON::Serializable

  property x : X?
end

class XClass
  include JSON::Serializable

  property x : X?
end

alias TopLevel = Hash(String, JSON::Any?) | Float64 | Int64 | Bool | String | Array(TopLevelElement?)

alias TopLevelElement = Array(JSON::Any?) | Float64 | Bool | String | TopLevelClass

alias XElement = Array(JSON::Any?) | Float64 | Bool | String | XClass

alias X = Hash(String, JSON::Any?) | Float64 | Bool | String | Array(XElement?)
