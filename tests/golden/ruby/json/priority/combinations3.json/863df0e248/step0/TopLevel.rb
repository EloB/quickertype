# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.protext.first
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

class JurorClass < Dry::Struct
  attribute :adipsy,          Types::Nil
  attribute :auxiliator,      Types::Nil
  attribute :benda,           Types::Nil
  attribute :benjamin,        Types::Nil
  attribute :brandling,       Types::Nil
  attribute :epicurishly,     Types::Nil
  attribute :eremochaetous,   Types::Nil
  attribute :marten,          Types::Nil
  attribute :monocline,       Types::Nil
  attribute :olea,            Types::Nil
  attribute :palgat,          Types::Nil
  attribute :pennyworth,      Types::Nil
  attribute :pioury,          Types::Nil
  attribute :pragmatistic,    Types::Nil
  attribute :stylelessness,   Types::Nil
  attribute :systematical,    Types::Nil
  attribute :thready,         Types::Nil
  attribute :uncontemporary,  Types::Nil
  attribute :uncouched,       Types::Nil
  attribute :uninhabitedness, Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      adipsy:          d.fetch("adipsy"),
      auxiliator:      d.fetch("auxiliator"),
      benda:           d.fetch("benda"),
      benjamin:        d.fetch("benjamin"),
      brandling:       d.fetch("brandling"),
      epicurishly:     d.fetch("epicurishly"),
      eremochaetous:   d.fetch("eremochaetous"),
      marten:          d.fetch("marten"),
      monocline:       d.fetch("monocline"),
      olea:            d.fetch("Olea"),
      palgat:          d.fetch("palgat"),
      pennyworth:      d.fetch("pennyworth"),
      pioury:          d.fetch("pioury"),
      pragmatistic:    d.fetch("pragmatistic"),
      stylelessness:   d.fetch("stylelessness"),
      systematical:    d.fetch("systematical"),
      thready:         d.fetch("thready"),
      uncontemporary:  d.fetch("uncontemporary"),
      uncouched:       d.fetch("uncouched"),
      uninhabitedness: d.fetch("uninhabitedness"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "adipsy"          => adipsy,
      "auxiliator"      => auxiliator,
      "benda"           => benda,
      "benjamin"        => benjamin,
      "brandling"       => brandling,
      "epicurishly"     => epicurishly,
      "eremochaetous"   => eremochaetous,
      "marten"          => marten,
      "monocline"       => monocline,
      "Olea"            => olea,
      "palgat"          => palgat,
      "pennyworth"      => pennyworth,
      "pioury"          => pioury,
      "pragmatistic"    => pragmatistic,
      "stylelessness"   => stylelessness,
      "systematical"    => systematical,
      "thready"         => thready,
      "uncontemporary"  => uncontemporary,
      "uncouched"       => uncouched,
      "uninhabitedness" => uninhabitedness,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class JurorElement < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :juror_class, JurorClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, juror_class: nil)
    end
    begin
      value = JurorClass.from_dynamic!(d)
      if schema.key(:juror_class).type.right.valid? value
        return new(juror_class: value, bool: nil)
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
    elsif juror_class != nil
      juror_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Kongoni < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :integer_map,   Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer_array: nil)
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
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LadronismClass < Dry::Struct
  attribute :acclaimer,     Types::Nil
  attribute :achree,        Types::Nil
  attribute :base,          Types::Nil
  attribute :conundrumize,  Types::Nil
  attribute :degerminator,  Types::Nil
  attribute :describable,   Types::Nil
  attribute :exasperatedly, Types::Nil
  attribute :heroine,       Types::Nil
  attribute :indazin,       Types::Nil
  attribute :luteous,       Types::Nil
  attribute :papular,       Types::Nil
  attribute :pritch,        Types::Nil
  attribute :prodenia,      Types::Nil
  attribute :seege,         Types::Nil
  attribute :shopgirl,      Types::Nil
  attribute :tragedietta,   Types::Nil
  attribute :unsparse,      Types::Nil
  attribute :uplook,        Types::Nil
  attribute :vermiformis,   Types::Nil
  attribute :whafabout,     Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      acclaimer:     d.fetch("acclaimer"),
      achree:        d.fetch("achree"),
      base:          d.fetch("base"),
      conundrumize:  d.fetch("conundrumize"),
      degerminator:  d.fetch("degerminator"),
      describable:   d.fetch("describable"),
      exasperatedly: d.fetch("exasperatedly"),
      heroine:       d.fetch("heroine"),
      indazin:       d.fetch("indazin"),
      luteous:       d.fetch("luteous"),
      papular:       d.fetch("papular"),
      pritch:        d.fetch("pritch"),
      prodenia:      d.fetch("Prodenia"),
      seege:         d.fetch("seege"),
      shopgirl:      d.fetch("shopgirl"),
      tragedietta:   d.fetch("tragedietta"),
      unsparse:      d.fetch("unsparse"),
      uplook:        d.fetch("uplook"),
      vermiformis:   d.fetch("vermiformis"),
      whafabout:     d.fetch("whafabout"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "acclaimer"     => acclaimer,
      "achree"        => achree,
      "base"          => base,
      "conundrumize"  => conundrumize,
      "degerminator"  => degerminator,
      "describable"   => describable,
      "exasperatedly" => exasperatedly,
      "heroine"       => heroine,
      "indazin"       => indazin,
      "luteous"       => luteous,
      "papular"       => papular,
      "pritch"        => pritch,
      "Prodenia"      => prodenia,
      "seege"         => seege,
      "shopgirl"      => shopgirl,
      "tragedietta"   => tragedietta,
      "unsparse"      => unsparse,
      "uplook"        => uplook,
      "vermiformis"   => vermiformis,
      "whafabout"     => whafabout,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LadronismElement < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :ladronism_class, LadronismClass.optional
  attribute :string,          Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, ladronism_class: nil, string: nil)
    end
    begin
      value = LadronismClass.from_dynamic!(d)
      if schema.key(:ladronism_class).type.right.valid? value
        return new(ladronism_class: value, double: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, ladronism_class: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif ladronism_class != nil
      ladronism_class.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LandlubberlyClass < Dry::Struct
  attribute :acropoleis,      Types::Nil
  attribute :aminate,         Types::Nil
  attribute :amyraldism,      Types::Nil
  attribute :bipenniform,     Types::Nil
  attribute :bugre,           Types::Nil
  attribute :calycule,        Types::Nil
  attribute :caoutchouc,      Types::Nil
  attribute :disprover,       Types::Nil
  attribute :fitroot,         Types::Nil
  attribute :fulgently,       Types::Nil
  attribute :kickup,          Types::Nil
  attribute :laevoversion,    Types::Nil
  attribute :moter,           Types::Nil
  attribute :objectivity,     Types::Nil
  attribute :posterity,       Types::Nil
  attribute :postnuptial,     Types::Nil
  attribute :precedentary,    Types::Nil
  attribute :saddling,        Types::Nil
  attribute :subcurrent,      Types::Nil
  attribute :unrecriminative, Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      acropoleis:      d.fetch("acropoleis"),
      aminate:         d.fetch("aminate"),
      amyraldism:      d.fetch("Amyraldism"),
      bipenniform:     d.fetch("bipenniform"),
      bugre:           d.fetch("bugre"),
      calycule:        d.fetch("calycule"),
      caoutchouc:      d.fetch("caoutchouc"),
      disprover:       d.fetch("disprover"),
      fitroot:         d.fetch("fitroot"),
      fulgently:       d.fetch("fulgently"),
      kickup:          d.fetch("kickup"),
      laevoversion:    d.fetch("laevoversion"),
      moter:           d.fetch("moter"),
      objectivity:     d.fetch("objectivity"),
      posterity:       d.fetch("posterity"),
      postnuptial:     d.fetch("postnuptial"),
      precedentary:    d.fetch("precedentary"),
      saddling:        d.fetch("saddling"),
      subcurrent:      d.fetch("subcurrent"),
      unrecriminative: d.fetch("unrecriminative"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "acropoleis"      => acropoleis,
      "aminate"         => aminate,
      "Amyraldism"      => amyraldism,
      "bipenniform"     => bipenniform,
      "bugre"           => bugre,
      "calycule"        => calycule,
      "caoutchouc"      => caoutchouc,
      "disprover"       => disprover,
      "fitroot"         => fitroot,
      "fulgently"       => fulgently,
      "kickup"          => kickup,
      "laevoversion"    => laevoversion,
      "moter"           => moter,
      "objectivity"     => objectivity,
      "posterity"       => posterity,
      "postnuptial"     => postnuptial,
      "precedentary"    => precedentary,
      "saddling"        => saddling,
      "subcurrent"      => subcurrent,
      "unrecriminative" => unrecriminative,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LandlubberlyElement < Dry::Struct
  attribute :bool,               Types::Bool.optional
  attribute :integer,            Types::Integer.optional
  attribute :landlubberly_class, LandlubberlyClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, landlubberly_class: nil, integer: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, bool: nil, landlubberly_class: nil)
    end
    begin
      value = LandlubberlyClass.from_dynamic!(d)
      if schema.key(:landlubberly_class).type.right.valid? value
        return new(landlubberly_class: value, bool: nil, integer: nil)
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
    elsif landlubberly_class != nil
      landlubberly_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Listener < Dry::Struct
  attribute :integer,    Types::Integer.optional
  attribute :null_array, Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null_array: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LupusClass < Dry::Struct
  attribute :catharticalness, Types::Double.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :chlorioninae,    Types::Integer.optional
  attribute :corvinae,        Types::Integer.optional
  attribute :crassina,        Types::Integer.optional
  attribute :disdiapason,     Types::String.optional
  attribute :exiguity,        Types::Integer.optional
  attribute :farcist,         Types::Integer.optional
  attribute :holographical,   Types::Integer.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :ichthyophagan,   Types::Integer.optional
  attribute :implacable,      Types::Integer.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :outshiner,       Types::Integer.optional
  attribute :overweather,     Types::Integer.optional
  attribute :protonegroid,    Types::Integer.optional
  attribute :shallowish,      Types::Integer.optional
  attribute :snoke,           Types::Integer.optional
  attribute :snout,           Types::Integer.optional
  attribute :surveillance,    Types::Integer.optional
  attribute :threshingtime,   Types::Integer.optional
  attribute :thysanocarpus,   Types::Integer.optional
  attribute :unsignificantly, Types::Integer.optional
  attribute :unsnap,          Types::Integer.optional
  attribute :vendible,        Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      chlorioninae:    d.key?("Chlorioninae") ? Types::Integer[d["Chlorioninae"]] : nil,
      corvinae:        d.key?("Corvinae") ? Types::Integer[d["Corvinae"]] : nil,
      crassina:        d.key?("Crassina") ? Types::Integer[d["Crassina"]] : nil,
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      exiguity:        d.key?("exiguity") ? Types::Integer[d["exiguity"]] : nil,
      farcist:         d.key?("farcist") ? Types::Integer[d["farcist"]] : nil,
      holographical:   d.key?("holographical") ? Types::Integer[d["holographical"]] : nil,
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      ichthyophagan:   d.key?("ichthyophagan") ? Types::Integer[d["ichthyophagan"]] : nil,
      implacable:      d.key?("implacable") ? Types::Integer[d["implacable"]] : nil,
      nonbookish:      d["nonbookish"],
      outshiner:       d.key?("outshiner") ? Types::Integer[d["outshiner"]] : nil,
      overweather:     d.key?("overweather") ? Types::Integer[d["overweather"]] : nil,
      protonegroid:    d.key?("protonegroid") ? Types::Integer[d["protonegroid"]] : nil,
      shallowish:      d.key?("shallowish") ? Types::Integer[d["shallowish"]] : nil,
      snoke:           d.key?("snoke") ? Types::Integer[d["snoke"]] : nil,
      snout:           d.key?("snout") ? Types::Integer[d["snout"]] : nil,
      surveillance:    d.key?("surveillance") ? Types::Integer[d["surveillance"]] : nil,
      threshingtime:   d.key?("threshingtime") ? Types::Integer[d["threshingtime"]] : nil,
      thysanocarpus:   d.key?("Thysanocarpus") ? Types::Integer[d["Thysanocarpus"]] : nil,
      unsignificantly: d.key?("unsignificantly") ? Types::Integer[d["unsignificantly"]] : nil,
      unsnap:          d.key?("unsnap") ? Types::Integer[d["unsnap"]] : nil,
      vendible:        d.key?("vendible") ? Types::Integer[d["vendible"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "catharticalness" => catharticalness,
      "Chirotherium"    => chirotherium,
      "Chlorioninae"    => chlorioninae,
      "Corvinae"        => corvinae,
      "Crassina"        => crassina,
      "disdiapason"     => disdiapason,
      "exiguity"        => exiguity,
      "farcist"         => farcist,
      "holographical"   => holographical,
      "homocerc"        => homocerc,
      "ichthyophagan"   => ichthyophagan,
      "implacable"      => implacable,
      "nonbookish"      => nonbookish,
      "outshiner"       => outshiner,
      "overweather"     => overweather,
      "protonegroid"    => protonegroid,
      "shallowish"      => shallowish,
      "snoke"           => snoke,
      "snout"           => snout,
      "surveillance"    => surveillance,
      "threshingtime"   => threshingtime,
      "Thysanocarpus"   => thysanocarpus,
      "unsignificantly" => unsignificantly,
      "unsnap"          => unsnap,
      "vendible"        => vendible,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class LupusElement < Dry::Struct
  attribute :integer,     Types::Integer.optional
  attribute :lupus_class, LupusClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, lupus_class: nil)
    end
    begin
      value = LupusClass.from_dynamic!(d)
      if schema.key(:lupus_class).type.right.valid? value
        return new(lupus_class: value, integer: nil)
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
    elsif lupus_class != nil
      lupus_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Maslin < Dry::Struct
  attribute :alicant,         Types::Integer.optional
  attribute :antiatonement,   Types::Nil.optional
  attribute :anticorrosive,   Types::Integer.optional
  attribute :aphidozer,       Types::Nil.optional
  attribute :bakuninist,      Types::Nil.optional
  attribute :be,              Types::Integer.optional
  attribute :catharticalness, Types::Double.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :chub,            Types::Integer.optional
  attribute :cuprosilicon,    Types::Integer.optional
  attribute :curtailedly,     Types::Integer.optional
  attribute :dellenite,       Types::Integer.optional
  attribute :dimitry,         Types::Integer.optional
  attribute :disdiapason,     Types::String.optional
  attribute :edifying,        Types::Nil.optional
  attribute :ethmoiditis,     Types::Integer.optional
  attribute :gastralgy,       Types::Nil.optional
  attribute :goatherd,        Types::Integer.optional
  attribute :hammerdress,     Types::Integer.optional
  attribute :hangfire,        Types::Nil.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :lacunosity,      Types::Integer.optional
  attribute :longiloquence,   Types::Nil.optional
  attribute :mameliere,       Types::Integer.optional
  attribute :motherless,      Types::Nil.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :noncorrodible,   Types::Nil.optional
  attribute :nonsensicality,  Types::Nil.optional
  attribute :oafishly,        Types::Integer.optional
  attribute :pfund,           Types::Nil.optional
  attribute :preadvisory,     Types::Nil.optional
  attribute :retroflexed,     Types::Nil.optional
  attribute :saccharulmic,    Types::Integer.optional
  attribute :scowlful,        Types::Integer.optional
  attribute :secluded,        Types::Nil.optional
  attribute :slackage,        Types::Nil.optional
  attribute :sphaeridial,     Types::Integer.optional
  attribute :spondulics,      Types::Nil.optional
  attribute :subsecive,       Types::Integer.optional
  attribute :swellmobsman,    Types::Nil.optional
  attribute :trachyglossate,  Types::Integer.optional
  attribute :trialogue,       Types::Nil.optional
  attribute :unassuaged,      Types::Integer.optional
  attribute :ungross,         Types::Nil.optional
  attribute :unjudiciously,   Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      alicant:         d.key?("Alicant") ? Types::Integer[d["Alicant"]] : nil,
      antiatonement:   d["antiatonement"],
      anticorrosive:   d.key?("anticorrosive") ? Types::Integer[d["anticorrosive"]] : nil,
      aphidozer:       d["aphidozer"],
      bakuninist:      d["Bakuninist"],
      be:              d.key?("be") ? Types::Integer[d["be"]] : nil,
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      chub:            d.key?("chub") ? Types::Integer[d["chub"]] : nil,
      cuprosilicon:    d.key?("cuprosilicon") ? Types::Integer[d["cuprosilicon"]] : nil,
      curtailedly:     d.key?("curtailedly") ? Types::Integer[d["curtailedly"]] : nil,
      dellenite:       d.key?("dellenite") ? Types::Integer[d["dellenite"]] : nil,
      dimitry:         d.key?("Dimitry") ? Types::Integer[d["Dimitry"]] : nil,
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      edifying:        d["edifying"],
      ethmoiditis:     d.key?("ethmoiditis") ? Types::Integer[d["ethmoiditis"]] : nil,
      gastralgy:       d["gastralgy"],
      goatherd:        d.key?("goatherd") ? Types::Integer[d["goatherd"]] : nil,
      hammerdress:     d.key?("hammerdress") ? Types::Integer[d["hammerdress"]] : nil,
      hangfire:        d["hangfire"],
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      lacunosity:      d.key?("lacunosity") ? Types::Integer[d["lacunosity"]] : nil,
      longiloquence:   d["longiloquence"],
      mameliere:       d.key?("mameliere") ? Types::Integer[d["mameliere"]] : nil,
      motherless:      d["motherless"],
      nonbookish:      d["nonbookish"],
      noncorrodible:   d["noncorrodible"],
      nonsensicality:  d["nonsensicality"],
      oafishly:        d.key?("oafishly") ? Types::Integer[d["oafishly"]] : nil,
      pfund:           d["pfund"],
      preadvisory:     d["preadvisory"],
      retroflexed:     d["retroflexed"],
      saccharulmic:    d.key?("saccharulmic") ? Types::Integer[d["saccharulmic"]] : nil,
      scowlful:        d.key?("scowlful") ? Types::Integer[d["scowlful"]] : nil,
      secluded:        d["secluded"],
      slackage:        d["slackage"],
      sphaeridial:     d.key?("sphaeridial") ? Types::Integer[d["sphaeridial"]] : nil,
      spondulics:      d["spondulics"],
      subsecive:       d.key?("subsecive") ? Types::Integer[d["subsecive"]] : nil,
      swellmobsman:    d["swellmobsman"],
      trachyglossate:  d.key?("trachyglossate") ? Types::Integer[d["trachyglossate"]] : nil,
      trialogue:       d["trialogue"],
      unassuaged:      d.key?("unassuaged") ? Types::Integer[d["unassuaged"]] : nil,
      ungross:         d["ungross"],
      unjudiciously:   d["unjudiciously"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Alicant"         => alicant,
      "antiatonement"   => antiatonement,
      "anticorrosive"   => anticorrosive,
      "aphidozer"       => aphidozer,
      "Bakuninist"      => bakuninist,
      "be"              => be,
      "catharticalness" => catharticalness,
      "Chirotherium"    => chirotherium,
      "chub"            => chub,
      "cuprosilicon"    => cuprosilicon,
      "curtailedly"     => curtailedly,
      "dellenite"       => dellenite,
      "Dimitry"         => dimitry,
      "disdiapason"     => disdiapason,
      "edifying"        => edifying,
      "ethmoiditis"     => ethmoiditis,
      "gastralgy"       => gastralgy,
      "goatherd"        => goatherd,
      "hammerdress"     => hammerdress,
      "hangfire"        => hangfire,
      "homocerc"        => homocerc,
      "lacunosity"      => lacunosity,
      "longiloquence"   => longiloquence,
      "mameliere"       => mameliere,
      "motherless"      => motherless,
      "nonbookish"      => nonbookish,
      "noncorrodible"   => noncorrodible,
      "nonsensicality"  => nonsensicality,
      "oafishly"        => oafishly,
      "pfund"           => pfund,
      "preadvisory"     => preadvisory,
      "retroflexed"     => retroflexed,
      "saccharulmic"    => saccharulmic,
      "scowlful"        => scowlful,
      "secluded"        => secluded,
      "slackage"        => slackage,
      "sphaeridial"     => sphaeridial,
      "spondulics"      => spondulics,
      "subsecive"       => subsecive,
      "swellmobsman"    => swellmobsman,
      "trachyglossate"  => trachyglossate,
      "trialogue"       => trialogue,
      "unassuaged"      => unassuaged,
      "ungross"         => ungross,
      "unjudiciously"   => unjudiciously,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MonaziteClass < Dry::Struct
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

class MonaziteElement < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :monazite_class, MonaziteClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, monazite_class: nil)
    end
    begin
      value = MonaziteClass.from_dynamic!(d)
      if schema.key(:monazite_class).type.right.valid? value
        return new(monazite_class: value, double: nil)
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
    elsif monazite_class != nil
      monazite_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Monoliteral < Dry::Struct
  attribute :bool,       Types::Bool.optional
  attribute :null_array, Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null_array: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MonotheisticallyClass < Dry::Struct
  attribute :blaspheme,              Types::Nil.optional
  attribute :catharticalness,        Types::Double.optional
  attribute :celiosalpingectomy,     Types::Nil.optional
  attribute :chirotherium,           Types::Integer.optional
  attribute :consummativeness,       Types::Nil.optional
  attribute :disdiapason,            Types::String.optional
  attribute :egestive,               Types::Nil.optional
  attribute :enchylema,              Types::Nil.optional
  attribute :gasconade,              Types::Nil.optional
  attribute :holidayer,              Types::Nil.optional
  attribute :homocerc,               Types::Bool.optional
  attribute :intuitionalism,         Types::Nil.optional
  attribute :lophiostomate,          Types::Nil.optional
  attribute :monotheistically_trust, Types::Nil.optional
  attribute :nonbookish,             Types::Nil.optional
  attribute :nonvolition,            Types::Nil.optional
  attribute :palatableness,          Types::Nil.optional
  attribute :pimpery,                Types::Nil.optional
  attribute :previolation,           Types::Nil.optional
  attribute :reconveyance,           Types::Nil.optional
  attribute :registership,           Types::Nil.optional
  attribute :rhyacolite,             Types::Nil.optional
  attribute :smithereens,            Types::Nil.optional
  attribute :superedification,       Types::Nil.optional
  attribute :whitestone,             Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      blaspheme:              d["blaspheme"],
      catharticalness:        d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      celiosalpingectomy:     d["celiosalpingectomy"],
      chirotherium:           d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      consummativeness:       d["consummativeness"],
      disdiapason:            d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      egestive:               d["egestive"],
      enchylema:              d["enchylema"],
      gasconade:              d["gasconade"],
      holidayer:              d["holidayer"],
      homocerc:               d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      intuitionalism:         d["intuitionalism"],
      lophiostomate:          d["lophiostomate"],
      monotheistically_trust: d["trust"],
      nonbookish:             d["nonbookish"],
      nonvolition:            d["nonvolition"],
      palatableness:          d["palatableness"],
      pimpery:                d["pimpery"],
      previolation:           d["previolation"],
      reconveyance:           d["reconveyance"],
      registership:           d["registership"],
      rhyacolite:             d["rhyacolite"],
      smithereens:            d["smithereens"],
      superedification:       d["superedification"],
      whitestone:             d["whitestone"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "blaspheme"          => blaspheme,
      "catharticalness"    => catharticalness,
      "celiosalpingectomy" => celiosalpingectomy,
      "Chirotherium"       => chirotherium,
      "consummativeness"   => consummativeness,
      "disdiapason"        => disdiapason,
      "egestive"           => egestive,
      "enchylema"          => enchylema,
      "gasconade"          => gasconade,
      "holidayer"          => holidayer,
      "homocerc"           => homocerc,
      "intuitionalism"     => intuitionalism,
      "lophiostomate"      => lophiostomate,
      "trust"              => monotheistically_trust,
      "nonbookish"         => nonbookish,
      "nonvolition"        => nonvolition,
      "palatableness"      => palatableness,
      "pimpery"            => pimpery,
      "previolation"       => previolation,
      "reconveyance"       => reconveyance,
      "registership"       => registership,
      "rhyacolite"         => rhyacolite,
      "smithereens"        => smithereens,
      "superedification"   => superedification,
      "whitestone"         => whitestone,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class MonotheisticallyElement < Dry::Struct
  attribute :monotheistically_class, MonotheisticallyClass.optional
  attribute :null_array,             Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    begin
      value = MonotheisticallyClass.from_dynamic!(d)
      if schema.key(:monotheistically_class).type.right.valid? value
        return new(monotheistically_class: value, null_array: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, monotheistically_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if monotheistically_class != nil
      monotheistically_class.to_dynamic
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Montage < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :null_array, Types.Array(Types::Nil).optional
  attribute :string,     Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_array: nil, string: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, double: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, null_array: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif null_array != nil
      null_array
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Moralness < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :null,       Types::Nil.optional
  attribute :null_array, Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_array: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, null_array: nil, double: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, double: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif null_array != nil
      null_array
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Mulishly < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :null,          Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_array: nil, null: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, double: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_array: nil, double: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Myoscope < Dry::Struct
  attribute :bool,       Types::Bool.optional
  attribute :integer,    Types::Integer.optional
  attribute :null_array, Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null_array: nil, integer: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null_array: nil, bool: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, bool: nil, integer: nil)
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
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Neuromastic < Dry::Struct
  attribute :double,     Types::Double.optional
  attribute :null_array, Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_array: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Noncontributing < Dry::Struct
  attribute :estevin,     Types::String
  attribute :jolterhead,  Types::Double
  attribute :sauternes,   Types::Integer
  attribute :sparsely,    Types::Bool
  attribute :unrequested, Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      estevin:     d.fetch("estevin"),
      jolterhead:  d.fetch("jolterhead"),
      sauternes:   d.fetch("sauternes"),
      sparsely:    d.fetch("sparsely"),
      unrequested: d.fetch("unrequested"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "estevin"     => estevin,
      "jolterhead"  => jolterhead,
      "sauternes"   => sauternes,
      "sparsely"    => sparsely,
      "unrequested" => unrequested,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nonnervous < Dry::Struct
  attribute :bool,    Types::Bool.optional
  attribute :integer, Types::Integer.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, bool: nil)
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
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Nonvaluation < Dry::Struct
  attribute :bool,       Types::Bool.optional
  attribute :double,     Types::Double.optional
  attribute :null_array, Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null_array: nil, double: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_array: nil, bool: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, bool: nil, double: nil)
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
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OccupationalistClass < Dry::Struct
  attribute :beholdable,       Types::Nil
  attribute :brotuliform,      Types::Nil
  attribute :chimakum,         Types::Nil
  attribute :doodler,          Types::Nil
  attribute :emulsin,          Types::Nil
  attribute :fin,              Types::Nil
  attribute :flourishing,      Types::Nil
  attribute :flueless,         Types::Nil
  attribute :furtively,        Types::Nil
  attribute :gritter,          Types::Nil
  attribute :interwish,        Types::Nil
  attribute :monoxylic,        Types::Nil
  attribute :myristic,         Types::Nil
  attribute :nightwear,        Types::Nil
  attribute :peruser,          Types::Nil
  attribute :theoastrological, Types::Nil
  attribute :thumby,           Types::Nil
  attribute :tingitid,         Types::Nil
  attribute :trailless,        Types::Nil
  attribute :unpocketed,       Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      beholdable:       d.fetch("beholdable"),
      brotuliform:      d.fetch("brotuliform"),
      chimakum:         d.fetch("Chimakum"),
      doodler:          d.fetch("doodler"),
      emulsin:          d.fetch("emulsin"),
      fin:              d.fetch("Fin"),
      flourishing:      d.fetch("flourishing"),
      flueless:         d.fetch("flueless"),
      furtively:        d.fetch("furtively"),
      gritter:          d.fetch("gritter"),
      interwish:        d.fetch("interwish"),
      monoxylic:        d.fetch("monoxylic"),
      myristic:         d.fetch("myristic"),
      nightwear:        d.fetch("nightwear"),
      peruser:          d.fetch("peruser"),
      theoastrological: d.fetch("theoastrological"),
      thumby:           d.fetch("thumby"),
      tingitid:         d.fetch("tingitid"),
      trailless:        d.fetch("trailless"),
      unpocketed:       d.fetch("unpocketed"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "beholdable"       => beholdable,
      "brotuliform"      => brotuliform,
      "Chimakum"         => chimakum,
      "doodler"          => doodler,
      "emulsin"          => emulsin,
      "Fin"              => fin,
      "flourishing"      => flourishing,
      "flueless"         => flueless,
      "furtively"        => furtively,
      "gritter"          => gritter,
      "interwish"        => interwish,
      "monoxylic"        => monoxylic,
      "myristic"         => myristic,
      "nightwear"        => nightwear,
      "peruser"          => peruser,
      "theoastrological" => theoastrological,
      "thumby"           => thumby,
      "tingitid"         => tingitid,
      "trailless"        => trailless,
      "unpocketed"       => unpocketed,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OccupationalistElement < Dry::Struct
  attribute :null,                  Types::Nil.optional
  attribute :null_array,            Types.Array(Types::Nil).optional
  attribute :occupationalist_class, OccupationalistClass.optional

  def self.from_dynamic!(d)
    if schema.key(:null).type.right.valid? d
      return new(null: d, null_array: nil, occupationalist_class: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, occupationalist_class: nil, null: nil)
    end
    begin
      value = OccupationalistClass.from_dynamic!(d)
      if schema.key(:occupationalist_class).type.right.valid? value
        return new(occupationalist_class: value, null_array: nil, null: nil)
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
    elsif occupationalist_class != nil
      occupationalist_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OutrivalClass < Dry::Struct
  attribute :adroitly,        Types::Nil
  attribute :bridehood,       Types::Nil
  attribute :castoroides,     Types::Nil
  attribute :czechoslovak,    Types::Nil
  attribute :diagenesis,      Types::Nil
  attribute :dihexahedron,    Types::Nil
  attribute :dopester,        Types::Nil
  attribute :eumerism,        Types::Nil
  attribute :flyness,         Types::Nil
  attribute :fouler,          Types::Nil
  attribute :laudanosine,     Types::Nil
  attribute :lingulidae,      Types::Nil
  attribute :minutary,        Types::Nil
  attribute :mitra,           Types::Nil
  attribute :opisthorchiasis, Types::Nil
  attribute :pensively,       Types::Nil
  attribute :pubigerous,      Types::Nil
  attribute :rebellious,      Types::Nil
  attribute :recodify,        Types::Nil
  attribute :unpaced,         Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      adroitly:        d.fetch("adroitly"),
      bridehood:       d.fetch("bridehood"),
      castoroides:     d.fetch("Castoroides"),
      czechoslovak:    d.fetch("Czechoslovak"),
      diagenesis:      d.fetch("diagenesis"),
      dihexahedron:    d.fetch("dihexahedron"),
      dopester:        d.fetch("dopester"),
      eumerism:        d.fetch("eumerism"),
      flyness:         d.fetch("flyness"),
      fouler:          d.fetch("fouler"),
      laudanosine:     d.fetch("laudanosine"),
      lingulidae:      d.fetch("Lingulidae"),
      minutary:        d.fetch("minutary"),
      mitra:           d.fetch("mitra"),
      opisthorchiasis: d.fetch("opisthorchiasis"),
      pensively:       d.fetch("pensively"),
      pubigerous:      d.fetch("pubigerous"),
      rebellious:      d.fetch("rebellious"),
      recodify:        d.fetch("recodify"),
      unpaced:         d.fetch("unpaced"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "adroitly"        => adroitly,
      "bridehood"       => bridehood,
      "Castoroides"     => castoroides,
      "Czechoslovak"    => czechoslovak,
      "diagenesis"      => diagenesis,
      "dihexahedron"    => dihexahedron,
      "dopester"        => dopester,
      "eumerism"        => eumerism,
      "flyness"         => flyness,
      "fouler"          => fouler,
      "laudanosine"     => laudanosine,
      "Lingulidae"      => lingulidae,
      "minutary"        => minutary,
      "mitra"           => mitra,
      "opisthorchiasis" => opisthorchiasis,
      "pensively"       => pensively,
      "pubigerous"      => pubigerous,
      "rebellious"      => rebellious,
      "recodify"        => recodify,
      "unpaced"         => unpaced,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class OutrivalElement < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :null,           Types::Nil.optional
  attribute :outrival_class, OutrivalClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, outrival_class: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, outrival_class: nil, double: nil)
    end
    begin
      value = OutrivalClass.from_dynamic!(d)
      if schema.key(:outrival_class).type.right.valid? value
        return new(outrival_class: value, double: nil, null: nil)
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
    elsif outrival_class != nil
      outrival_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Paleographically < Dry::Struct
  attribute :double,    Types::Double.optional
  attribute :union_map, Types::Hash.meta(of: Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, v] }.to_h
      if schema.key(:union_map).type.right.valid? value
        return new(union_map: value, double: nil)
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
    elsif union_map != nil
      union_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Pamphletwise < Dry::Struct
  attribute :integer,     Types::Integer.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :string,      Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_map: nil, string: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer: nil, integer_map: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Pediatric < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :double, Types::Double.optional
  attribute :null,   Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil, null: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, bool: nil, double: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PiaculumClass < Dry::Struct
  attribute :alada,           Types::Integer.optional
  attribute :amphistomous,    Types::Integer.optional
  attribute :boysenberry,     Types::Integer.optional
  attribute :catharticalness, Types::Double.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :decardinalize,   Types::Integer.optional
  attribute :discouragement,  Types::Integer.optional
  attribute :disdiapason,     Types::String.optional
  attribute :doitrified,      Types::Integer.optional
  attribute :hexaspermous,    Types::Integer.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :insinking,       Types::Integer.optional
  attribute :loathfulness,    Types::Integer.optional
  attribute :miasmatical,     Types::Integer.optional
  attribute :neurofibril,     Types::Integer.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :phonendoscope,   Types::Integer.optional
  attribute :pilferment,      Types::Integer.optional
  attribute :predismissory,   Types::Integer.optional
  attribute :preinscription,  Types::Integer.optional
  attribute :quotative,       Types::Integer.optional
  attribute :sienna,          Types::Integer.optional
  attribute :thorax,          Types::Integer.optional
  attribute :yachting,        Types::Integer.optional
  attribute :zipper,          Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      alada:           d.key?("alada") ? Types::Integer[d["alada"]] : nil,
      amphistomous:    d.key?("amphistomous") ? Types::Integer[d["amphistomous"]] : nil,
      boysenberry:     d.key?("boysenberry") ? Types::Integer[d["boysenberry"]] : nil,
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      decardinalize:   d.key?("decardinalize") ? Types::Integer[d["decardinalize"]] : nil,
      discouragement:  d.key?("discouragement") ? Types::Integer[d["discouragement"]] : nil,
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      doitrified:      d.key?("doitrified") ? Types::Integer[d["doitrified"]] : nil,
      hexaspermous:    d.key?("hexaspermous") ? Types::Integer[d["hexaspermous"]] : nil,
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      insinking:       d.key?("insinking") ? Types::Integer[d["insinking"]] : nil,
      loathfulness:    d.key?("loathfulness") ? Types::Integer[d["loathfulness"]] : nil,
      miasmatical:     d.key?("miasmatical") ? Types::Integer[d["miasmatical"]] : nil,
      neurofibril:     d.key?("neurofibril") ? Types::Integer[d["neurofibril"]] : nil,
      nonbookish:      d["nonbookish"],
      phonendoscope:   d.key?("phonendoscope") ? Types::Integer[d["phonendoscope"]] : nil,
      pilferment:      d.key?("pilferment") ? Types::Integer[d["pilferment"]] : nil,
      predismissory:   d.key?("predismissory") ? Types::Integer[d["predismissory"]] : nil,
      preinscription:  d.key?("preinscription") ? Types::Integer[d["preinscription"]] : nil,
      quotative:       d.key?("quotative") ? Types::Integer[d["quotative"]] : nil,
      sienna:          d.key?("sienna") ? Types::Integer[d["sienna"]] : nil,
      thorax:          d.key?("thorax") ? Types::Integer[d["thorax"]] : nil,
      yachting:        d.key?("yachting") ? Types::Integer[d["yachting"]] : nil,
      zipper:          d.key?("Zipper") ? Types::Integer[d["Zipper"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "alada"           => alada,
      "amphistomous"    => amphistomous,
      "boysenberry"     => boysenberry,
      "catharticalness" => catharticalness,
      "Chirotherium"    => chirotherium,
      "decardinalize"   => decardinalize,
      "discouragement"  => discouragement,
      "disdiapason"     => disdiapason,
      "doitrified"      => doitrified,
      "hexaspermous"    => hexaspermous,
      "homocerc"        => homocerc,
      "insinking"       => insinking,
      "loathfulness"    => loathfulness,
      "miasmatical"     => miasmatical,
      "neurofibril"     => neurofibril,
      "nonbookish"      => nonbookish,
      "phonendoscope"   => phonendoscope,
      "pilferment"      => pilferment,
      "predismissory"   => predismissory,
      "preinscription"  => preinscription,
      "quotative"       => quotative,
      "sienna"          => sienna,
      "thorax"          => thorax,
      "yachting"        => yachting,
      "Zipper"          => zipper,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PiaculumElement < Dry::Struct
  attribute :double,         Types::Double.optional
  attribute :piaculum_class, PiaculumClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, piaculum_class: nil)
    end
    begin
      value = PiaculumClass.from_dynamic!(d)
      if schema.key(:piaculum_class).type.right.valid? value
        return new(piaculum_class: value, double: nil)
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
    elsif piaculum_class != nil
      piaculum_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Piccadilly < Dry::Struct
  attribute :double, Types::Double.optional
  attribute :null,   Types::Nil.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, double: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil, null: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Piffler < Dry::Struct
  attribute :monazite_class, MonaziteClass.optional
  attribute :null_array,     Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    begin
      value = MonaziteClass.from_dynamic!(d)
      if schema.key(:monazite_class).type.right.valid? value
        return new(monazite_class: value, null_array: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, monazite_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if monazite_class != nil
      monazite_class.to_dynamic
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Pithful < Dry::Struct
  attribute :bool,    Types::Bool.optional
  attribute :integer, Types::Integer.optional
  attribute :null,    Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer: nil, null: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, bool: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, bool: nil, integer: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Placuntiti < Dry::Struct
  attribute :integer,     Types::Integer.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer: nil)
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
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Plectopterous < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, double: nil)
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
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Pneumocele < Dry::Struct
  attribute :carbonarism,     Types::Nil.optional
  attribute :catharticalness, Types::Double.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :cineolic,        Types::Nil.optional
  attribute :cobbly,          Types::Nil.optional
  attribute :conchyliferous,  Types::Nil.optional
  attribute :congregation,    Types::Nil.optional
  attribute :disdiapason,     Types::String.optional
  attribute :enterotomy,      Types::Nil.optional
  attribute :entophytal,      Types::Nil.optional
  attribute :fewtrils,        Types::Nil.optional
  attribute :herem,           Types::Nil.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :koniga,          Types::Nil.optional
  attribute :meticulosity,    Types::Nil.optional
  attribute :micky,           Types::Nil.optional
  attribute :mismarriage,     Types::Nil.optional
  attribute :neurotrophic,    Types::Nil.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :persuasively,    Types::Nil.optional
  attribute :replaceable,     Types::Nil.optional
  attribute :silex,           Types::Nil.optional
  attribute :taillight,       Types::Nil.optional
  attribute :unjealous,       Types::Nil.optional
  attribute :visitorial,      Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      carbonarism:     d["Carbonarism"],
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      cineolic:        d["cineolic"],
      cobbly:          d["cobbly"],
      conchyliferous:  d["conchyliferous"],
      congregation:    d["congregation"],
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      enterotomy:      d["enterotomy"],
      entophytal:      d["entophytal"],
      fewtrils:        d["fewtrils"],
      herem:           d["herem"],
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      koniga:          d["Koniga"],
      meticulosity:    d["meticulosity"],
      micky:           d["Micky"],
      mismarriage:     d["mismarriage"],
      neurotrophic:    d["neurotrophic"],
      nonbookish:      d["nonbookish"],
      persuasively:    d["persuasively"],
      replaceable:     d["replaceable"],
      silex:           d["silex"],
      taillight:       d["taillight"],
      unjealous:       d["unjealous"],
      visitorial:      d["visitorial"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Carbonarism"     => carbonarism,
      "catharticalness" => catharticalness,
      "Chirotherium"    => chirotherium,
      "cineolic"        => cineolic,
      "cobbly"          => cobbly,
      "conchyliferous"  => conchyliferous,
      "congregation"    => congregation,
      "disdiapason"     => disdiapason,
      "enterotomy"      => enterotomy,
      "entophytal"      => entophytal,
      "fewtrils"        => fewtrils,
      "herem"           => herem,
      "homocerc"        => homocerc,
      "Koniga"          => koniga,
      "meticulosity"    => meticulosity,
      "Micky"           => micky,
      "mismarriage"     => mismarriage,
      "neurotrophic"    => neurotrophic,
      "nonbookish"      => nonbookish,
      "persuasively"    => persuasively,
      "replaceable"     => replaceable,
      "silex"           => silex,
      "taillight"       => taillight,
      "unjealous"       => unjealous,
      "visitorial"      => visitorial,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Poliorcetic < Dry::Struct
  attribute :bool,           Types::Bool.optional
  attribute :monazite_class, MonaziteClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, monazite_class: nil)
    end
    begin
      value = MonaziteClass.from_dynamic!(d)
      if schema.key(:monazite_class).type.right.valid? value
        return new(monazite_class: value, bool: nil)
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
    elsif monazite_class != nil
      monazite_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Poormaster < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :integer_map,   Types::Hash.meta(of: Types::Integer).optional
  attribute :null,          Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, integer_map: nil, null: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer_array: nil, null: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_array: nil, integer_map: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer_array != nil
      integer_array
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

class PotwhiskyClass < Dry::Struct
  attribute :arciform,          Types::Nil
  attribute :cresolin,          Types::Nil
  attribute :disheartener,      Types::Nil
  attribute :disproportionable, Types::Nil
  attribute :euchorda,          Types::Nil
  attribute :ferryway,          Types::Nil
  attribute :filamentiferous,   Types::Nil
  attribute :flemish,           Types::Nil
  attribute :forgainst,         Types::Nil
  attribute :grainering,        Types::Nil
  attribute :irrevoluble,       Types::Nil
  attribute :kindredship,       Types::Nil
  attribute :pinguitudinous,    Types::Nil
  attribute :simpletonic,       Types::Nil
  attribute :singsong,          Types::Nil
  attribute :submergement,      Types::Nil
  attribute :supraoesophagal,   Types::Nil
  attribute :thrashel,          Types::Nil
  attribute :tyremesis,         Types::Nil
  attribute :yoruba,            Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      arciform:          d.fetch("arciform"),
      cresolin:          d.fetch("cresolin"),
      disheartener:      d.fetch("disheartener"),
      disproportionable: d.fetch("disproportionable"),
      euchorda:          d.fetch("Euchorda"),
      ferryway:          d.fetch("ferryway"),
      filamentiferous:   d.fetch("filamentiferous"),
      flemish:           d.fetch("flemish"),
      forgainst:         d.fetch("forgainst"),
      grainering:        d.fetch("grainering"),
      irrevoluble:       d.fetch("irrevoluble"),
      kindredship:       d.fetch("kindredship"),
      pinguitudinous:    d.fetch("pinguitudinous"),
      simpletonic:       d.fetch("simpletonic"),
      singsong:          d.fetch("singsong"),
      submergement:      d.fetch("submergement"),
      supraoesophagal:   d.fetch("supraoesophagal"),
      thrashel:          d.fetch("thrashel"),
      tyremesis:         d.fetch("tyremesis"),
      yoruba:            d.fetch("Yoruba"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "arciform"          => arciform,
      "cresolin"          => cresolin,
      "disheartener"      => disheartener,
      "disproportionable" => disproportionable,
      "Euchorda"          => euchorda,
      "ferryway"          => ferryway,
      "filamentiferous"   => filamentiferous,
      "flemish"           => flemish,
      "forgainst"         => forgainst,
      "grainering"        => grainering,
      "irrevoluble"       => irrevoluble,
      "kindredship"       => kindredship,
      "pinguitudinous"    => pinguitudinous,
      "simpletonic"       => simpletonic,
      "singsong"          => singsong,
      "submergement"      => submergement,
      "supraoesophagal"   => supraoesophagal,
      "thrashel"          => thrashel,
      "tyremesis"         => tyremesis,
      "Yoruba"            => yoruba,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PotwhiskyElement < Dry::Struct
  attribute :integer,         Types::Integer.optional
  attribute :null,            Types::Nil.optional
  attribute :potwhisky_class, PotwhiskyClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, potwhisky_class: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, potwhisky_class: nil, integer: nil)
    end
    begin
      value = PotwhiskyClass.from_dynamic!(d)
      if schema.key(:potwhisky_class).type.right.valid? value
        return new(potwhisky_class: value, integer: nil, null: nil)
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
    elsif potwhisky_class != nil
      potwhisky_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Practicalizer < Dry::Struct
  attribute :monazite_class, MonaziteClass.optional
  attribute :null_array,     Types.Array(Types::Nil).optional
  attribute :string,         Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = MonaziteClass.from_dynamic!(d)
      if schema.key(:monazite_class).type.right.valid? value
        return new(monazite_class: value, null_array: nil, string: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, monazite_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, null_array: nil, monazite_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if monazite_class != nil
      monazite_class.to_dynamic
    elsif null_array != nil
      null_array
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PrefreshmanClass < Dry::Struct
  attribute :azorubine,     Types::Nil
  attribute :choroiditis,   Types::Nil
  attribute :coagulatory,   Types::Nil
  attribute :cyclorama,     Types::Nil
  attribute :dolphus,       Types::Nil
  attribute :duckhearted,   Types::Nil
  attribute :ficus,         Types::Nil
  attribute :gemaric,       Types::Nil
  attribute :jugation,      Types::Nil
  attribute :myoliposis,    Types::Nil
  attribute :nonnomination, Types::Nil
  attribute :palay,         Types::Nil
  attribute :pentactinal,   Types::Nil
  attribute :phaet,         Types::Nil
  attribute :piquant,       Types::Nil
  attribute :registration,  Types::Nil
  attribute :remancipation, Types::Nil
  attribute :scutatiform,   Types::Nil
  attribute :theodolite,    Types::Nil
  attribute :underward,     Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      azorubine:     d.fetch("azorubine"),
      choroiditis:   d.fetch("choroiditis"),
      coagulatory:   d.fetch("coagulatory"),
      cyclorama:     d.fetch("cyclorama"),
      dolphus:       d.fetch("Dolphus"),
      duckhearted:   d.fetch("duckhearted"),
      ficus:         d.fetch("Ficus"),
      gemaric:       d.fetch("Gemaric"),
      jugation:      d.fetch("jugation"),
      myoliposis:    d.fetch("myoliposis"),
      nonnomination: d.fetch("nonnomination"),
      palay:         d.fetch("palay"),
      pentactinal:   d.fetch("pentactinal"),
      phaet:         d.fetch("Phaet"),
      piquant:       d.fetch("piquant"),
      registration:  d.fetch("registration"),
      remancipation: d.fetch("remancipation"),
      scutatiform:   d.fetch("scutatiform"),
      theodolite:    d.fetch("theodolite"),
      underward:     d.fetch("underward"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "azorubine"     => azorubine,
      "choroiditis"   => choroiditis,
      "coagulatory"   => coagulatory,
      "cyclorama"     => cyclorama,
      "Dolphus"       => dolphus,
      "duckhearted"   => duckhearted,
      "Ficus"         => ficus,
      "Gemaric"       => gemaric,
      "jugation"      => jugation,
      "myoliposis"    => myoliposis,
      "nonnomination" => nonnomination,
      "palay"         => palay,
      "pentactinal"   => pentactinal,
      "Phaet"         => phaet,
      "piquant"       => piquant,
      "registration"  => registration,
      "remancipation" => remancipation,
      "scutatiform"   => scutatiform,
      "theodolite"    => theodolite,
      "underward"     => underward,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PrefreshmanElement < Dry::Struct
  attribute :null_array,        Types.Array(Types::Nil).optional
  attribute :prefreshman_class, PrefreshmanClass.optional
  attribute :string,            Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, prefreshman_class: nil, string: nil)
    end
    begin
      value = PrefreshmanClass.from_dynamic!(d)
      if schema.key(:prefreshman_class).type.right.valid? value
        return new(prefreshman_class: value, null_array: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, null_array: nil, prefreshman_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if null_array != nil
      null_array
    elsif prefreshman_class != nil
      prefreshman_class.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Prehensility < Dry::Struct
  attribute :bool,           Types::Bool.optional
  attribute :monazite_class, MonaziteClass.optional
  attribute :null_array,     Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null_array: nil, monazite_class: nil)
    end
    begin
      value = MonaziteClass.from_dynamic!(d)
      if schema.key(:monazite_class).type.right.valid? value
        return new(monazite_class: value, null_array: nil, bool: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, bool: nil, monazite_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif monazite_class != nil
      monazite_class.to_dynamic
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Prevoidance < Dry::Struct
  attribute :integer,        Types::Integer.optional
  attribute :integer_array,  Types.Array(Types::Integer).optional
  attribute :monazite_class, MonaziteClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil, monazite_class: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, monazite_class: nil, integer: nil)
    end
    begin
      value = MonaziteClass.from_dynamic!(d)
      if schema.key(:monazite_class).type.right.valid? value
        return new(monazite_class: value, integer_array: nil, integer: nil)
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
    elsif monazite_class != nil
      monazite_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Protext < Dry::Struct
  attribute :bool,           Types::Bool.optional
  attribute :integer_array,  Types.Array(Types::Integer).optional
  attribute :monazite_class, MonaziteClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil, monazite_class: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil, monazite_class: nil)
    end
    begin
      value = MonaziteClass.from_dynamic!(d)
      if schema.key(:monazite_class).type.right.valid? value
        return new(monazite_class: value, integer_array: nil, bool: nil)
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
    elsif monazite_class != nil
      monazite_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :juror,            Types.Array(Types.Instance(JurorElement))
  attribute :kongoni,          Types.Array(Types.Instance(Kongoni))
  attribute :ladronism,        Types.Array(Types.Instance(LadronismElement))
  attribute :landlubberly,     Types.Array(Types.Instance(LandlubberlyElement))
  attribute :listener,         Types.Array(Types.Instance(Listener))
  attribute :lupus,            Types.Array(Types.Instance(LupusElement))
  attribute :maslin,           Types.Array(Maslin)
  attribute :monazite,         Types.Array(Types.Instance(MonaziteElement))
  attribute :monoliteral,      Types.Array(Types.Instance(Monoliteral))
  attribute :monotheistically, Types.Array(Types.Instance(MonotheisticallyElement))
  attribute :montage,          Types.Array(Types.Instance(Montage))
  attribute :moralness,        Types.Array(Types.Instance(Moralness))
  attribute :mowra,            Types.Array(MonaziteClass.optional)
  attribute :mulishly,         Types.Array(Types.Instance(Mulishly))
  attribute :myoscope,         Types.Array(Types.Instance(Myoscope))
  attribute :nach,             Types.Array(Types.Array(Types::Integer.optional).optional)
  attribute :neuromastic,      Types.Array(Types.Instance(Neuromastic))
  attribute :noncontributing,  Types.Array(Noncontributing)
  attribute :nonnervous,       Types.Array(Types.Instance(Nonnervous))
  attribute :nonvaluation,     Types.Array(Types.Instance(Nonvaluation))
  attribute :occupationalist,  Types.Array(Types.Instance(OccupationalistElement))
  attribute :outrival,         Types.Array(Types.Instance(OutrivalElement))
  attribute :paleographically, Types.Array(Types.Instance(Paleographically))
  attribute :pamphletwise,     Types.Array(Types.Instance(Pamphletwise))
  attribute :pediatrics,       Types.Array(Types.Instance(Pediatric))
  attribute :perceptive,       Types.Array(Types::Bool)
  attribute :piaculum,         Types.Array(Types.Instance(PiaculumElement))
  attribute :piccadilly,       Types.Array(Types.Instance(Piccadilly))
  attribute :piffler,          Types.Array(Types.Instance(Piffler))
  attribute :pithful,          Types.Array(Types.Instance(Pithful))
  attribute :placuntitis,      Types.Array(Types.Instance(Placuntiti))
  attribute :plectopterous,    Types.Array(Types.Instance(Plectopterous))
  attribute :pneumocele,       Types.Array(Pneumocele.optional)
  attribute :poliorcetic,      Types.Array(Types.Instance(Poliorcetic))
  attribute :poormaster,       Types.Array(Types.Instance(Poormaster))
  attribute :potwhisky,        Types.Array(Types.Instance(PotwhiskyElement))
  attribute :practicalizer,    Types.Array(Types.Instance(Practicalizer))
  attribute :prefreshman,      Types.Array(Types.Instance(PrefreshmanElement))
  attribute :prehensility,     Types.Array(Types.Instance(Prehensility))
  attribute :prevoidance,      Types.Array(Types.Instance(Prevoidance))
  attribute :probant,          Types.Array(Types::Hash.meta(of: Types::Integer.optional))
  attribute :protext,          Types.Array(Types.Instance(Protext))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      juror:            d.fetch("juror").map { |x| JurorElement.from_dynamic!(x) },
      kongoni:          d.fetch("kongoni").map { |x| Kongoni.from_dynamic!(x) },
      ladronism:        d.fetch("ladronism").map { |x| LadronismElement.from_dynamic!(x) },
      landlubberly:     d.fetch("landlubberly").map { |x| LandlubberlyElement.from_dynamic!(x) },
      listener:         d.fetch("listener").map { |x| Listener.from_dynamic!(x) },
      lupus:            d.fetch("lupus").map { |x| LupusElement.from_dynamic!(x) },
      maslin:           d.fetch("maslin").map { |x| Maslin.from_dynamic!(x) },
      monazite:         d.fetch("monazite").map { |x| MonaziteElement.from_dynamic!(x) },
      monoliteral:      d.fetch("monoliteral").map { |x| Monoliteral.from_dynamic!(x) },
      monotheistically: d.fetch("monotheistically").map { |x| MonotheisticallyElement.from_dynamic!(x) },
      montage:          d.fetch("montage").map { |x| Montage.from_dynamic!(x) },
      moralness:        d.fetch("moralness").map { |x| Moralness.from_dynamic!(x) },
      mowra:            d.fetch("mowra").map { |x| x ? MonaziteClass.from_dynamic!(x) : nil },
      mulishly:         d.fetch("mulishly").map { |x| Mulishly.from_dynamic!(x) },
      myoscope:         d.fetch("myoscope").map { |x| Myoscope.from_dynamic!(x) },
      nach:             d.fetch("nach"),
      neuromastic:      d.fetch("neuromastic").map { |x| Neuromastic.from_dynamic!(x) },
      noncontributing:  d.fetch("noncontributing").map { |x| Noncontributing.from_dynamic!(x) },
      nonnervous:       d.fetch("nonnervous").map { |x| Nonnervous.from_dynamic!(x) },
      nonvaluation:     d.fetch("nonvaluation").map { |x| Nonvaluation.from_dynamic!(x) },
      occupationalist:  d.fetch("occupationalist").map { |x| OccupationalistElement.from_dynamic!(x) },
      outrival:         d.fetch("outrival").map { |x| OutrivalElement.from_dynamic!(x) },
      paleographically: d.fetch("paleographically").map { |x| Paleographically.from_dynamic!(x) },
      pamphletwise:     d.fetch("pamphletwise").map { |x| Pamphletwise.from_dynamic!(x) },
      pediatrics:       d.fetch("pediatrics").map { |x| Pediatric.from_dynamic!(x) },
      perceptive:       d.fetch("perceptive"),
      piaculum:         d.fetch("piaculum").map { |x| PiaculumElement.from_dynamic!(x) },
      piccadilly:       d.fetch("piccadilly").map { |x| Piccadilly.from_dynamic!(x) },
      piffler:          d.fetch("piffler").map { |x| Piffler.from_dynamic!(x) },
      pithful:          d.fetch("pithful").map { |x| Pithful.from_dynamic!(x) },
      placuntitis:      d.fetch("placuntitis").map { |x| Placuntiti.from_dynamic!(x) },
      plectopterous:    d.fetch("plectopterous").map { |x| Plectopterous.from_dynamic!(x) },
      pneumocele:       d.fetch("pneumocele").map { |x| x ? Pneumocele.from_dynamic!(x) : nil },
      poliorcetic:      d.fetch("poliorcetic").map { |x| Poliorcetic.from_dynamic!(x) },
      poormaster:       d.fetch("poormaster").map { |x| Poormaster.from_dynamic!(x) },
      potwhisky:        d.fetch("potwhisky").map { |x| PotwhiskyElement.from_dynamic!(x) },
      practicalizer:    d.fetch("practicalizer").map { |x| Practicalizer.from_dynamic!(x) },
      prefreshman:      d.fetch("prefreshman").map { |x| PrefreshmanElement.from_dynamic!(x) },
      prehensility:     d.fetch("prehensility").map { |x| Prehensility.from_dynamic!(x) },
      prevoidance:      d.fetch("prevoidance").map { |x| Prevoidance.from_dynamic!(x) },
      probant:          d.fetch("probant").map { |x| Types::Hash[x].map { |k, v| [k, v] }.to_h },
      protext:          d.fetch("protext").map { |x| Protext.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "juror"            => juror.map { |x| x.to_dynamic },
      "kongoni"          => kongoni.map { |x| x.to_dynamic },
      "ladronism"        => ladronism.map { |x| x.to_dynamic },
      "landlubberly"     => landlubberly.map { |x| x.to_dynamic },
      "listener"         => listener.map { |x| x.to_dynamic },
      "lupus"            => lupus.map { |x| x.to_dynamic },
      "maslin"           => maslin.map { |x| x.to_dynamic },
      "monazite"         => monazite.map { |x| x.to_dynamic },
      "monoliteral"      => monoliteral.map { |x| x.to_dynamic },
      "monotheistically" => monotheistically.map { |x| x.to_dynamic },
      "montage"          => montage.map { |x| x.to_dynamic },
      "moralness"        => moralness.map { |x| x.to_dynamic },
      "mowra"            => mowra.map { |x| x&.to_dynamic },
      "mulishly"         => mulishly.map { |x| x.to_dynamic },
      "myoscope"         => myoscope.map { |x| x.to_dynamic },
      "nach"             => nach,
      "neuromastic"      => neuromastic.map { |x| x.to_dynamic },
      "noncontributing"  => noncontributing.map { |x| x.to_dynamic },
      "nonnervous"       => nonnervous.map { |x| x.to_dynamic },
      "nonvaluation"     => nonvaluation.map { |x| x.to_dynamic },
      "occupationalist"  => occupationalist.map { |x| x.to_dynamic },
      "outrival"         => outrival.map { |x| x.to_dynamic },
      "paleographically" => paleographically.map { |x| x.to_dynamic },
      "pamphletwise"     => pamphletwise.map { |x| x.to_dynamic },
      "pediatrics"       => pediatrics.map { |x| x.to_dynamic },
      "perceptive"       => perceptive,
      "piaculum"         => piaculum.map { |x| x.to_dynamic },
      "piccadilly"       => piccadilly.map { |x| x.to_dynamic },
      "piffler"          => piffler.map { |x| x.to_dynamic },
      "pithful"          => pithful.map { |x| x.to_dynamic },
      "placuntitis"      => placuntitis.map { |x| x.to_dynamic },
      "plectopterous"    => plectopterous.map { |x| x.to_dynamic },
      "pneumocele"       => pneumocele.map { |x| x&.to_dynamic },
      "poliorcetic"      => poliorcetic.map { |x| x.to_dynamic },
      "poormaster"       => poormaster.map { |x| x.to_dynamic },
      "potwhisky"        => potwhisky.map { |x| x.to_dynamic },
      "practicalizer"    => practicalizer.map { |x| x.to_dynamic },
      "prefreshman"      => prefreshman.map { |x| x.to_dynamic },
      "prehensility"     => prehensility.map { |x| x.to_dynamic },
      "prevoidance"      => prevoidance.map { |x| x.to_dynamic },
      "probant"          => probant,
      "protext"          => protext.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
