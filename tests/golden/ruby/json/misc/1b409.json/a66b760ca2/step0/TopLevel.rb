# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_meta.limit.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer       = Strict::Integer
  Nil           = Strict::Nil
  Bool          = Strict::Bool
  Hash          = Strict::Hash
  String        = Strict::String
  Party         = Strict::String.enum("Republican", "Democrat")
  Gender        = Strict::String.enum("male", "female")
  GenderLabel   = Strict::String.enum("Male", "Female")
  Namemod       = Strict::String.enum("", "Jr.", "II", "III", "IV")
  RoleType      = Strict::String.enum("representative")
  RoleTypeLabel = Strict::String.enum("Representative", "Delegate", "Resident Commissioner")
  Title         = Strict::String.enum("Rep.", "Commish.")
end

class Extra < Dry::Struct
  attribute :address,      Types::String
  attribute :contact_form, Types::String.optional
  attribute :fax,          Types::String.optional.optional
  attribute :office,       Types::String
  attribute :rss_url,      Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      address:      d.fetch("address"),
      contact_form: d.key?("contact_form") ? Types::String[d["contact_form"]] : nil,
      fax:          d["fax"],
      office:       d.fetch("office"),
      rss_url:      d.key?("rss_url") ? Types::String[d["rss_url"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "address"      => address,
      "contact_form" => contact_form,
      "fax"          => fax,
      "office"       => office,
      "rss_url"      => rss_url,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Party
  Republican = "Republican"
  Democrat   = "Democrat"
end

module Gender
  Male   = "male"
  Female = "female"
end

module GenderLabel
  Male   = "Male"
  Female = "Female"
end

module Namemod
  Empty = ""
  Jr    = "Jr."
  Ii    = "II"
  Iii   = "III"
  Iv    = "IV"
end

class Person < Dry::Struct
  attribute :bioguideid,   Types::String
  attribute :birthday,     Types::String
  attribute :cspanid,      Types::Integer
  attribute :firstname,    Types::String
  attribute :gender,       Types::Gender
  attribute :gender_label, Types::GenderLabel
  attribute :id,           Types::Integer
  attribute :lastname,     Types::String
  attribute :link,         Types::String
  attribute :middlename,   Types::String
  attribute :namemod,      Types::Namemod
  attribute :nickname,     Types::String
  attribute :osid,         Types::String
  attribute :person_name,  Types::String
  attribute :pvsid,        Types::String.optional
  attribute :sortname,     Types::String
  attribute :twitterid,    Types::String.optional
  attribute :youtubeid,    Types::String.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bioguideid:   d.fetch("bioguideid"),
      birthday:     d.fetch("birthday"),
      cspanid:      d.fetch("cspanid"),
      firstname:    d.fetch("firstname"),
      gender:       d.fetch("gender"),
      gender_label: d.fetch("gender_label"),
      id:           d.fetch("id"),
      lastname:     d.fetch("lastname"),
      link:         d.fetch("link"),
      middlename:   d.fetch("middlename"),
      namemod:      d.fetch("namemod"),
      nickname:     d.fetch("nickname"),
      osid:         d.fetch("osid"),
      person_name:  d.fetch("name"),
      pvsid:        d.fetch("pvsid"),
      sortname:     d.fetch("sortname"),
      twitterid:    d.fetch("twitterid"),
      youtubeid:    d.fetch("youtubeid"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bioguideid"   => bioguideid,
      "birthday"     => birthday,
      "cspanid"      => cspanid,
      "firstname"    => firstname,
      "gender"       => gender,
      "gender_label" => gender_label,
      "id"           => id,
      "lastname"     => lastname,
      "link"         => link,
      "middlename"   => middlename,
      "namemod"      => namemod,
      "nickname"     => nickname,
      "osid"         => osid,
      "name"         => person_name,
      "pvsid"        => pvsid,
      "sortname"     => sortname,
      "twitterid"    => twitterid,
      "youtubeid"    => youtubeid,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module RoleType
  Representative = "representative"
end

module RoleTypeLabel
  Representative       = "Representative"
  Delegate             = "Delegate"
  ResidentCommissioner = "Resident Commissioner"
end

module Title
  Rep     = "Rep."
  Commish = "Commish."
end

class ObjectElement < Dry::Struct
  attribute :caucus,           Types::Nil
  attribute :congress_numbers, Types.Array(Types::Integer)
  attribute :current,          Types::Bool
  attribute :description,      Types::String
  attribute :district,         Types::Integer
  attribute :enddate,          Types::String
  attribute :extra,            Extra
  attribute :id,               Types::Integer
  attribute :leadership_title, Types::String.optional
  attribute :party,            Types::Party
  attribute :person,           Person
  attribute :phone,            Types::String
  attribute :role_type,        Types::RoleType
  attribute :role_type_label,  Types::RoleTypeLabel
  attribute :senator_class,    Types::Nil
  attribute :senator_rank,     Types::Nil
  attribute :startdate,        Types::String
  attribute :state,            Types::String
  attribute :title,            Types::Title
  attribute :title_long,       Types::RoleTypeLabel
  attribute :website,          Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      caucus:           d.fetch("caucus"),
      congress_numbers: d.fetch("congress_numbers"),
      current:          d.fetch("current"),
      description:      d.fetch("description"),
      district:         d.fetch("district"),
      enddate:          d.fetch("enddate"),
      extra:            Extra.from_dynamic!(d.fetch("extra")),
      id:               d.fetch("id"),
      leadership_title: d.fetch("leadership_title"),
      party:            d.fetch("party"),
      person:           Person.from_dynamic!(d.fetch("person")),
      phone:            d.fetch("phone"),
      role_type:        d.fetch("role_type"),
      role_type_label:  d.fetch("role_type_label"),
      senator_class:    d.fetch("senator_class"),
      senator_rank:     d.fetch("senator_rank"),
      startdate:        d.fetch("startdate"),
      state:            d.fetch("state"),
      title:            d.fetch("title"),
      title_long:       d.fetch("title_long"),
      website:          d.fetch("website"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "caucus"           => caucus,
      "congress_numbers" => congress_numbers,
      "current"          => current,
      "description"      => description,
      "district"         => district,
      "enddate"          => enddate,
      "extra"            => extra.to_dynamic,
      "id"               => id,
      "leadership_title" => leadership_title,
      "party"            => party,
      "person"           => person.to_dynamic,
      "phone"            => phone,
      "role_type"        => role_type,
      "role_type_label"  => role_type_label,
      "senator_class"    => senator_class,
      "senator_rank"     => senator_rank,
      "startdate"        => startdate,
      "state"            => state,
      "title"            => title,
      "title_long"       => title_long,
      "website"          => website,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Meta < Dry::Struct
  attribute :limit,       Types::Integer
  attribute :offset,      Types::Integer
  attribute :total_count, Types::Integer

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      limit:       d.fetch("limit"),
      offset:      d.fetch("offset"),
      total_count: d.fetch("total_count"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "limit"       => limit,
      "offset"      => offset,
      "total_count" => total_count,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :objects,        Types.Array(ObjectElement)
  attribute :top_level_meta, Meta

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      objects:        d.fetch("objects").map { |x| ObjectElement.from_dynamic!(x) },
      top_level_meta: Meta.from_dynamic!(d.fetch("meta")),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "objects" => objects.map { |x| x.to_dynamic },
      "meta"    => top_level_meta.to_dynamic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
