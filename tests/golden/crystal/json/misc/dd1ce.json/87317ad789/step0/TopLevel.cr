require "json"

class TopLevel
  include JSON::Serializable

  property booster : Array(String)

  property border : String

  property cards : Array(Card)

  property code : String

  @[JSON::Field(key: "gathererCode")]
  property gatherer_code : String

  @[JSON::Field(key: "magicCardsInfoCode")]
  property magic_cards_info_code : String

  property mkm_id : Int64

  property mkm_name : String

  property name : String

  @[JSON::Field(key: "releaseDate")]
  property release_date : String

  @[JSON::Field(key: "type")]
  property top_level_type : String
end

class Card
  include JSON::Serializable

  property artist : String

  @[JSON::Field(key: "type")]
  property card_type : String

  property cmc : Int64

  @[JSON::Field(key: "colorIdentity")]
  property color_identity : Array(String)?

  property colors : Array(String)?

  property flavor : String?

  property id : String

  @[JSON::Field(key: "imageName")]
  property image_name : String

  property layout : String

  property legalities : Array(LegalityElement)

  @[JSON::Field(key: "manaCost")]
  property mana_cost : String?

  @[JSON::Field(key: "mciNumber")]
  property mci_number : String?

  property multiverseid : Int64

  property name : String

  @[JSON::Field(key: "originalText")]
  property original_text : String?

  @[JSON::Field(key: "originalType")]
  property original_type : String

  property power : String?

  property printings : Array(String)

  property rarity : String

  property reserved : Bool?

  property rulings : Array(Ruling)?

  property subtypes : Array(String)?

  property supertypes : Array(String)?

  property text : String?

  property toughness : String?

  property types : Array(String)

  property variations : Array(Int64)?
end

class LegalityElement
  include JSON::Serializable

  property format : String

  property legality : String
end

class Ruling
  include JSON::Serializable

  property date : String

  property text : String
end
