require "json"

class TopLevel
  include JSON::Serializable

  property above_i32_max : Int64

  property below_i32_min : Int64

  property i32_range : Int64

  property large_bounds : Int64

  property only_maximum : Int64

  property only_minimum : Int64

  property small_negative : Int64

  property small_positive : Int64

  property unbounded : Int64
end
