require "json"

class TopLevel
  include JSON::Serializable

  property meta : Meta

  property objects : Array(ObjectElement)
end

class Meta
  include JSON::Serializable

  property limit : Int64

  property offset : Int64

  property total_count : Int64
end

class ObjectElement
  include JSON::Serializable

  property caucus : Nil

  property congress_numbers : Array(Int64)

  property current : Bool

  property description : String

  property district : Int64

  property enddate : String

  property extra : Extra

  property id : Int64

  property leadership_title : String?

  property party : String

  property person : Person

  property phone : String

  property role_type : String

  property role_type_label : String

  property senator_class : Nil

  property senator_rank : Nil

  property startdate : String

  property state : String

  property title : String

  property title_long : String

  property website : String
end

class Extra
  include JSON::Serializable

  property address : String

  property contact_form : String?

  property fax : String?

  property office : String

  property rss_url : String?
end

class Person
  include JSON::Serializable

  property bioguideid : String

  property birthday : String

  property cspanid : Int64

  property firstname : String

  property gender : String

  property gender_label : String

  property id : Int64

  property lastname : String

  property link : String

  property middlename : String

  property name : String

  property namemod : String

  property nickname : String

  property osid : String

  property pvsid : String?

  property sortname : String

  property twitterid : String?

  property youtubeid : String?
end
