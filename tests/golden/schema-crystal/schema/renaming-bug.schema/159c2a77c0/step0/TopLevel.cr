require "json"

class TopLevel
  include JSON::Serializable

  property version : String?

  property fruits : Array(Fruit)?

  property vehicles : Array(Vehicle)?
end

class Fruit
  include JSON::Serializable

  property apple : Bool?

  property berries : Array(Berry)?

  property orange : Bool?
end

class Berry
  include JSON::Serializable

  property color : Color?

  property name : String?

  property shapes : Array(Shape)?
end

class Color
  include JSON::Serializable

  property rgb : Float64?
end

class Shape
  include JSON::Serializable

  property geometry : Geometry?

  property history : History?
end

class Geometry
  include JSON::Serializable

  @[JSON::Field(key: "rectShape")]
  property rect_shape : RectShape?

  @[JSON::Field(key: "circularShape")]
  property circular_shape : Array(CircularShape)?
end

class CircularShape
  include JSON::Serializable

  @[JSON::Field(key: "shapeName")]
  property shape_name : String?
end

class RectShape
  include JSON::Serializable

  property parts : Array(Part)?
end

class Part
  include JSON::Serializable

  property depth : String?

  property length : String?

  property width : String?
end

class History
  include JSON::Serializable

  @[JSON::Field(key: "class")]
  property history_class : String?
end

class Vehicle
  include JSON::Serializable

  property brand : String?

  property id : String?

  property speed : Speed?

  @[JSON::Field(key: "subModule")]
  property sub_module : Bool?

  @[JSON::Field(key: "type")]
  property vehicle_type : VehicleType?

  property year : String?
end

class Speed
  include JSON::Serializable

  property velocity : Limit?
end

class Limit
  include JSON::Serializable

  property maximum : Float64?

  property minimum : Float64?
end

class VehicleType
  include JSON::Serializable

  property name : String?

  property width : String?

  property length : String?
end
