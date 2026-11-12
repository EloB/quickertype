# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.wayao["…"]
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry.Types(default: :nominal)

  Integer = Strict::Integer
  Nil     = Strict::Nil
  Bool    = Strict::Bool
  Hash    = Strict::Hash
  String  = Strict::String
  Double  = Strict::Float | Strict::Integer
end

class Abranchiata < Dry::Struct
  attribute :integer,       Types::Integer.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :null,          Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil, null: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, integer: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_array: nil, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif integer_array != nil
      integer_array
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Academe < Dry::Struct
  attribute :integer,       Types::Integer.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :integer_map,   Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil, integer_map: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, integer: nil, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer_array: nil, integer: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif integer_array != nil
      integer_array
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Acquirable < Dry::Struct
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :union_array, Types.Array(Types::Integer.optional).optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, union_array: nil)
      end
    rescue
    end
    if schema.key(:union_array).type.right.valid? d
      return new(union_array: d, integer_map: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer_map != nil
      integer_map
    elsif union_array != nil
      union_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Aerometry < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :double, Types::Double.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Alexin < Dry::Struct
  attribute :bool,          Types::Bool.optional
  attribute :integer_array, Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif integer_array != nil
      integer_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AlleviateClass < Dry::Struct
  attribute :apriori,         Types::Nil
  attribute :beggarer,        Types::Nil
  attribute :brokenheartedly, Types::Nil
  attribute :debilitation,    Types::Nil
  attribute :frike,           Types::Nil
  attribute :gastrolith,      Types::Nil
  attribute :hulsean,         Types::Nil
  attribute :orthocentric,    Types::Nil
  attribute :petaly,          Types::Nil
  attribute :probudgeting,    Types::Nil
  attribute :reacquire,       Types::Nil
  attribute :scow,            Types::Nil
  attribute :shutoff,         Types::Nil
  attribute :subcontiguous,   Types::Nil
  attribute :suffumigate,     Types::Nil
  attribute :transformable,   Types::Nil
  attribute :uncoroneted,     Types::Nil
  attribute :unparking,       Types::Nil
  attribute :unvarnishedness, Types::Nil
  attribute :wherewithal,     Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      apriori:         d.fetch("apriori"),
      beggarer:        d.fetch("beggarer"),
      brokenheartedly: d.fetch("brokenheartedly"),
      debilitation:    d.fetch("debilitation"),
      frike:           d.fetch("frike"),
      gastrolith:      d.fetch("gastrolith"),
      hulsean:         d.fetch("Hulsean"),
      orthocentric:    d.fetch("orthocentric"),
      petaly:          d.fetch("petaly"),
      probudgeting:    d.fetch("probudgeting"),
      reacquire:       d.fetch("reacquire"),
      scow:            d.fetch("scow"),
      shutoff:         d.fetch("shutoff"),
      subcontiguous:   d.fetch("subcontiguous"),
      suffumigate:     d.fetch("suffumigate"),
      transformable:   d.fetch("transformable"),
      uncoroneted:     d.fetch("uncoroneted"),
      unparking:       d.fetch("unparking"),
      unvarnishedness: d.fetch("unvarnishedness"),
      wherewithal:     d.fetch("wherewithal"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "apriori"         => apriori,
      "beggarer"        => beggarer,
      "brokenheartedly" => brokenheartedly,
      "debilitation"    => debilitation,
      "frike"           => frike,
      "gastrolith"      => gastrolith,
      "Hulsean"         => hulsean,
      "orthocentric"    => orthocentric,
      "petaly"          => petaly,
      "probudgeting"    => probudgeting,
      "reacquire"       => reacquire,
      "scow"            => scow,
      "shutoff"         => shutoff,
      "subcontiguous"   => subcontiguous,
      "suffumigate"     => suffumigate,
      "transformable"   => transformable,
      "uncoroneted"     => uncoroneted,
      "unparking"       => unparking,
      "unvarnishedness" => unvarnishedness,
      "wherewithal"     => wherewithal,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AlleviateElement < Dry::Struct
  attribute :alleviate_class, AlleviateClass.optional
  attribute :union_array,     Types.Array(Types::Integer.optional).optional

  def self.from_dynamic!(d)
    begin
      value = AlleviateClass.from_dynamic!(d)
      if schema.key(:alleviate_class).type.right.valid? value
        return new(alleviate_class: value, union_array: nil)
      end
    rescue
    end
    if schema.key(:union_array).type.right.valid? d
      return new(union_array: d, alleviate_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if alleviate_class != nil
      alleviate_class.to_dynamic
    elsif union_array != nil
      union_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Rebecca < Dry::Struct
  attribute :catharticalness, Types::Double
  attribute :chirotherium,    Types::Integer
  attribute :disdiapason,     Types::String
  attribute :homocerc,        Types::Bool
  attribute :nonbookish,      Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      catharticalness: d.fetch("catharticalness"),
      chirotherium:    d.fetch("Chirotherium"),
      disdiapason:     d.fetch("disdiapason"),
      homocerc:        d.fetch("homocerc"),
      nonbookish:      d.fetch("nonbookish"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "catharticalness" => catharticalness,
      "Chirotherium"    => chirotherium,
      "disdiapason"     => disdiapason,
      "homocerc"        => homocerc,
      "nonbookish"      => nonbookish,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Amaa < Dry::Struct
  attribute :bool,    Types::Bool.optional
  attribute :integer, Types::Integer.optional
  attribute :rebecca, Rebecca.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, rebecca: nil, integer: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, bool: nil, rebecca: nil)
    end
    begin
      value = Rebecca.from_dynamic!(d)
      if schema.key(:rebecca).type.right.valid? value
        return new(rebecca: value, bool: nil, integer: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif integer != nil
      integer
    elsif rebecca != nil
      rebecca.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ambassage < Dry::Struct
  attribute :null_array, Types.Array(Types::Nil).optional
  attribute :string,     Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, null_array: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if null_array != nil
      null_array
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Amphithyron < Dry::Struct
  attribute :akroasis,        Types::Integer.optional
  attribute :antiphonical,    Types::Integer.optional
  attribute :basebred,        Types::Integer.optional
  attribute :catharticalness, Types::Double.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :conductometric,  Types::Integer.optional
  attribute :disdiapason,     Types::String.optional
  attribute :ensilation,      Types::Integer.optional
  attribute :eyebolt,         Types::Integer.optional
  attribute :fistulated,      Types::Integer.optional
  attribute :heteropod,       Types::Integer.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :juniperus,       Types::Integer.optional
  attribute :labyrinthically, Types::Integer.optional
  attribute :martyrization,   Types::Integer.optional
  attribute :mispolicy,       Types::Integer.optional
  attribute :multipara,       Types::Integer.optional
  attribute :nazirite,        Types::Integer.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :possessorial,    Types::Integer.optional
  attribute :shamed,          Types::Integer.optional
  attribute :shelfworn,       Types::Integer.optional
  attribute :stagnum,         Types::Integer.optional
  attribute :those,           Types::Integer.optional
  attribute :undecimal,       Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      akroasis:        d.key?("akroasis") ? Types::Integer[d["akroasis"]] : nil,
      antiphonical:    d.key?("antiphonical") ? Types::Integer[d["antiphonical"]] : nil,
      basebred:        d.key?("basebred") ? Types::Integer[d["basebred"]] : nil,
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      conductometric:  d.key?("conductometric") ? Types::Integer[d["conductometric"]] : nil,
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      ensilation:      d.key?("ensilation") ? Types::Integer[d["ensilation"]] : nil,
      eyebolt:         d.key?("eyebolt") ? Types::Integer[d["eyebolt"]] : nil,
      fistulated:      d.key?("fistulated") ? Types::Integer[d["fistulated"]] : nil,
      heteropod:       d.key?("heteropod") ? Types::Integer[d["heteropod"]] : nil,
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      juniperus:       d.key?("Juniperus") ? Types::Integer[d["Juniperus"]] : nil,
      labyrinthically: d.key?("labyrinthically") ? Types::Integer[d["labyrinthically"]] : nil,
      martyrization:   d.key?("martyrization") ? Types::Integer[d["martyrization"]] : nil,
      mispolicy:       d.key?("mispolicy") ? Types::Integer[d["mispolicy"]] : nil,
      multipara:       d.key?("multipara") ? Types::Integer[d["multipara"]] : nil,
      nazirite:        d.key?("Nazirite") ? Types::Integer[d["Nazirite"]] : nil,
      nonbookish:      d["nonbookish"],
      possessorial:    d.key?("possessorial") ? Types::Integer[d["possessorial"]] : nil,
      shamed:          d.key?("shamed") ? Types::Integer[d["shamed"]] : nil,
      shelfworn:       d.key?("shelfworn") ? Types::Integer[d["shelfworn"]] : nil,
      stagnum:         d.key?("stagnum") ? Types::Integer[d["stagnum"]] : nil,
      those:           d.key?("Those") ? Types::Integer[d["Those"]] : nil,
      undecimal:       d.key?("undecimal") ? Types::Integer[d["undecimal"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "akroasis"        => akroasis,
      "antiphonical"    => antiphonical,
      "basebred"        => basebred,
      "catharticalness" => catharticalness,
      "Chirotherium"    => chirotherium,
      "conductometric"  => conductometric,
      "disdiapason"     => disdiapason,
      "ensilation"      => ensilation,
      "eyebolt"         => eyebolt,
      "fistulated"      => fistulated,
      "heteropod"       => heteropod,
      "homocerc"        => homocerc,
      "Juniperus"       => juniperus,
      "labyrinthically" => labyrinthically,
      "martyrization"   => martyrization,
      "mispolicy"       => mispolicy,
      "multipara"       => multipara,
      "Nazirite"        => nazirite,
      "nonbookish"      => nonbookish,
      "possessorial"    => possessorial,
      "shamed"          => shamed,
      "shelfworn"       => shelfworn,
      "stagnum"         => stagnum,
      "Those"           => those,
      "undecimal"       => undecimal,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AnkeeClass < Dry::Struct
  attribute :anomoean,        Types::Nil
  attribute :barleyhood,      Types::Nil
  attribute :befriender,      Types::Nil
  attribute :brutishness,     Types::Nil
  attribute :cephalalgy,      Types::Nil
  attribute :cirurgian,       Types::Nil
  attribute :conventionally,  Types::Nil
  attribute :jackshay,        Types::Nil
  attribute :milammeter,      Types::Nil
  attribute :naja,            Types::Nil
  attribute :ombrological,    Types::Nil
  attribute :phonasthenia,    Types::Nil
  attribute :retrievableness, Types::Nil
  attribute :snakily,         Types::Nil
  attribute :swot,            Types::Nil
  attribute :tartlet,         Types::Nil
  attribute :thiofuran,       Types::Nil
  attribute :tracheophone,    Types::Nil
  attribute :tuglike,         Types::Nil
  attribute :unscratchingly,  Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      anomoean:        d.fetch("Anomoean"),
      barleyhood:      d.fetch("barleyhood"),
      befriender:      d.fetch("befriender"),
      brutishness:     d.fetch("brutishness"),
      cephalalgy:      d.fetch("cephalalgy"),
      cirurgian:       d.fetch("cirurgian"),
      conventionally:  d.fetch("conventionally"),
      jackshay:        d.fetch("jackshay"),
      milammeter:      d.fetch("milammeter"),
      naja:            d.fetch("Naja"),
      ombrological:    d.fetch("ombrological"),
      phonasthenia:    d.fetch("phonasthenia"),
      retrievableness: d.fetch("retrievableness"),
      snakily:         d.fetch("snakily"),
      swot:            d.fetch("swot"),
      tartlet:         d.fetch("tartlet"),
      thiofuran:       d.fetch("thiofuran"),
      tracheophone:    d.fetch("tracheophone"),
      tuglike:         d.fetch("tuglike"),
      unscratchingly:  d.fetch("unscratchingly"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Anomoean"        => anomoean,
      "barleyhood"      => barleyhood,
      "befriender"      => befriender,
      "brutishness"     => brutishness,
      "cephalalgy"      => cephalalgy,
      "cirurgian"       => cirurgian,
      "conventionally"  => conventionally,
      "jackshay"        => jackshay,
      "milammeter"      => milammeter,
      "Naja"            => naja,
      "ombrological"    => ombrological,
      "phonasthenia"    => phonasthenia,
      "retrievableness" => retrievableness,
      "snakily"         => snakily,
      "swot"            => swot,
      "tartlet"         => tartlet,
      "thiofuran"       => thiofuran,
      "tracheophone"    => tracheophone,
      "tuglike"         => tuglike,
      "unscratchingly"  => unscratchingly,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AnkeeElement < Dry::Struct
  attribute :ankee_class,   AnkeeClass.optional
  attribute :integer,       Types::Integer.optional
  attribute :integer_array, Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    begin
      value = AnkeeClass.from_dynamic!(d)
      if schema.key(:ankee_class).type.right.valid? value
        return new(ankee_class: value, integer_array: nil, integer: nil)
      end
    rescue
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil, ankee_class: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, ankee_class: nil, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if ankee_class != nil
      ankee_class.to_dynamic
    elsif integer != nil
      integer
    elsif integer_array != nil
      integer_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AnsarieClass < Dry::Struct
  attribute :accension,      Types::Nil
  attribute :alida,          Types::Nil
  attribute :asteria,        Types::Nil
  attribute :beriberic,      Types::Nil
  attribute :edgebone,       Types::Nil
  attribute :gastrodialysis, Types::Nil
  attribute :geographic,     Types::Nil
  attribute :ictonyx,        Types::Nil
  attribute :metrocele,      Types::Nil
  attribute :misgraft,       Types::Nil
  attribute :monteith,       Types::Nil
  attribute :notcher,        Types::Nil
  attribute :prorestriction, Types::Nil
  attribute :ramist,         Types::Nil
  attribute :throatlet,      Types::Nil
  attribute :unfair,         Types::Nil
  attribute :unsynonymous,   Types::Nil
  attribute :water,          Types::Nil
  attribute :zestfully,      Types::Nil
  attribute :zincic,         Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      accension:      d.fetch("accension"),
      alida:          d.fetch("Alida"),
      asteria:        d.fetch("asteria"),
      beriberic:      d.fetch("beriberic"),
      edgebone:       d.fetch("edgebone"),
      gastrodialysis: d.fetch("gastrodialysis"),
      geographic:     d.fetch("geographic"),
      ictonyx:        d.fetch("Ictonyx"),
      metrocele:      d.fetch("metrocele"),
      misgraft:       d.fetch("misgraft"),
      monteith:       d.fetch("monteith"),
      notcher:        d.fetch("notcher"),
      prorestriction: d.fetch("prorestriction"),
      ramist:         d.fetch("Ramist"),
      throatlet:      d.fetch("throatlet"),
      unfair:         d.fetch("unfair"),
      unsynonymous:   d.fetch("unsynonymous"),
      water:          d.fetch("water"),
      zestfully:      d.fetch("zestfully"),
      zincic:         d.fetch("zincic"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "accension"      => accension,
      "Alida"          => alida,
      "asteria"        => asteria,
      "beriberic"      => beriberic,
      "edgebone"       => edgebone,
      "gastrodialysis" => gastrodialysis,
      "geographic"     => geographic,
      "Ictonyx"        => ictonyx,
      "metrocele"      => metrocele,
      "misgraft"       => misgraft,
      "monteith"       => monteith,
      "notcher"        => notcher,
      "prorestriction" => prorestriction,
      "Ramist"         => ramist,
      "throatlet"      => throatlet,
      "unfair"         => unfair,
      "unsynonymous"   => unsynonymous,
      "water"          => water,
      "zestfully"      => zestfully,
      "zincic"         => zincic,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AnsarieElement < Dry::Struct
  attribute :ansarie_class, AnsarieClass.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :null,          Types::Nil.optional

  def self.from_dynamic!(d)
    begin
      value = AnsarieClass.from_dynamic!(d)
      if schema.key(:ansarie_class).type.right.valid? value
        return new(ansarie_class: value, integer_array: nil, null: nil)
      end
    rescue
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, ansarie_class: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_array: nil, ansarie_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if ansarie_class != nil
      ansarie_class.to_dynamic
    elsif integer_array != nil
      integer_array
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Aphasia < Dry::Struct
  attribute :integer,       Types::Integer.optional
  attribute :integer_array, Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif integer_array != nil
      integer_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Asprawl < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bedesman < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :double, Types::Double.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil, string: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif double != nil
      double
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Belard < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :rebecca,       Rebecca.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_array: nil, rebecca: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, rebecca: nil, double: nil)
    end
    begin
      value = Rebecca.from_dynamic!(d)
      if schema.key(:rebecca).type.right.valid? value
        return new(rebecca: value, integer_array: nil, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif integer_array != nil
      integer_array
    elsif rebecca != nil
      rebecca.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bocking < Dry::Struct
  attribute :bool,          Types::Bool.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :integer_map,   Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil, integer_map: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer_array: nil, bool: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif integer_array != nil
      integer_array
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Brawlingly < Dry::Struct
  attribute :null_array, Types.Array(Types::Nil).optional
  attribute :union_map,  Types::Hash.meta(of: Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, union_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, v] }.to_h
      if schema.key(:union_map).type.right.valid? value
        return new(union_map: value, null_array: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if null_array != nil
      null_array
    elsif union_map != nil
      union_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Brookie < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :rebecca,       Rebecca.optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, rebecca: nil)
    end
    begin
      value = Rebecca.from_dynamic!(d)
      if schema.key(:rebecca).type.right.valid? value
        return new(rebecca: value, integer_array: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer_array != nil
      integer_array
    elsif rebecca != nil
      rebecca.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Bumboatman < Dry::Struct
  attribute :null,       Types::Nil.optional
  attribute :null_array, Types.Array(Types::Nil).optional
  attribute :string,     Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:null).type.right.valid? d
      return new(null: d, null_array: nil, string: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, null: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, null_array: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if null_array != nil
      null_array
    elsif string != nil
      string
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Calaverite < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer_array != nil
      integer_array
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Catallactic < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null_array,  Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null_array: nil, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, null_array: nil, bool: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, bool: nil, integer_map: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif integer_map != nil
      integer_map
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Cemental < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :integer_map,   Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_array: nil, integer_map: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, double: nil, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer_array: nil, double: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif integer_array != nil
      integer_array
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ChytridiaceaeClass < Dry::Struct
  attribute :batidaceae,     Types::Nil
  attribute :brechites,      Types::Nil
  attribute :codespairer,    Types::Nil
  attribute :emery,          Types::Nil
  attribute :enervative,     Types::Nil
  attribute :excriminate,    Types::Nil
  attribute :goshenite,      Types::Nil
  attribute :grime,          Types::Nil
  attribute :gritten,        Types::Nil
  attribute :hectorly,       Types::Nil
  attribute :intermediation, Types::Nil
  attribute :meeterly,       Types::Nil
  attribute :narraganset,    Types::Nil
  attribute :onymatic,       Types::Nil
  attribute :paddlecock,     Types::Nil
  attribute :thana,          Types::Nil
  attribute :thornily,       Types::Nil
  attribute :uckia,          Types::Nil
  attribute :unmettle,       Types::Nil
  attribute :vorticellid,    Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      batidaceae:     d.fetch("Batidaceae"),
      brechites:      d.fetch("Brechites"),
      codespairer:    d.fetch("codespairer"),
      emery:          d.fetch("Emery"),
      enervative:     d.fetch("enervative"),
      excriminate:    d.fetch("excriminate"),
      goshenite:      d.fetch("goshenite"),
      grime:          d.fetch("grime"),
      gritten:        d.fetch("gritten"),
      hectorly:       d.fetch("hectorly"),
      intermediation: d.fetch("intermediation"),
      meeterly:       d.fetch("meeterly"),
      narraganset:    d.fetch("Narraganset"),
      onymatic:       d.fetch("onymatic"),
      paddlecock:     d.fetch("paddlecock"),
      thana:          d.fetch("thana"),
      thornily:       d.fetch("thornily"),
      uckia:          d.fetch("uckia"),
      unmettle:       d.fetch("unmettle"),
      vorticellid:    d.fetch("vorticellid"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Batidaceae"     => batidaceae,
      "Brechites"      => brechites,
      "codespairer"    => codespairer,
      "Emery"          => emery,
      "enervative"     => enervative,
      "excriminate"    => excriminate,
      "goshenite"      => goshenite,
      "grime"          => grime,
      "gritten"        => gritten,
      "hectorly"       => hectorly,
      "intermediation" => intermediation,
      "meeterly"       => meeterly,
      "Narraganset"    => narraganset,
      "onymatic"       => onymatic,
      "paddlecock"     => paddlecock,
      "thana"          => thana,
      "thornily"       => thornily,
      "uckia"          => uckia,
      "unmettle"       => unmettle,
      "vorticellid"    => vorticellid,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ChytridiaceaeElement < Dry::Struct
  attribute :bool,                Types::Bool.optional
  attribute :chytridiaceae_class, ChytridiaceaeClass.optional
  attribute :null,                Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, chytridiaceae_class: nil, null: nil)
    end
    begin
      value = ChytridiaceaeClass.from_dynamic!(d)
      if schema.key(:chytridiaceae_class).type.right.valid? value
        return new(chytridiaceae_class: value, bool: nil, null: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, bool: nil, chytridiaceae_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif chytridiaceae_class != nil
      chytridiaceae_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DiscordiaClass < Dry::Struct
  attribute :altaic,           Types::Integer.optional
  attribute :amoristic,        Types::Integer.optional
  attribute :blennophthalmia,  Types::Integer.optional
  attribute :catharticalness,  Types::Double.optional
  attribute :chirotherium,     Types::Integer.optional
  attribute :disciplinability, Types::Integer.optional
  attribute :disdiapason,      Types::String.optional
  attribute :goofer,           Types::Integer.optional
  attribute :homocerc,         Types::Bool.optional
  attribute :laryngograph,     Types::Integer.optional
  attribute :leucitis,         Types::Integer.optional
  attribute :lymphocyst,       Types::Integer.optional
  attribute :microcosmology,   Types::Integer.optional
  attribute :nauseation,       Types::Integer.optional
  attribute :nonbookish,       Types::Nil.optional
  attribute :patarin,          Types::Integer.optional
  attribute :preliberal,       Types::Integer.optional
  attribute :prettifier,       Types::Integer.optional
  attribute :rangework,        Types::Integer.optional
  attribute :redient,          Types::Integer.optional
  attribute :subfusiform,      Types::Integer.optional
  attribute :suicidical,       Types::Integer.optional
  attribute :swow,             Types::Integer.optional
  attribute :wastrel,          Types::Integer.optional
  attribute :wingle,           Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      altaic:           d.key?("Altaic") ? Types::Integer[d["Altaic"]] : nil,
      amoristic:        d.key?("amoristic") ? Types::Integer[d["amoristic"]] : nil,
      blennophthalmia:  d.key?("blennophthalmia") ? Types::Integer[d["blennophthalmia"]] : nil,
      catharticalness:  d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:     d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      disciplinability: d.key?("disciplinability") ? Types::Integer[d["disciplinability"]] : nil,
      disdiapason:      d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      goofer:           d.key?("goofer") ? Types::Integer[d["goofer"]] : nil,
      homocerc:         d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      laryngograph:     d.key?("laryngograph") ? Types::Integer[d["laryngograph"]] : nil,
      leucitis:         d.key?("leucitis") ? Types::Integer[d["leucitis"]] : nil,
      lymphocyst:       d.key?("lymphocyst") ? Types::Integer[d["lymphocyst"]] : nil,
      microcosmology:   d.key?("microcosmology") ? Types::Integer[d["microcosmology"]] : nil,
      nauseation:       d.key?("nauseation") ? Types::Integer[d["nauseation"]] : nil,
      nonbookish:       d["nonbookish"],
      patarin:          d.key?("Patarin") ? Types::Integer[d["Patarin"]] : nil,
      preliberal:       d.key?("preliberal") ? Types::Integer[d["preliberal"]] : nil,
      prettifier:       d.key?("prettifier") ? Types::Integer[d["prettifier"]] : nil,
      rangework:        d.key?("rangework") ? Types::Integer[d["rangework"]] : nil,
      redient:          d.key?("redient") ? Types::Integer[d["redient"]] : nil,
      subfusiform:      d.key?("subfusiform") ? Types::Integer[d["subfusiform"]] : nil,
      suicidical:       d.key?("suicidical") ? Types::Integer[d["suicidical"]] : nil,
      swow:             d.key?("swow") ? Types::Integer[d["swow"]] : nil,
      wastrel:          d.key?("wastrel") ? Types::Integer[d["wastrel"]] : nil,
      wingle:           d.key?("wingle") ? Types::Integer[d["wingle"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Altaic"           => altaic,
      "amoristic"        => amoristic,
      "blennophthalmia"  => blennophthalmia,
      "catharticalness"  => catharticalness,
      "Chirotherium"     => chirotherium,
      "disciplinability" => disciplinability,
      "disdiapason"      => disdiapason,
      "goofer"           => goofer,
      "homocerc"         => homocerc,
      "laryngograph"     => laryngograph,
      "leucitis"         => leucitis,
      "lymphocyst"       => lymphocyst,
      "microcosmology"   => microcosmology,
      "nauseation"       => nauseation,
      "nonbookish"       => nonbookish,
      "Patarin"          => patarin,
      "preliberal"       => preliberal,
      "prettifier"       => prettifier,
      "rangework"        => rangework,
      "redient"          => redient,
      "subfusiform"      => subfusiform,
      "suicidical"       => suicidical,
      "swow"             => swow,
      "wastrel"          => wastrel,
      "wingle"           => wingle,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DiscordiaElement < Dry::Struct
  attribute :discordia_class, DiscordiaClass.optional
  attribute :integer_array,   Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    begin
      value = DiscordiaClass.from_dynamic!(d)
      if schema.key(:discordia_class).type.right.valid? value
        return new(discordia_class: value, integer_array: nil)
      end
    rescue
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, discordia_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if discordia_class != nil
      discordia_class.to_dynamic
    elsif integer_array != nil
      integer_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Endomyce < Dry::Struct
  attribute :integer, Types::Integer.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Epinephelidae < Dry::Struct
  attribute :bool,    Types::Bool.optional
  attribute :integer, Types::Integer.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer: nil, string: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, bool: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif integer != nil
      integer
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Eupatorium < Dry::Struct
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null_array,  Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, null_array: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, integer_map: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer_map != nil
      integer_map
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class GryphosaurusClass < Dry::Struct
  attribute :amissibility,    Types::Nil
  attribute :burushaski,      Types::Nil
  attribute :citronin,        Types::Nil
  attribute :coplaintiff,     Types::Nil
  attribute :disquisitionary, Types::Nil
  attribute :enoplan,         Types::Nil
  attribute :faintness,       Types::Nil
  attribute :hebetomy,        Types::Nil
  attribute :islandry,        Types::Nil
  attribute :lameduck,        Types::Nil
  attribute :overbattle,      Types::Nil
  attribute :overinterested,  Types::Nil
  attribute :phrenologic,     Types::Nil
  attribute :rainband,        Types::Nil
  attribute :shiningly,       Types::Nil
  attribute :stamineous,      Types::Nil
  attribute :subscapularis,   Types::Nil
  attribute :tahami,          Types::Nil
  attribute :undaubed,        Types::Nil
  attribute :underntime,      Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      amissibility:    d.fetch("amissibility"),
      burushaski:      d.fetch("Burushaski"),
      citronin:        d.fetch("citronin"),
      coplaintiff:     d.fetch("coplaintiff"),
      disquisitionary: d.fetch("disquisitionary"),
      enoplan:         d.fetch("enoplan"),
      faintness:       d.fetch("faintness"),
      hebetomy:        d.fetch("hebetomy"),
      islandry:        d.fetch("islandry"),
      lameduck:        d.fetch("lameduck"),
      overbattle:      d.fetch("overbattle"),
      overinterested:  d.fetch("overinterested"),
      phrenologic:     d.fetch("phrenologic"),
      rainband:        d.fetch("rainband"),
      shiningly:       d.fetch("shiningly"),
      stamineous:      d.fetch("stamineous"),
      subscapularis:   d.fetch("subscapularis"),
      tahami:          d.fetch("Tahami"),
      undaubed:        d.fetch("undaubed"),
      underntime:      d.fetch("underntime"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "amissibility"    => amissibility,
      "Burushaski"      => burushaski,
      "citronin"        => citronin,
      "coplaintiff"     => coplaintiff,
      "disquisitionary" => disquisitionary,
      "enoplan"         => enoplan,
      "faintness"       => faintness,
      "hebetomy"        => hebetomy,
      "islandry"        => islandry,
      "lameduck"        => lameduck,
      "overbattle"      => overbattle,
      "overinterested"  => overinterested,
      "phrenologic"     => phrenologic,
      "rainband"        => rainband,
      "shiningly"       => shiningly,
      "stamineous"      => stamineous,
      "subscapularis"   => subscapularis,
      "Tahami"          => tahami,
      "undaubed"        => undaubed,
      "underntime"      => underntime,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class GryphosaurusElement < Dry::Struct
  attribute :gryphosaurus_class, GryphosaurusClass.optional
  attribute :integer_array,      Types.Array(Types::Integer).optional
  attribute :string,             Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = GryphosaurusClass.from_dynamic!(d)
      if schema.key(:gryphosaurus_class).type.right.valid? value
        return new(gryphosaurus_class: value, integer_array: nil, string: nil)
      end
    rescue
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, gryphosaurus_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil, gryphosaurus_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if gryphosaurus_class != nil
      gryphosaurus_class.to_dynamic
    elsif integer_array != nil
      integer_array
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Koryak < Dry::Struct
  attribute :string,    Types::String.optional
  attribute :union_map, Types::Hash.meta(of: Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:string).type.right.valid? d
      return new(string: d, union_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, v] }.to_h
      if schema.key(:union_map).type.right.valid? value
        return new(union_map: value, string: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if string != nil
      string
    elsif union_map != nil
      union_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LaviniaClass < Dry::Struct
  attribute :agitable,          Types::Integer.optional
  attribute :asininity,         Types::Integer.optional
  attribute :benefiter,         Types::Integer.optional
  attribute :bronzelike,        Types::Integer.optional
  attribute :catharticalness,   Types::Double.optional
  attribute :chirotherium,      Types::Integer.optional
  attribute :cholesteatomatous, Types::Integer.optional
  attribute :deprivement,       Types::Integer.optional
  attribute :disdiapason,       Types::String.optional
  attribute :flippantness,      Types::Integer.optional
  attribute :fogproof,          Types::Integer.optional
  attribute :homocerc,          Types::Bool.optional
  attribute :merrymeeting,      Types::Integer.optional
  attribute :nonbookish,        Types::Nil.optional
  attribute :overcareful,       Types::Integer.optional
  attribute :panaris,           Types::Integer.optional
  attribute :preacceptance,     Types::Integer.optional
  attribute :quinoxaline,       Types::Integer.optional
  attribute :sig,               Types::Integer.optional
  attribute :superconfusion,    Types::Integer.optional
  attribute :tacana,            Types::Integer.optional
  attribute :tillotter,         Types::Integer.optional
  attribute :tranquillize,      Types::Integer.optional
  attribute :unquestionable,    Types::Integer.optional
  attribute :uproute,           Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      agitable:          d.key?("agitable") ? Types::Integer[d["agitable"]] : nil,
      asininity:         d.key?("asininity") ? Types::Integer[d["asininity"]] : nil,
      benefiter:         d.key?("benefiter") ? Types::Integer[d["benefiter"]] : nil,
      bronzelike:        d.key?("bronzelike") ? Types::Integer[d["bronzelike"]] : nil,
      catharticalness:   d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:      d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      cholesteatomatous: d.key?("cholesteatomatous") ? Types::Integer[d["cholesteatomatous"]] : nil,
      deprivement:       d.key?("deprivement") ? Types::Integer[d["deprivement"]] : nil,
      disdiapason:       d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      flippantness:      d.key?("flippantness") ? Types::Integer[d["flippantness"]] : nil,
      fogproof:          d.key?("fogproof") ? Types::Integer[d["fogproof"]] : nil,
      homocerc:          d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      merrymeeting:      d.key?("merrymeeting") ? Types::Integer[d["merrymeeting"]] : nil,
      nonbookish:        d["nonbookish"],
      overcareful:       d.key?("overcareful") ? Types::Integer[d["overcareful"]] : nil,
      panaris:           d.key?("panaris") ? Types::Integer[d["panaris"]] : nil,
      preacceptance:     d.key?("preacceptance") ? Types::Integer[d["preacceptance"]] : nil,
      quinoxaline:       d.key?("quinoxaline") ? Types::Integer[d["quinoxaline"]] : nil,
      sig:               d.key?("sig") ? Types::Integer[d["sig"]] : nil,
      superconfusion:    d.key?("superconfusion") ? Types::Integer[d["superconfusion"]] : nil,
      tacana:            d.key?("Tacana") ? Types::Integer[d["Tacana"]] : nil,
      tillotter:         d.key?("tillotter") ? Types::Integer[d["tillotter"]] : nil,
      tranquillize:      d.key?("tranquillize") ? Types::Integer[d["tranquillize"]] : nil,
      unquestionable:    d.key?("unquestionable") ? Types::Integer[d["unquestionable"]] : nil,
      uproute:           d.key?("uproute") ? Types::Integer[d["uproute"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "agitable"          => agitable,
      "asininity"         => asininity,
      "benefiter"         => benefiter,
      "bronzelike"        => bronzelike,
      "catharticalness"   => catharticalness,
      "Chirotherium"      => chirotherium,
      "cholesteatomatous" => cholesteatomatous,
      "deprivement"       => deprivement,
      "disdiapason"       => disdiapason,
      "flippantness"      => flippantness,
      "fogproof"          => fogproof,
      "homocerc"          => homocerc,
      "merrymeeting"      => merrymeeting,
      "nonbookish"        => nonbookish,
      "overcareful"       => overcareful,
      "panaris"           => panaris,
      "preacceptance"     => preacceptance,
      "quinoxaline"       => quinoxaline,
      "sig"               => sig,
      "superconfusion"    => superconfusion,
      "Tacana"            => tacana,
      "tillotter"         => tillotter,
      "tranquillize"      => tranquillize,
      "unquestionable"    => unquestionable,
      "uproute"           => uproute,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LaviniaElement < Dry::Struct
  attribute :lavinia_class, LaviniaClass.optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = LaviniaClass.from_dynamic!(d)
      if schema.key(:lavinia_class).type.right.valid? value
        return new(lavinia_class: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, lavinia_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if lavinia_class != nil
      lavinia_class.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OskarClass < Dry::Struct
  attribute :acrobates,        Types::Nil
  attribute :beanshooter,      Types::Nil
  attribute :bearhound,        Types::Nil
  attribute :cayuga,           Types::Nil
  attribute :guarneri,         Types::Nil
  attribute :hypochondriacism, Types::Nil
  attribute :indication,       Types::Nil
  attribute :jaculative,       Types::Nil
  attribute :nagana,           Types::Nil
  attribute :netherlandish,    Types::Nil
  attribute :noctivagous,      Types::Nil
  attribute :nonphysiological, Types::Nil
  attribute :praxis,           Types::Nil
  attribute :provision,        Types::Nil
  attribute :subterhuman,      Types::Nil
  attribute :sunlit,           Types::Nil
  attribute :syncraniate,      Types::Nil
  attribute :teachment,        Types::Nil
  attribute :unmutinous,       Types::Nil
  attribute :unstoppable,      Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      acrobates:        d.fetch("Acrobates"),
      beanshooter:      d.fetch("beanshooter"),
      bearhound:        d.fetch("bearhound"),
      cayuga:           d.fetch("Cayuga"),
      guarneri:         d.fetch("guarneri"),
      hypochondriacism: d.fetch("hypochondriacism"),
      indication:       d.fetch("indication"),
      jaculative:       d.fetch("jaculative"),
      nagana:           d.fetch("nagana"),
      netherlandish:    d.fetch("Netherlandish"),
      noctivagous:      d.fetch("noctivagous"),
      nonphysiological: d.fetch("nonphysiological"),
      praxis:           d.fetch("praxis"),
      provision:        d.fetch("provision"),
      subterhuman:      d.fetch("subterhuman"),
      sunlit:           d.fetch("sunlit"),
      syncraniate:      d.fetch("syncraniate"),
      teachment:        d.fetch("teachment"),
      unmutinous:       d.fetch("unmutinous"),
      unstoppable:      d.fetch("unstoppable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Acrobates"        => acrobates,
      "beanshooter"      => beanshooter,
      "bearhound"        => bearhound,
      "Cayuga"           => cayuga,
      "guarneri"         => guarneri,
      "hypochondriacism" => hypochondriacism,
      "indication"       => indication,
      "jaculative"       => jaculative,
      "nagana"           => nagana,
      "Netherlandish"    => netherlandish,
      "noctivagous"      => noctivagous,
      "nonphysiological" => nonphysiological,
      "praxis"           => praxis,
      "provision"        => provision,
      "subterhuman"      => subterhuman,
      "sunlit"           => sunlit,
      "syncraniate"      => syncraniate,
      "teachment"        => teachment,
      "unmutinous"       => unmutinous,
      "unstoppable"      => unstoppable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OskarElement < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :oskar_class,   OskarClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, oskar_class: nil)
    end
    begin
      value = OskarClass.from_dynamic!(d)
      if schema.key(:oskar_class).type.right.valid? value
        return new(oskar_class: value, integer_array: nil)
      end
    rescue
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer_array != nil
      integer_array
    elsif oskar_class != nil
      oskar_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RebeccaElement < Dry::Struct
  attribute :integer, Types::Integer.optional
  attribute :rebecca, Rebecca.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, rebecca: nil, string: nil)
    end
    begin
      value = Rebecca.from_dynamic!(d)
      if schema.key(:rebecca).type.right.valid? value
        return new(rebecca: value, integer: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, rebecca: nil, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif rebecca != nil
      rebecca.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Rhomboganoidei < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :rebecca,       Rebecca.optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, rebecca: nil, string: nil)
    end
    begin
      value = Rebecca.from_dynamic!(d)
      if schema.key(:rebecca).type.right.valid? value
        return new(rebecca: value, integer_array: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil, rebecca: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer_array != nil
      integer_array
    elsif rebecca != nil
      rebecca.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ruellia < Dry::Struct
  attribute :bool,    Types::Bool.optional
  attribute :rebecca, Rebecca.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, rebecca: nil, string: nil)
    end
    begin
      value = Rebecca.from_dynamic!(d)
      if schema.key(:rebecca).type.right.valid? value
        return new(rebecca: value, bool: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, rebecca: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif rebecca != nil
      rebecca.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class School < Dry::Struct
  attribute :integer,     Types::Integer.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null,        Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_map: nil, null: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer: nil, null: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer: nil, integer_map: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif integer_map != nil
      integer_map
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Shakespearolater < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_array: nil, string: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, double: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif integer_array != nil
      integer_array
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :abranchiata,      Types.Array(Types.Instance(Abranchiata))
  attribute :academe,          Types.Array(Types.Instance(Academe))
  attribute :acquirable,       Types.Array(Types.Instance(Acquirable))
  attribute :aerometry,        Types.Array(Types.Instance(Aerometry))
  attribute :alexin,           Types.Array(Types.Instance(Alexin))
  attribute :alleviate,        Types.Array(Types.Instance(AlleviateElement))
  attribute :amaas,            Types.Array(Types.Instance(Amaa))
  attribute :ambassage,        Types.Array(Types.Instance(Ambassage))
  attribute :amphithyron,      Types.Array(Amphithyron.optional)
  attribute :andriana,         Types.Array(Types::String.optional)
  attribute :ankee,            Types.Array(Types.Instance(AnkeeElement))
  attribute :annihilator,      Types.Array(Types::Hash.meta(of: Types::Integer.optional).optional)
  attribute :annulose,         Types::Nil
  attribute :ansarie,          Types.Array(Types.Instance(AnsarieElement))
  attribute :aphasia,          Types.Array(Types.Instance(Aphasia))
  attribute :asprawl,          Types.Array(Types.Instance(Asprawl))
  attribute :attractive,       Types.Array(Types::Bool.optional)
  attribute :barksome,         Types::Hash.meta(of: Types::Integer)
  attribute :bedesman,         Types.Array(Types.Instance(Bedesman))
  attribute :belard,           Types.Array(Types.Instance(Belard))
  attribute :bocking,          Types.Array(Types.Instance(Bocking))
  attribute :brawlingly,       Types.Array(Types.Instance(Brawlingly))
  attribute :brookie,          Types.Array(Types.Instance(Brookie))
  attribute :bumboatman,       Types.Array(Types.Instance(Bumboatman))
  attribute :bystreet,         Types.Array(Types::Nil)
  attribute :calaverite,       Types.Array(Types.Instance(Calaverite))
  attribute :catallactic,      Types.Array(Types.Instance(Catallactic))
  attribute :cemental,         Types.Array(Types.Instance(Cemental))
  attribute :chytridiaceae,    Types.Array(Types.Instance(ChytridiaceaeElement))
  attribute :discordia,        Types.Array(Types.Instance(DiscordiaElement))
  attribute :endomyces,        Types.Array(Types.Instance(Endomyce))
  attribute :epinephelidae,    Types.Array(Types.Instance(Epinephelidae))
  attribute :eupatorium,       Types.Array(Types.Instance(Eupatorium))
  attribute :gryphosaurus,     Types.Array(Types.Instance(GryphosaurusElement))
  attribute :koryak,           Types.Array(Types.Instance(Koryak))
  attribute :lavinia,          Types.Array(Types.Instance(LaviniaElement))
  attribute :oskar,            Types.Array(Types.Instance(OskarElement))
  attribute :rebecca,          Types.Array(Types.Instance(RebeccaElement))
  attribute :rhomboganoidei,   Types.Array(Types.Instance(Rhomboganoidei))
  attribute :rigsmal,          Types::Bool
  attribute :ruellia,          Types.Array(Types.Instance(Ruellia))
  attribute :school,           Types.Array(Types.Instance(School))
  attribute :shakespearolater, Types.Array(Types.Instance(Shakespearolater))
  attribute :svan,             Types.Array(Types::Double)
  attribute :wayao,            Types::Hash.meta(of: Types::Double)

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      abranchiata:      d.fetch("Abranchiata").map { |x| Abranchiata.from_dynamic!(x) },
      academe:          d.fetch("academe").map { |x| Academe.from_dynamic!(x) },
      acquirable:       d.fetch("acquirable").map { |x| Acquirable.from_dynamic!(x) },
      aerometry:        d.fetch("aerometry").map { |x| Aerometry.from_dynamic!(x) },
      alexin:           d.fetch("alexin").map { |x| Alexin.from_dynamic!(x) },
      alleviate:        d.fetch("alleviate").map { |x| AlleviateElement.from_dynamic!(x) },
      amaas:            d.fetch("amaas").map { |x| Amaa.from_dynamic!(x) },
      ambassage:        d.fetch("ambassage").map { |x| Ambassage.from_dynamic!(x) },
      amphithyron:      d.fetch("amphithyron").map { |x| x ? Amphithyron.from_dynamic!(x) : nil },
      andriana:         d.fetch("Andriana"),
      ankee:            d.fetch("ankee").map { |x| AnkeeElement.from_dynamic!(x) },
      annihilator:      d.fetch("annihilator").map { |x| Types::Hash.optional[x]&.map { |k, v| [k, v] }&.to_h },
      annulose:         d.fetch("annulose"),
      ansarie:          d.fetch("Ansarie").map { |x| AnsarieElement.from_dynamic!(x) },
      aphasia:          d.fetch("aphasia").map { |x| Aphasia.from_dynamic!(x) },
      asprawl:          d.fetch("asprawl").map { |x| Asprawl.from_dynamic!(x) },
      attractive:       d.fetch("attractive"),
      barksome:         Types::Hash[d.fetch("barksome")].map { |k, v| [k, Types::Integer[v]] }.to_h,
      bedesman:         d.fetch("bedesman").map { |x| Bedesman.from_dynamic!(x) },
      belard:           d.fetch("belard").map { |x| Belard.from_dynamic!(x) },
      bocking:          d.fetch("bocking").map { |x| Bocking.from_dynamic!(x) },
      brawlingly:       d.fetch("brawlingly").map { |x| Brawlingly.from_dynamic!(x) },
      brookie:          d.fetch("brookie").map { |x| Brookie.from_dynamic!(x) },
      bumboatman:       d.fetch("bumboatman").map { |x| Bumboatman.from_dynamic!(x) },
      bystreet:         d.fetch("bystreet"),
      calaverite:       d.fetch("calaverite").map { |x| Calaverite.from_dynamic!(x) },
      catallactic:      d.fetch("catallactic").map { |x| Catallactic.from_dynamic!(x) },
      cemental:         d.fetch("cemental").map { |x| Cemental.from_dynamic!(x) },
      chytridiaceae:    d.fetch("Chytridiaceae").map { |x| ChytridiaceaeElement.from_dynamic!(x) },
      discordia:        d.fetch("Discordia").map { |x| DiscordiaElement.from_dynamic!(x) },
      endomyces:        d.fetch("Endomyces").map { |x| Endomyce.from_dynamic!(x) },
      epinephelidae:    d.fetch("Epinephelidae").map { |x| Epinephelidae.from_dynamic!(x) },
      eupatorium:       d.fetch("Eupatorium").map { |x| Eupatorium.from_dynamic!(x) },
      gryphosaurus:     d.fetch("Gryphosaurus").map { |x| GryphosaurusElement.from_dynamic!(x) },
      koryak:           d.fetch("Koryak").map { |x| Koryak.from_dynamic!(x) },
      lavinia:          d.fetch("Lavinia").map { |x| LaviniaElement.from_dynamic!(x) },
      oskar:            d.fetch("Oskar").map { |x| OskarElement.from_dynamic!(x) },
      rebecca:          d.fetch("Rebecca").map { |x| RebeccaElement.from_dynamic!(x) },
      rhomboganoidei:   d.fetch("Rhomboganoidei").map { |x| Rhomboganoidei.from_dynamic!(x) },
      rigsmal:          d.fetch("Rigsmal"),
      ruellia:          d.fetch("Ruellia").map { |x| Ruellia.from_dynamic!(x) },
      school:           d.fetch("School").map { |x| School.from_dynamic!(x) },
      shakespearolater: d.fetch("Shakespearolater").map { |x| Shakespearolater.from_dynamic!(x) },
      svan:             d.fetch("Svan"),
      wayao:            Types::Hash[d.fetch("Wayao")].map { |k, v| [k, Types::Double[v]] }.to_h,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Abranchiata"      => abranchiata.map { |x| x.to_dynamic },
      "academe"          => academe.map { |x| x.to_dynamic },
      "acquirable"       => acquirable.map { |x| x.to_dynamic },
      "aerometry"        => aerometry.map { |x| x.to_dynamic },
      "alexin"           => alexin.map { |x| x.to_dynamic },
      "alleviate"        => alleviate.map { |x| x.to_dynamic },
      "amaas"            => amaas.map { |x| x.to_dynamic },
      "ambassage"        => ambassage.map { |x| x.to_dynamic },
      "amphithyron"      => amphithyron.map { |x| x&.to_dynamic },
      "Andriana"         => andriana,
      "ankee"            => ankee.map { |x| x.to_dynamic },
      "annihilator"      => annihilator,
      "annulose"         => annulose,
      "Ansarie"          => ansarie.map { |x| x.to_dynamic },
      "aphasia"          => aphasia.map { |x| x.to_dynamic },
      "asprawl"          => asprawl.map { |x| x.to_dynamic },
      "attractive"       => attractive,
      "barksome"         => barksome,
      "bedesman"         => bedesman.map { |x| x.to_dynamic },
      "belard"           => belard.map { |x| x.to_dynamic },
      "bocking"          => bocking.map { |x| x.to_dynamic },
      "brawlingly"       => brawlingly.map { |x| x.to_dynamic },
      "brookie"          => brookie.map { |x| x.to_dynamic },
      "bumboatman"       => bumboatman.map { |x| x.to_dynamic },
      "bystreet"         => bystreet,
      "calaverite"       => calaverite.map { |x| x.to_dynamic },
      "catallactic"      => catallactic.map { |x| x.to_dynamic },
      "cemental"         => cemental.map { |x| x.to_dynamic },
      "Chytridiaceae"    => chytridiaceae.map { |x| x.to_dynamic },
      "Discordia"        => discordia.map { |x| x.to_dynamic },
      "Endomyces"        => endomyces.map { |x| x.to_dynamic },
      "Epinephelidae"    => epinephelidae.map { |x| x.to_dynamic },
      "Eupatorium"       => eupatorium.map { |x| x.to_dynamic },
      "Gryphosaurus"     => gryphosaurus.map { |x| x.to_dynamic },
      "Koryak"           => koryak.map { |x| x.to_dynamic },
      "Lavinia"          => lavinia.map { |x| x.to_dynamic },
      "Oskar"            => oskar.map { |x| x.to_dynamic },
      "Rebecca"          => rebecca.map { |x| x.to_dynamic },
      "Rhomboganoidei"   => rhomboganoidei.map { |x| x.to_dynamic },
      "Rigsmal"          => rigsmal,
      "Ruellia"          => ruellia.map { |x| x.to_dynamic },
      "School"           => school.map { |x| x.to_dynamic },
      "Shakespearolater" => shakespearolater.map { |x| x.to_dynamic },
      "Svan"             => svan,
      "Wayao"            => wayao,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
