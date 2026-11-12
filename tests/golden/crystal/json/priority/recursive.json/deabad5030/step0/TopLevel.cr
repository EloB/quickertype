require "json"

class TopLevel
  include JSON::Serializable

  property category : Category

  property details : Details

  property match : String

  property page : Int64

  property product : Array(ProductElement)

  property schk : Bool

  property totallooseoffers : Int64

  property totalpages : Int64

  property totalresultsavailable : Int64

  property totalresultsreturned : Int64
end

class Category
  include JSON::Serializable

  property concatenatecategoryname : Bool

  property hasoffer : Bool

  property id : Int64

  property isfinal : Bool

  property links : Array(LinkElement)

  property name : String

  property parentcategoryid : Int64

  property thumbnail : CategoryThumbnail
end

class LinkElement
  include JSON::Serializable

  property link : LinkLink
end

class LinkLink
  include JSON::Serializable

  @[JSON::Field(key: "type")]
  property link_type : String

  property url : String
end

class CategoryThumbnail
  include JSON::Serializable

  property url : String
end

class Details
  include JSON::Serializable

  property applicationid : String

  property applicationversion : String

  property code : Int64

  property date : Date

  property elapsedtime : Int64

  property message : String

  property status : String
end

class Date
  include JSON::Serializable

  property day : Int64

  property eonandyear : Eonandyear

  property hour : Int64

  property millisecond : Int64

  property minute : Int64

  property month : Int64

  property second : Int64

  property timezone : Int64

  property valid : Bool

  property xmlschematype : Xmlschematype

  property year : Int64
end

class Eonandyear
  include JSON::Serializable

  property lowestsetbit : Int64
end

class Xmlschematype
  include JSON::Serializable

  property localpart : String

  property namespaceuri : String

  property prefix : String
end

class ProductElement
  include JSON::Serializable

  property product : ProductProduct
end

class ProductProduct
  include JSON::Serializable

  property categoryid : Int64

  property currency : Currency

  property eco : Bool

  property fulldescription : Bool

  property hasmetasearch : Bool

  property id : Int64

  property links : Array(LinkElement)

  property numoffers : Int64

  property pricemax : String

  property pricemin : String

  property productname : String

  property quantity : Int64

  property rating : Rating

  property specification : Specification

  property thumbnail : FormatsClass

  property totalsellers : Int64
end

class Currency
  include JSON::Serializable

  property abbreviation : String
end

class Rating
  include JSON::Serializable

  property useraveragerating : Useraveragerating
end

class Useraveragerating
  include JSON::Serializable

  property links : Array(LinkElement)

  property numcomments : Int64

  property rating : String
end

class Specification
  include JSON::Serializable

  property links : Array(LinkElement)
end

class Format
  include JSON::Serializable

  property formats : FormatsClass
end

class FormatsClass
  include JSON::Serializable

  property formats : Array(Format)?

  property height : Int64

  property url : String

  property width : Int64
end
