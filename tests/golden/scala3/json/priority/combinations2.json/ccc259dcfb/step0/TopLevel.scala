package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val Abranchiata : Seq[Abranchiata],
    val academe : Seq[Academe],
    val acquirable : Seq[Acquirable],
    val aerometry : Seq[Aerometry],
    val alexin : Seq[Alexin],
    val alleviate : Seq[AlleviateElement],
    val amaas : Seq[Amaa],
    val ambassage : Seq[Ambassage],
    val amphithyron : Seq[Option[Amphithyron]],
    val Andriana : Seq[Option[String]],
    val ankee : Seq[AnkeeElement],
    val annihilator : Seq[Option[Map[String, Option[Long]]]],
    val annulose : Option[Json] = None,
    val Ansarie : Seq[AnsarieElement],
    val aphasia : Seq[Aphasia],
    val asprawl : Seq[Asprawl],
    val attractive : Seq[Option[Boolean]],
    val barksome : Map[String, Long],
    val bedesman : Seq[Bedesman],
    val belard : Seq[Belard],
    val bocking : Seq[Bocking],
    val brawlingly : Seq[Brawlingly],
    val brookie : Seq[Brookie],
    val bumboatman : Seq[Bumboatman],
    val bystreet : Seq[Option[Json]],
    val calaverite : Seq[Calaverite],
    val catallactic : Seq[Catallactic],
    val cemental : Seq[Cemental],
    val Chytridiaceae : Seq[ChytridiaceaeElement],
    val Discordia : Seq[DiscordiaElement],
    val Endomyces : Seq[Endomyce],
    val Epinephelidae : Seq[Epinephelidae],
    val Eupatorium : Seq[Eupatorium],
    val Gryphosaurus : Seq[GryphosaurusElement],
    val Koryak : Seq[Koryak],
    val Lavinia : Seq[LaviniaElement],
    val Oskar : Seq[OskarElement],
    val Rebecca : Seq[RebeccaElement],
    val Rhomboganoidei : Seq[Rhomboganoidei],
    val Rigsmal : Boolean,
    val Ruellia : Seq[Ruellia],
    val School : Seq[School],
    val Shakespearolater : Seq[Shakespearolater],
    val Svan : Seq[Double],
    val Wayao : Map[String, Double]
) derives Encoder.AsObject, Decoder

type Abranchiata = Seq[Long] | Long | NullValue
given Decoder[Abranchiata] = {
    List[Decoder[Abranchiata]](
        Decoder[Long].widen,
        Decoder[Seq[Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Abranchiata] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Academe = Seq[Long] | Map[String, Long] | Long
given Decoder[Academe] = {
    List[Decoder[Academe]](
        Decoder[Long].widen,
        Decoder[Seq[Long]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Academe] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Acquirable = Map[String, Long] | Seq[Option[Long]]
given Decoder[Acquirable] = {
    List[Decoder[Acquirable]](
        Decoder[Seq[Option[Long]]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Acquirable] = Encoder.instance {
    case enc0 : Seq[Option[Long]] => Encoder.encodeSeq[Option[Long]].apply(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
}

type Aerometry = Boolean | Double
given Decoder[Aerometry] = {
    List[Decoder[Aerometry]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Aerometry] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}

type Alexin = Boolean | Seq[Long]
given Decoder[Alexin] = {
    List[Decoder[Alexin]](
        Decoder[Boolean].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Alexin] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
}

type AlleviateElement = AlleviateClass | Seq[Option[Long]]
given Decoder[AlleviateElement] = {
    List[Decoder[AlleviateElement]](
        Decoder[Seq[Option[Long]]].widen,
        Decoder[AlleviateClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[AlleviateElement] = Encoder.instance {
    case enc0 : Seq[Option[Long]] => Encoder.encodeSeq[Option[Long]].apply(enc0)
    case enc1 : AlleviateClass => Encoder.AsObject[AlleviateClass].apply(enc1)
}

case class AlleviateClass (
    val apriori : Option[Json] = None,
    val beggarer : Option[Json] = None,
    val brokenheartedly : Option[Json] = None,
    val debilitation : Option[Json] = None,
    val frike : Option[Json] = None,
    val gastrolith : Option[Json] = None,
    val Hulsean : Option[Json] = None,
    val orthocentric : Option[Json] = None,
    val petaly : Option[Json] = None,
    val probudgeting : Option[Json] = None,
    val reacquire : Option[Json] = None,
    val scow : Option[Json] = None,
    val shutoff : Option[Json] = None,
    val subcontiguous : Option[Json] = None,
    val suffumigate : Option[Json] = None,
    val transformable : Option[Json] = None,
    val uncoroneted : Option[Json] = None,
    val unparking : Option[Json] = None,
    val unvarnishedness : Option[Json] = None,
    val wherewithal : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Amaa = Boolean | Long | Rebecca
given Decoder[Amaa] = {
    List[Decoder[Amaa]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Rebecca].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Amaa] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Rebecca => Encoder.AsObject[Rebecca].apply(enc2)
}

case class Rebecca (
    val catharticalness : Double,
    val Chirotherium : Long,
    val disdiapason : String,
    val homocerc : Boolean,
    val nonbookish : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Ambassage = Seq[Option[Json]] | String
given Decoder[Ambassage] = {
    List[Decoder[Ambassage]](
        Decoder[String].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Ambassage] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
}

case class Amphithyron (
    val akroasis : Option[Long] = None,
    val antiphonical : Option[Long] = None,
    val basebred : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val conductometric : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val ensilation : Option[Long] = None,
    val eyebolt : Option[Long] = None,
    val fistulated : Option[Long] = None,
    val heteropod : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val Juniperus : Option[Long] = None,
    val labyrinthically : Option[Long] = None,
    val martyrization : Option[Long] = None,
    val mispolicy : Option[Long] = None,
    val multipara : Option[Long] = None,
    val Nazirite : Option[Long] = None,
    val nonbookish : Option[Json] = None,
    val possessorial : Option[Long] = None,
    val shamed : Option[Long] = None,
    val shelfworn : Option[Long] = None,
    val stagnum : Option[Long] = None,
    val Those : Option[Long] = None,
    val undecimal : Option[Long] = None
) derives Encoder.AsObject, Decoder

type AnkeeElement = AnkeeClass | Seq[Long] | Long
given Decoder[AnkeeElement] = {
    List[Decoder[AnkeeElement]](
        Decoder[Long].widen,
        Decoder[Seq[Long]].widen,
        Decoder[AnkeeClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[AnkeeElement] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : AnkeeClass => Encoder.AsObject[AnkeeClass].apply(enc2)
}

case class AnkeeClass (
    val Anomoean : Option[Json] = None,
    val barleyhood : Option[Json] = None,
    val befriender : Option[Json] = None,
    val brutishness : Option[Json] = None,
    val cephalalgy : Option[Json] = None,
    val cirurgian : Option[Json] = None,
    val conventionally : Option[Json] = None,
    val jackshay : Option[Json] = None,
    val milammeter : Option[Json] = None,
    val Naja : Option[Json] = None,
    val ombrological : Option[Json] = None,
    val phonasthenia : Option[Json] = None,
    val retrievableness : Option[Json] = None,
    val snakily : Option[Json] = None,
    val swot : Option[Json] = None,
    val tartlet : Option[Json] = None,
    val thiofuran : Option[Json] = None,
    val tracheophone : Option[Json] = None,
    val tuglike : Option[Json] = None,
    val unscratchingly : Option[Json] = None
) derives Encoder.AsObject, Decoder

type AnsarieElement = AnsarieClass | Seq[Long] | NullValue
given Decoder[AnsarieElement] = {
    List[Decoder[AnsarieElement]](
        Decoder[Seq[Long]].widen,
        Decoder[AnsarieClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[AnsarieElement] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : AnsarieClass => Encoder.AsObject[AnsarieClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class AnsarieClass (
    val accension : Option[Json] = None,
    val Alida : Option[Json] = None,
    val asteria : Option[Json] = None,
    val beriberic : Option[Json] = None,
    val edgebone : Option[Json] = None,
    val gastrodialysis : Option[Json] = None,
    val geographic : Option[Json] = None,
    val Ictonyx : Option[Json] = None,
    val metrocele : Option[Json] = None,
    val misgraft : Option[Json] = None,
    val monteith : Option[Json] = None,
    val notcher : Option[Json] = None,
    val prorestriction : Option[Json] = None,
    val Ramist : Option[Json] = None,
    val throatlet : Option[Json] = None,
    val unfair : Option[Json] = None,
    val unsynonymous : Option[Json] = None,
    val water : Option[Json] = None,
    val zestfully : Option[Json] = None,
    val zincic : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Aphasia = Seq[Long] | Long
given Decoder[Aphasia] = {
    List[Decoder[Aphasia]](
        Decoder[Long].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Aphasia] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
}

type Asprawl = Double | String
given Decoder[Asprawl] = {
    List[Decoder[Asprawl]](
        Decoder[String].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Asprawl] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}

type Bedesman = Boolean | Double | String
given Decoder[Bedesman] = {
    List[Decoder[Bedesman]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Bedesman] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Double => Encoder.encodeDouble(enc2)
}

type Belard = Double | Seq[Long] | Rebecca
given Decoder[Belard] = {
    List[Decoder[Belard]](
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
        Decoder[Rebecca].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Belard] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : Rebecca => Encoder.AsObject[Rebecca].apply(enc2)
}

type Bocking = Boolean | Seq[Long] | Map[String, Long]
given Decoder[Bocking] = {
    List[Decoder[Bocking]](
        Decoder[Boolean].widen,
        Decoder[Seq[Long]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Bocking] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Brawlingly = Seq[Option[Json]] | Map[String, Option[Long]]
given Decoder[Brawlingly] = {
    List[Decoder[Brawlingly]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[Map[String, Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Brawlingly] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : Map[String, Option[Long]] => Encoder.encodeMap[String,Option[Long]].apply(enc1)
}

type Brookie = Seq[Long] | Rebecca
given Decoder[Brookie] = {
    List[Decoder[Brookie]](
        Decoder[Seq[Long]].widen,
        Decoder[Rebecca].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Brookie] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : Rebecca => Encoder.AsObject[Rebecca].apply(enc1)
}

type Bumboatman = Seq[Option[Json]] | String | NullValue
given Decoder[Bumboatman] = {
    List[Decoder[Bumboatman]](
        Decoder[String].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Bumboatman] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Calaverite = Seq[Long] | String
given Decoder[Calaverite] = {
    List[Decoder[Calaverite]](
        Decoder[String].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Calaverite] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
}

type Catallactic = Boolean | Map[String, Long] | Seq[Option[Json]]
given Decoder[Catallactic] = {
    List[Decoder[Catallactic]](
        Decoder[Boolean].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Catallactic] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Cemental = Double | Seq[Long] | Map[String, Long]
given Decoder[Cemental] = {
    List[Decoder[Cemental]](
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Cemental] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type ChytridiaceaeElement = Boolean | ChytridiaceaeClass | NullValue
given Decoder[ChytridiaceaeElement] = {
    List[Decoder[ChytridiaceaeElement]](
        Decoder[Boolean].widen,
        Decoder[ChytridiaceaeClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[ChytridiaceaeElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : ChytridiaceaeClass => Encoder.AsObject[ChytridiaceaeClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class ChytridiaceaeClass (
    val Batidaceae : Option[Json] = None,
    val Brechites : Option[Json] = None,
    val codespairer : Option[Json] = None,
    val Emery : Option[Json] = None,
    val enervative : Option[Json] = None,
    val excriminate : Option[Json] = None,
    val goshenite : Option[Json] = None,
    val grime : Option[Json] = None,
    val gritten : Option[Json] = None,
    val hectorly : Option[Json] = None,
    val intermediation : Option[Json] = None,
    val meeterly : Option[Json] = None,
    val Narraganset : Option[Json] = None,
    val onymatic : Option[Json] = None,
    val paddlecock : Option[Json] = None,
    val thana : Option[Json] = None,
    val thornily : Option[Json] = None,
    val uckia : Option[Json] = None,
    val unmettle : Option[Json] = None,
    val vorticellid : Option[Json] = None
) derives Encoder.AsObject, Decoder

type DiscordiaElement = DiscordiaClass | Seq[Long]
given Decoder[DiscordiaElement] = {
    List[Decoder[DiscordiaElement]](
        Decoder[Seq[Long]].widen,
        Decoder[DiscordiaClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[DiscordiaElement] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : DiscordiaClass => Encoder.AsObject[DiscordiaClass].apply(enc1)
}

case class DiscordiaClass (
    val Altaic : Option[Long] = None,
    val amoristic : Option[Long] = None,
    val blennophthalmia : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val disciplinability : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val goofer : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val laryngograph : Option[Long] = None,
    val leucitis : Option[Long] = None,
    val lymphocyst : Option[Long] = None,
    val microcosmology : Option[Long] = None,
    val nauseation : Option[Long] = None,
    val nonbookish : Option[Json] = None,
    val Patarin : Option[Long] = None,
    val preliberal : Option[Long] = None,
    val prettifier : Option[Long] = None,
    val rangework : Option[Long] = None,
    val redient : Option[Long] = None,
    val subfusiform : Option[Long] = None,
    val suicidical : Option[Long] = None,
    val swow : Option[Long] = None,
    val wastrel : Option[Long] = None,
    val wingle : Option[Long] = None
) derives Encoder.AsObject, Decoder

type Endomyce = Long | String
given Decoder[Endomyce] = {
    List[Decoder[Endomyce]](
        Decoder[String].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Endomyce] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}

type Epinephelidae = Boolean | Long | String
given Decoder[Epinephelidae] = {
    List[Decoder[Epinephelidae]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Epinephelidae] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Long => Encoder.encodeLong(enc2)
}

type Eupatorium = Map[String, Long] | Seq[Option[Json]]
given Decoder[Eupatorium] = {
    List[Decoder[Eupatorium]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Eupatorium] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
}

type GryphosaurusElement = GryphosaurusClass | Seq[Long] | String
given Decoder[GryphosaurusElement] = {
    List[Decoder[GryphosaurusElement]](
        Decoder[String].widen,
        Decoder[Seq[Long]].widen,
        Decoder[GryphosaurusClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[GryphosaurusElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : GryphosaurusClass => Encoder.AsObject[GryphosaurusClass].apply(enc2)
}

case class GryphosaurusClass (
    val amissibility : Option[Json] = None,
    val Burushaski : Option[Json] = None,
    val citronin : Option[Json] = None,
    val coplaintiff : Option[Json] = None,
    val disquisitionary : Option[Json] = None,
    val enoplan : Option[Json] = None,
    val faintness : Option[Json] = None,
    val hebetomy : Option[Json] = None,
    val islandry : Option[Json] = None,
    val lameduck : Option[Json] = None,
    val overbattle : Option[Json] = None,
    val overinterested : Option[Json] = None,
    val phrenologic : Option[Json] = None,
    val rainband : Option[Json] = None,
    val shiningly : Option[Json] = None,
    val stamineous : Option[Json] = None,
    val subscapularis : Option[Json] = None,
    val Tahami : Option[Json] = None,
    val undaubed : Option[Json] = None,
    val underntime : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Koryak = String | Map[String, Option[Long]]
given Decoder[Koryak] = {
    List[Decoder[Koryak]](
        Decoder[String].widen,
        Decoder[Map[String, Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Koryak] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Map[String, Option[Long]] => Encoder.encodeMap[String,Option[Long]].apply(enc1)
}

type LaviniaElement = LaviniaClass | String
given Decoder[LaviniaElement] = {
    List[Decoder[LaviniaElement]](
        Decoder[String].widen,
        Decoder[LaviniaClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[LaviniaElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : LaviniaClass => Encoder.AsObject[LaviniaClass].apply(enc1)
}

case class LaviniaClass (
    val agitable : Option[Long] = None,
    val asininity : Option[Long] = None,
    val benefiter : Option[Long] = None,
    val bronzelike : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val cholesteatomatous : Option[Long] = None,
    val deprivement : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val flippantness : Option[Long] = None,
    val fogproof : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val merrymeeting : Option[Long] = None,
    val nonbookish : Option[Json] = None,
    val overcareful : Option[Long] = None,
    val panaris : Option[Long] = None,
    val preacceptance : Option[Long] = None,
    val quinoxaline : Option[Long] = None,
    val sig : Option[Long] = None,
    val superconfusion : Option[Long] = None,
    val Tacana : Option[Long] = None,
    val tillotter : Option[Long] = None,
    val tranquillize : Option[Long] = None,
    val unquestionable : Option[Long] = None,
    val uproute : Option[Long] = None
) derives Encoder.AsObject, Decoder

type OskarElement = Seq[Long] | OskarClass
given Decoder[OskarElement] = {
    List[Decoder[OskarElement]](
        Decoder[Seq[Long]].widen,
        Decoder[OskarClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[OskarElement] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : OskarClass => Encoder.AsObject[OskarClass].apply(enc1)
}

case class OskarClass (
    val Acrobates : Option[Json] = None,
    val beanshooter : Option[Json] = None,
    val bearhound : Option[Json] = None,
    val Cayuga : Option[Json] = None,
    val guarneri : Option[Json] = None,
    val hypochondriacism : Option[Json] = None,
    val indication : Option[Json] = None,
    val jaculative : Option[Json] = None,
    val nagana : Option[Json] = None,
    val Netherlandish : Option[Json] = None,
    val noctivagous : Option[Json] = None,
    val nonphysiological : Option[Json] = None,
    val praxis : Option[Json] = None,
    val provision : Option[Json] = None,
    val subterhuman : Option[Json] = None,
    val sunlit : Option[Json] = None,
    val syncraniate : Option[Json] = None,
    val teachment : Option[Json] = None,
    val unmutinous : Option[Json] = None,
    val unstoppable : Option[Json] = None
) derives Encoder.AsObject, Decoder

type RebeccaElement = Long | Rebecca | String
given Decoder[RebeccaElement] = {
    List[Decoder[RebeccaElement]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[Rebecca].widen,
    ).reduceLeft(_ or _)
}

given Encoder[RebeccaElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Rebecca => Encoder.AsObject[Rebecca].apply(enc2)
}

type Rhomboganoidei = Seq[Long] | Rebecca | String
given Decoder[Rhomboganoidei] = {
    List[Decoder[Rhomboganoidei]](
        Decoder[String].widen,
        Decoder[Seq[Long]].widen,
        Decoder[Rebecca].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Rhomboganoidei] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : Rebecca => Encoder.AsObject[Rebecca].apply(enc2)
}

type Ruellia = Boolean | Rebecca | String
given Decoder[Ruellia] = {
    List[Decoder[Ruellia]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Rebecca].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Ruellia] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Rebecca => Encoder.AsObject[Rebecca].apply(enc2)
}

type School = Map[String, Long] | Long | NullValue
given Decoder[School] = {
    List[Decoder[School]](
        Decoder[Long].widen,
        Decoder[Map[String, Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[School] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Shakespearolater = Double | Seq[Long] | String
given Decoder[Shakespearolater] = {
    List[Decoder[Shakespearolater]](
        Decoder[String].widen,
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Shakespearolater] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc2)
}
