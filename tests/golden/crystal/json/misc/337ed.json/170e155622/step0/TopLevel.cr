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

  property cost_absolute : Int64?

  property cost_max : Int64?

  property cost_min : Int64?

  property created_at : String

  @[JSON::Field(key: "customIncomes")]
  property custom_incomes : Array(CustomIncome)

  property direct_rep_costs_max : Nil

  property direct_rep_costs_min : Nil

  property end_date : String

  property eur_sources_grants : Int64

  property eur_sources_grants_src : String?

  property eur_sources_procurement : Int64

  property eur_sources_procurement_src : String?

  property id : String

  property new_organisation : Nil

  property no_clients : String?

  property other_financial_information : String?

  property other_sources_contributions : Int64?

  property other_sources_donation : Int64?

  property other_sources_total : Int64?

  property public_financing_infranational : Int64?

  property public_financing_national : Int64?

  property public_financing_total : Int64?

  property representative : String

  @[JSON::Field(key: "type")]
  property result_type : String

  property start_date : String

  property status : String

  property total_budget : Int64?

  property turnover_absolute : Int64?

  property turnover_max : Int64?

  property turnover_min : Int64?

  property updated_at : String

  property uri : String
end

class CustomIncome
  include JSON::Serializable

  property amount : Int64

  property created_at : String

  @[JSON::Field(key: "type")]
  property custom_income_type : String

  property id : String

  property name : String

  property status : String

  property updated_at : String

  property uri : String
end
