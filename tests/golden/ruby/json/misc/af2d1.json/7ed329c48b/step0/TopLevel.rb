# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.features.first.properties.add_improv.nil?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer        = Strict::Integer
  Nil            = Strict::Nil
  Hash           = Strict::Hash
  String         = Strict::String
  Double         = Strict::Float | Strict::Integer
  FeatureType    = Strict::String.enum("Feature")
  GeometryType   = Strict::String.enum("MultiPolygon")
  GeometryName   = Strict::String.enum("geom")
  AddImprov      = Strict::String.enum("f", "F", "t")
  FundingBa      = Strict::String.enum("Non GCCC", "Capex", "Initial", "Contribute")
  LevelAccu      = Strict::String.enum("GPS Corrected 1.0M", "APPROX", "GPS COrrected 1.0M")
  Material       = Strict::String.enum("Gravel", "Concrete", "Bitumen", "Interlock Conc Block", "Other", "Earth")
  MiSymbolo      = Strict::String.enum("Pen (2, 2, 65535) Brush (1, 0, 16777215)")
  PropertiesType = Strict::String.enum("Boat Ramp")
  Status         = Strict::String.enum("CURRENT")
end

class CRSProperties < Dry::Struct
  attribute :properties_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      properties_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "name" => properties_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CRS < Dry::Struct
  attribute :crs_type,   Types::String
  attribute :properties, CRSProperties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      crs_type:   d.fetch("type"),
      properties: CRSProperties.from_dynamic!(d.fetch("properties")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"       => crs_type,
      "properties" => properties.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module FeatureType
  Feature = "Feature"
end

module GeometryType
  MultiPolygon = "MultiPolygon"
end

class Geometry < Dry::Struct
  attribute :coordinates,   Types.Array(Types.Array(Types.Array(Types.Array(Types::Double))))
  attribute :geometry_type, Types::GeometryType

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      coordinates:   d.fetch("coordinates"),
      geometry_type: d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "coordinates" => coordinates,
      "type"        => geometry_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module GeometryName
  Geom = "geom"
end

module AddImprov
  F          = "f"
  AddImprovF = "F"
  T          = "t"
end

module FundingBa
  NonGCCC    = "Non GCCC"
  Capex      = "Capex"
  Initial    = "Initial"
  Contribute = "Contribute"
end

module LevelAccu
  GPSCorrected10M = "GPS Corrected 1.0M"
  Approx          = "APPROX"
  GPSCOrrected10M = "GPS COrrected 1.0M"
end

module Material
  Gravel             = "Gravel"
  Concrete           = "Concrete"
  Bitumen            = "Bitumen"
  InterlockConcBlock = "Interlock Conc Block"
  Other              = "Other"
  Earth              = "Earth"
end

module MiSymbolo
  Pen2265535Brush1016777215 = "Pen (2, 2, 65535) Brush (1, 0, 16777215)"
end

module PropertiesType
  BoatRamp = "Boat Ramp"
end

module Status
  Current = "CURRENT"
end

class FeatureProperties < Dry::Struct
  attribute :add_improv,      Types::AddImprov.optional
  attribute :area,            Types::Double
  attribute :asset_numb,      Types::String
  attribute :comments,        Types::String.optional
  attribute :condition,       Types::Integer
  attribute :constructi,      Types::String.optional
  attribute :createdate,      Types::Nil
  attribute :createuser,      Types::Nil
  attribute :disposal_d,      Types::Nil
  attribute :documents,       Types::String
  attribute :drawing_nu,      Types::String.optional
  attribute :file_numbe,      Types::String.optional
  attribute :folder_num,      Types::String.optional
  attribute :funding_ba,      Types::FundingBa.optional
  attribute :historic_c,      Types::Integer
  attribute :inspection,      Types::String
  attribute :inspectors,      Types::Nil
  attribute :last_updat,      Types::Nil
  attribute :level_accu,      Types::LevelAccu.optional
  attribute :material,        Types::Material
  attribute :mi_prinx,        Types::Integer
  attribute :mi_symbolo,      Types::MiSymbolo
  attribute :number_lan,      Types::Integer
  attribute :owner,           Types::String.optional
  attribute :positional,      Types::LevelAccu.optional
  attribute :project_nu,      Types::String.optional
  attribute :properties_type, Types::PropertiesType.optional
  attribute :rec_id,          Types::Integer
  attribute :record_cre,      Types::String.optional
  attribute :shape_area,      Types::Double
  attribute :shape_leng,      Types::Double
  attribute :status,          Types::Status
  attribute :survey_num,      Types::Nil
  attribute :toe_rl,          Types::Double
  attribute :top_rl,          Types::Double
  attribute :update_dat,      Types::String
  attribute :updatedate,      Types::Nil
  attribute :updateuser,      Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      add_improv:      d.fetch("add_improv"),
      area:            d.fetch("area_"),
      asset_numb:      d.fetch("asset_numb"),
      comments:        d.fetch("comments"),
      condition:       d.fetch("condition"),
      constructi:      d.fetch("constructi"),
      createdate:      d.fetch("createdate"),
      createuser:      d.fetch("createuser"),
      disposal_d:      d.fetch("disposal_d"),
      documents:       d.fetch("documents"),
      drawing_nu:      d.fetch("drawing_nu"),
      file_numbe:      d.fetch("file_numbe"),
      folder_num:      d.fetch("folder_num"),
      funding_ba:      d.fetch("funding_ba"),
      historic_c:      d.fetch("historic_c"),
      inspection:      d.fetch("inspection"),
      inspectors:      d.fetch("inspectors"),
      last_updat:      d.fetch("last_updat"),
      level_accu:      d.fetch("level_accu"),
      material:        d.fetch("material"),
      mi_prinx:        d.fetch("mi_prinx"),
      mi_symbolo:      d.fetch("mi_symbolo"),
      number_lan:      d.fetch("number_lan"),
      owner:           d.fetch("owner"),
      positional:      d.fetch("positional"),
      project_nu:      d.fetch("project_nu"),
      properties_type: d.fetch("type"),
      rec_id:          d.fetch("rec_id"),
      record_cre:      d.fetch("record_cre"),
      shape_area:      d.fetch("shape_area"),
      shape_leng:      d.fetch("shape_leng"),
      status:          d.fetch("status"),
      survey_num:      d.fetch("survey_num"),
      toe_rl:          d.fetch("toe_rl"),
      top_rl:          d.fetch("top_rl"),
      update_dat:      d.fetch("update_dat"),
      updatedate:      d.fetch("updatedate"),
      updateuser:      d.fetch("updateuser"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "add_improv" => add_improv,
      "area_"      => area,
      "asset_numb" => asset_numb,
      "comments"   => comments,
      "condition"  => condition,
      "constructi" => constructi,
      "createdate" => createdate,
      "createuser" => createuser,
      "disposal_d" => disposal_d,
      "documents"  => documents,
      "drawing_nu" => drawing_nu,
      "file_numbe" => file_numbe,
      "folder_num" => folder_num,
      "funding_ba" => funding_ba,
      "historic_c" => historic_c,
      "inspection" => inspection,
      "inspectors" => inspectors,
      "last_updat" => last_updat,
      "level_accu" => level_accu,
      "material"   => material,
      "mi_prinx"   => mi_prinx,
      "mi_symbolo" => mi_symbolo,
      "number_lan" => number_lan,
      "owner"      => owner,
      "positional" => positional,
      "project_nu" => project_nu,
      "type"       => properties_type,
      "rec_id"     => rec_id,
      "record_cre" => record_cre,
      "shape_area" => shape_area,
      "shape_leng" => shape_leng,
      "status"     => status,
      "survey_num" => survey_num,
      "toe_rl"     => toe_rl,
      "top_rl"     => top_rl,
      "update_dat" => update_dat,
      "updatedate" => updatedate,
      "updateuser" => updateuser,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Feature < Dry::Struct
  attribute :feature_type,  Types::FeatureType
  attribute :geometry,      Geometry
  attribute :geometry_name, Types::GeometryName
  attribute :id,            Types::String
  attribute :properties,    FeatureProperties

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      feature_type:  d.fetch("type"),
      geometry:      Geometry.from_dynamic!(d.fetch("geometry")),
      geometry_name: d.fetch("geometry_name"),
      id:            d.fetch("id"),
      properties:    FeatureProperties.from_dynamic!(d.fetch("properties")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "type"          => feature_type,
      "geometry"      => geometry.to_dynamic,
      "geometry_name" => geometry_name,
      "id"            => id,
      "properties"    => properties.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :crs,            CRS
  attribute :features,       Types.Array(Feature)
  attribute :top_level_type, Types::String
  attribute :total_features, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      crs:            CRS.from_dynamic!(d.fetch("crs")),
      features:       d.fetch("features").map { |x| Feature.from_dynamic!(x) },
      top_level_type: d.fetch("type"),
      total_features: d.fetch("totalFeatures"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "crs"           => crs.to_dynamic,
      "features"      => features.map { |x| x.to_dynamic },
      "type"          => top_level_type,
      "totalFeatures" => total_features,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
