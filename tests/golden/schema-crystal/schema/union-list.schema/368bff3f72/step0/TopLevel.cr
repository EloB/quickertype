require "json"

class TopLevel
  include JSON::Serializable

  property list : UnionList
end

class UnionListClass
  include JSON::Serializable

  @[JSON::Field(key: "next")]
  property union_list_next : UnionList
end

alias UnionList = Float64 | UnionListClass
