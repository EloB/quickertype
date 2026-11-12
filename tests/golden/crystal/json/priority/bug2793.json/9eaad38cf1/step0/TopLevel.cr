require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "Hints")]
  property hints : Hints

  @[JSON::Field(key: "Labels")]
  property labels : Labels
end

class Hints
  include JSON::Serializable

end

class Labels
  include JSON::Serializable

  @[JSON::Field(key: "AccountNumber")]
  property account_number : String

  @[JSON::Field(key: "Title")]
  property title : String
end
