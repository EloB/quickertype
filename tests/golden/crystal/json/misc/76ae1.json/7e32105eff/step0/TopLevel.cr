require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "basePath")]
  property base_path : String

  property definitions : Definitions

  property host : String

  property info : Info

  property paths : Paths

  property produces : Array(String)

  property schemes : Array(String)

  property swagger : String
end

class Definitions
  include JSON::Serializable

  @[JSON::Field(key: "Article")]
  property article : Article

  @[JSON::Field(key: "Center")]
  property center : Article

  @[JSON::Field(key: "DeMinimis")]
  property de_minimis : DeMinimis

  @[JSON::Field(key: "Event")]
  property event : Article

  @[JSON::Field(key: "FAQ")]
  property faq : Faq

  @[JSON::Field(key: "Lead")]
  property lead : Article

  @[JSON::Field(key: "List")]
  property list : Article

  @[JSON::Field(key: "MarketIntelligence")]
  property market_intelligence : Article

  @[JSON::Field(key: "Office")]
  property office : Article

  @[JSON::Field(key: "Provider")]
  property provider : Article

  @[JSON::Field(key: "Rate")]
  property rate : Article

  @[JSON::Field(key: "Report")]
  property report : Report

  @[JSON::Field(key: "Taxonomy")]
  property taxonomy : Taxonomy
end

class Article
  include JSON::Serializable

  property properties : Hash(String, Property)
end

class Property
  include JSON::Serializable

  property description : String

  @[JSON::Field(key: "type")]
  property property_type : String
end

class DeMinimis
  include JSON::Serializable

  property properties : DeMinimisProperties
end

class DeMinimisProperties
  include JSON::Serializable

  property countries : Property

  property country : Property

  property de_minimis_currency : Property

  property de_minimis_value : Property

  property notes : Property

  property vat_amount : Property

  property vat_currency : Property
end

class Faq
  include JSON::Serializable

  property properties : FaqProperties
end

class FaqProperties
  include JSON::Serializable

  property answer : Property

  property countries : Property

  property first_published_date : Property

  property id : Property

  property industries : Property

  property last_published_date : Property

  property question : Property

  property topics : Property

  property trade_regions : Property

  property url : Property

  property world_regions : Property
end

class Report
  include JSON::Serializable

  property properties : ReportProperties
end

class ReportProperties
  include JSON::Serializable

  property countries : Property

  property description : Property

  property expiration_date : Property

  property id : Property

  property industries : Property

  property ita_industries : Property

  property report_type : Property

  property title : Property

  property url : Property
end

class Taxonomy
  include JSON::Serializable

  property properties : TaxonomyProperties
end

class TaxonomyProperties
  include JSON::Serializable

  property annotations : Property

  property datatype_properties : Property

  property id : Property

  property label : Property

  @[JSON::Field(key: "type")]
  property properties_type : Property

  property sub_class_of : Property
end

class Info
  include JSON::Serializable

  property description : String

  property title : String

  property version : String
end

class Paths
  include JSON::Serializable

  @[JSON::Field(key: "/business_service_providers/search")]
  property business_service_providers_search : BusinessServiceProvidersSearchClass

  @[JSON::Field(key: "/consolidated_screening_list/search")]
  property consolidated_screening_list_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/de_minimis/search")]
  property de_minimis_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/ita_faqs/search")]
  property ita_faqs_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/ita_office_locations/search")]
  property ita_office_locations_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/ita_taxonomies/search")]
  property ita_taxonomies_search : BusinessServiceProvidersSearchClass

  @[JSON::Field(key: "/ita_zipcode_to_post/search")]
  property ita_zipcode_to_post_search : BusinessServiceProvidersSearchClass

  @[JSON::Field(key: "/market_intelligence/search")]
  property market_intelligence_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/market_research_library/search")]
  property market_research_library_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/tariff_rates/search")]
  property tariff_rates_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/trade_articles/search")]
  property trade_articles_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/trade_events/search")]
  property trade_events_search : ConsolidatedScreeningListSearchClass

  @[JSON::Field(key: "/trade_leads/search")]
  property trade_leads_search : ConsolidatedScreeningListSearchClass
end

class BusinessServiceProvidersSearchClass
  include JSON::Serializable

  property get : BusinessServiceProvidersSearchGet
end

class BusinessServiceProvidersSearchGet
  include JSON::Serializable

  property description : String

  property parameters : Array(Parameter)

  property responses : PurpleResponses

  property summary : String

  property tags : Array(String)
end

class Parameter
  include JSON::Serializable

  property description : String

  property format : String

  property name : String

  @[JSON::Field(key: "in")]
  property parameter_in : String

  @[JSON::Field(key: "type")]
  property parameter_type : String

  property required : Bool
end

class PurpleResponses
  include JSON::Serializable

  @[JSON::Field(key: "200")]
  property the_200 : Purple200
end

class Purple200
  include JSON::Serializable

  property description : String

  property schema : ItemsClass
end

class ItemsClass
  include JSON::Serializable

  @[JSON::Field(key: "$ref")]
  property ref : String
end

class ConsolidatedScreeningListSearchClass
  include JSON::Serializable

  property get : ConsolidatedScreeningListSearchGet
end

class ConsolidatedScreeningListSearchGet
  include JSON::Serializable

  property description : String

  property parameters : Array(Parameter)

  property responses : FluffyResponses

  property summary : String

  property tags : Array(String)
end

class FluffyResponses
  include JSON::Serializable

  @[JSON::Field(key: "200")]
  property the_200 : Fluffy200
end

class Fluffy200
  include JSON::Serializable

  property description : String

  property schema : PurpleSchema
end

class PurpleSchema
  include JSON::Serializable

  property items : ItemsClass

  @[JSON::Field(key: "type")]
  property schema_type : String
end
