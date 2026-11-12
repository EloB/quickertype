require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "LightParams")]
  property light_params : LightParams
end

class LightParams
  include JSON::Serializable

  property app_id : String

  property outlet_id : String

  property rgba : String
end
