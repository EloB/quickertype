require "json"

class TopLevel
  include JSON::Serializable

  @[JSON::Field(key: "Abranchiata")]
  property abranchiata : Array(Abranchiata?)

  property academe : Array(Academe)

  property acquirable : Array(Acquirable)

  property aerometry : Array(Aerometry)

  property alexin : Array(Alexin)

  property alleviate : Array(AlleviateElement)

  property amaas : Array(Amaa)

  property ambassage : Array(Ambassage)

  property amphithyron : Array(Amphithyron?)

  @[JSON::Field(key: "Andriana")]
  property andriana : Array(String?)

  property ankee : Array(AnkeeElement)

  property annihilator : Array(Hash(String, Int64?)?)

  property annulose : Nil

  @[JSON::Field(key: "Ansarie")]
  property ansarie : Array(AnsarieElement?)

  property aphasia : Array(Aphasia)

  property asprawl : Array(Asprawl)

  property attractive : Array(Bool?)

  property barksome : Hash(String, Int64)

  property bedesman : Array(Bedesman)

  property belard : Array(Belard)

  property bocking : Array(Bocking)

  property brawlingly : Array(Brawlingly)

  property brookie : Array(Brookie)

  property bumboatman : Array(Bumboatman?)

  property bystreet : Array(Nil)

  property calaverite : Array(Calaverite)

  property catallactic : Array(Catallactic)

  property cemental : Array(Cemental)

  @[JSON::Field(key: "Chytridiaceae")]
  property chytridiaceae : Array(ChytridiaceaeElement?)

  @[JSON::Field(key: "Discordia")]
  property discordia : Array(DiscordiaElement)

  @[JSON::Field(key: "Endomyces")]
  property endomyces : Array(Endomyce)

  @[JSON::Field(key: "Epinephelidae")]
  property epinephelidae : Array(Epinephelidae)

  @[JSON::Field(key: "Eupatorium")]
  property eupatorium : Array(Eupatorium)

  @[JSON::Field(key: "Gryphosaurus")]
  property gryphosaurus : Array(GryphosaurusElement)

  @[JSON::Field(key: "Koryak")]
  property koryak : Array(Koryak)

  @[JSON::Field(key: "Lavinia")]
  property lavinia : Array(LaviniaElement)

  @[JSON::Field(key: "Oskar")]
  property oskar : Array(OskarElement)

  @[JSON::Field(key: "Rebecca")]
  property rebecca : Array(RebeccaElement)

  @[JSON::Field(key: "Rhomboganoidei")]
  property rhomboganoidei : Array(Rhomboganoidei)

  @[JSON::Field(key: "Rigsmal")]
  property rigsmal : Bool

  @[JSON::Field(key: "Ruellia")]
  property ruellia : Array(Ruellia)

  @[JSON::Field(key: "School")]
  property school : Array(School?)

  @[JSON::Field(key: "Shakespearolater")]
  property shakespearolater : Array(Shakespearolater)

  @[JSON::Field(key: "Svan")]
  property svan : Array(Float64)

  @[JSON::Field(key: "Wayao")]
  property wayao : Hash(String, Float64)
end

class AlleviateClass
  include JSON::Serializable

  property apriori : Nil

  property beggarer : Nil

  property brokenheartedly : Nil

  property debilitation : Nil

  property frike : Nil

  property gastrolith : Nil

  @[JSON::Field(key: "Hulsean")]
  property hulsean : Nil

  property orthocentric : Nil

  property petaly : Nil

  property probudgeting : Nil

  property reacquire : Nil

  property scow : Nil

  property shutoff : Nil

  property subcontiguous : Nil

  property suffumigate : Nil

  property transformable : Nil

  property uncoroneted : Nil

  property unparking : Nil

  property unvarnishedness : Nil

  property wherewithal : Nil
end

class Rebecca
  include JSON::Serializable

  property catharticalness : Float64

  @[JSON::Field(key: "Chirotherium")]
  property chirotherium : Int64

  property disdiapason : String

  property homocerc : Bool

  property nonbookish : Nil
end

class Amphithyron
  include JSON::Serializable

  property akroasis : Int64?

  property antiphonical : Int64?

  property basebred : Int64?

  property catharticalness : Float64?

  @[JSON::Field(key: "Chirotherium")]
  property chirotherium : Int64?

  property conductometric : Int64?

  property disdiapason : String?

  property ensilation : Int64?

  property eyebolt : Int64?

  property fistulated : Int64?

  property heteropod : Int64?

  property homocerc : Bool?

  @[JSON::Field(key: "Juniperus")]
  property juniperus : Int64?

  property labyrinthically : Int64?

  property martyrization : Int64?

  property mispolicy : Int64?

  property multipara : Int64?

  @[JSON::Field(key: "Nazirite")]
  property nazirite : Int64?

  property nonbookish : Nil

  property possessorial : Int64?

  property shamed : Int64?

  property shelfworn : Int64?

  property stagnum : Int64?

  @[JSON::Field(key: "Those")]
  property those : Int64?

  property undecimal : Int64?
end

class AnkeeClass
  include JSON::Serializable

  @[JSON::Field(key: "Anomoean")]
  property anomoean : Nil

  property barleyhood : Nil

  property befriender : Nil

  property brutishness : Nil

  property cephalalgy : Nil

  property cirurgian : Nil

  property conventionally : Nil

  property jackshay : Nil

  property milammeter : Nil

  @[JSON::Field(key: "Naja")]
  property naja : Nil

  property ombrological : Nil

  property phonasthenia : Nil

  property retrievableness : Nil

  property snakily : Nil

  property swot : Nil

  property tartlet : Nil

  property thiofuran : Nil

  property tracheophone : Nil

  property tuglike : Nil

  property unscratchingly : Nil
end

class AnsarieClass
  include JSON::Serializable

  property accension : Nil

  @[JSON::Field(key: "Alida")]
  property alida : Nil

  property asteria : Nil

  property beriberic : Nil

  property edgebone : Nil

  property gastrodialysis : Nil

  property geographic : Nil

  @[JSON::Field(key: "Ictonyx")]
  property ictonyx : Nil

  property metrocele : Nil

  property misgraft : Nil

  property monteith : Nil

  property notcher : Nil

  property prorestriction : Nil

  @[JSON::Field(key: "Ramist")]
  property ramist : Nil

  property throatlet : Nil

  property unfair : Nil

  property unsynonymous : Nil

  property water : Nil

  property zestfully : Nil

  property zincic : Nil
end

class ChytridiaceaeClass
  include JSON::Serializable

  @[JSON::Field(key: "Batidaceae")]
  property batidaceae : Nil

  @[JSON::Field(key: "Brechites")]
  property brechites : Nil

  property codespairer : Nil

  @[JSON::Field(key: "Emery")]
  property emery : Nil

  property enervative : Nil

  property excriminate : Nil

  property goshenite : Nil

  property grime : Nil

  property gritten : Nil

  property hectorly : Nil

  property intermediation : Nil

  property meeterly : Nil

  @[JSON::Field(key: "Narraganset")]
  property narraganset : Nil

  property onymatic : Nil

  property paddlecock : Nil

  property thana : Nil

  property thornily : Nil

  property uckia : Nil

  property unmettle : Nil

  property vorticellid : Nil
end

class DiscordiaClass
  include JSON::Serializable

  @[JSON::Field(key: "Altaic")]
  property altaic : Int64?

  property amoristic : Int64?

  property blennophthalmia : Int64?

  property catharticalness : Float64?

  @[JSON::Field(key: "Chirotherium")]
  property chirotherium : Int64?

  property disciplinability : Int64?

  property disdiapason : String?

  property goofer : Int64?

  property homocerc : Bool?

  property laryngograph : Int64?

  property leucitis : Int64?

  property lymphocyst : Int64?

  property microcosmology : Int64?

  property nauseation : Int64?

  property nonbookish : Nil

  @[JSON::Field(key: "Patarin")]
  property patarin : Int64?

  property preliberal : Int64?

  property prettifier : Int64?

  property rangework : Int64?

  property redient : Int64?

  property subfusiform : Int64?

  property suicidical : Int64?

  property swow : Int64?

  property wastrel : Int64?

  property wingle : Int64?
end

class GryphosaurusClass
  include JSON::Serializable

  property amissibility : Nil

  @[JSON::Field(key: "Burushaski")]
  property burushaski : Nil

  property citronin : Nil

  property coplaintiff : Nil

  property disquisitionary : Nil

  property enoplan : Nil

  property faintness : Nil

  property hebetomy : Nil

  property islandry : Nil

  property lameduck : Nil

  property overbattle : Nil

  property overinterested : Nil

  property phrenologic : Nil

  property rainband : Nil

  property shiningly : Nil

  property stamineous : Nil

  property subscapularis : Nil

  @[JSON::Field(key: "Tahami")]
  property tahami : Nil

  property undaubed : Nil

  property underntime : Nil
end

class LaviniaClass
  include JSON::Serializable

  property agitable : Int64?

  property asininity : Int64?

  property benefiter : Int64?

  property bronzelike : Int64?

  property catharticalness : Float64?

  @[JSON::Field(key: "Chirotherium")]
  property chirotherium : Int64?

  property cholesteatomatous : Int64?

  property deprivement : Int64?

  property disdiapason : String?

  property flippantness : Int64?

  property fogproof : Int64?

  property homocerc : Bool?

  property merrymeeting : Int64?

  property nonbookish : Nil

  property overcareful : Int64?

  property panaris : Int64?

  property preacceptance : Int64?

  property quinoxaline : Int64?

  property sig : Int64?

  property superconfusion : Int64?

  @[JSON::Field(key: "Tacana")]
  property tacana : Int64?

  property tillotter : Int64?

  property tranquillize : Int64?

  property unquestionable : Int64?

  property uproute : Int64?
end

class OskarClass
  include JSON::Serializable

  @[JSON::Field(key: "Acrobates")]
  property acrobates : Nil

  property beanshooter : Nil

  property bearhound : Nil

  @[JSON::Field(key: "Cayuga")]
  property cayuga : Nil

  property guarneri : Nil

  property hypochondriacism : Nil

  property indication : Nil

  property jaculative : Nil

  property nagana : Nil

  @[JSON::Field(key: "Netherlandish")]
  property netherlandish : Nil

  property noctivagous : Nil

  property nonphysiological : Nil

  property praxis : Nil

  property provision : Nil

  property subterhuman : Nil

  property sunlit : Nil

  property syncraniate : Nil

  property teachment : Nil

  property unmutinous : Nil

  property unstoppable : Nil
end

alias Abranchiata = Int64 | Array(Int64)

alias Academe = Int64 | Array(Int64) | Hash(String, Int64)

alias Acquirable = Hash(String, Int64) | Array(Int64?)

alias Aerometry = Float64 | Bool

alias Alexin = Array(Int64) | Bool

alias AlleviateElement = AlleviateClass | Array(Int64?)

alias Amaa = Int64 | Bool | Rebecca

alias Ambassage = Array(Nil) | String

alias AnkeeElement = AnkeeClass | Int64 | Array(Int64)

alias AnsarieElement = AnsarieClass | Array(Int64)

alias Aphasia = Int64 | Array(Int64)

alias Asprawl = Float64 | String

alias Bedesman = Float64 | Bool | String

alias Belard = Float64 | Array(Int64) | Rebecca

alias Bocking = Array(Int64) | Hash(String, Int64) | Bool

alias Brawlingly = Array(Nil) | Hash(String, Int64?)

alias Brookie = Array(Int64) | Rebecca

alias Bumboatman = Array(Nil) | String

alias Calaverite = Array(Int64) | String

alias Catallactic = Hash(String, Int64) | Array(Nil) | Bool

alias Cemental = Float64 | Array(Int64) | Hash(String, Int64)

alias ChytridiaceaeElement = ChytridiaceaeClass | Bool

alias DiscordiaElement = DiscordiaClass | Array(Int64)

alias Endomyce = Int64 | String

alias Epinephelidae = Int64 | Bool | String

alias Eupatorium = Hash(String, Int64) | Array(Nil)

alias GryphosaurusElement = GryphosaurusClass | Array(Int64) | String

alias Koryak = String | Hash(String, Int64?)

alias LaviniaElement = LaviniaClass | String

alias OskarElement = Array(Int64) | OskarClass

alias RebeccaElement = Int64 | String | Rebecca

alias Rhomboganoidei = Array(Int64) | String | Rebecca

alias Ruellia = Bool | String | Rebecca

alias School = Int64 | Hash(String, Int64)

alias Shakespearolater = Float64 | Array(Int64) | String
