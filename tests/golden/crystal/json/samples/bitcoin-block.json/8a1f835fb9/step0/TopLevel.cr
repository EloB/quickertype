require "json"

class TopLevel
  include JSON::Serializable

  property block_index : Int64

  property hash : String

  property height : Int64

  property time : Int64

  @[JSON::Field(key: "txIndexes")]
  property tx_indexes : Array(Int64)
end
