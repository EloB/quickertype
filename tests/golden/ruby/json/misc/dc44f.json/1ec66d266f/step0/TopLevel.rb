# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.cards.first.variations&.first.even?
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer       = Strict::Integer
  Bool          = Strict::Bool
  Hash          = Strict::Hash
  String        = Strict::String
  Booster       = Strict::String.enum("rare", "uncommon", "common")
  ColorIdentity = Strict::String.enum("U", "B", "W", "G", "R")
  Color         = Strict::String.enum("Blue", "Black", "White", "Green", "Red")
  Layout        = Strict::String.enum("normal")
  LegalityEnum  = Strict::String.enum("Legal", "Banned", "Restricted")
  Format        = Strict::String.enum("Commander", "Legacy", "Modern", "Vintage", "Time Spiral Block", "Ravnica Block", "Ice Age Block", "Tempest Block", "Onslaught Block", "Masques Block", "Mirage Block", "Urza Block", "Scars of Mirrodin Block", "Mirrodin Block", "Amonkhet Block", "Battle for Zendikar Block", "Innistrad Block", "Invasion Block", "Kaladesh Block", "Kamigawa Block", "Khans of Tarkir Block", "Lorwyn-Shadowmoor Block", "Odyssey Block", "Return to Ravnica Block", "Shadows over Innistrad Block", "Shards of Alara Block", "Standard", "Theros Block", "Un-Sets", "Zendikar Block")
  Rarity        = Strict::String.enum("Uncommon", "Rare", "Common", "Basic Land")
  Supertype     = Strict::String.enum("Basic")
  Type          = Strict::String.enum("Creature", "Instant", "Enchantment", "Artifact", "Sorcery", "Land")
end

module Booster
  Rare     = "rare"
  Uncommon = "uncommon"
  Common   = "common"
end

module ColorIdentity
  U = "U"
  B = "B"
  W = "W"
  G = "G"
  R = "R"
end

module Color
  Blue  = "Blue"
  Black = "Black"
  White = "White"
  Green = "Green"
  Red   = "Red"
end

module Layout
  Normal = "normal"
end

module LegalityEnum
  Legal      = "Legal"
  Banned     = "Banned"
  Restricted = "Restricted"
end

module Format
  Commander                 = "Commander"
  Legacy                    = "Legacy"
  Modern                    = "Modern"
  Vintage                   = "Vintage"
  TimeSpiralBlock           = "Time Spiral Block"
  RavnicaBlock              = "Ravnica Block"
  IceAgeBlock               = "Ice Age Block"
  TempestBlock              = "Tempest Block"
  OnslaughtBlock            = "Onslaught Block"
  MasquesBlock              = "Masques Block"
  MirageBlock               = "Mirage Block"
  UrzaBlock                 = "Urza Block"
  ScarsOfMirrodinBlock      = "Scars of Mirrodin Block"
  MirrodinBlock             = "Mirrodin Block"
  AmonkhetBlock             = "Amonkhet Block"
  BattleForZendikarBlock    = "Battle for Zendikar Block"
  InnistradBlock            = "Innistrad Block"
  InvasionBlock             = "Invasion Block"
  KaladeshBlock             = "Kaladesh Block"
  KamigawaBlock             = "Kamigawa Block"
  KhansOfTarkirBlock        = "Khans of Tarkir Block"
  LorwynShadowmoorBlock     = "Lorwyn-Shadowmoor Block"
  OdysseyBlock              = "Odyssey Block"
  ReturnToRavnicaBlock      = "Return to Ravnica Block"
  ShadowsOverInnistradBlock = "Shadows over Innistrad Block"
  ShardsOfAlaraBlock        = "Shards of Alara Block"
  Standard                  = "Standard"
  TherosBlock               = "Theros Block"
  UnSets                    = "Un-Sets"
  ZendikarBlock             = "Zendikar Block"
end

class LegalityElement < Dry::Struct
  attribute :legality,        Types::LegalityEnum
  attribute :legality_format, Types::Format

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      legality:        d.fetch("legality"),
      legality_format: d.fetch("format"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "legality" => legality,
      "format"   => legality_format,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Rarity
  Uncommon  = "Uncommon"
  Rare      = "Rare"
  Common    = "Common"
  BasicLand = "Basic Land"
end

class Ruling < Dry::Struct
  attribute :date, Types::String
  attribute :text, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      date: d.fetch("date"),
      text: d.fetch("text"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "date" => date,
      "text" => text,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

module Supertype
  Basic = "Basic"
end

module Type
  Creature    = "Creature"
  Instant     = "Instant"
  Enchantment = "Enchantment"
  Artifact    = "Artifact"
  Sorcery     = "Sorcery"
  Land        = "Land"
end

class Card < Dry::Struct
  attribute :artist,         Types::String
  attribute :card_name,      Types::String
  attribute :card_type,      Types::String
  attribute :cmc,            Types::Integer
  attribute :color_identity, Types.Array(Types::ColorIdentity).optional
  attribute :colors,         Types.Array(Types::Color).optional
  attribute :flavor,         Types::String.optional
  attribute :id,             Types::String
  attribute :image_name,     Types::String
  attribute :layout,         Types::Layout
  attribute :legalities,     Types.Array(LegalityElement)
  attribute :mana_cost,      Types::String.optional
  attribute :mci_number,     Types::String.optional
  attribute :multiverseid,   Types::Integer
  attribute :original_text,  Types::String.optional
  attribute :original_type,  Types::String
  attribute :power,          Types::String.optional
  attribute :printings,      Types.Array(Types::String)
  attribute :rarity,         Types::Rarity
  attribute :reserved,       Types::Bool.optional
  attribute :rulings,        Types.Array(Ruling).optional
  attribute :subtypes,       Types.Array(Types::String).optional
  attribute :supertypes,     Types.Array(Types::Supertype).optional
  attribute :text,           Types::String.optional
  attribute :toughness,      Types::String.optional
  attribute :types,          Types.Array(Types::Type)
  attribute :variations,     Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      artist:         d.fetch("artist"),
      card_name:      d.fetch("name"),
      card_type:      d.fetch("type"),
      cmc:            d.fetch("cmc"),
      color_identity: d.key?("colorIdentity") ? d["colorIdentity"].map { |x| Types::ColorIdentity[x] } : nil,
      colors:         d.key?("colors") ? d["colors"].map { |x| Types::Color[x] } : nil,
      flavor:         d.key?("flavor") ? Types::String[d["flavor"]] : nil,
      id:             d.fetch("id"),
      image_name:     d.fetch("imageName"),
      layout:         d.fetch("layout"),
      legalities:     d.fetch("legalities").map { |x| LegalityElement.from_dynamic!(x) },
      mana_cost:      d.key?("manaCost") ? Types::String[d["manaCost"]] : nil,
      mci_number:     d.key?("mciNumber") ? Types::String[d["mciNumber"]] : nil,
      multiverseid:   d.fetch("multiverseid"),
      original_text:  d.key?("originalText") ? Types::String[d["originalText"]] : nil,
      original_type:  d.fetch("originalType"),
      power:          d.key?("power") ? Types::String[d["power"]] : nil,
      printings:      d.fetch("printings"),
      rarity:         d.fetch("rarity"),
      reserved:       d.key?("reserved") ? Types::Bool[d["reserved"]] : nil,
      rulings:        d.key?("rulings") ? d["rulings"].map { |x| Ruling.from_dynamic!(x) } : nil,
      subtypes:       d.key?("subtypes") ? d["subtypes"].map { |x| Types::String[x] } : nil,
      supertypes:     d.key?("supertypes") ? d["supertypes"].map { |x| Types::Supertype[x] } : nil,
      text:           d.key?("text") ? Types::String[d["text"]] : nil,
      toughness:      d.key?("toughness") ? Types::String[d["toughness"]] : nil,
      types:          d.fetch("types"),
      variations:     d.key?("variations") ? d["variations"].map { |x| Types::Integer[x] } : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "artist"        => artist,
      "name"          => card_name,
      "type"          => card_type,
      "cmc"           => cmc,
      "colorIdentity" => color_identity,
      "colors"        => colors,
      "flavor"        => flavor,
      "id"            => id,
      "imageName"     => image_name,
      "layout"        => layout,
      "legalities"    => legalities.map { |x| x.to_dynamic },
      "manaCost"      => mana_cost,
      "mciNumber"     => mci_number,
      "multiverseid"  => multiverseid,
      "originalText"  => original_text,
      "originalType"  => original_type,
      "power"         => power,
      "printings"     => printings,
      "rarity"        => rarity,
      "reserved"      => reserved,
      "rulings"       => rulings&.map { |x| x.to_dynamic },
      "subtypes"      => subtypes,
      "supertypes"    => supertypes,
      "text"          => text,
      "toughness"     => toughness,
      "types"         => types,
      "variations"    => variations,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :booster,               Types.Array(Types::Booster)
  attribute :border,                Types::String
  attribute :cards,                 Types.Array(Card)
  attribute :code,                  Types::String
  attribute :gatherer_code,         Types::String
  attribute :magic_cards_info_code, Types::String
  attribute :mkm_id,                Types::Integer
  attribute :mkm_name,              Types::String
  attribute :release_date,          Types::String
  attribute :top_level_name,        Types::String
  attribute :top_level_type,        Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      booster:               d.fetch("booster"),
      border:                d.fetch("border"),
      cards:                 d.fetch("cards").map { |x| Card.from_dynamic!(x) },
      code:                  d.fetch("code"),
      gatherer_code:         d.fetch("gathererCode"),
      magic_cards_info_code: d.fetch("magicCardsInfoCode"),
      mkm_id:                d.fetch("mkm_id"),
      mkm_name:              d.fetch("mkm_name"),
      release_date:          d.fetch("releaseDate"),
      top_level_name:        d.fetch("name"),
      top_level_type:        d.fetch("type"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "booster"            => booster,
      "border"             => border,
      "cards"              => cards.map { |x| x.to_dynamic },
      "code"               => code,
      "gathererCode"       => gatherer_code,
      "magicCardsInfoCode" => magic_cards_info_code,
      "mkm_id"             => mkm_id,
      "mkm_name"           => mkm_name,
      "releaseDate"        => release_date,
      "name"               => top_level_name,
      "type"               => top_level_type,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
