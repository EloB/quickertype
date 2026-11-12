require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "next")]
  property top_level_next : Next?

  property value : String
end

class Node
  include JSON::Serializable

  @[JSON::Field(key: "next")]
  property node_next : Next?

  property value : String
end

alias Next = Node | String
