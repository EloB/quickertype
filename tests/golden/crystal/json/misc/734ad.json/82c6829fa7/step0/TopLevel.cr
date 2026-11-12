require "json"

class TopLevel
  include JSON::Serializable

  property count : Int64

  property facets : Facets

  property limit : Int64

  property offset : Int64

  property previous : Bool

  property results : Array(Result)

  @[JSON::Field(key: "next")]
  property top_level_next : String
end

class Facets
  include JSON::Serializable

end

class Result
  include JSON::Serializable

  property acronym : String?

  property activity_consult_committees : String

  property activity_eu_legislative : String

  property activity_expert_groups : String

  property activity_high_level_groups : String

  property activity_industry_forums : String

  property activity_inter_groups : String

  property activity_other : String?

  property activity_relevant_comm : String

  property be_office_country : String?

  property be_office_lat : Float64?

  property be_office_lon : Float64?

  property be_office_phone : String?

  property be_office_post_code : String?

  property be_office_postbox : String?

  property be_office_street : String?

  property be_office_town : String?

  property code_of_conduct : String

  property contact_country : Int64

  property created_at : String

  property entity : String

  property goals : String

  property head : String

  property head_office_country : String

  property head_office_lat : Float64?

  property head_office_lon : Float64?

  property head_office_phone : String

  property head_office_post_code : String?

  property head_office_postbox : String?

  property head_office_street : String

  property head_office_town : String

  property id : String

  property identification_code : String

  property info_members : String

  property last_update_date : String

  property legal : String

  property legal_status : String

  property main_category : Int64

  property main_category_title : String

  property members : Int64

  property members_100 : Int64?

  property members_25 : Int64?

  property members_50 : Int64?

  property members_75 : Int64?

  property members_fte : Float64

  property name : String

  property native_name : Nil

  property networking : String?

  property number_of_natural_persons : Int64?

  property other_code_of_conduct : String?

  property registration_date : String

  property status : String

  property structure_members : String

  property sub_category : Int64

  property sub_category_title : String

  property updated_at : String

  property uri : String

  property web_site_url : String?
end
