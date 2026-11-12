# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.wrothy.first
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

class Protrusive < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :union_array, Types.Array(Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, union_array: nil)
    end
    if schema.key(:union_array).type.right.valid? d
      return new(union_array: d, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if double != nil
      double
    elsif union_array != nil
      union_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PulpitismClass < Dry::Struct
  attribute :abnet,           Types::Nil
  attribute :buckhorn,        Types::Nil
  attribute :calciform,       Types::Nil
  attribute :chelophore,      Types::Nil
  attribute :cogitation,      Types::Nil
  attribute :decreeable,      Types::Nil
  attribute :despicable,      Types::Nil
  attribute :isodiazo,        Types::Nil
  attribute :jadedly,         Types::Nil
  attribute :leptochlorite,   Types::Nil
  attribute :nursling,        Types::Nil
  attribute :palamedean,      Types::Nil
  attribute :photoheliograph, Types::Nil
  attribute :pipewood,        Types::Nil
  attribute :roberd,          Types::Nil
  attribute :statable,        Types::Nil
  attribute :superassume,     Types::Nil
  attribute :syllabe,         Types::Nil
  attribute :toughhead,       Types::Nil
  attribute :underburn,       Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      abnet:           d.fetch("abnet"),
      buckhorn:        d.fetch("buckhorn"),
      calciform:       d.fetch("calciform"),
      chelophore:      d.fetch("chelophore"),
      cogitation:      d.fetch("cogitation"),
      decreeable:      d.fetch("decreeable"),
      despicable:      d.fetch("despicable"),
      isodiazo:        d.fetch("isodiazo"),
      jadedly:         d.fetch("jadedly"),
      leptochlorite:   d.fetch("leptochlorite"),
      nursling:        d.fetch("nursling"),
      palamedean:      d.fetch("palamedean"),
      photoheliograph: d.fetch("photoheliograph"),
      pipewood:        d.fetch("pipewood"),
      roberd:          d.fetch("roberd"),
      statable:        d.fetch("statable"),
      superassume:     d.fetch("superassume"),
      syllabe:         d.fetch("syllabe"),
      toughhead:       d.fetch("toughhead"),
      underburn:       d.fetch("underburn"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "abnet"           => abnet,
      "buckhorn"        => buckhorn,
      "calciform"       => calciform,
      "chelophore"      => chelophore,
      "cogitation"      => cogitation,
      "decreeable"      => decreeable,
      "despicable"      => despicable,
      "isodiazo"        => isodiazo,
      "jadedly"         => jadedly,
      "leptochlorite"   => leptochlorite,
      "nursling"        => nursling,
      "palamedean"      => palamedean,
      "photoheliograph" => photoheliograph,
      "pipewood"        => pipewood,
      "roberd"          => roberd,
      "statable"        => statable,
      "superassume"     => superassume,
      "syllabe"         => syllabe,
      "toughhead"       => toughhead,
      "underburn"       => underburn,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PulpitismElement < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :integer_array,   Types.Array(Types::Integer).optional
  attribute :pulpitism_class, PulpitismClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_array: nil, pulpitism_class: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, pulpitism_class: nil, double: nil)
    end
    begin
      value = PulpitismClass.from_dynamic!(d)
      if schema.key(:pulpitism_class).type.right.valid? value
        return new(pulpitism_class: value, integer_array: nil, double: nil)
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
    elsif pulpitism_class != nil
      pulpitism_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PyodermiaClass < Dry::Struct
  attribute :aphoristically, Types::Nil
  attribute :apophyllous,    Types::Nil
  attribute :cognize,        Types::Nil
  attribute :dermonosology,  Types::Nil
  attribute :gyppo,          Types::Nil
  attribute :ither,          Types::Nil
  attribute :juglandaceous,  Types::Nil
  attribute :litho,          Types::Nil
  attribute :macropterous,   Types::Nil
  attribute :photographer,   Types::Nil
  attribute :romancing,      Types::Nil
  attribute :rumness,        Types::Nil
  attribute :somniloquist,   Types::Nil
  attribute :stressfully,    Types::Nil
  attribute :tactically,     Types::Nil
  attribute :tracheophony,   Types::Nil
  attribute :unappositely,   Types::Nil
  attribute :unclothedly,    Types::Nil
  attribute :unimplied,      Types::Nil
  attribute :unsyncopated,   Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aphoristically: d.fetch("aphoristically"),
      apophyllous:    d.fetch("apophyllous"),
      cognize:        d.fetch("cognize"),
      dermonosology:  d.fetch("dermonosology"),
      gyppo:          d.fetch("Gyppo"),
      ither:          d.fetch("ither"),
      juglandaceous:  d.fetch("juglandaceous"),
      litho:          d.fetch("litho"),
      macropterous:   d.fetch("macropterous"),
      photographer:   d.fetch("photographer"),
      romancing:      d.fetch("romancing"),
      rumness:        d.fetch("rumness"),
      somniloquist:   d.fetch("somniloquist"),
      stressfully:    d.fetch("stressfully"),
      tactically:     d.fetch("tactically"),
      tracheophony:   d.fetch("tracheophony"),
      unappositely:   d.fetch("unappositely"),
      unclothedly:    d.fetch("unclothedly"),
      unimplied:      d.fetch("unimplied"),
      unsyncopated:   d.fetch("unsyncopated"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aphoristically" => aphoristically,
      "apophyllous"    => apophyllous,
      "cognize"        => cognize,
      "dermonosology"  => dermonosology,
      "Gyppo"          => gyppo,
      "ither"          => ither,
      "juglandaceous"  => juglandaceous,
      "litho"          => litho,
      "macropterous"   => macropterous,
      "photographer"   => photographer,
      "romancing"      => romancing,
      "rumness"        => rumness,
      "somniloquist"   => somniloquist,
      "stressfully"    => stressfully,
      "tactically"     => tactically,
      "tracheophony"   => tracheophony,
      "unappositely"   => unappositely,
      "unclothedly"    => unclothedly,
      "unimplied"      => unimplied,
      "unsyncopated"   => unsyncopated,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class PyodermiaElement < Dry::Struct
  attribute :integer,         Types::Integer.optional
  attribute :pyodermia_class, PyodermiaClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, pyodermia_class: nil)
    end
    begin
      value = PyodermiaClass.from_dynamic!(d)
      if schema.key(:pyodermia_class).type.right.valid? value
        return new(pyodermia_class: value, integer: nil)
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
    elsif pyodermia_class != nil
      pyodermia_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class QuebrachineClass < Dry::Struct
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

class QuebrachineElement < Dry::Struct
  attribute :bool,              Types::Bool.optional
  attribute :null,              Types::Nil.optional
  attribute :quebrachine_class, QuebrachineClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, quebrachine_class: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, bool: nil, quebrachine_class: nil)
    end
    begin
      value = QuebrachineClass.from_dynamic!(d)
      if schema.key(:quebrachine_class).type.right.valid? value
        return new(quebrachine_class: value, bool: nil, null: nil)
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
    elsif quebrachine_class != nil
      quebrachine_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Querier < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, bool: nil)
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
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Rebarbative < Dry::Struct
  attribute :bool,          Types::Bool.optional
  attribute :double,        Types::Double.optional
  attribute :integer_array, Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil, double: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_array: nil, bool: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil, double: nil)
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
    elsif integer_array != nil
      integer_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Reimagine < Dry::Struct
  attribute :adducible,       Types::Nil.optional
  attribute :anabolin,        Types::Nil.optional
  attribute :brainy,          Types::Nil.optional
  attribute :catharticalness, Types::Double.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :chrysamine,      Types::Nil.optional
  attribute :disdiapason,     Types::String.optional
  attribute :fluxweed,        Types::Nil.optional
  attribute :glaucine,        Types::Nil.optional
  attribute :grobianism,      Types::Nil.optional
  attribute :hermo,           Types::Nil.optional
  attribute :hieroglyphist,   Types::Nil.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :icteroid,        Types::Nil.optional
  attribute :immortal,        Types::Nil.optional
  attribute :impetulant,      Types::Nil.optional
  attribute :irrigate,        Types::Nil.optional
  attribute :myxedema,        Types::Nil.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :onyx,            Types::Nil.optional
  attribute :repasser,        Types::Nil.optional
  attribute :septomarginal,   Types::Nil.optional
  attribute :subdie,          Types::Nil.optional
  attribute :tibiometatarsal, Types::Nil.optional
  attribute :waltzlike,       Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      adducible:       d["adducible"],
      anabolin:        d["anabolin"],
      brainy:          d["brainy"],
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      chrysamine:      d["chrysamine"],
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      fluxweed:        d["fluxweed"],
      glaucine:        d["glaucine"],
      grobianism:      d["grobianism"],
      hermo:           d["Hermo"],
      hieroglyphist:   d["hieroglyphist"],
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      icteroid:        d["icteroid"],
      immortal:        d["immortal"],
      impetulant:      d["impetulant"],
      irrigate:        d["irrigate"],
      myxedema:        d["myxedema"],
      nonbookish:      d["nonbookish"],
      onyx:            d["onyx"],
      repasser:        d["repasser"],
      septomarginal:   d["septomarginal"],
      subdie:          d["subdie"],
      tibiometatarsal: d["tibiometatarsal"],
      waltzlike:       d["waltzlike"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "adducible"       => adducible,
      "anabolin"        => anabolin,
      "brainy"          => brainy,
      "catharticalness" => catharticalness,
      "Chirotherium"    => chirotherium,
      "chrysamine"      => chrysamine,
      "disdiapason"     => disdiapason,
      "fluxweed"        => fluxweed,
      "glaucine"        => glaucine,
      "grobianism"      => grobianism,
      "Hermo"           => hermo,
      "hieroglyphist"   => hieroglyphist,
      "homocerc"        => homocerc,
      "icteroid"        => icteroid,
      "immortal"        => immortal,
      "impetulant"      => impetulant,
      "irrigate"        => irrigate,
      "myxedema"        => myxedema,
      "nonbookish"      => nonbookish,
      "onyx"            => onyx,
      "repasser"        => repasser,
      "septomarginal"   => septomarginal,
      "subdie"          => subdie,
      "tibiometatarsal" => tibiometatarsal,
      "waltzlike"       => waltzlike,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Ressaut < Dry::Struct
  attribute :apperceptive,    Types::String
  attribute :cuttoo,          Types::String
  attribute :douser,          Types::String
  attribute :drinkproof,      Types::String
  attribute :forementioned,   Types::String
  attribute :freesia,         Types::String
  attribute :genevieve,       Types::String
  attribute :hyperdiabolical, Types::String
  attribute :hypocone,        Types::String
  attribute :irreverentially, Types::String
  attribute :jumart,          Types::String
  attribute :mimosaceae,      Types::String
  attribute :mollicrush,      Types::String
  attribute :nedder,          Types::String
  attribute :retinasphalt,    Types::String
  attribute :sough,           Types::String
  attribute :steading,        Types::String
  attribute :theopaschitism,  Types::String
  attribute :undurableness,   Types::String
  attribute :unmingleable,    Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      apperceptive:    d.fetch("apperceptive"),
      cuttoo:          d.fetch("cuttoo"),
      douser:          d.fetch("douser"),
      drinkproof:      d.fetch("drinkproof"),
      forementioned:   d.fetch("forementioned"),
      freesia:         d.fetch("Freesia"),
      genevieve:       d.fetch("Genevieve"),
      hyperdiabolical: d.fetch("hyperdiabolical"),
      hypocone:        d.fetch("hypocone"),
      irreverentially: d.fetch("irreverentially"),
      jumart:          d.fetch("jumart"),
      mimosaceae:      d.fetch("Mimosaceae"),
      mollicrush:      d.fetch("mollicrush"),
      nedder:          d.fetch("nedder"),
      retinasphalt:    d.fetch("retinasphalt"),
      sough:           d.fetch("sough"),
      steading:        d.fetch("steading"),
      theopaschitism:  d.fetch("Theopaschitism"),
      undurableness:   d.fetch("undurableness"),
      unmingleable:    d.fetch("unmingleable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "apperceptive"    => apperceptive,
      "cuttoo"          => cuttoo,
      "douser"          => douser,
      "drinkproof"      => drinkproof,
      "forementioned"   => forementioned,
      "Freesia"         => freesia,
      "Genevieve"       => genevieve,
      "hyperdiabolical" => hyperdiabolical,
      "hypocone"        => hypocone,
      "irreverentially" => irreverentially,
      "jumart"          => jumart,
      "Mimosaceae"      => mimosaceae,
      "mollicrush"      => mollicrush,
      "nedder"          => nedder,
      "retinasphalt"    => retinasphalt,
      "sough"           => sough,
      "steading"        => steading,
      "Theopaschitism"  => theopaschitism,
      "undurableness"   => undurableness,
      "unmingleable"    => unmingleable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Retrocervical < Dry::Struct
  attribute :integer,     Types::Integer.optional
  attribute :union_array, Types.Array(Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, union_array: nil)
    end
    if schema.key(:union_array).type.right.valid? d
      return new(union_array: d, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer != nil
      integer
    elsif union_array != nil
      union_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Revert < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RewriteClass < Dry::Struct
  attribute :accountancy,      Types::Nil
  attribute :cacotrophic,      Types::Nil
  attribute :contest,          Types::Nil
  attribute :couthily,         Types::Nil
  attribute :falculate,        Types::Nil
  attribute :foreseize,        Types::Nil
  attribute :hyades,           Types::Nil
  attribute :lemnad,           Types::Nil
  attribute :monotheistically, Types::Nil
  attribute :nonflying,        Types::Nil
  attribute :ptenoglossa,      Types::Nil
  attribute :repatch,          Types::Nil
  attribute :rodman,           Types::Nil
  attribute :strung,           Types::Nil
  attribute :titmal,           Types::Nil
  attribute :twalpennyworth,   Types::Nil
  attribute :unblamable,       Types::Nil
  attribute :vertical,         Types::Nil
  attribute :whiggification,   Types::Nil
  attribute :yardman,          Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      accountancy:      d.fetch("accountancy"),
      cacotrophic:      d.fetch("cacotrophic"),
      contest:          d.fetch("contest"),
      couthily:         d.fetch("couthily"),
      falculate:        d.fetch("falculate"),
      foreseize:        d.fetch("foreseize"),
      hyades:           d.fetch("Hyades"),
      lemnad:           d.fetch("lemnad"),
      monotheistically: d.fetch("monotheistically"),
      nonflying:        d.fetch("nonflying"),
      ptenoglossa:      d.fetch("Ptenoglossa"),
      repatch:          d.fetch("repatch"),
      rodman:           d.fetch("rodman"),
      strung:           d.fetch("strung"),
      titmal:           d.fetch("titmal"),
      twalpennyworth:   d.fetch("twalpennyworth"),
      unblamable:       d.fetch("unblamable"),
      vertical:         d.fetch("vertical"),
      whiggification:   d.fetch("Whiggification"),
      yardman:          d.fetch("yardman"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "accountancy"      => accountancy,
      "cacotrophic"      => cacotrophic,
      "contest"          => contest,
      "couthily"         => couthily,
      "falculate"        => falculate,
      "foreseize"        => foreseize,
      "Hyades"           => hyades,
      "lemnad"           => lemnad,
      "monotheistically" => monotheistically,
      "nonflying"        => nonflying,
      "Ptenoglossa"      => ptenoglossa,
      "repatch"          => repatch,
      "rodman"           => rodman,
      "strung"           => strung,
      "titmal"           => titmal,
      "twalpennyworth"   => twalpennyworth,
      "unblamable"       => unblamable,
      "vertical"         => vertical,
      "Whiggification"   => whiggification,
      "yardman"          => yardman,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class RewriteElement < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :null_array,    Types.Array(Types::Nil).optional
  attribute :rewrite_class, RewriteClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_array: nil, rewrite_class: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, rewrite_class: nil, double: nil)
    end
    begin
      value = RewriteClass.from_dynamic!(d)
      if schema.key(:rewrite_class).type.right.valid? value
        return new(rewrite_class: value, null_array: nil, double: nil)
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
    elsif null_array != nil
      null_array
    elsif rewrite_class != nil
      rewrite_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Saccoderm < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :null,          Types::Nil.optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_array: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil, null: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SantirClass < Dry::Struct
  attribute :admiredly,       Types::Nil
  attribute :demicaponier,    Types::Nil
  attribute :epitympanic,     Types::Nil
  attribute :investitor,      Types::Nil
  attribute :lupiform,        Types::Nil
  attribute :monoflagellate,  Types::Nil
  attribute :paleoethnic,     Types::Nil
  attribute :prediscountable, Types::Nil
  attribute :rhetoricals,     Types::Nil
  attribute :roomth,          Types::Nil
  attribute :saccharose,      Types::Nil
  attribute :septonasal,      Types::Nil
  attribute :serpenticide,    Types::Nil
  attribute :setarious,       Types::Nil
  attribute :spaework,        Types::Nil
  attribute :stylite,         Types::Nil
  attribute :suessiones,      Types::Nil
  attribute :timelily,        Types::Nil
  attribute :unprofaned,      Types::Nil
  attribute :vorticular,      Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      admiredly:       d.fetch("admiredly"),
      demicaponier:    d.fetch("demicaponier"),
      epitympanic:     d.fetch("epitympanic"),
      investitor:      d.fetch("investitor"),
      lupiform:        d.fetch("lupiform"),
      monoflagellate:  d.fetch("monoflagellate"),
      paleoethnic:     d.fetch("paleoethnic"),
      prediscountable: d.fetch("prediscountable"),
      rhetoricals:     d.fetch("rhetoricals"),
      roomth:          d.fetch("roomth"),
      saccharose:      d.fetch("saccharose"),
      septonasal:      d.fetch("septonasal"),
      serpenticide:    d.fetch("serpenticide"),
      setarious:       d.fetch("setarious"),
      spaework:        d.fetch("spaework"),
      stylite:         d.fetch("stylite"),
      suessiones:      d.fetch("Suessiones"),
      timelily:        d.fetch("timelily"),
      unprofaned:      d.fetch("unprofaned"),
      vorticular:      d.fetch("vorticular"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "admiredly"       => admiredly,
      "demicaponier"    => demicaponier,
      "epitympanic"     => epitympanic,
      "investitor"      => investitor,
      "lupiform"        => lupiform,
      "monoflagellate"  => monoflagellate,
      "paleoethnic"     => paleoethnic,
      "prediscountable" => prediscountable,
      "rhetoricals"     => rhetoricals,
      "roomth"          => roomth,
      "saccharose"      => saccharose,
      "septonasal"      => septonasal,
      "serpenticide"    => serpenticide,
      "setarious"       => setarious,
      "spaework"        => spaework,
      "stylite"         => stylite,
      "Suessiones"      => suessiones,
      "timelily"        => timelily,
      "unprofaned"      => unprofaned,
      "vorticular"      => vorticular,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SantirElement < Dry::Struct
  attribute :double,       Types::Double.optional
  attribute :santir_class, SantirClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, santir_class: nil)
    end
    begin
      value = SantirClass.from_dynamic!(d)
      if schema.key(:santir_class).type.right.valid? value
        return new(santir_class: value, double: nil)
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
    elsif santir_class != nil
      santir_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Saprophilous < Dry::Struct
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null,        Types::Nil.optional
  attribute :string,      Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_map: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_map: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if integer_map != nil
      integer_map
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

class SaxtenClass < Dry::Struct
  attribute :algarrobilla,    Types::Nil.optional
  attribute :bowgrace,        Types::Nil.optional
  attribute :catharticalness, Types::Double.optional
  attribute :centaurid,       Types::Nil.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :disdiapason,     Types::String.optional
  attribute :flix,            Types::Nil.optional
  attribute :germanely,       Types::Nil.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :inhume,          Types::Nil.optional
  attribute :lepidote,        Types::Nil.optional
  attribute :megalochirous,   Types::Nil.optional
  attribute :ninepenny,       Types::Nil.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :nondeist,        Types::Nil.optional
  attribute :nymphaeaceous,   Types::Nil.optional
  attribute :parietofrontal,  Types::Nil.optional
  attribute :sancyite,        Types::Nil.optional
  attribute :subjectivist,    Types::Nil.optional
  attribute :tibiad,          Types::Nil.optional
  attribute :transonic,       Types::Nil.optional
  attribute :tripetalous,     Types::Nil.optional
  attribute :trunchman,       Types::Nil.optional
  attribute :urger,           Types::Nil.optional
  attribute :withdrawnness,   Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      algarrobilla:    d["algarrobilla"],
      bowgrace:        d["bowgrace"],
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      centaurid:       d["Centaurid"],
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      flix:            d["flix"],
      germanely:       d["germanely"],
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      inhume:          d["inhume"],
      lepidote:        d["lepidote"],
      megalochirous:   d["megalochirous"],
      ninepenny:       d["ninepenny"],
      nonbookish:      d["nonbookish"],
      nondeist:        d["nondeist"],
      nymphaeaceous:   d["nymphaeaceous"],
      parietofrontal:  d["parietofrontal"],
      sancyite:        d["sancyite"],
      subjectivist:    d["subjectivist"],
      tibiad:          d["tibiad"],
      transonic:       d["transonic"],
      tripetalous:     d["tripetalous"],
      trunchman:       d["trunchman"],
      urger:           d["urger"],
      withdrawnness:   d["withdrawnness"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "algarrobilla"    => algarrobilla,
      "bowgrace"        => bowgrace,
      "catharticalness" => catharticalness,
      "Centaurid"       => centaurid,
      "Chirotherium"    => chirotherium,
      "disdiapason"     => disdiapason,
      "flix"            => flix,
      "germanely"       => germanely,
      "homocerc"        => homocerc,
      "inhume"          => inhume,
      "lepidote"        => lepidote,
      "megalochirous"   => megalochirous,
      "ninepenny"       => ninepenny,
      "nonbookish"      => nonbookish,
      "nondeist"        => nondeist,
      "nymphaeaceous"   => nymphaeaceous,
      "parietofrontal"  => parietofrontal,
      "sancyite"        => sancyite,
      "subjectivist"    => subjectivist,
      "tibiad"          => tibiad,
      "transonic"       => transonic,
      "tripetalous"     => tripetalous,
      "trunchman"       => trunchman,
      "urger"           => urger,
      "withdrawnness"   => withdrawnness,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SaxtenElement < Dry::Struct
  attribute :saxten_class, SaxtenClass.optional
  attribute :string,       Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = SaxtenClass.from_dynamic!(d)
      if schema.key(:saxten_class).type.right.valid? value
        return new(saxten_class: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, saxten_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if saxten_class != nil
      saxten_class.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Scatty < Dry::Struct
  attribute :aeriferous,         Types::Nil
  attribute :antical,            Types::Nil
  attribute :antighostism,       Types::Nil
  attribute :arcanum,            Types::Nil
  attribute :autotrophy,         Types::Nil
  attribute :baronial,           Types::Nil
  attribute :caffeine,           Types::Nil
  attribute :gorgoniacean,       Types::Nil
  attribute :heroical,           Types::Nil
  attribute :hydropical,         Types::Nil
  attribute :mechanology,        Types::Nil
  attribute :musicopoetic,       Types::Nil
  attribute :officiality,        Types::Nil
  attribute :oftentimes,         Types::Nil
  attribute :ophthalmotonometer, Types::Nil
  attribute :reflectively,       Types::Nil
  attribute :springer,           Types::Nil
  attribute :tabasco,            Types::Nil
  attribute :teleianthous,       Types::Nil
  attribute :uncombated,         Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aeriferous:         d.fetch("aeriferous"),
      antical:            d.fetch("antical"),
      antighostism:       d.fetch("antighostism"),
      arcanum:            d.fetch("arcanum"),
      autotrophy:         d.fetch("autotrophy"),
      baronial:           d.fetch("baronial"),
      caffeine:           d.fetch("caffeine"),
      gorgoniacean:       d.fetch("gorgoniacean"),
      heroical:           d.fetch("heroical"),
      hydropical:         d.fetch("hydropical"),
      mechanology:        d.fetch("mechanology"),
      musicopoetic:       d.fetch("musicopoetic"),
      officiality:        d.fetch("officiality"),
      oftentimes:         d.fetch("oftentimes"),
      ophthalmotonometer: d.fetch("ophthalmotonometer"),
      reflectively:       d.fetch("reflectively"),
      springer:           d.fetch("springer"),
      tabasco:            d.fetch("Tabasco"),
      teleianthous:       d.fetch("teleianthous"),
      uncombated:         d.fetch("uncombated"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "aeriferous"         => aeriferous,
      "antical"            => antical,
      "antighostism"       => antighostism,
      "arcanum"            => arcanum,
      "autotrophy"         => autotrophy,
      "baronial"           => baronial,
      "caffeine"           => caffeine,
      "gorgoniacean"       => gorgoniacean,
      "heroical"           => heroical,
      "hydropical"         => hydropical,
      "mechanology"        => mechanology,
      "musicopoetic"       => musicopoetic,
      "officiality"        => officiality,
      "oftentimes"         => oftentimes,
      "ophthalmotonometer" => ophthalmotonometer,
      "reflectively"       => reflectively,
      "springer"           => springer,
      "Tabasco"            => tabasco,
      "teleianthous"       => teleianthous,
      "uncombated"         => uncombated,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Scoffer < Dry::Struct
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null,        Types::Nil.optional
  attribute :null_array,  Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, null_array: nil, null: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, null_array: nil, integer_map: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, integer_map: nil, null: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Scrampum < Dry::Struct
  attribute :bool,          Types::Bool.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :null,          Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil, null: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_array: nil, bool: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Serpentinic < Dry::Struct
  attribute :double,        Types::Double.optional
  attribute :integer_array, Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_array: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, double: nil)
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
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Shadowable < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :union_array, Types.Array(Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, union_array: nil)
    end
    if schema.key(:union_array).type.right.valid? d
      return new(union_array: d, bool: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif union_array != nil
      union_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SisteringClass < Dry::Struct
  attribute :amphicarpic,      Types::Nil
  attribute :chianti,          Types::Nil
  attribute :frigorific,       Types::Nil
  attribute :haplomi,          Types::Nil
  attribute :hyperkinesis,     Types::Nil
  attribute :laudable,         Types::Nil
  attribute :madwoman,         Types::Nil
  attribute :maimedly,         Types::Nil
  attribute :micropterygidae,  Types::Nil
  attribute :microrhabdus,     Types::Nil
  attribute :nondense,         Types::Nil
  attribute :phlebemphraxis,   Types::Nil
  attribute :redsear,          Types::Nil
  attribute :schismatical,     Types::Nil
  attribute :tartryl,          Types::Nil
  attribute :unabhorred,       Types::Nil
  attribute :undeliberateness, Types::Nil
  attribute :unmixable,        Types::Nil
  attribute :untruckling,      Types::Nil
  attribute :vineal,           Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      amphicarpic:      d.fetch("amphicarpic"),
      chianti:          d.fetch("Chianti"),
      frigorific:       d.fetch("frigorific"),
      haplomi:          d.fetch("Haplomi"),
      hyperkinesis:     d.fetch("hyperkinesis"),
      laudable:         d.fetch("laudable"),
      madwoman:         d.fetch("madwoman"),
      maimedly:         d.fetch("maimedly"),
      micropterygidae:  d.fetch("Micropterygidae"),
      microrhabdus:     d.fetch("microrhabdus"),
      nondense:         d.fetch("nondense"),
      phlebemphraxis:   d.fetch("phlebemphraxis"),
      redsear:          d.fetch("redsear"),
      schismatical:     d.fetch("schismatical"),
      tartryl:          d.fetch("tartryl"),
      unabhorred:       d.fetch("unabhorred"),
      undeliberateness: d.fetch("undeliberateness"),
      unmixable:        d.fetch("unmixable"),
      untruckling:      d.fetch("untruckling"),
      vineal:           d.fetch("vineal"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "amphicarpic"      => amphicarpic,
      "Chianti"          => chianti,
      "frigorific"       => frigorific,
      "Haplomi"          => haplomi,
      "hyperkinesis"     => hyperkinesis,
      "laudable"         => laudable,
      "madwoman"         => madwoman,
      "maimedly"         => maimedly,
      "Micropterygidae"  => micropterygidae,
      "microrhabdus"     => microrhabdus,
      "nondense"         => nondense,
      "phlebemphraxis"   => phlebemphraxis,
      "redsear"          => redsear,
      "schismatical"     => schismatical,
      "tartryl"          => tartryl,
      "unabhorred"       => unabhorred,
      "undeliberateness" => undeliberateness,
      "unmixable"        => unmixable,
      "untruckling"      => untruckling,
      "vineal"           => vineal,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class SisteringElement < Dry::Struct
  attribute :integer,         Types::Integer.optional
  attribute :null_array,      Types.Array(Types::Nil).optional
  attribute :sistering_class, SisteringClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null_array: nil, sistering_class: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, sistering_class: nil, integer: nil)
    end
    begin
      value = SisteringClass.from_dynamic!(d)
      if schema.key(:sistering_class).type.right.valid? value
        return new(sistering_class: value, null_array: nil, integer: nil)
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
    elsif null_array != nil
      null_array
    elsif sistering_class != nil
      sistering_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Staghunting < Dry::Struct
  attribute :calorimetric,       Types::Integer.optional
  attribute :canid,              Types::Integer.optional
  attribute :catharticalness,    Types::Double.optional
  attribute :chirotherium,       Types::Integer.optional
  attribute :disdiapason,        Types::String.optional
  attribute :ditriglyphic,       Types::Integer.optional
  attribute :floriferousness,    Types::Integer.optional
  attribute :gamelike,           Types::Integer.optional
  attribute :grig,               Types::Integer.optional
  attribute :homocerc,           Types::Bool.optional
  attribute :interloan,          Types::Integer.optional
  attribute :lithotomy,          Types::Integer.optional
  attribute :loric,              Types::Integer.optional
  attribute :membranocoriaceous, Types::Integer.optional
  attribute :membranogenic,      Types::Integer.optional
  attribute :nonbookish,         Types::Nil.optional
  attribute :overtrump,          Types::Integer.optional
  attribute :scotino,            Types::Integer.optional
  attribute :seasonable,         Types::Integer.optional
  attribute :sephen,             Types::Integer.optional
  attribute :stigmarioid,        Types::Integer.optional
  attribute :tired,              Types::Integer.optional
  attribute :trifid,             Types::Integer.optional
  attribute :undefeatedly,       Types::Integer.optional
  attribute :ungirlish,          Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      calorimetric:       d.key?("calorimetric") ? Types::Integer[d["calorimetric"]] : nil,
      canid:              d.key?("canid") ? Types::Integer[d["canid"]] : nil,
      catharticalness:    d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:       d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      disdiapason:        d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      ditriglyphic:       d.key?("ditriglyphic") ? Types::Integer[d["ditriglyphic"]] : nil,
      floriferousness:    d.key?("floriferousness") ? Types::Integer[d["floriferousness"]] : nil,
      gamelike:           d.key?("gamelike") ? Types::Integer[d["gamelike"]] : nil,
      grig:               d.key?("grig") ? Types::Integer[d["grig"]] : nil,
      homocerc:           d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      interloan:          d.key?("interloan") ? Types::Integer[d["interloan"]] : nil,
      lithotomy:          d.key?("lithotomy") ? Types::Integer[d["lithotomy"]] : nil,
      loric:              d.key?("loric") ? Types::Integer[d["loric"]] : nil,
      membranocoriaceous: d.key?("membranocoriaceous") ? Types::Integer[d["membranocoriaceous"]] : nil,
      membranogenic:      d.key?("membranogenic") ? Types::Integer[d["membranogenic"]] : nil,
      nonbookish:         d["nonbookish"],
      overtrump:          d.key?("overtrump") ? Types::Integer[d["overtrump"]] : nil,
      scotino:            d.key?("scotino") ? Types::Integer[d["scotino"]] : nil,
      seasonable:         d.key?("seasonable") ? Types::Integer[d["seasonable"]] : nil,
      sephen:             d.key?("sephen") ? Types::Integer[d["sephen"]] : nil,
      stigmarioid:        d.key?("stigmarioid") ? Types::Integer[d["stigmarioid"]] : nil,
      tired:              d.key?("tired") ? Types::Integer[d["tired"]] : nil,
      trifid:             d.key?("trifid") ? Types::Integer[d["trifid"]] : nil,
      undefeatedly:       d.key?("undefeatedly") ? Types::Integer[d["undefeatedly"]] : nil,
      ungirlish:          d.key?("ungirlish") ? Types::Integer[d["ungirlish"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "calorimetric"       => calorimetric,
      "canid"              => canid,
      "catharticalness"    => catharticalness,
      "Chirotherium"       => chirotherium,
      "disdiapason"        => disdiapason,
      "ditriglyphic"       => ditriglyphic,
      "floriferousness"    => floriferousness,
      "gamelike"           => gamelike,
      "grig"               => grig,
      "homocerc"           => homocerc,
      "interloan"          => interloan,
      "lithotomy"          => lithotomy,
      "loric"              => loric,
      "membranocoriaceous" => membranocoriaceous,
      "membranogenic"      => membranogenic,
      "nonbookish"         => nonbookish,
      "overtrump"          => overtrump,
      "scotino"            => scotino,
      "seasonable"         => seasonable,
      "sephen"             => sephen,
      "stigmarioid"        => stigmarioid,
      "tired"              => tired,
      "trifid"             => trifid,
      "undefeatedly"       => undefeatedly,
      "ungirlish"          => ungirlish,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Stagmometer < Dry::Struct
  attribute :string,      Types::String.optional
  attribute :union_array, Types.Array(Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:string).type.right.valid? d
      return new(string: d, union_array: nil)
    end
    if schema.key(:union_array).type.right.valid? d
      return new(union_array: d, string: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if string != nil
      string
    elsif union_array != nil
      union_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Stimulability < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :integer,     Types::Integer.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer: nil, integer_map: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, bool: nil, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, bool: nil, integer: nil)
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
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Strangleable < Dry::Struct
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

class StrenuosityClass < Dry::Struct
  attribute :bliss,           Types::Integer.optional
  attribute :buccate,         Types::Integer.optional
  attribute :bulletproof,     Types::Integer.optional
  attribute :catharticalness, Types::Double.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :crumblingness,   Types::Integer.optional
  attribute :disdiapason,     Types::String.optional
  attribute :engagedly,       Types::Integer.optional
  attribute :fightable,       Types::Integer.optional
  attribute :hoariness,       Types::Integer.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :hypopodium,      Types::Integer.optional
  attribute :luxurist,        Types::Integer.optional
  attribute :mechanician,     Types::Integer.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :onopordon,       Types::Integer.optional
  attribute :podgily,         Types::Integer.optional
  attribute :reformableness,  Types::Integer.optional
  attribute :scatterbrains,   Types::Integer.optional
  attribute :seminuria,       Types::Integer.optional
  attribute :sodomite,        Types::Integer.optional
  attribute :tramp,           Types::Integer.optional
  attribute :undueness,       Types::Integer.optional
  attribute :worthily,        Types::Integer.optional
  attribute :yankeeist,       Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bliss:           d.key?("bliss") ? Types::Integer[d["bliss"]] : nil,
      buccate:         d.key?("buccate") ? Types::Integer[d["buccate"]] : nil,
      bulletproof:     d.key?("bulletproof") ? Types::Integer[d["bulletproof"]] : nil,
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      crumblingness:   d.key?("crumblingness") ? Types::Integer[d["crumblingness"]] : nil,
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      engagedly:       d.key?("engagedly") ? Types::Integer[d["engagedly"]] : nil,
      fightable:       d.key?("fightable") ? Types::Integer[d["fightable"]] : nil,
      hoariness:       d.key?("hoariness") ? Types::Integer[d["hoariness"]] : nil,
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      hypopodium:      d.key?("hypopodium") ? Types::Integer[d["hypopodium"]] : nil,
      luxurist:        d.key?("luxurist") ? Types::Integer[d["luxurist"]] : nil,
      mechanician:     d.key?("mechanician") ? Types::Integer[d["mechanician"]] : nil,
      nonbookish:      d["nonbookish"],
      onopordon:       d.key?("Onopordon") ? Types::Integer[d["Onopordon"]] : nil,
      podgily:         d.key?("podgily") ? Types::Integer[d["podgily"]] : nil,
      reformableness:  d.key?("reformableness") ? Types::Integer[d["reformableness"]] : nil,
      scatterbrains:   d.key?("scatterbrains") ? Types::Integer[d["scatterbrains"]] : nil,
      seminuria:       d.key?("seminuria") ? Types::Integer[d["seminuria"]] : nil,
      sodomite:        d.key?("Sodomite") ? Types::Integer[d["Sodomite"]] : nil,
      tramp:           d.key?("tramp") ? Types::Integer[d["tramp"]] : nil,
      undueness:       d.key?("undueness") ? Types::Integer[d["undueness"]] : nil,
      worthily:        d.key?("worthily") ? Types::Integer[d["worthily"]] : nil,
      yankeeist:       d.key?("Yankeeist") ? Types::Integer[d["Yankeeist"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bliss"           => bliss,
      "buccate"         => buccate,
      "bulletproof"     => bulletproof,
      "catharticalness" => catharticalness,
      "Chirotherium"    => chirotherium,
      "crumblingness"   => crumblingness,
      "disdiapason"     => disdiapason,
      "engagedly"       => engagedly,
      "fightable"       => fightable,
      "hoariness"       => hoariness,
      "homocerc"        => homocerc,
      "hypopodium"      => hypopodium,
      "luxurist"        => luxurist,
      "mechanician"     => mechanician,
      "nonbookish"      => nonbookish,
      "Onopordon"       => onopordon,
      "podgily"         => podgily,
      "reformableness"  => reformableness,
      "scatterbrains"   => scatterbrains,
      "seminuria"       => seminuria,
      "Sodomite"        => sodomite,
      "tramp"           => tramp,
      "undueness"       => undueness,
      "worthily"        => worthily,
      "Yankeeist"       => yankeeist,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class StrenuosityElement < Dry::Struct
  attribute :null_array,        Types.Array(Types::Nil).optional
  attribute :strenuosity_class, StrenuosityClass.optional

  def self.from_dynamic!(d)
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, strenuosity_class: nil)
    end
    begin
      value = StrenuosityClass.from_dynamic!(d)
      if schema.key(:strenuosity_class).type.right.valid? value
        return new(strenuosity_class: value, null_array: nil)
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
    elsif strenuosity_class != nil
      strenuosity_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Tabaxir < Dry::Struct
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

class Talpiform < Dry::Struct
  attribute :double,            Types::Double.optional
  attribute :null,              Types::Nil.optional
  attribute :quebrachine_class, QuebrachineClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, quebrachine_class: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, quebrachine_class: nil, double: nil)
    end
    begin
      value = QuebrachineClass.from_dynamic!(d)
      if schema.key(:quebrachine_class).type.right.valid? value
        return new(quebrachine_class: value, double: nil, null: nil)
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
    elsif quebrachine_class != nil
      quebrachine_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Thwack < Dry::Struct
  attribute :bool,              Types::Bool.optional
  attribute :double,            Types::Double.optional
  attribute :quebrachine_class, QuebrachineClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, quebrachine_class: nil, double: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, quebrachine_class: nil)
    end
    begin
      value = QuebrachineClass.from_dynamic!(d)
      if schema.key(:quebrachine_class).type.right.valid? value
        return new(quebrachine_class: value, bool: nil, double: nil)
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
    elsif double != nil
      double
    elsif quebrachine_class != nil
      quebrachine_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Tortricine < Dry::Struct
  attribute :quebrachine_class, QuebrachineClass.optional
  attribute :union_array,       Types.Array(Types::Integer.optional).optional

  def self.from_dynamic!(d)
    begin
      value = QuebrachineClass.from_dynamic!(d)
      if schema.key(:quebrachine_class).type.right.valid? value
        return new(quebrachine_class: value, union_array: nil)
      end
    rescue
    end
    if schema.key(:union_array).type.right.valid? d
      return new(union_array: d, quebrachine_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if quebrachine_class != nil
      quebrachine_class.to_dynamic
    elsif union_array != nil
      union_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TruantcyClass < Dry::Struct
  attribute :alfiona,         Types::Nil.optional
  attribute :ascaridiasis,    Types::Nil.optional
  attribute :bungey,          Types::Nil.optional
  attribute :catharticalness, Types::Double.optional
  attribute :ceroxyle,        Types::Nil.optional
  attribute :chirotherium,    Types::Integer.optional
  attribute :chorology,       Types::Nil.optional
  attribute :disdiapason,     Types::String.optional
  attribute :enmarble,        Types::Nil.optional
  attribute :epeira,          Types::Nil.optional
  attribute :eurylaimi,       Types::Nil.optional
  attribute :germination,     Types::Nil.optional
  attribute :hallelujah,      Types::Nil.optional
  attribute :homocerc,        Types::Bool.optional
  attribute :lev,             Types::Nil.optional
  attribute :mouthing,        Types::Nil.optional
  attribute :nonbookish,      Types::Nil.optional
  attribute :philliloo,       Types::Nil.optional
  attribute :planetal,        Types::Nil.optional
  attribute :poney,           Types::Nil.optional
  attribute :punctualist,     Types::Nil.optional
  attribute :returnlessly,    Types::Nil.optional
  attribute :skelder,         Types::Nil.optional
  attribute :windwaywardly,   Types::Nil.optional
  attribute :yuman,           Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      alfiona:         d["alfiona"],
      ascaridiasis:    d["ascaridiasis"],
      bungey:          d["bungey"],
      catharticalness: d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      ceroxyle:        d["ceroxyle"],
      chirotherium:    d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      chorology:       d["chorology"],
      disdiapason:     d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      enmarble:        d["enmarble"],
      epeira:          d["Epeira"],
      eurylaimi:       d["Eurylaimi"],
      germination:     d["germination"],
      hallelujah:      d["hallelujah"],
      homocerc:        d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      lev:             d["lev"],
      mouthing:        d["mouthing"],
      nonbookish:      d["nonbookish"],
      philliloo:       d["philliloo"],
      planetal:        d["planetal"],
      poney:           d["poney"],
      punctualist:     d["punctualist"],
      returnlessly:    d["returnlessly"],
      skelder:         d["skelder"],
      windwaywardly:   d["windwaywardly"],
      yuman:           d["Yuman"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "alfiona"         => alfiona,
      "ascaridiasis"    => ascaridiasis,
      "bungey"          => bungey,
      "catharticalness" => catharticalness,
      "ceroxyle"        => ceroxyle,
      "Chirotherium"    => chirotherium,
      "chorology"       => chorology,
      "disdiapason"     => disdiapason,
      "enmarble"        => enmarble,
      "Epeira"          => epeira,
      "Eurylaimi"       => eurylaimi,
      "germination"     => germination,
      "hallelujah"      => hallelujah,
      "homocerc"        => homocerc,
      "lev"             => lev,
      "mouthing"        => mouthing,
      "nonbookish"      => nonbookish,
      "philliloo"       => philliloo,
      "planetal"        => planetal,
      "poney"           => poney,
      "punctualist"     => punctualist,
      "returnlessly"    => returnlessly,
      "skelder"         => skelder,
      "windwaywardly"   => windwaywardly,
      "Yuman"           => yuman,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TruantcyElement < Dry::Struct
  attribute :bool,           Types::Bool.optional
  attribute :truantcy_class, TruantcyClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, truantcy_class: nil)
    end
    begin
      value = TruantcyClass.from_dynamic!(d)
      if schema.key(:truantcy_class).type.right.valid? value
        return new(truantcy_class: value, bool: nil)
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
    elsif truantcy_class != nil
      truantcy_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unbeginning < Dry::Struct
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null_array,  Types.Array(Types::Nil).optional
  attribute :string,      Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, null_array: nil, string: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, integer_map: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, null_array: nil, integer_map: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Undesirability < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :integer_map,   Types::Hash.meta(of: Types::Integer).optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, integer_map: nil, string: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, integer_array: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil, integer_map: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unerasing < Dry::Struct
  attribute :integer,     Types::Integer.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null_array,  Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null_array: nil, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, null_array: nil, integer: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, integer: nil, integer_map: nil)
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
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unguentarium < Dry::Struct
  attribute :integer,    Types::Integer.optional
  attribute :null,       Types::Nil.optional
  attribute :null_array, Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null_array: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, null_array: nil, integer: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, integer: nil, null: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnimpeachablyClass < Dry::Struct
  attribute :acerin,             Types::Integer.optional
  attribute :bobadil,            Types::Integer.optional
  attribute :catharticalness,    Types::Double.optional
  attribute :chirotherium,       Types::Integer.optional
  attribute :chlorophylligenous, Types::Integer.optional
  attribute :conversational,     Types::Integer.optional
  attribute :demiowl,            Types::Integer.optional
  attribute :disdiapason,        Types::String.optional
  attribute :ectorhinal,         Types::Integer.optional
  attribute :gamblesomeness,     Types::Integer.optional
  attribute :homocerc,           Types::Bool.optional
  attribute :irrorate,           Types::Integer.optional
  attribute :kindergartening,    Types::Integer.optional
  attribute :lateritic,          Types::Integer.optional
  attribute :mespil,             Types::Integer.optional
  attribute :misconfiguration,   Types::Integer.optional
  attribute :nonbookish,         Types::Nil.optional
  attribute :planometry,         Types::Integer.optional
  attribute :quiina,             Types::Integer.optional
  attribute :robert,             Types::Integer.optional
  attribute :rot,                Types::Integer.optional
  attribute :subcinctorium,      Types::Integer.optional
  attribute :tussocker,          Types::Integer.optional
  attribute :ultraproud,         Types::Integer.optional
  attribute :unsuggestedness,    Types::Integer.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      acerin:             d.key?("acerin") ? Types::Integer[d["acerin"]] : nil,
      bobadil:            d.key?("Bobadil") ? Types::Integer[d["Bobadil"]] : nil,
      catharticalness:    d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:       d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      chlorophylligenous: d.key?("chlorophylligenous") ? Types::Integer[d["chlorophylligenous"]] : nil,
      conversational:     d.key?("conversational") ? Types::Integer[d["conversational"]] : nil,
      demiowl:            d.key?("demiowl") ? Types::Integer[d["demiowl"]] : nil,
      disdiapason:        d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      ectorhinal:         d.key?("ectorhinal") ? Types::Integer[d["ectorhinal"]] : nil,
      gamblesomeness:     d.key?("gamblesomeness") ? Types::Integer[d["gamblesomeness"]] : nil,
      homocerc:           d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      irrorate:           d.key?("irrorate") ? Types::Integer[d["irrorate"]] : nil,
      kindergartening:    d.key?("kindergartening") ? Types::Integer[d["kindergartening"]] : nil,
      lateritic:          d.key?("lateritic") ? Types::Integer[d["lateritic"]] : nil,
      mespil:             d.key?("mespil") ? Types::Integer[d["mespil"]] : nil,
      misconfiguration:   d.key?("misconfiguration") ? Types::Integer[d["misconfiguration"]] : nil,
      nonbookish:         d["nonbookish"],
      planometry:         d.key?("planometry") ? Types::Integer[d["planometry"]] : nil,
      quiina:             d.key?("Quiina") ? Types::Integer[d["Quiina"]] : nil,
      robert:             d.key?("Robert") ? Types::Integer[d["Robert"]] : nil,
      rot:                d.key?("rot") ? Types::Integer[d["rot"]] : nil,
      subcinctorium:      d.key?("subcinctorium") ? Types::Integer[d["subcinctorium"]] : nil,
      tussocker:          d.key?("tussocker") ? Types::Integer[d["tussocker"]] : nil,
      ultraproud:         d.key?("ultraproud") ? Types::Integer[d["ultraproud"]] : nil,
      unsuggestedness:    d.key?("unsuggestedness") ? Types::Integer[d["unsuggestedness"]] : nil,
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "acerin"             => acerin,
      "Bobadil"            => bobadil,
      "catharticalness"    => catharticalness,
      "Chirotherium"       => chirotherium,
      "chlorophylligenous" => chlorophylligenous,
      "conversational"     => conversational,
      "demiowl"            => demiowl,
      "disdiapason"        => disdiapason,
      "ectorhinal"         => ectorhinal,
      "gamblesomeness"     => gamblesomeness,
      "homocerc"           => homocerc,
      "irrorate"           => irrorate,
      "kindergartening"    => kindergartening,
      "lateritic"          => lateritic,
      "mespil"             => mespil,
      "misconfiguration"   => misconfiguration,
      "nonbookish"         => nonbookish,
      "planometry"         => planometry,
      "Quiina"             => quiina,
      "Robert"             => robert,
      "rot"                => rot,
      "subcinctorium"      => subcinctorium,
      "tussocker"          => tussocker,
      "ultraproud"         => ultraproud,
      "unsuggestedness"    => unsuggestedness,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnimpeachablyElement < Dry::Struct
  attribute :bool,                Types::Bool.optional
  attribute :unimpeachably_class, UnimpeachablyClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, unimpeachably_class: nil)
    end
    begin
      value = UnimpeachablyClass.from_dynamic!(d)
      if schema.key(:unimpeachably_class).type.right.valid? value
        return new(unimpeachably_class: value, bool: nil)
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
    elsif unimpeachably_class != nil
      unimpeachably_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unmortgaged < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null,        Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_map: nil, null: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, double: nil, null: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, double: nil, integer_map: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unobstructed < Dry::Struct
  attribute :integer,           Types::Integer.optional
  attribute :null,              Types::Nil.optional
  attribute :quebrachine_class, QuebrachineClass.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, quebrachine_class: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, quebrachine_class: nil, integer: nil)
    end
    begin
      value = QuebrachineClass.from_dynamic!(d)
      if schema.key(:quebrachine_class).type.right.valid? value
        return new(quebrachine_class: value, integer: nil, null: nil)
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
    elsif quebrachine_class != nil
      quebrachine_class.to_dynamic
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unreceptivity < Dry::Struct
  attribute :integer,    Types::Integer.optional
  attribute :null_array, Types.Array(Types::Nil).optional
  attribute :string,     Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null_array: nil, string: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, null_array: nil, integer: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unsatisfactoriness < Dry::Struct
  attribute :bool,          Types::Bool.optional
  attribute :integer,       Types::Integer.optional
  attribute :integer_array, Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil, integer: nil)
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil, bool: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil, integer: nil)
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
    elsif integer_array != nil
      integer_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnstressedClass < Dry::Struct
  attribute :alain,           Types::Nil
  attribute :amphirhina,      Types::Nil
  attribute :antimachinery,   Types::Nil
  attribute :coldish,         Types::Nil
  attribute :crantara,        Types::Nil
  attribute :distinguishing,  Types::Nil
  attribute :elytroposis,     Types::Nil
  attribute :gentianwort,     Types::Nil
  attribute :heliosis,        Types::Nil
  attribute :instrumental,    Types::Nil
  attribute :introinflection, Types::Nil
  attribute :kala,            Types::Nil
  attribute :lincolnian,      Types::Nil
  attribute :metad,           Types::Nil
  attribute :sarcophilus,     Types::Nil
  attribute :swingingly,      Types::Nil
  attribute :unconformity,    Types::Nil
  attribute :undecreed,       Types::Nil
  attribute :venerable,       Types::Nil
  attribute :vowellessness,   Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      alain:           d.fetch("Alain"),
      amphirhina:      d.fetch("Amphirhina"),
      antimachinery:   d.fetch("antimachinery"),
      coldish:         d.fetch("coldish"),
      crantara:        d.fetch("crantara"),
      distinguishing:  d.fetch("distinguishing"),
      elytroposis:     d.fetch("elytroposis"),
      gentianwort:     d.fetch("gentianwort"),
      heliosis:        d.fetch("heliosis"),
      instrumental:    d.fetch("instrumental"),
      introinflection: d.fetch("introinflection"),
      kala:            d.fetch("kala"),
      lincolnian:      d.fetch("Lincolnian"),
      metad:           d.fetch("metad"),
      sarcophilus:     d.fetch("Sarcophilus"),
      swingingly:      d.fetch("swingingly"),
      unconformity:    d.fetch("unconformity"),
      undecreed:       d.fetch("undecreed"),
      venerable:       d.fetch("venerable"),
      vowellessness:   d.fetch("vowellessness"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Alain"           => alain,
      "Amphirhina"      => amphirhina,
      "antimachinery"   => antimachinery,
      "coldish"         => coldish,
      "crantara"        => crantara,
      "distinguishing"  => distinguishing,
      "elytroposis"     => elytroposis,
      "gentianwort"     => gentianwort,
      "heliosis"        => heliosis,
      "instrumental"    => instrumental,
      "introinflection" => introinflection,
      "kala"            => kala,
      "Lincolnian"      => lincolnian,
      "metad"           => metad,
      "Sarcophilus"     => sarcophilus,
      "swingingly"      => swingingly,
      "unconformity"    => unconformity,
      "undecreed"       => undecreed,
      "venerable"       => venerable,
      "vowellessness"   => vowellessness,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class UnstressedElement < Dry::Struct
  attribute :bool,             Types::Bool.optional
  attribute :string,           Types::String.optional
  attribute :unstressed_class, UnstressedClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, unstressed_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, unstressed_class: nil)
    end
    begin
      value = UnstressedClass.from_dynamic!(d)
      if schema.key(:unstressed_class).type.right.valid? value
        return new(unstressed_class: value, bool: nil, string: nil)
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
    elsif string != nil
      string
    elsif unstressed_class != nil
      unstressed_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Untasked < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null_array,  Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_array: nil, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, null_array: nil, double: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, double: nil, integer_map: nil)
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
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Unvarying < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :double,      Types::Double.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, double: nil, integer_map: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, integer_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, bool: nil, double: nil)
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
    elsif double != nil
      double
    elsif integer_map != nil
      integer_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Vehemently < Dry::Struct
  attribute :bool,       Types::Bool.optional
  attribute :null,       Types::Nil.optional
  attribute :null_array, Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null_array: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, null_array: nil, bool: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, bool: nil, null: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Whitepot < Dry::Struct
  attribute :double,            Types::Double.optional
  attribute :quebrachine_class, QuebrachineClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, quebrachine_class: nil)
    end
    begin
      value = QuebrachineClass.from_dynamic!(d)
      if schema.key(:quebrachine_class).type.right.valid? value
        return new(quebrachine_class: value, double: nil)
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
    elsif quebrachine_class != nil
      quebrachine_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class WrothyClass < Dry::Struct
  attribute :aeschynanthus,    Types::Nil
  attribute :aquiferous,       Types::Nil
  attribute :cheapener,        Types::Nil
  attribute :enumeration,      Types::Nil
  attribute :ephesine,         Types::Nil
  attribute :escadrille,       Types::Nil
  attribute :estrous,          Types::Nil
  attribute :interestedly,     Types::Nil
  attribute :katakinetomer,    Types::Nil
  attribute :mortification,    Types::Nil
  attribute :morula,           Types::Nil
  attribute :orthosymmetrical, Types::Nil
  attribute :overbark,         Types::Nil
  attribute :politist,         Types::Nil
  attribute :qualified,        Types::Nil
  attribute :sphenomalar,      Types::Nil
  attribute :throatful,        Types::Nil
  attribute :transhumance,     Types::Nil
  attribute :triandrian,       Types::Nil
  attribute :unbooked,         Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      aeschynanthus:    d.fetch("Aeschynanthus"),
      aquiferous:       d.fetch("aquiferous"),
      cheapener:        d.fetch("cheapener"),
      enumeration:      d.fetch("enumeration"),
      ephesine:         d.fetch("Ephesine"),
      escadrille:       d.fetch("escadrille"),
      estrous:          d.fetch("estrous"),
      interestedly:     d.fetch("interestedly"),
      katakinetomer:    d.fetch("katakinetomer"),
      mortification:    d.fetch("mortification"),
      morula:           d.fetch("morula"),
      orthosymmetrical: d.fetch("orthosymmetrical"),
      overbark:         d.fetch("overbark"),
      politist:         d.fetch("politist"),
      qualified:        d.fetch("qualified"),
      sphenomalar:      d.fetch("sphenomalar"),
      throatful:        d.fetch("throatful"),
      transhumance:     d.fetch("transhumance"),
      triandrian:       d.fetch("triandrian"),
      unbooked:         d.fetch("unbooked"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Aeschynanthus"    => aeschynanthus,
      "aquiferous"       => aquiferous,
      "cheapener"        => cheapener,
      "enumeration"      => enumeration,
      "Ephesine"         => ephesine,
      "escadrille"       => escadrille,
      "estrous"          => estrous,
      "interestedly"     => interestedly,
      "katakinetomer"    => katakinetomer,
      "mortification"    => mortification,
      "morula"           => morula,
      "orthosymmetrical" => orthosymmetrical,
      "overbark"         => overbark,
      "politist"         => politist,
      "qualified"        => qualified,
      "sphenomalar"      => sphenomalar,
      "throatful"        => throatful,
      "transhumance"     => transhumance,
      "triandrian"       => triandrian,
      "unbooked"         => unbooked,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class WrothyElement < Dry::Struct
  attribute :null_array,   Types.Array(Types::Nil).optional
  attribute :wrothy_class, WrothyClass.optional

  def self.from_dynamic!(d)
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, wrothy_class: nil)
    end
    begin
      value = WrothyClass.from_dynamic!(d)
      if schema.key(:wrothy_class).type.right.valid? value
        return new(wrothy_class: value, null_array: nil)
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
    elsif wrothy_class != nil
      wrothy_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :protrusive,         Types.Array(Types.Instance(Protrusive))
  attribute :pulpitism,          Types.Array(Types.Instance(PulpitismElement))
  attribute :pyodermia,          Types.Array(Types.Instance(PyodermiaElement))
  attribute :quebrachine,        Types.Array(Types.Instance(QuebrachineElement))
  attribute :querier,            Types.Array(Types.Instance(Querier))
  attribute :rebarbative,        Types.Array(Types.Instance(Rebarbative))
  attribute :reimagine,          Types.Array(Reimagine)
  attribute :ressaut,            Ressaut
  attribute :retrocervical,      Types.Array(Types.Instance(Retrocervical))
  attribute :revert,             Types.Array(Types.Instance(Revert))
  attribute :rewrite,            Types.Array(Types.Instance(RewriteElement))
  attribute :saccoderm,          Types.Array(Types.Instance(Saccoderm))
  attribute :santir,             Types.Array(Types.Instance(SantirElement))
  attribute :saprophilous,       Types.Array(Types.Instance(Saprophilous))
  attribute :saxten,             Types.Array(Types.Instance(SaxtenElement))
  attribute :scatty,             Types.Array(Scatty.optional)
  attribute :scoffer,            Types.Array(Types.Instance(Scoffer))
  attribute :scrampum,           Types.Array(Types.Instance(Scrampum))
  attribute :semantic,           Types::Double
  attribute :serpentinic,        Types.Array(Types.Instance(Serpentinic))
  attribute :shadowable,         Types.Array(Types.Instance(Shadowable))
  attribute :sistering,          Types.Array(Types.Instance(SisteringElement))
  attribute :staghunting,        Types.Array(Staghunting)
  attribute :stagmometer,        Types.Array(Types.Instance(Stagmometer))
  attribute :stimulability,      Types.Array(Types.Instance(Stimulability))
  attribute :strangleable,       Types.Array(Types.Instance(Strangleable))
  attribute :strenuosity,        Types.Array(Types.Instance(StrenuosityElement))
  attribute :tabaxir,            Types.Array(Types.Instance(Tabaxir))
  attribute :talpiform,          Types.Array(Types.Instance(Talpiform))
  attribute :thwack,             Types.Array(Types.Instance(Thwack))
  attribute :to,                 Types.Array(Types::Double.optional)
  attribute :tortricine,         Types.Array(Types.Instance(Tortricine))
  attribute :truantcy,           Types.Array(Types.Instance(TruantcyElement))
  attribute :turgesce,           Types.Array(Types::String)
  attribute :unbeginning,        Types.Array(Types.Instance(Unbeginning))
  attribute :underdunged,        Types.Array(Types::Double)
  attribute :undesirability,     Types.Array(Types.Instance(Undesirability))
  attribute :unerasing,          Types.Array(Types.Instance(Unerasing))
  attribute :unguentarium,       Types.Array(Types.Instance(Unguentarium))
  attribute :unimpeachably,      Types.Array(Types.Instance(UnimpeachablyElement))
  attribute :unmortgaged,        Types.Array(Types.Instance(Unmortgaged))
  attribute :unobstructed,       Types.Array(Types.Instance(Unobstructed))
  attribute :unreceptivity,      Types.Array(Types.Instance(Unreceptivity))
  attribute :unsatisfactoriness, Types.Array(Types.Instance(Unsatisfactoriness))
  attribute :unsecurity,         Types.Array(Types::Integer)
  attribute :unstressed,         Types.Array(Types.Instance(UnstressedElement))
  attribute :untasked,           Types.Array(Types.Instance(Untasked))
  attribute :unvarying,          Types.Array(Types.Instance(Unvarying))
  attribute :vehemently,         Types.Array(Types.Instance(Vehemently))
  attribute :warriorship,        Types::Hash.meta(of: Types::Bool)
  attribute :whitepot,           Types.Array(Types.Instance(Whitepot))
  attribute :wrothy,             Types.Array(Types.Instance(WrothyElement))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      protrusive:         d.fetch("protrusive").map { |x| Protrusive.from_dynamic!(x) },
      pulpitism:          d.fetch("pulpitism").map { |x| PulpitismElement.from_dynamic!(x) },
      pyodermia:          d.fetch("pyodermia").map { |x| PyodermiaElement.from_dynamic!(x) },
      quebrachine:        d.fetch("quebrachine").map { |x| QuebrachineElement.from_dynamic!(x) },
      querier:            d.fetch("querier").map { |x| Querier.from_dynamic!(x) },
      rebarbative:        d.fetch("rebarbative").map { |x| Rebarbative.from_dynamic!(x) },
      reimagine:          d.fetch("reimagine").map { |x| Reimagine.from_dynamic!(x) },
      ressaut:            Ressaut.from_dynamic!(d.fetch("ressaut")),
      retrocervical:      d.fetch("retrocervical").map { |x| Retrocervical.from_dynamic!(x) },
      revert:             d.fetch("revert").map { |x| Revert.from_dynamic!(x) },
      rewrite:            d.fetch("rewrite").map { |x| RewriteElement.from_dynamic!(x) },
      saccoderm:          d.fetch("saccoderm").map { |x| Saccoderm.from_dynamic!(x) },
      santir:             d.fetch("santir").map { |x| SantirElement.from_dynamic!(x) },
      saprophilous:       d.fetch("saprophilous").map { |x| Saprophilous.from_dynamic!(x) },
      saxten:             d.fetch("saxten").map { |x| SaxtenElement.from_dynamic!(x) },
      scatty:             d.fetch("scatty").map { |x| x ? Scatty.from_dynamic!(x) : nil },
      scoffer:            d.fetch("scoffer").map { |x| Scoffer.from_dynamic!(x) },
      scrampum:           d.fetch("scrampum").map { |x| Scrampum.from_dynamic!(x) },
      semantic:           d.fetch("semantic"),
      serpentinic:        d.fetch("serpentinic").map { |x| Serpentinic.from_dynamic!(x) },
      shadowable:         d.fetch("shadowable").map { |x| Shadowable.from_dynamic!(x) },
      sistering:          d.fetch("sistering").map { |x| SisteringElement.from_dynamic!(x) },
      staghunting:        d.fetch("staghunting").map { |x| Staghunting.from_dynamic!(x) },
      stagmometer:        d.fetch("stagmometer").map { |x| Stagmometer.from_dynamic!(x) },
      stimulability:      d.fetch("stimulability").map { |x| Stimulability.from_dynamic!(x) },
      strangleable:       d.fetch("strangleable").map { |x| Strangleable.from_dynamic!(x) },
      strenuosity:        d.fetch("strenuosity").map { |x| StrenuosityElement.from_dynamic!(x) },
      tabaxir:            d.fetch("tabaxir").map { |x| Tabaxir.from_dynamic!(x) },
      talpiform:          d.fetch("talpiform").map { |x| Talpiform.from_dynamic!(x) },
      thwack:             d.fetch("thwack").map { |x| Thwack.from_dynamic!(x) },
      to:                 d.fetch("to"),
      tortricine:         d.fetch("tortricine").map { |x| Tortricine.from_dynamic!(x) },
      truantcy:           d.fetch("truantcy").map { |x| TruantcyElement.from_dynamic!(x) },
      turgesce:           d.fetch("turgesce"),
      unbeginning:        d.fetch("unbeginning").map { |x| Unbeginning.from_dynamic!(x) },
      underdunged:        d.fetch("underdunged"),
      undesirability:     d.fetch("undesirability").map { |x| Undesirability.from_dynamic!(x) },
      unerasing:          d.fetch("unerasing").map { |x| Unerasing.from_dynamic!(x) },
      unguentarium:       d.fetch("unguentarium").map { |x| Unguentarium.from_dynamic!(x) },
      unimpeachably:      d.fetch("unimpeachably").map { |x| UnimpeachablyElement.from_dynamic!(x) },
      unmortgaged:        d.fetch("unmortgaged").map { |x| Unmortgaged.from_dynamic!(x) },
      unobstructed:       d.fetch("unobstructed").map { |x| Unobstructed.from_dynamic!(x) },
      unreceptivity:      d.fetch("unreceptivity").map { |x| Unreceptivity.from_dynamic!(x) },
      unsatisfactoriness: d.fetch("unsatisfactoriness").map { |x| Unsatisfactoriness.from_dynamic!(x) },
      unsecurity:         d.fetch("unsecurity"),
      unstressed:         d.fetch("unstressed").map { |x| UnstressedElement.from_dynamic!(x) },
      untasked:           d.fetch("untasked").map { |x| Untasked.from_dynamic!(x) },
      unvarying:          d.fetch("unvarying").map { |x| Unvarying.from_dynamic!(x) },
      vehemently:         d.fetch("vehemently").map { |x| Vehemently.from_dynamic!(x) },
      warriorship:        Types::Hash[d.fetch("warriorship")].map { |k, v| [k, Types::Bool[v]] }.to_h,
      whitepot:           d.fetch("whitepot").map { |x| Whitepot.from_dynamic!(x) },
      wrothy:             d.fetch("wrothy").map { |x| WrothyElement.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "protrusive"         => protrusive.map { |x| x.to_dynamic },
      "pulpitism"          => pulpitism.map { |x| x.to_dynamic },
      "pyodermia"          => pyodermia.map { |x| x.to_dynamic },
      "quebrachine"        => quebrachine.map { |x| x.to_dynamic },
      "querier"            => querier.map { |x| x.to_dynamic },
      "rebarbative"        => rebarbative.map { |x| x.to_dynamic },
      "reimagine"          => reimagine.map { |x| x.to_dynamic },
      "ressaut"            => ressaut.to_dynamic,
      "retrocervical"      => retrocervical.map { |x| x.to_dynamic },
      "revert"             => revert.map { |x| x.to_dynamic },
      "rewrite"            => rewrite.map { |x| x.to_dynamic },
      "saccoderm"          => saccoderm.map { |x| x.to_dynamic },
      "santir"             => santir.map { |x| x.to_dynamic },
      "saprophilous"       => saprophilous.map { |x| x.to_dynamic },
      "saxten"             => saxten.map { |x| x.to_dynamic },
      "scatty"             => scatty.map { |x| x&.to_dynamic },
      "scoffer"            => scoffer.map { |x| x.to_dynamic },
      "scrampum"           => scrampum.map { |x| x.to_dynamic },
      "semantic"           => semantic,
      "serpentinic"        => serpentinic.map { |x| x.to_dynamic },
      "shadowable"         => shadowable.map { |x| x.to_dynamic },
      "sistering"          => sistering.map { |x| x.to_dynamic },
      "staghunting"        => staghunting.map { |x| x.to_dynamic },
      "stagmometer"        => stagmometer.map { |x| x.to_dynamic },
      "stimulability"      => stimulability.map { |x| x.to_dynamic },
      "strangleable"       => strangleable.map { |x| x.to_dynamic },
      "strenuosity"        => strenuosity.map { |x| x.to_dynamic },
      "tabaxir"            => tabaxir.map { |x| x.to_dynamic },
      "talpiform"          => talpiform.map { |x| x.to_dynamic },
      "thwack"             => thwack.map { |x| x.to_dynamic },
      "to"                 => to,
      "tortricine"         => tortricine.map { |x| x.to_dynamic },
      "truantcy"           => truantcy.map { |x| x.to_dynamic },
      "turgesce"           => turgesce,
      "unbeginning"        => unbeginning.map { |x| x.to_dynamic },
      "underdunged"        => underdunged,
      "undesirability"     => undesirability.map { |x| x.to_dynamic },
      "unerasing"          => unerasing.map { |x| x.to_dynamic },
      "unguentarium"       => unguentarium.map { |x| x.to_dynamic },
      "unimpeachably"      => unimpeachably.map { |x| x.to_dynamic },
      "unmortgaged"        => unmortgaged.map { |x| x.to_dynamic },
      "unobstructed"       => unobstructed.map { |x| x.to_dynamic },
      "unreceptivity"      => unreceptivity.map { |x| x.to_dynamic },
      "unsatisfactoriness" => unsatisfactoriness.map { |x| x.to_dynamic },
      "unsecurity"         => unsecurity,
      "unstressed"         => unstressed.map { |x| x.to_dynamic },
      "untasked"           => untasked.map { |x| x.to_dynamic },
      "unvarying"          => unvarying.map { |x| x.to_dynamic },
      "vehemently"         => vehemently.map { |x| x.to_dynamic },
      "warriorship"        => warriorship,
      "whitepot"           => whitepot.map { |x| x.to_dynamic },
      "wrothy"             => wrothy.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
