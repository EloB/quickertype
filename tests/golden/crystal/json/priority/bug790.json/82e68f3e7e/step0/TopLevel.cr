require "json"

class TopLevel
  include JSON::Serializable

  property children_data : Array(TopLevel)

  property id : Int64

  property is_active : Bool

  property level : Int64

  property name : String

  property parent_id : Int64

  property position : Int64

  property product_count : Int64
end
