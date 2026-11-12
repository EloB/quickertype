require "json"

alias TopLevel = Array(TopLevelElement)

class TopLevelElement
  include JSON::Serializable

  property comments : Int64

  property comments_url : String

  property commits_url : String

  property created_at : String

  property description : String?

  property files : Hash(String, FileValue)

  property forks_url : String

  property git_pull_url : String

  property git_push_url : String

  property html_url : String

  property id : String

  property public : Bool

  property truncated : Bool

  property updated_at : String

  property url : String

  property user : Nil
end

class FileValue
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property file_type : String

  property filename : String

  property language : String?

  property raw_url : String

  property size : Int64
end
