require "json"

class TopLevel
  include JSON::Serializable

  property boolean : Bool

  property integer : Int64

  property integers : Array(Int64)

  property number : Float64

  property string : String
end
