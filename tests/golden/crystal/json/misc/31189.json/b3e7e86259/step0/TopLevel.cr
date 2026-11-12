require "json"

class TopLevel
  include JSON::Serializable

  property details : String

  property rates : Array(Rate)

  property version : Nil
end

class Rate
  include JSON::Serializable

  property code : String

  property country_code : String

  property name : String

  property periods : Array(Period)
end

class Period
  include JSON::Serializable

  property effective_from : String

  property rates : Rates
end

class Rates
  include JSON::Serializable

  property parking : Float64?

  property reduced : Float64?

  property reduced1 : Float64?

  property reduced2 : Float64?

  property standard : Float64

  property super_reduced : Float64?
end
