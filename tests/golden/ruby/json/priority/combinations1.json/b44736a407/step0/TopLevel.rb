# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   top_level = TopLevel.from_json! "{…}"
#   puts top_level.top_level_constructor.first
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

class CerographClass < Dry::Struct
  attribute :apotropaion,        Types::Nil
  attribute :casuary,            Types::Nil
  attribute :creaker,            Types::Nil
  attribute :disqualification,   Types::Nil
  attribute :imperatorious,      Types::Nil
  attribute :impermeabilize,     Types::Nil
  attribute :metastoma,          Types::Nil
  attribute :noctidiurnal,       Types::Nil
  attribute :nonreserve,         Types::Nil
  attribute :ophthalmotonometry, Types::Nil
  attribute :pailful,            Types::Nil
  attribute :pigfish,            Types::Nil
  attribute :pongee,             Types::Nil
  attribute :prosodical,         Types::Nil
  attribute :scrofuloderm,       Types::Nil
  attribute :storekeeping,       Types::Nil
  attribute :therologist,        Types::Nil
  attribute :tolowa,             Types::Nil
  attribute :tradeful,           Types::Nil
  attribute :unriveting,         Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      apotropaion:        d.fetch("apotropaion"),
      casuary:            d.fetch("casuary"),
      creaker:            d.fetch("creaker"),
      disqualification:   d.fetch("disqualification"),
      imperatorious:      d.fetch("imperatorious"),
      impermeabilize:     d.fetch("impermeabilize"),
      metastoma:          d.fetch("metastoma"),
      noctidiurnal:       d.fetch("noctidiurnal"),
      nonreserve:         d.fetch("nonreserve"),
      ophthalmotonometry: d.fetch("ophthalmotonometry"),
      pailful:            d.fetch("pailful"),
      pigfish:            d.fetch("pigfish"),
      pongee:             d.fetch("pongee"),
      prosodical:         d.fetch("prosodical"),
      scrofuloderm:       d.fetch("scrofuloderm"),
      storekeeping:       d.fetch("storekeeping"),
      therologist:        d.fetch("therologist"),
      tolowa:             d.fetch("Tolowa"),
      tradeful:           d.fetch("tradeful"),
      unriveting:         d.fetch("unriveting"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "apotropaion"        => apotropaion,
      "casuary"            => casuary,
      "creaker"            => creaker,
      "disqualification"   => disqualification,
      "imperatorious"      => imperatorious,
      "impermeabilize"     => impermeabilize,
      "metastoma"          => metastoma,
      "noctidiurnal"       => noctidiurnal,
      "nonreserve"         => nonreserve,
      "ophthalmotonometry" => ophthalmotonometry,
      "pailful"            => pailful,
      "pigfish"            => pigfish,
      "pongee"             => pongee,
      "prosodical"         => prosodical,
      "scrofuloderm"       => scrofuloderm,
      "storekeeping"       => storekeeping,
      "therologist"        => therologist,
      "Tolowa"             => tolowa,
      "tradeful"           => tradeful,
      "unriveting"         => unriveting,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CerographElement < Dry::Struct
  attribute :cerograph_class, CerographClass.optional
  attribute :null,            Types::Nil.optional
  attribute :string,          Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = CerographClass.from_dynamic!(d)
      if schema.key(:cerograph_class).type.right.valid? value
        return new(cerograph_class: value, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, cerograph_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, cerograph_class: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cerograph_class != nil
      cerograph_class.to_dynamic
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

class ChemotherapeuticClass < Dry::Struct
  attribute :angioneurotic,     Types::Nil.optional
  attribute :availment,         Types::Nil.optional
  attribute :bladelet,          Types::Nil.optional
  attribute :catharticalness,   Types::Double.optional
  attribute :caulis,            Types::Nil.optional
  attribute :chalcus,           Types::Nil.optional
  attribute :chirotherium,      Types::Integer.optional
  attribute :disdiapason,       Types::String.optional
  attribute :enteradenological, Types::Nil.optional
  attribute :homocerc,          Types::Bool.optional
  attribute :imporosity,        Types::Nil.optional
  attribute :insistently,       Types::Nil.optional
  attribute :intraparietal,     Types::Nil.optional
  attribute :ivied,             Types::Nil.optional
  attribute :maureen,           Types::Nil.optional
  attribute :nonbookish,        Types::Nil.optional
  attribute :nostochine,        Types::Nil.optional
  attribute :nutcracker,        Types::Nil.optional
  attribute :ofttimes,          Types::Nil.optional
  attribute :phenocryst,        Types::Nil.optional
  attribute :precoincident,     Types::Nil.optional
  attribute :ramiferous,        Types::Nil.optional
  attribute :stagmometer,       Types::Nil.optional
  attribute :tetherball,        Types::Nil.optional
  attribute :unshy,             Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      angioneurotic:     d["angioneurotic"],
      availment:         d["availment"],
      bladelet:          d["bladelet"],
      catharticalness:   d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      caulis:            d["caulis"],
      chalcus:           d["chalcus"],
      chirotherium:      d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      disdiapason:       d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      enteradenological: d["enteradenological"],
      homocerc:          d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      imporosity:        d["imporosity"],
      insistently:       d["insistently"],
      intraparietal:     d["intraparietal"],
      ivied:             d["ivied"],
      maureen:           d["Maureen"],
      nonbookish:        d["nonbookish"],
      nostochine:        d["nostochine"],
      nutcracker:        d["nutcracker"],
      ofttimes:          d["ofttimes"],
      phenocryst:        d["phenocryst"],
      precoincident:     d["precoincident"],
      ramiferous:        d["ramiferous"],
      stagmometer:       d["stagmometer"],
      tetherball:        d["tetherball"],
      unshy:             d["unshy"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "angioneurotic"     => angioneurotic,
      "availment"         => availment,
      "bladelet"          => bladelet,
      "catharticalness"   => catharticalness,
      "caulis"            => caulis,
      "chalcus"           => chalcus,
      "Chirotherium"      => chirotherium,
      "disdiapason"       => disdiapason,
      "enteradenological" => enteradenological,
      "homocerc"          => homocerc,
      "imporosity"        => imporosity,
      "insistently"       => insistently,
      "intraparietal"     => intraparietal,
      "ivied"             => ivied,
      "Maureen"           => maureen,
      "nonbookish"        => nonbookish,
      "nostochine"        => nostochine,
      "nutcracker"        => nutcracker,
      "ofttimes"          => ofttimes,
      "phenocryst"        => phenocryst,
      "precoincident"     => precoincident,
      "ramiferous"        => ramiferous,
      "stagmometer"       => stagmometer,
      "tetherball"        => tetherball,
      "unshy"             => unshy,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ChemotherapeuticElement < Dry::Struct
  attribute :chemotherapeutic_class, ChemotherapeuticClass.optional
  attribute :integer,                Types::Integer.optional

  def self.from_dynamic!(d)
    begin
      value = ChemotherapeuticClass.from_dynamic!(d)
      if schema.key(:chemotherapeutic_class).type.right.valid? value
        return new(chemotherapeutic_class: value, integer: nil)
      end
    rescue
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, chemotherapeutic_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if chemotherapeutic_class != nil
      chemotherapeutic_class.to_dynamic
    elsif integer != nil
      integer
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CimeliaClass < Dry::Struct
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

class CimeliaElement < Dry::Struct
  attribute :cimelia_class, CimeliaClass.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :null,          Types::Nil.optional

  def self.from_dynamic!(d)
    begin
      value = CimeliaClass.from_dynamic!(d)
      if schema.key(:cimelia_class).type.right.valid? value
        return new(cimelia_class: value, integer_array: nil, null: nil)
      end
    rescue
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, cimelia_class: nil, null: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer_array: nil, cimelia_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cimelia_class != nil
      cimelia_class.to_dynamic
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

class Clinodome < Dry::Struct
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

class CoadjustClass < Dry::Struct
  attribute :amidosulphonal,   Types::Nil.optional
  attribute :benny,            Types::Nil.optional
  attribute :catharticalness,  Types::Double.optional
  attribute :chirotherium,     Types::Integer.optional
  attribute :disdiapason,      Types::String.optional
  attribute :ensnare,          Types::Nil.optional
  attribute :homocerc,         Types::Bool.optional
  attribute :hybridizer,       Types::Nil.optional
  attribute :leastwise,        Types::Nil.optional
  attribute :lof,              Types::Nil.optional
  attribute :monkhood,         Types::Nil.optional
  attribute :netherlandish,    Types::Nil.optional
  attribute :nonbookish,       Types::Nil.optional
  attribute :peonism,          Types::Nil.optional
  attribute :phonelescope,     Types::Nil.optional
  attribute :porphyrogeniture, Types::Nil.optional
  attribute :preindemnify,     Types::Nil.optional
  attribute :rosal,            Types::Nil.optional
  attribute :scalenous,        Types::Nil.optional
  attribute :scopine,          Types::Nil.optional
  attribute :sedaceae,         Types::Nil.optional
  attribute :suberinize,       Types::Nil.optional
  attribute :symbiot,          Types::Nil.optional
  attribute :tablefellow,      Types::Nil.optional
  attribute :unchargeable,     Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      amidosulphonal:   d["amidosulphonal"],
      benny:            d["Benny"],
      catharticalness:  d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:     d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      disdiapason:      d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      ensnare:          d["ensnare"],
      homocerc:         d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      hybridizer:       d["hybridizer"],
      leastwise:        d["leastwise"],
      lof:              d["lof"],
      monkhood:         d["monkhood"],
      netherlandish:    d["Netherlandish"],
      nonbookish:       d["nonbookish"],
      peonism:          d["peonism"],
      phonelescope:     d["Phonelescope"],
      porphyrogeniture: d["porphyrogeniture"],
      preindemnify:     d["preindemnify"],
      rosal:            d["rosal"],
      scalenous:        d["scalenous"],
      scopine:          d["scopine"],
      sedaceae:         d["Sedaceae"],
      suberinize:       d["suberinize"],
      symbiot:          d["symbiot"],
      tablefellow:      d["tablefellow"],
      unchargeable:     d["unchargeable"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "amidosulphonal"   => amidosulphonal,
      "Benny"            => benny,
      "catharticalness"  => catharticalness,
      "Chirotherium"     => chirotherium,
      "disdiapason"      => disdiapason,
      "ensnare"          => ensnare,
      "homocerc"         => homocerc,
      "hybridizer"       => hybridizer,
      "leastwise"        => leastwise,
      "lof"              => lof,
      "monkhood"         => monkhood,
      "Netherlandish"    => netherlandish,
      "nonbookish"       => nonbookish,
      "peonism"          => peonism,
      "Phonelescope"     => phonelescope,
      "porphyrogeniture" => porphyrogeniture,
      "preindemnify"     => preindemnify,
      "rosal"            => rosal,
      "scalenous"        => scalenous,
      "scopine"          => scopine,
      "Sedaceae"         => sedaceae,
      "suberinize"       => suberinize,
      "symbiot"          => symbiot,
      "tablefellow"      => tablefellow,
      "unchargeable"     => unchargeable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CoadjustElement < Dry::Struct
  attribute :coadjust_class, CoadjustClass.optional
  attribute :double,         Types::Double.optional

  def self.from_dynamic!(d)
    begin
      value = CoadjustClass.from_dynamic!(d)
      if schema.key(:coadjust_class).type.right.valid? value
        return new(coadjust_class: value, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, coadjust_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if coadjust_class != nil
      coadjust_class.to_dynamic
    elsif double != nil
      double
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Consilience < Dry::Struct
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

class Continuative < Dry::Struct
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :string,      Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_map: nil)
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
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CredulityClass < Dry::Struct
  attribute :ammonolytic,          Types::Nil
  attribute :bushmaster,           Types::Nil
  attribute :considering,          Types::Nil
  attribute :consuetudinary,       Types::Nil
  attribute :embarras,             Types::Nil
  attribute :fineness,             Types::Nil
  attribute :flaithship,           Types::Nil
  attribute :flavia,               Types::Nil
  attribute :gruffly,              Types::Nil
  attribute :hedychium,            Types::Nil
  attribute :leadwort,             Types::Nil
  attribute :overseriously,        Types::Nil
  attribute :parabola,             Types::Nil
  attribute :pectinatodenticulate, Types::Nil
  attribute :popean,               Types::Nil
  attribute :pornocrat,            Types::Nil
  attribute :quadrisect,           Types::Nil
  attribute :seriality,            Types::Nil
  attribute :vamphorn,             Types::Nil
  attribute :wharp,                Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      ammonolytic:          d.fetch("ammonolytic"),
      bushmaster:           d.fetch("bushmaster"),
      considering:          d.fetch("considering"),
      consuetudinary:       d.fetch("consuetudinary"),
      embarras:             d.fetch("embarras"),
      fineness:             d.fetch("fineness"),
      flaithship:           d.fetch("flaithship"),
      flavia:               d.fetch("Flavia"),
      gruffly:              d.fetch("gruffly"),
      hedychium:            d.fetch("Hedychium"),
      leadwort:             d.fetch("leadwort"),
      overseriously:        d.fetch("overseriously"),
      parabola:             d.fetch("parabola"),
      pectinatodenticulate: d.fetch("pectinatodenticulate"),
      popean:               d.fetch("Popean"),
      pornocrat:            d.fetch("pornocrat"),
      quadrisect:           d.fetch("quadrisect"),
      seriality:            d.fetch("seriality"),
      vamphorn:             d.fetch("vamphorn"),
      wharp:                d.fetch("wharp"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "ammonolytic"          => ammonolytic,
      "bushmaster"           => bushmaster,
      "considering"          => considering,
      "consuetudinary"       => consuetudinary,
      "embarras"             => embarras,
      "fineness"             => fineness,
      "flaithship"           => flaithship,
      "Flavia"               => flavia,
      "gruffly"              => gruffly,
      "Hedychium"            => hedychium,
      "leadwort"             => leadwort,
      "overseriously"        => overseriously,
      "parabola"             => parabola,
      "pectinatodenticulate" => pectinatodenticulate,
      "Popean"               => popean,
      "pornocrat"            => pornocrat,
      "quadrisect"           => quadrisect,
      "seriality"            => seriality,
      "vamphorn"             => vamphorn,
      "wharp"                => wharp,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class CredulityElement < Dry::Struct
  attribute :credulity_class, CredulityClass.optional
  attribute :integer,         Types::Integer.optional
  attribute :string,          Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = CredulityClass.from_dynamic!(d)
      if schema.key(:credulity_class).type.right.valid? value
        return new(credulity_class: value, integer: nil, string: nil)
      end
    rescue
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, credulity_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, credulity_class: nil, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if credulity_class != nil
      credulity_class.to_dynamic
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

class Creviced < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :string,      Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_map: nil, string: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, bool: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, integer_map: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DeruralizeClass < Dry::Struct
  attribute :bockerel,       Types::Nil
  attribute :boulder,        Types::Nil
  attribute :churrus,        Types::Nil
  attribute :counterdigged,  Types::Nil
  attribute :dialogite,      Types::Nil
  attribute :digenic,        Types::Nil
  attribute :dunbird,        Types::Nil
  attribute :ergatogyne,     Types::Nil
  attribute :fiendful,       Types::Nil
  attribute :jackrod,        Types::Nil
  attribute :jehovistic,     Types::Nil
  attribute :paninean,       Types::Nil
  attribute :panther,        Types::Nil
  attribute :placentigerous, Types::Nil
  attribute :romney,         Types::Nil
  attribute :sparm,          Types::Nil
  attribute :tocsin,         Types::Nil
  attribute :unnicked,       Types::Nil
  attribute :unstavable,     Types::Nil
  attribute :windfirm,       Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      bockerel:       d.fetch("bockerel"),
      boulder:        d.fetch("boulder"),
      churrus:        d.fetch("churrus"),
      counterdigged:  d.fetch("counterdigged"),
      dialogite:      d.fetch("dialogite"),
      digenic:        d.fetch("digenic"),
      dunbird:        d.fetch("dunbird"),
      ergatogyne:     d.fetch("ergatogyne"),
      fiendful:       d.fetch("fiendful"),
      jackrod:        d.fetch("jackrod"),
      jehovistic:     d.fetch("Jehovistic"),
      paninean:       d.fetch("Paninean"),
      panther:        d.fetch("panther"),
      placentigerous: d.fetch("placentigerous"),
      romney:         d.fetch("Romney"),
      sparm:          d.fetch("sparm"),
      tocsin:         d.fetch("tocsin"),
      unnicked:       d.fetch("unnicked"),
      unstavable:     d.fetch("unstavable"),
      windfirm:       d.fetch("windfirm"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "bockerel"       => bockerel,
      "boulder"        => boulder,
      "churrus"        => churrus,
      "counterdigged"  => counterdigged,
      "dialogite"      => dialogite,
      "digenic"        => digenic,
      "dunbird"        => dunbird,
      "ergatogyne"     => ergatogyne,
      "fiendful"       => fiendful,
      "jackrod"        => jackrod,
      "Jehovistic"     => jehovistic,
      "Paninean"       => paninean,
      "panther"        => panther,
      "placentigerous" => placentigerous,
      "Romney"         => romney,
      "sparm"          => sparm,
      "tocsin"         => tocsin,
      "unnicked"       => unnicked,
      "unstavable"     => unstavable,
      "windfirm"       => windfirm,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DeruralizeElement < Dry::Struct
  attribute :bool,             Types::Bool.optional
  attribute :deruralize_class, DeruralizeClass.optional
  attribute :null_array,       Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null_array: nil, deruralize_class: nil)
    end
    begin
      value = DeruralizeClass.from_dynamic!(d)
      if schema.key(:deruralize_class).type.right.valid? value
        return new(deruralize_class: value, null_array: nil, bool: nil)
      end
    rescue
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, bool: nil, deruralize_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif deruralize_class != nil
      deruralize_class.to_dynamic
    elsif null_array != nil
      null_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DiaereseClass < Dry::Struct
  attribute :amoreuxia,         Types::Nil
  attribute :ani,               Types::Nil
  attribute :bernicle,          Types::Nil
  attribute :blackwasher,       Types::Nil
  attribute :blowhard,          Types::Nil
  attribute :broma,             Types::Nil
  attribute :closecross,        Types::Nil
  attribute :congregationalism, Types::Nil
  attribute :grayly,            Types::Nil
  attribute :historically,      Types::Nil
  attribute :hoast,             Types::Nil
  attribute :irretentive,       Types::Nil
  attribute :parcener,          Types::Nil
  attribute :pedder,            Types::Nil
  attribute :pseudoanatomic,    Types::Nil
  attribute :rhizocarpian,      Types::Nil
  attribute :samel,             Types::Nil
  attribute :silker,            Types::Nil
  attribute :subdentated,       Types::Nil
  attribute :subobscure,        Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      amoreuxia:         d.fetch("Amoreuxia"),
      ani:               d.fetch("ani"),
      bernicle:          d.fetch("bernicle"),
      blackwasher:       d.fetch("blackwasher"),
      blowhard:          d.fetch("blowhard"),
      broma:             d.fetch("broma"),
      closecross:        d.fetch("closecross"),
      congregationalism: d.fetch("congregationalism"),
      grayly:            d.fetch("grayly"),
      historically:      d.fetch("historically"),
      hoast:             d.fetch("hoast"),
      irretentive:       d.fetch("irretentive"),
      parcener:          d.fetch("parcener"),
      pedder:            d.fetch("pedder"),
      pseudoanatomic:    d.fetch("pseudoanatomic"),
      rhizocarpian:      d.fetch("rhizocarpian"),
      samel:             d.fetch("samel"),
      silker:            d.fetch("silker"),
      subdentated:       d.fetch("subdentated"),
      subobscure:        d.fetch("subobscure"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "Amoreuxia"         => amoreuxia,
      "ani"               => ani,
      "bernicle"          => bernicle,
      "blackwasher"       => blackwasher,
      "blowhard"          => blowhard,
      "broma"             => broma,
      "closecross"        => closecross,
      "congregationalism" => congregationalism,
      "grayly"            => grayly,
      "historically"      => historically,
      "hoast"             => hoast,
      "irretentive"       => irretentive,
      "parcener"          => parcener,
      "pedder"            => pedder,
      "pseudoanatomic"    => pseudoanatomic,
      "rhizocarpian"      => rhizocarpian,
      "samel"             => samel,
      "silker"            => silker,
      "subdentated"       => subdentated,
      "subobscure"        => subobscure,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class DiaereseElement < Dry::Struct
  attribute :bool,           Types::Bool.optional
  attribute :diaerese_class, DiaereseClass.optional
  attribute :integer_array,  Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil, diaerese_class: nil)
    end
    begin
      value = DiaereseClass.from_dynamic!(d)
      if schema.key(:diaerese_class).type.right.valid? value
        return new(diaerese_class: value, integer_array: nil, bool: nil)
      end
    rescue
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil, diaerese_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if bool != nil
      bool
    elsif diaerese_class != nil
      diaerese_class.to_dynamic
    elsif integer_array != nil
      integer_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Downstroke < Dry::Struct
  attribute :bool,       Types::Bool.optional
  attribute :null_array, Types.Array(Types::Nil).optional
  attribute :string,     Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null_array: nil, string: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, bool: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, null_array: nil, bool: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Eleutheromania < Dry::Struct
  attribute :double,      Types::Double.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :string,      Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, integer_map: nil, string: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, double: nil, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, double: nil, integer_map: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Encrust < Dry::Struct
  attribute :comradely,       Types::Nil
  attribute :diacanthous,     Types::Nil
  attribute :feminineness,    Types::Nil
  attribute :gossamered,      Types::Nil
  attribute :hibernia,        Types::Nil
  attribute :hibiscus,        Types::Nil
  attribute :lepidosauria,    Types::Nil
  attribute :lollingly,       Types::Nil
  attribute :manager,         Types::Nil
  attribute :mechanic,        Types::Nil
  attribute :overminuteness,  Types::Nil
  attribute :papelonne,       Types::Nil
  attribute :plebification,   Types::Nil
  attribute :pugmiller,       Types::Nil
  attribute :recoveror,       Types::Nil
  attribute :spermatoblastic, Types::Nil
  attribute :syllidae,        Types::Nil
  attribute :ungyved,         Types::Nil
  attribute :whirlabout,      Types::Nil
  attribute :woodenware,      Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      comradely:       d.fetch("comradely"),
      diacanthous:     d.fetch("diacanthous"),
      feminineness:    d.fetch("feminineness"),
      gossamered:      d.fetch("gossamered"),
      hibernia:        d.fetch("Hibernia"),
      hibiscus:        d.fetch("Hibiscus"),
      lepidosauria:    d.fetch("Lepidosauria"),
      lollingly:       d.fetch("lollingly"),
      manager:         d.fetch("manager"),
      mechanic:        d.fetch("mechanic"),
      overminuteness:  d.fetch("overminuteness"),
      papelonne:       d.fetch("papelonne"),
      plebification:   d.fetch("plebification"),
      pugmiller:       d.fetch("pugmiller"),
      recoveror:       d.fetch("recoveror"),
      spermatoblastic: d.fetch("spermatoblastic"),
      syllidae:        d.fetch("Syllidae"),
      ungyved:         d.fetch("ungyved"),
      whirlabout:      d.fetch("whirlabout"),
      woodenware:      d.fetch("woodenware"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "comradely"       => comradely,
      "diacanthous"     => diacanthous,
      "feminineness"    => feminineness,
      "gossamered"      => gossamered,
      "Hibernia"        => hibernia,
      "Hibiscus"        => hibiscus,
      "Lepidosauria"    => lepidosauria,
      "lollingly"       => lollingly,
      "manager"         => manager,
      "mechanic"        => mechanic,
      "overminuteness"  => overminuteness,
      "papelonne"       => papelonne,
      "plebification"   => plebification,
      "pugmiller"       => pugmiller,
      "recoveror"       => recoveror,
      "spermatoblastic" => spermatoblastic,
      "Syllidae"        => syllidae,
      "ungyved"         => ungyved,
      "whirlabout"      => whirlabout,
      "woodenware"      => woodenware,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Entomoid < Dry::Struct
  attribute :cimelia_class, CimeliaClass.optional
  attribute :integer,       Types::Integer.optional

  def self.from_dynamic!(d)
    begin
      value = CimeliaClass.from_dynamic!(d)
      if schema.key(:cimelia_class).type.right.valid? value
        return new(cimelia_class: value, integer: nil)
      end
    rescue
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, cimelia_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cimelia_class != nil
      cimelia_class.to_dynamic
    elsif integer != nil
      integer
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Epipaleolithic < Dry::Struct
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

class Expropriable < Dry::Struct
  attribute :cimelia_class, CimeliaClass.optional
  attribute :double,        Types::Double.optional
  attribute :null_array,    Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    begin
      value = CimeliaClass.from_dynamic!(d)
      if schema.key(:cimelia_class).type.right.valid? value
        return new(cimelia_class: value, null_array: nil, double: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, null_array: nil, cimelia_class: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, cimelia_class: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cimelia_class != nil
      cimelia_class.to_dynamic
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

class FagginglyClass < Dry::Struct
  attribute :abranchian,      Types::Nil
  attribute :aculeiform,      Types::Nil
  attribute :adiaphoristic,   Types::Nil
  attribute :adoptionism,     Types::Nil
  attribute :anglic,          Types::Nil
  attribute :antrotomy,       Types::Nil
  attribute :coerciveness,    Types::Nil
  attribute :decorist,        Types::Nil
  attribute :duckhood,        Types::Nil
  attribute :heteromeri,      Types::Nil
  attribute :hypochnose,      Types::Nil
  attribute :lochage,         Types::Nil
  attribute :melee,           Types::Nil
  attribute :nonconformitant, Types::Nil
  attribute :poinsettia,      Types::Nil
  attribute :putatively,      Types::Nil
  attribute :semivolatile,    Types::Nil
  attribute :soleas,          Types::Nil
  attribute :unfastenable,    Types::Nil
  attribute :unmillinered,    Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      abranchian:      d.fetch("abranchian"),
      aculeiform:      d.fetch("aculeiform"),
      adiaphoristic:   d.fetch("adiaphoristic"),
      adoptionism:     d.fetch("adoptionism"),
      anglic:          d.fetch("Anglic"),
      antrotomy:       d.fetch("antrotomy"),
      coerciveness:    d.fetch("coerciveness"),
      decorist:        d.fetch("decorist"),
      duckhood:        d.fetch("duckhood"),
      heteromeri:      d.fetch("Heteromeri"),
      hypochnose:      d.fetch("hypochnose"),
      lochage:         d.fetch("lochage"),
      melee:           d.fetch("melee"),
      nonconformitant: d.fetch("nonconformitant"),
      poinsettia:      d.fetch("Poinsettia"),
      putatively:      d.fetch("putatively"),
      semivolatile:    d.fetch("semivolatile"),
      soleas:          d.fetch("soleas"),
      unfastenable:    d.fetch("unfastenable"),
      unmillinered:    d.fetch("unmillinered"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "abranchian"      => abranchian,
      "aculeiform"      => aculeiform,
      "adiaphoristic"   => adiaphoristic,
      "adoptionism"     => adoptionism,
      "Anglic"          => anglic,
      "antrotomy"       => antrotomy,
      "coerciveness"    => coerciveness,
      "decorist"        => decorist,
      "duckhood"        => duckhood,
      "Heteromeri"      => heteromeri,
      "hypochnose"      => hypochnose,
      "lochage"         => lochage,
      "melee"           => melee,
      "nonconformitant" => nonconformitant,
      "Poinsettia"      => poinsettia,
      "putatively"      => putatively,
      "semivolatile"    => semivolatile,
      "soleas"          => soleas,
      "unfastenable"    => unfastenable,
      "unmillinered"    => unmillinered,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FagginglyElement < Dry::Struct
  attribute :double,          Types::Double.optional
  attribute :faggingly_class, FagginglyClass.optional

  def self.from_dynamic!(d)
    if schema.key(:double).type.right.valid? d
      return new(double: d, faggingly_class: nil)
    end
    begin
      value = FagginglyClass.from_dynamic!(d)
      if schema.key(:faggingly_class).type.right.valid? value
        return new(faggingly_class: value, double: nil)
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
    elsif faggingly_class != nil
      faggingly_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FenkClass < Dry::Struct
  attribute :apoise,        Types::Nil
  attribute :astronomize,   Types::Nil
  attribute :cockhorse,     Types::Nil
  attribute :copular,       Types::Nil
  attribute :dagomba,       Types::Nil
  attribute :draffy,        Types::Nil
  attribute :foreigner,     Types::Nil
  attribute :guyandot,      Types::Nil
  attribute :neurogliosis,  Types::Nil
  attribute :osmious,       Types::Nil
  attribute :palpitate,     Types::Nil
  attribute :rebukeable,    Types::Nil
  attribute :reinwardtia,   Types::Nil
  attribute :reservatory,   Types::Nil
  attribute :scalt,         Types::Nil
  attribute :scripturalize, Types::Nil
  attribute :tintometer,    Types::Nil
  attribute :tritoness,     Types::Nil
  attribute :undergrade,    Types::Nil
  attribute :undermountain, Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      apoise:        d.fetch("apoise"),
      astronomize:   d.fetch("astronomize"),
      cockhorse:     d.fetch("cockhorse"),
      copular:       d.fetch("copular"),
      dagomba:       d.fetch("Dagomba"),
      draffy:        d.fetch("draffy"),
      foreigner:     d.fetch("foreigner"),
      guyandot:      d.fetch("Guyandot"),
      neurogliosis:  d.fetch("neurogliosis"),
      osmious:       d.fetch("osmious"),
      palpitate:     d.fetch("palpitate"),
      rebukeable:    d.fetch("rebukeable"),
      reinwardtia:   d.fetch("Reinwardtia"),
      reservatory:   d.fetch("reservatory"),
      scalt:         d.fetch("scalt"),
      scripturalize: d.fetch("scripturalize"),
      tintometer:    d.fetch("tintometer"),
      tritoness:     d.fetch("Tritoness"),
      undergrade:    d.fetch("undergrade"),
      undermountain: d.fetch("undermountain"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "apoise"        => apoise,
      "astronomize"   => astronomize,
      "cockhorse"     => cockhorse,
      "copular"       => copular,
      "Dagomba"       => dagomba,
      "draffy"        => draffy,
      "foreigner"     => foreigner,
      "Guyandot"      => guyandot,
      "neurogliosis"  => neurogliosis,
      "osmious"       => osmious,
      "palpitate"     => palpitate,
      "rebukeable"    => rebukeable,
      "Reinwardtia"   => reinwardtia,
      "reservatory"   => reservatory,
      "scalt"         => scalt,
      "scripturalize" => scripturalize,
      "tintometer"    => tintometer,
      "Tritoness"     => tritoness,
      "undergrade"    => undergrade,
      "undermountain" => undermountain,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FenkElement < Dry::Struct
  attribute :fenk_class, FenkClass.optional
  attribute :string,     Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = FenkClass.from_dynamic!(d)
      if schema.key(:fenk_class).type.right.valid? value
        return new(fenk_class: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, fenk_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if fenk_class != nil
      fenk_class.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FlagmakingClass < Dry::Struct
  attribute :albarco,           Types::Nil
  attribute :bunodonta,         Types::Nil
  attribute :hornify,           Types::Nil
  attribute :hydrocorisae,      Types::Nil
  attribute :hypoglossus,       Types::Nil
  attribute :inexpiably,        Types::Nil
  attribute :ingratitude,       Types::Nil
  attribute :ladyfly,           Types::Nil
  attribute :medicament,        Types::Nil
  attribute :monogrammatic,     Types::Nil
  attribute :nobbut,            Types::Nil
  attribute :notacanthidae,     Types::Nil
  attribute :polyplacophore,    Types::Nil
  attribute :proexercise,       Types::Nil
  attribute :protoplast,        Types::Nil
  attribute :puzzling,          Types::Nil
  attribute :splanchnoskeleton, Types::Nil
  attribute :unloveliness,      Types::Nil
  attribute :unquarantined,     Types::Nil
  attribute :unrenounceable,    Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      albarco:           d.fetch("albarco"),
      bunodonta:         d.fetch("Bunodonta"),
      hornify:           d.fetch("hornify"),
      hydrocorisae:      d.fetch("Hydrocorisae"),
      hypoglossus:       d.fetch("hypoglossus"),
      inexpiably:        d.fetch("inexpiably"),
      ingratitude:       d.fetch("ingratitude"),
      ladyfly:           d.fetch("ladyfly"),
      medicament:        d.fetch("medicament"),
      monogrammatic:     d.fetch("monogrammatic"),
      nobbut:            d.fetch("nobbut"),
      notacanthidae:     d.fetch("Notacanthidae"),
      polyplacophore:    d.fetch("polyplacophore"),
      proexercise:       d.fetch("proexercise"),
      protoplast:        d.fetch("protoplast"),
      puzzling:          d.fetch("puzzling"),
      splanchnoskeleton: d.fetch("splanchnoskeleton"),
      unloveliness:      d.fetch("unloveliness"),
      unquarantined:     d.fetch("unquarantined"),
      unrenounceable:    d.fetch("unrenounceable"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "albarco"           => albarco,
      "Bunodonta"         => bunodonta,
      "hornify"           => hornify,
      "Hydrocorisae"      => hydrocorisae,
      "hypoglossus"       => hypoglossus,
      "inexpiably"        => inexpiably,
      "ingratitude"       => ingratitude,
      "ladyfly"           => ladyfly,
      "medicament"        => medicament,
      "monogrammatic"     => monogrammatic,
      "nobbut"            => nobbut,
      "Notacanthidae"     => notacanthidae,
      "polyplacophore"    => polyplacophore,
      "proexercise"       => proexercise,
      "protoplast"        => protoplast,
      "puzzling"          => puzzling,
      "splanchnoskeleton" => splanchnoskeleton,
      "unloveliness"      => unloveliness,
      "unquarantined"     => unquarantined,
      "unrenounceable"    => unrenounceable,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class FlagmakingElement < Dry::Struct
  attribute :bool,             Types::Bool.optional
  attribute :double,           Types::Double.optional
  attribute :flagmaking_class, FlagmakingClass.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, flagmaking_class: nil, double: nil)
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, bool: nil, flagmaking_class: nil)
    end
    begin
      value = FlagmakingClass.from_dynamic!(d)
      if schema.key(:flagmaking_class).type.right.valid? value
        return new(flagmaking_class: value, bool: nil, double: nil)
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
    elsif flagmaking_class != nil
      flagmaking_class.to_dynamic
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fluorometer < Dry::Struct
  attribute :integer, Types::Integer.optional
  attribute :null,    Types::Nil.optional
  attribute :string,  Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer: nil, null: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Fuzzy < Dry::Struct
  attribute :integer,   Types::Integer.optional
  attribute :union_map, Types::Hash.meta(of: Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, union_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, v] }.to_h
      if schema.key(:union_map).type.right.valid? value
        return new(union_map: value, integer: nil)
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
    elsif union_map != nil
      union_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Gardenward < Dry::Struct
  attribute :bool,          Types::Bool.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_array: nil, string: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, bool: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil, bool: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Generalissimo < Dry::Struct
  attribute :bool,        Types::Bool.optional
  attribute :integer_map, Types::Hash.meta(of: Types::Integer).optional
  attribute :null,        Types::Nil.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, integer_map: nil, null: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, Types::Integer[v]] }.to_h
      if schema.key(:integer_map).type.right.valid? value
        return new(integer_map: value, bool: nil, null: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, bool: nil, integer_map: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Hemicrystalline < Dry::Struct
  attribute :cimelia_class, CimeliaClass.optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = CimeliaClass.from_dynamic!(d)
      if schema.key(:cimelia_class).type.right.valid? value
        return new(cimelia_class: value, string: nil)
      end
    rescue
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, cimelia_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cimelia_class != nil
      cimelia_class.to_dynamic
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class HemocoeleClass < Dry::Struct
  attribute :acrogamy,          Types::Nil.optional
  attribute :amelification,     Types::Nil.optional
  attribute :autobiographic,    Types::Nil.optional
  attribute :berat,             Types::Nil.optional
  attribute :catharticalness,   Types::Double.optional
  attribute :chirotherium,      Types::Integer.optional
  attribute :disdiapason,       Types::String.optional
  attribute :disproportionably, Types::Nil.optional
  attribute :erythrite,         Types::Nil.optional
  attribute :graphic,           Types::Nil.optional
  attribute :hepatological,     Types::Nil.optional
  attribute :homocerc,          Types::Bool.optional
  attribute :incommensurably,   Types::Nil.optional
  attribute :misaffirm,         Types::Nil.optional
  attribute :nonbookish,        Types::Nil.optional
  attribute :pocketbook,        Types::Nil.optional
  attribute :sclerometric,      Types::Nil.optional
  attribute :stambouline,       Types::Nil.optional
  attribute :stickpin,          Types::Nil.optional
  attribute :tubulure,          Types::Nil.optional
  attribute :undelated,         Types::Nil.optional
  attribute :unsalt,            Types::Nil.optional
  attribute :untutelar,         Types::Nil.optional
  attribute :vagrant,           Types::Nil.optional
  attribute :walt,              Types::Nil.optional

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      acrogamy:          d["acrogamy"],
      amelification:     d["amelification"],
      autobiographic:    d["autobiographic"],
      berat:             d["berat"],
      catharticalness:   d.key?("catharticalness") ? Types::Double[d["catharticalness"]] : nil,
      chirotherium:      d.key?("Chirotherium") ? Types::Integer[d["Chirotherium"]] : nil,
      disdiapason:       d.key?("disdiapason") ? Types::String[d["disdiapason"]] : nil,
      disproportionably: d["disproportionably"],
      erythrite:         d["erythrite"],
      graphic:           d["graphic"],
      hepatological:     d["hepatological"],
      homocerc:          d.key?("homocerc") ? Types::Bool[d["homocerc"]] : nil,
      incommensurably:   d["incommensurably"],
      misaffirm:         d["misaffirm"],
      nonbookish:        d["nonbookish"],
      pocketbook:        d["pocketbook"],
      sclerometric:      d["sclerometric"],
      stambouline:       d["stambouline"],
      stickpin:          d["stickpin"],
      tubulure:          d["tubulure"],
      undelated:         d["undelated"],
      unsalt:            d["unsalt"],
      untutelar:         d["untutelar"],
      vagrant:           d["vagrant"],
      walt:              d["Walt"],
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "acrogamy"          => acrogamy,
      "amelification"     => amelification,
      "autobiographic"    => autobiographic,
      "berat"             => berat,
      "catharticalness"   => catharticalness,
      "Chirotherium"      => chirotherium,
      "disdiapason"       => disdiapason,
      "disproportionably" => disproportionably,
      "erythrite"         => erythrite,
      "graphic"           => graphic,
      "hepatological"     => hepatological,
      "homocerc"          => homocerc,
      "incommensurably"   => incommensurably,
      "misaffirm"         => misaffirm,
      "nonbookish"        => nonbookish,
      "pocketbook"        => pocketbook,
      "sclerometric"      => sclerometric,
      "stambouline"       => stambouline,
      "stickpin"          => stickpin,
      "tubulure"          => tubulure,
      "undelated"         => undelated,
      "unsalt"            => unsalt,
      "untutelar"         => untutelar,
      "vagrant"           => vagrant,
      "Walt"              => walt,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class HemocoeleElement < Dry::Struct
  attribute :hemocoele_class, HemocoeleClass.optional
  attribute :integer_array,   Types.Array(Types::Integer).optional

  def self.from_dynamic!(d)
    begin
      value = HemocoeleClass.from_dynamic!(d)
      if schema.key(:hemocoele_class).type.right.valid? value
        return new(hemocoele_class: value, integer_array: nil)
      end
    rescue
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, hemocoele_class: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if hemocoele_class != nil
      hemocoele_class.to_dynamic
    elsif integer_array != nil
      integer_array
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Hoister < Dry::Struct
  attribute :cimelia_class, CimeliaClass.optional
  attribute :null,          Types::Nil.optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = CimeliaClass.from_dynamic!(d)
      if schema.key(:cimelia_class).type.right.valid? value
        return new(cimelia_class: value, null: nil, string: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, cimelia_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, cimelia_class: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cimelia_class != nil
      cimelia_class.to_dynamic
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

class Hyperpiesi < Dry::Struct
  attribute :cimelia_class, CimeliaClass.optional
  attribute :null,          Types::Nil.optional
  attribute :null_array,    Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    begin
      value = CimeliaClass.from_dynamic!(d)
      if schema.key(:cimelia_class).type.right.valid? value
        return new(cimelia_class: value, null_array: nil, null: nil)
      end
    rescue
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, null_array: nil, cimelia_class: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, cimelia_class: nil, null: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cimelia_class != nil
      cimelia_class.to_dynamic
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

class Hyppish < Dry::Struct
  attribute :bool,   Types::Bool.optional
  attribute :null,   Types::Nil.optional
  attribute :string, Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, null: nil, string: nil)
    end
    if schema.key(:null).type.right.valid? d
      return new(null: d, bool: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, bool: nil, null: nil)
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
    else
      nil
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Idealizer < Dry::Struct
  attribute :cimelia_class, CimeliaClass.optional
  attribute :integer,       Types::Integer.optional
  attribute :null_array,    Types.Array(Types::Nil).optional

  def self.from_dynamic!(d)
    begin
      value = CimeliaClass.from_dynamic!(d)
      if schema.key(:cimelia_class).type.right.valid? value
        return new(cimelia_class: value, null_array: nil, integer: nil)
      end
    rescue
    end
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, null_array: nil, cimelia_class: nil)
    end
    if schema.key(:null_array).type.right.valid? d
      return new(null_array: d, cimelia_class: nil, integer: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cimelia_class != nil
      cimelia_class.to_dynamic
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

class Incrustator < Dry::Struct
  attribute :integer,       Types::Integer.optional
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    if schema.key(:integer).type.right.valid? d
      return new(integer: d, integer_array: nil, string: nil)
    end
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, integer: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, integer_array: nil, integer: nil)
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
    elsif string != nil
      string
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Intentiveness < Dry::Struct
  attribute :cimelia_class, CimeliaClass.optional
  attribute :double,        Types::Double.optional
  attribute :string,        Types::String.optional

  def self.from_dynamic!(d)
    begin
      value = CimeliaClass.from_dynamic!(d)
      if schema.key(:cimelia_class).type.right.valid? value
        return new(cimelia_class: value, double: nil, string: nil)
      end
    rescue
    end
    if schema.key(:double).type.right.valid? d
      return new(double: d, cimelia_class: nil, string: nil)
    end
    if schema.key(:string).type.right.valid? d
      return new(string: d, cimelia_class: nil, double: nil)
    end
    raise "Invalid union"
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    if cimelia_class != nil
      cimelia_class.to_dynamic
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

class Interacinar < Dry::Struct
  attribute :assapan,        Types::Double
  attribute :benefactorship, Types::Bool
  attribute :triseriatim,    Types::String
  attribute :tubbing,        Types::Integer
  attribute :untrimmed,      Types::Nil

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      assapan:        d.fetch("assapan"),
      benefactorship: d.fetch("benefactorship"),
      triseriatim:    d.fetch("triseriatim"),
      tubbing:        d.fetch("tubbing"),
      untrimmed:      d.fetch("untrimmed"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "assapan"        => assapan,
      "benefactorship" => benefactorship,
      "triseriatim"    => triseriatim,
      "tubbing"        => tubbing,
      "untrimmed"      => untrimmed,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class Jacutinga < Dry::Struct
  attribute :integer_array, Types.Array(Types::Integer).optional
  attribute :union_map,     Types::Hash.meta(of: Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:integer_array).type.right.valid? d
      return new(integer_array: d, union_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, v] }.to_h
      if schema.key(:union_map).type.right.valid? value
        return new(union_map: value, integer_array: nil)
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
    elsif union_map != nil
      union_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ConstructorElement < Dry::Struct
  attribute :bool,      Types::Bool.optional
  attribute :union_map, Types::Hash.meta(of: Types::Integer.optional).optional

  def self.from_dynamic!(d)
    if schema.key(:bool).type.right.valid? d
      return new(bool: d, union_map: nil)
    end
    begin
      value = Types::Hash[d].map { |k, v| [k, v] }.to_h
      if schema.key(:union_map).type.right.valid? value
        return new(union_map: value, bool: nil)
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
    elsif union_map != nil
      union_map
    end
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class TopLevel < Dry::Struct
  attribute :centrodesmose,         Types::String
  attribute :cerograph,             Types.Array(Types.Instance(CerographElement))
  attribute :chemotherapeutics,     Types.Array(Types.Instance(ChemotherapeuticElement))
  attribute :cimelia,               Types.Array(Types.Instance(CimeliaElement))
  attribute :citrated,              Types::Integer
  attribute :clinodome,             Types.Array(Types.Instance(Clinodome))
  attribute :coadjust,              Types.Array(Types.Instance(CoadjustElement))
  attribute :consilience,           Types.Array(Types.Instance(Consilience))
  attribute :continuative,          Types.Array(Types.Instance(Continuative))
  attribute :credulity,             Types.Array(Types.Instance(CredulityElement))
  attribute :creviced,              Types.Array(Types.Instance(Creviced))
  attribute :cubiculum,             Types.Array(Types.Array(Types::Integer.optional))
  attribute :deruralize,            Types.Array(Types.Instance(DeruralizeElement))
  attribute :diaereses,             Types.Array(Types.Instance(DiaereseElement))
  attribute :dissolution,           Types.Array(Types.Array(Types::Nil).optional)
  attribute :downstroke,            Types.Array(Types.Instance(Downstroke))
  attribute :electrotautomerism,    Types.Array(Types::Double.optional)
  attribute :eleutheromania,        Types.Array(Types.Instance(Eleutheromania))
  attribute :encrust,               Encrust
  attribute :entomoid,              Types.Array(Types.Instance(Entomoid))
  attribute :epipaleolithic,        Types.Array(Types.Instance(Epipaleolithic))
  attribute :expropriable,          Types.Array(Types.Instance(Expropriable))
  attribute :faggingly,             Types.Array(Types.Instance(FagginglyElement))
  attribute :fenks,                 Types.Array(Types.Instance(FenkElement))
  attribute :flagmaking,            Types.Array(Types.Instance(FlagmakingElement))
  attribute :fluorometer,           Types.Array(Types.Instance(Fluorometer))
  attribute :fulsome,               Types.Array(Types::Integer.optional)
  attribute :fuzzy,                 Types.Array(Types.Instance(Fuzzy))
  attribute :gardenwards,           Types.Array(Types.Instance(Gardenward))
  attribute :generalissimo,         Types.Array(Types.Instance(Generalissimo))
  attribute :habeas,                Types.Array(Types::Hash.meta(of: Types::Integer).optional)
  attribute :hemicrystalline,       Types.Array(Types.Instance(Hemicrystalline))
  attribute :hemocoele,             Types.Array(Types.Instance(HemocoeleElement))
  attribute :hoister,               Types.Array(Types.Instance(Hoister))
  attribute :hyperpiesis,           Types.Array(Types.Instance(Hyperpiesi))
  attribute :hyppish,               Types.Array(Types.Instance(Hyppish))
  attribute :idealizer,             Types.Array(Types.Instance(Idealizer))
  attribute :incrustator,           Types.Array(Types.Instance(Incrustator))
  attribute :intentiveness,         Types.Array(Types.Instance(Intentiveness))
  attribute :interacinar,           Interacinar
  attribute :intercorrelation,      Types.Array(Types.Array(Types::Integer).optional)
  attribute :jacutinga,             Types.Array(Types.Instance(Jacutinga))
  attribute :top_level_constructor, Types.Array(Types.Instance(ConstructorElement))

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      centrodesmose:         d.fetch("centrodesmose"),
      cerograph:             d.fetch("cerograph").map { |x| CerographElement.from_dynamic!(x) },
      chemotherapeutics:     d.fetch("chemotherapeutics").map { |x| ChemotherapeuticElement.from_dynamic!(x) },
      cimelia:               d.fetch("cimelia").map { |x| CimeliaElement.from_dynamic!(x) },
      citrated:              d.fetch("citrated"),
      clinodome:             d.fetch("clinodome").map { |x| Clinodome.from_dynamic!(x) },
      coadjust:              d.fetch("coadjust").map { |x| CoadjustElement.from_dynamic!(x) },
      consilience:           d.fetch("consilience").map { |x| Consilience.from_dynamic!(x) },
      continuative:          d.fetch("continuative").map { |x| Continuative.from_dynamic!(x) },
      credulity:             d.fetch("credulity").map { |x| CredulityElement.from_dynamic!(x) },
      creviced:              d.fetch("creviced").map { |x| Creviced.from_dynamic!(x) },
      cubiculum:             d.fetch("cubiculum"),
      deruralize:            d.fetch("deruralize").map { |x| DeruralizeElement.from_dynamic!(x) },
      diaereses:             d.fetch("diaereses").map { |x| DiaereseElement.from_dynamic!(x) },
      dissolution:           d.fetch("dissolution"),
      downstroke:            d.fetch("downstroke").map { |x| Downstroke.from_dynamic!(x) },
      electrotautomerism:    d.fetch("electrotautomerism"),
      eleutheromania:        d.fetch("eleutheromania").map { |x| Eleutheromania.from_dynamic!(x) },
      encrust:               Encrust.from_dynamic!(d.fetch("encrust")),
      entomoid:              d.fetch("entomoid").map { |x| Entomoid.from_dynamic!(x) },
      epipaleolithic:        d.fetch("epipaleolithic").map { |x| Epipaleolithic.from_dynamic!(x) },
      expropriable:          d.fetch("expropriable").map { |x| Expropriable.from_dynamic!(x) },
      faggingly:             d.fetch("faggingly").map { |x| FagginglyElement.from_dynamic!(x) },
      fenks:                 d.fetch("fenks").map { |x| FenkElement.from_dynamic!(x) },
      flagmaking:            d.fetch("flagmaking").map { |x| FlagmakingElement.from_dynamic!(x) },
      fluorometer:           d.fetch("fluorometer").map { |x| Fluorometer.from_dynamic!(x) },
      fulsome:               d.fetch("fulsome"),
      fuzzy:                 d.fetch("fuzzy").map { |x| Fuzzy.from_dynamic!(x) },
      gardenwards:           d.fetch("gardenwards").map { |x| Gardenward.from_dynamic!(x) },
      generalissimo:         d.fetch("generalissimo").map { |x| Generalissimo.from_dynamic!(x) },
      habeas:                d.fetch("habeas").map { |x| Types::Hash.optional[x]&.map { |k, v| [k, Types::Integer[v]] }&.to_h },
      hemicrystalline:       d.fetch("hemicrystalline").map { |x| Hemicrystalline.from_dynamic!(x) },
      hemocoele:             d.fetch("hemocoele").map { |x| HemocoeleElement.from_dynamic!(x) },
      hoister:               d.fetch("hoister").map { |x| Hoister.from_dynamic!(x) },
      hyperpiesis:           d.fetch("hyperpiesis").map { |x| Hyperpiesi.from_dynamic!(x) },
      hyppish:               d.fetch("hyppish").map { |x| Hyppish.from_dynamic!(x) },
      idealizer:             d.fetch("idealizer").map { |x| Idealizer.from_dynamic!(x) },
      incrustator:           d.fetch("incrustator").map { |x| Incrustator.from_dynamic!(x) },
      intentiveness:         d.fetch("intentiveness").map { |x| Intentiveness.from_dynamic!(x) },
      interacinar:           Interacinar.from_dynamic!(d.fetch("interacinar")),
      intercorrelation:      d.fetch("intercorrelation"),
      jacutinga:             d.fetch("jacutinga").map { |x| Jacutinga.from_dynamic!(x) },
      top_level_constructor: d.fetch("constructor").map { |x| ConstructorElement.from_dynamic!(x) },
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "centrodesmose"      => centrodesmose,
      "cerograph"          => cerograph.map { |x| x.to_dynamic },
      "chemotherapeutics"  => chemotherapeutics.map { |x| x.to_dynamic },
      "cimelia"            => cimelia.map { |x| x.to_dynamic },
      "citrated"           => citrated,
      "clinodome"          => clinodome.map { |x| x.to_dynamic },
      "coadjust"           => coadjust.map { |x| x.to_dynamic },
      "consilience"        => consilience.map { |x| x.to_dynamic },
      "continuative"       => continuative.map { |x| x.to_dynamic },
      "credulity"          => credulity.map { |x| x.to_dynamic },
      "creviced"           => creviced.map { |x| x.to_dynamic },
      "cubiculum"          => cubiculum,
      "deruralize"         => deruralize.map { |x| x.to_dynamic },
      "diaereses"          => diaereses.map { |x| x.to_dynamic },
      "dissolution"        => dissolution,
      "downstroke"         => downstroke.map { |x| x.to_dynamic },
      "electrotautomerism" => electrotautomerism,
      "eleutheromania"     => eleutheromania.map { |x| x.to_dynamic },
      "encrust"            => encrust.to_dynamic,
      "entomoid"           => entomoid.map { |x| x.to_dynamic },
      "epipaleolithic"     => epipaleolithic.map { |x| x.to_dynamic },
      "expropriable"       => expropriable.map { |x| x.to_dynamic },
      "faggingly"          => faggingly.map { |x| x.to_dynamic },
      "fenks"              => fenks.map { |x| x.to_dynamic },
      "flagmaking"         => flagmaking.map { |x| x.to_dynamic },
      "fluorometer"        => fluorometer.map { |x| x.to_dynamic },
      "fulsome"            => fulsome,
      "fuzzy"              => fuzzy.map { |x| x.to_dynamic },
      "gardenwards"        => gardenwards.map { |x| x.to_dynamic },
      "generalissimo"      => generalissimo.map { |x| x.to_dynamic },
      "habeas"             => habeas,
      "hemicrystalline"    => hemicrystalline.map { |x| x.to_dynamic },
      "hemocoele"          => hemocoele.map { |x| x.to_dynamic },
      "hoister"            => hoister.map { |x| x.to_dynamic },
      "hyperpiesis"        => hyperpiesis.map { |x| x.to_dynamic },
      "hyppish"            => hyppish.map { |x| x.to_dynamic },
      "idealizer"          => idealizer.map { |x| x.to_dynamic },
      "incrustator"        => incrustator.map { |x| x.to_dynamic },
      "intentiveness"      => intentiveness.map { |x| x.to_dynamic },
      "interacinar"        => interacinar.to_dynamic,
      "intercorrelation"   => intercorrelation,
      "jacutinga"          => jacutinga.map { |x| x.to_dynamic },
      "constructor"        => top_level_constructor.map { |x| x.to_dynamic },
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
