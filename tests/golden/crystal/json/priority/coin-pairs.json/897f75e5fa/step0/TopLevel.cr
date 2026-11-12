require "json"

class TopLevel
  include JSON::Serializable

  property pairs : Hash(String, Pair)

  property server_time : Int64
end

class Pair
  include JSON::Serializable

  property decimal_places : Int64

  property fee : Float64

  property hidden : Int64

  property max_amount : Int64

  property max_price : Int64

  property min_amount : Float64

  property min_price : Float64

  property min_total : Float64
end
