require "json"

class TopLevel
  include JSON::Serializable

  property crs : Crs

  property features : Array(Feature)

  @[JSON::Field(key: "type")]
  property top_level_type : String

  @[JSON::Field(key: "totalFeatures")]
  property total_features : Int64
end

class Crs
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property crs_type : String

  property properties : CrsProperties
end

class CrsProperties
  include JSON::Serializable

  property name : String
end

class Feature
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property feature_type : String

  property geometry : Geometry

  property geometry_name : String

  property id : String

  property properties : FeatureProperties
end

class Geometry
  include JSON::Serializable

  property coordinates : Array(Array(Array(Array(Float64))))

  @[JSON::Field(key: "type")]
  property geometry_type : String
end

class FeatureProperties
  include JSON::Serializable

  property add_improv : String?

  @[JSON::Field(key: "area_")]
  property area : Float64

  property asset_numb : String

  property comments : String?

  property condition : Int64

  property constructi : String?

  property createdate : Nil

  property createuser : Nil

  property disposal_d : Nil

  property documents : String

  property drawing_nu : String?

  property file_numbe : String?

  property folder_num : String?

  property funding_ba : String?

  property historic_c : Int64

  property inspection : String

  property inspectors : Nil

  property last_updat : Nil

  property level_accu : String?

  property material : String

  property mi_prinx : Int64

  property mi_symbolo : String

  property number_lan : Int64

  property owner : String?

  property positional : String?

  property project_nu : String?

  @[JSON::Field(key: "type")]
  property properties_type : String?

  property rec_id : Int64

  property record_cre : String?

  property shape_area : Float64

  property shape_leng : Float64

  property status : String

  property survey_num : Nil

  property toe_rl : Float64

  property top_rl : Float64

  property update_dat : String

  property updatedate : Nil

  property updateuser : Nil
end
