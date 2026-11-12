package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val protrusive : Seq[Protrusive],
    val pulpitism : Seq[PulpitismElement],
    val pyodermia : Seq[PyodermiaElement],
    val quebrachine : Seq[QuebrachineElement],
    val querier : Seq[Querier],
    val rebarbative : Seq[Rebarbative],
    val reimagine : Seq[Reimagine],
    val ressaut : Ressaut,
    val retrocervical : Seq[Retrocervical],
    val revert : Seq[Revert],
    val rewrite : Seq[RewriteElement],
    val saccoderm : Seq[Saccoderm],
    val santir : Seq[SantirElement],
    val saprophilous : Seq[Saprophilous],
    val saxten : Seq[SaxtenElement],
    val scatty : Seq[Option[Scatty]],
    val scoffer : Seq[Scoffer],
    val scrampum : Seq[Scrampum],
    val semantic : Double,
    val serpentinic : Seq[Serpentinic],
    val shadowable : Seq[Shadowable],
    val sistering : Seq[SisteringElement],
    val staghunting : Seq[Staghunting],
    val stagmometer : Seq[Stagmometer],
    val stimulability : Seq[Stimulability],
    val strangleable : Seq[Strangleable],
    val strenuosity : Seq[StrenuosityElement],
    val tabaxir : Seq[Tabaxir],
    val talpiform : Seq[Talpiform],
    val thwack : Seq[Thwack],
    val to : Seq[Option[Double]],
    val tortricine : Seq[Tortricine],
    val truantcy : Seq[TruantcyElement],
    val turgesce : Seq[String],
    val unbeginning : Seq[Unbeginning],
    val underdunged : Seq[Double],
    val undesirability : Seq[Undesirability],
    val unerasing : Seq[Unerasing],
    val unguentarium : Seq[Unguentarium],
    val unimpeachably : Seq[UnimpeachablyElement],
    val unmortgaged : Seq[Unmortgaged],
    val unobstructed : Seq[Unobstructed],
    val unreceptivity : Seq[Unreceptivity],
    val unsatisfactoriness : Seq[Unsatisfactoriness],
    val unsecurity : Seq[Long],
    val unstressed : Seq[UnstressedElement],
    val untasked : Seq[Untasked],
    val unvarying : Seq[Unvarying],
    val vehemently : Seq[Vehemently],
    val warriorship : Map[String, Boolean],
    val whitepot : Seq[Whitepot],
    val wrothy : Seq[WrothyElement]
) derives Encoder.AsObject, Decoder

type Protrusive = Double | Seq[Option[Long]]
given Decoder[Protrusive] = {
    List[Decoder[Protrusive]](
        Decoder[Double].widen,
        Decoder[Seq[Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Protrusive] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Option[Long]] => Encoder.encodeSeq[Option[Long]].apply(enc1)
}

type PulpitismElement = Double | Seq[Long] | PulpitismClass
given Decoder[PulpitismElement] = {
    List[Decoder[PulpitismElement]](
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
        Decoder[PulpitismClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[PulpitismElement] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : PulpitismClass => Encoder.AsObject[PulpitismClass].apply(enc2)
}

case class PulpitismClass (
    val abnet : Option[Json] = None,
    val buckhorn : Option[Json] = None,
    val calciform : Option[Json] = None,
    val chelophore : Option[Json] = None,
    val cogitation : Option[Json] = None,
    val decreeable : Option[Json] = None,
    val despicable : Option[Json] = None,
    val isodiazo : Option[Json] = None,
    val jadedly : Option[Json] = None,
    val leptochlorite : Option[Json] = None,
    val nursling : Option[Json] = None,
    val palamedean : Option[Json] = None,
    val photoheliograph : Option[Json] = None,
    val pipewood : Option[Json] = None,
    val roberd : Option[Json] = None,
    val statable : Option[Json] = None,
    val superassume : Option[Json] = None,
    val syllabe : Option[Json] = None,
    val toughhead : Option[Json] = None,
    val underburn : Option[Json] = None
) derives Encoder.AsObject, Decoder

type PyodermiaElement = Long | PyodermiaClass
given Decoder[PyodermiaElement] = {
    List[Decoder[PyodermiaElement]](
        Decoder[Long].widen,
        Decoder[PyodermiaClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[PyodermiaElement] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : PyodermiaClass => Encoder.AsObject[PyodermiaClass].apply(enc1)
}

case class PyodermiaClass (
    val aphoristically : Option[Json] = None,
    val apophyllous : Option[Json] = None,
    val cognize : Option[Json] = None,
    val dermonosology : Option[Json] = None,
    val Gyppo : Option[Json] = None,
    val ither : Option[Json] = None,
    val juglandaceous : Option[Json] = None,
    val litho : Option[Json] = None,
    val macropterous : Option[Json] = None,
    val photographer : Option[Json] = None,
    val romancing : Option[Json] = None,
    val rumness : Option[Json] = None,
    val somniloquist : Option[Json] = None,
    val stressfully : Option[Json] = None,
    val tactically : Option[Json] = None,
    val tracheophony : Option[Json] = None,
    val unappositely : Option[Json] = None,
    val unclothedly : Option[Json] = None,
    val unimplied : Option[Json] = None,
    val unsyncopated : Option[Json] = None
) derives Encoder.AsObject, Decoder

type QuebrachineElement = Boolean | QuebrachineClass | NullValue
given Decoder[QuebrachineElement] = {
    List[Decoder[QuebrachineElement]](
        Decoder[Boolean].widen,
        Decoder[QuebrachineClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[QuebrachineElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : QuebrachineClass => Encoder.AsObject[QuebrachineClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class QuebrachineClass (
    val catharticalness : Double,
    val Chirotherium : Long,
    val disdiapason : String,
    val homocerc : Boolean,
    val nonbookish : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Querier = Boolean | Map[String, Long]
given Decoder[Querier] = {
    List[Decoder[Querier]](
        Decoder[Boolean].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Querier] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
}

type Rebarbative = Boolean | Double | Seq[Long]
given Decoder[Rebarbative] = {
    List[Decoder[Rebarbative]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Rebarbative] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc2)
}

case class Reimagine (
    val adducible : Option[Json] = None,
    val anabolin : Option[Json] = None,
    val brainy : Option[Json] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val chrysamine : Option[Json] = None,
    val disdiapason : Option[String] = None,
    val fluxweed : Option[Json] = None,
    val glaucine : Option[Json] = None,
    val grobianism : Option[Json] = None,
    val Hermo : Option[Json] = None,
    val hieroglyphist : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val icteroid : Option[Json] = None,
    val immortal : Option[Json] = None,
    val impetulant : Option[Json] = None,
    val irrigate : Option[Json] = None,
    val myxedema : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val onyx : Option[Json] = None,
    val repasser : Option[Json] = None,
    val septomarginal : Option[Json] = None,
    val subdie : Option[Json] = None,
    val tibiometatarsal : Option[Json] = None,
    val waltzlike : Option[Json] = None
) derives Encoder.AsObject, Decoder

case class Ressaut (
    val apperceptive : String,
    val cuttoo : String,
    val douser : String,
    val drinkproof : String,
    val forementioned : String,
    val Freesia : String,
    val Genevieve : String,
    val hyperdiabolical : String,
    val hypocone : String,
    val irreverentially : String,
    val jumart : String,
    val Mimosaceae : String,
    val mollicrush : String,
    val nedder : String,
    val retinasphalt : String,
    val sough : String,
    val steading : String,
    val Theopaschitism : String,
    val undurableness : String,
    val unmingleable : String
) derives Encoder.AsObject, Decoder

type Retrocervical = Long | Seq[Option[Long]]
given Decoder[Retrocervical] = {
    List[Decoder[Retrocervical]](
        Decoder[Long].widen,
        Decoder[Seq[Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Retrocervical] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Option[Long]] => Encoder.encodeSeq[Option[Long]].apply(enc1)
}

type Revert = Boolean | String
given Decoder[Revert] = {
    List[Decoder[Revert]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Revert] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
}

type RewriteElement = Double | Seq[Option[Json]] | RewriteClass
given Decoder[RewriteElement] = {
    List[Decoder[RewriteElement]](
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[RewriteClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[RewriteElement] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : RewriteClass => Encoder.AsObject[RewriteClass].apply(enc2)
}

case class RewriteClass (
    val accountancy : Option[Json] = None,
    val cacotrophic : Option[Json] = None,
    val contest : Option[Json] = None,
    val couthily : Option[Json] = None,
    val falculate : Option[Json] = None,
    val foreseize : Option[Json] = None,
    val Hyades : Option[Json] = None,
    val lemnad : Option[Json] = None,
    val monotheistically : Option[Json] = None,
    val nonflying : Option[Json] = None,
    val Ptenoglossa : Option[Json] = None,
    val repatch : Option[Json] = None,
    val rodman : Option[Json] = None,
    val strung : Option[Json] = None,
    val titmal : Option[Json] = None,
    val twalpennyworth : Option[Json] = None,
    val unblamable : Option[Json] = None,
    val vertical : Option[Json] = None,
    val Whiggification : Option[Json] = None,
    val yardman : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Saccoderm = Seq[Long] | String | NullValue
given Decoder[Saccoderm] = {
    List[Decoder[Saccoderm]](
        Decoder[String].widen,
        Decoder[Seq[Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Saccoderm] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type SantirElement = Double | SantirClass
given Decoder[SantirElement] = {
    List[Decoder[SantirElement]](
        Decoder[Double].widen,
        Decoder[SantirClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[SantirElement] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : SantirClass => Encoder.AsObject[SantirClass].apply(enc1)
}

case class SantirClass (
    val admiredly : Option[Json] = None,
    val demicaponier : Option[Json] = None,
    val epitympanic : Option[Json] = None,
    val investitor : Option[Json] = None,
    val lupiform : Option[Json] = None,
    val monoflagellate : Option[Json] = None,
    val paleoethnic : Option[Json] = None,
    val prediscountable : Option[Json] = None,
    val rhetoricals : Option[Json] = None,
    val roomth : Option[Json] = None,
    val saccharose : Option[Json] = None,
    val septonasal : Option[Json] = None,
    val serpenticide : Option[Json] = None,
    val setarious : Option[Json] = None,
    val spaework : Option[Json] = None,
    val stylite : Option[Json] = None,
    val Suessiones : Option[Json] = None,
    val timelily : Option[Json] = None,
    val unprofaned : Option[Json] = None,
    val vorticular : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Saprophilous = Map[String, Long] | String | NullValue
given Decoder[Saprophilous] = {
    List[Decoder[Saprophilous]](
        Decoder[String].widen,
        Decoder[Map[String, Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Saprophilous] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type SaxtenElement = SaxtenClass | String
given Decoder[SaxtenElement] = {
    List[Decoder[SaxtenElement]](
        Decoder[String].widen,
        Decoder[SaxtenClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[SaxtenElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : SaxtenClass => Encoder.AsObject[SaxtenClass].apply(enc1)
}

case class SaxtenClass (
    val algarrobilla : Option[Json] = None,
    val bowgrace : Option[Json] = None,
    val catharticalness : Option[Double] = None,
    val Centaurid : Option[Json] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val flix : Option[Json] = None,
    val germanely : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val inhume : Option[Json] = None,
    val lepidote : Option[Json] = None,
    val megalochirous : Option[Json] = None,
    val ninepenny : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val nondeist : Option[Json] = None,
    val nymphaeaceous : Option[Json] = None,
    val parietofrontal : Option[Json] = None,
    val sancyite : Option[Json] = None,
    val subjectivist : Option[Json] = None,
    val tibiad : Option[Json] = None,
    val transonic : Option[Json] = None,
    val tripetalous : Option[Json] = None,
    val trunchman : Option[Json] = None,
    val urger : Option[Json] = None,
    val withdrawnness : Option[Json] = None
) derives Encoder.AsObject, Decoder

case class Scatty (
    val aeriferous : Option[Json] = None,
    val antical : Option[Json] = None,
    val antighostism : Option[Json] = None,
    val arcanum : Option[Json] = None,
    val autotrophy : Option[Json] = None,
    val baronial : Option[Json] = None,
    val caffeine : Option[Json] = None,
    val gorgoniacean : Option[Json] = None,
    val heroical : Option[Json] = None,
    val hydropical : Option[Json] = None,
    val mechanology : Option[Json] = None,
    val musicopoetic : Option[Json] = None,
    val officiality : Option[Json] = None,
    val oftentimes : Option[Json] = None,
    val ophthalmotonometer : Option[Json] = None,
    val reflectively : Option[Json] = None,
    val springer : Option[Json] = None,
    val Tabasco : Option[Json] = None,
    val teleianthous : Option[Json] = None,
    val uncombated : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Scoffer = Map[String, Long] | Seq[Option[Json]] | NullValue
given Decoder[Scoffer] = {
    List[Decoder[Scoffer]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[Map[String, Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Scoffer] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Scrampum = Boolean | Seq[Long] | NullValue
given Decoder[Scrampum] = {
    List[Decoder[Scrampum]](
        Decoder[Boolean].widen,
        Decoder[Seq[Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Scrampum] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Serpentinic = Double | Seq[Long]
given Decoder[Serpentinic] = {
    List[Decoder[Serpentinic]](
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Serpentinic] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
}

type Shadowable = Boolean | Seq[Option[Long]]
given Decoder[Shadowable] = {
    List[Decoder[Shadowable]](
        Decoder[Boolean].widen,
        Decoder[Seq[Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Shadowable] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Option[Long]] => Encoder.encodeSeq[Option[Long]].apply(enc1)
}

type SisteringElement = Long | Seq[Option[Json]] | SisteringClass
given Decoder[SisteringElement] = {
    List[Decoder[SisteringElement]](
        Decoder[Long].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[SisteringClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[SisteringElement] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : SisteringClass => Encoder.AsObject[SisteringClass].apply(enc2)
}

case class SisteringClass (
    val amphicarpic : Option[Json] = None,
    val Chianti : Option[Json] = None,
    val frigorific : Option[Json] = None,
    val Haplomi : Option[Json] = None,
    val hyperkinesis : Option[Json] = None,
    val laudable : Option[Json] = None,
    val madwoman : Option[Json] = None,
    val maimedly : Option[Json] = None,
    val Micropterygidae : Option[Json] = None,
    val microrhabdus : Option[Json] = None,
    val nondense : Option[Json] = None,
    val phlebemphraxis : Option[Json] = None,
    val redsear : Option[Json] = None,
    val schismatical : Option[Json] = None,
    val tartryl : Option[Json] = None,
    val unabhorred : Option[Json] = None,
    val undeliberateness : Option[Json] = None,
    val unmixable : Option[Json] = None,
    val untruckling : Option[Json] = None,
    val vineal : Option[Json] = None
) derives Encoder.AsObject, Decoder

case class Staghunting (
    val calorimetric : Option[Long] = None,
    val canid : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val ditriglyphic : Option[Long] = None,
    val floriferousness : Option[Long] = None,
    val gamelike : Option[Long] = None,
    val grig : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val interloan : Option[Long] = None,
    val lithotomy : Option[Long] = None,
    val loric : Option[Long] = None,
    val membranocoriaceous : Option[Long] = None,
    val membranogenic : Option[Long] = None,
    val nonbookish : Option[Json] = None,
    val overtrump : Option[Long] = None,
    val scotino : Option[Long] = None,
    val seasonable : Option[Long] = None,
    val sephen : Option[Long] = None,
    val stigmarioid : Option[Long] = None,
    val tired : Option[Long] = None,
    val trifid : Option[Long] = None,
    val undefeatedly : Option[Long] = None,
    val ungirlish : Option[Long] = None
) derives Encoder.AsObject, Decoder

type Stagmometer = String | Seq[Option[Long]]
given Decoder[Stagmometer] = {
    List[Decoder[Stagmometer]](
        Decoder[String].widen,
        Decoder[Seq[Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Stagmometer] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Option[Long]] => Encoder.encodeSeq[Option[Long]].apply(enc1)
}

type Stimulability = Boolean | Map[String, Long] | Long
given Decoder[Stimulability] = {
    List[Decoder[Stimulability]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Stimulability] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Strangleable = Double | Seq[Option[Json]]
given Decoder[Strangleable] = {
    List[Decoder[Strangleable]](
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Strangleable] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
}

type StrenuosityElement = Seq[Option[Json]] | StrenuosityClass
given Decoder[StrenuosityElement] = {
    List[Decoder[StrenuosityElement]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[StrenuosityClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[StrenuosityElement] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : StrenuosityClass => Encoder.AsObject[StrenuosityClass].apply(enc1)
}

case class StrenuosityClass (
    val bliss : Option[Long] = None,
    val buccate : Option[Long] = None,
    val bulletproof : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val crumblingness : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val engagedly : Option[Long] = None,
    val fightable : Option[Long] = None,
    val hoariness : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val hypopodium : Option[Long] = None,
    val luxurist : Option[Long] = None,
    val mechanician : Option[Long] = None,
    val nonbookish : Option[Json] = None,
    val Onopordon : Option[Long] = None,
    val podgily : Option[Long] = None,
    val reformableness : Option[Long] = None,
    val scatterbrains : Option[Long] = None,
    val seminuria : Option[Long] = None,
    val Sodomite : Option[Long] = None,
    val tramp : Option[Long] = None,
    val undueness : Option[Long] = None,
    val worthily : Option[Long] = None,
    val Yankeeist : Option[Long] = None
) derives Encoder.AsObject, Decoder

type Tabaxir = Boolean | Double
given Decoder[Tabaxir] = {
    List[Decoder[Tabaxir]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Tabaxir] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}

type Talpiform = Double | QuebrachineClass | NullValue
given Decoder[Talpiform] = {
    List[Decoder[Talpiform]](
        Decoder[Double].widen,
        Decoder[QuebrachineClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Talpiform] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : QuebrachineClass => Encoder.AsObject[QuebrachineClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Thwack = Boolean | Double | QuebrachineClass
given Decoder[Thwack] = {
    List[Decoder[Thwack]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
        Decoder[QuebrachineClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Thwack] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : QuebrachineClass => Encoder.AsObject[QuebrachineClass].apply(enc2)
}

type Tortricine = QuebrachineClass | Seq[Option[Long]]
given Decoder[Tortricine] = {
    List[Decoder[Tortricine]](
        Decoder[Seq[Option[Long]]].widen,
        Decoder[QuebrachineClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Tortricine] = Encoder.instance {
    case enc0 : Seq[Option[Long]] => Encoder.encodeSeq[Option[Long]].apply(enc0)
    case enc1 : QuebrachineClass => Encoder.AsObject[QuebrachineClass].apply(enc1)
}

type TruantcyElement = Boolean | TruantcyClass
given Decoder[TruantcyElement] = {
    List[Decoder[TruantcyElement]](
        Decoder[Boolean].widen,
        Decoder[TruantcyClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[TruantcyElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : TruantcyClass => Encoder.AsObject[TruantcyClass].apply(enc1)
}

case class TruantcyClass (
    val alfiona : Option[Json] = None,
    val ascaridiasis : Option[Json] = None,
    val bungey : Option[Json] = None,
    val catharticalness : Option[Double] = None,
    val ceroxyle : Option[Json] = None,
    val Chirotherium : Option[Long] = None,
    val chorology : Option[Json] = None,
    val disdiapason : Option[String] = None,
    val enmarble : Option[Json] = None,
    val Epeira : Option[Json] = None,
    val Eurylaimi : Option[Json] = None,
    val germination : Option[Json] = None,
    val hallelujah : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val lev : Option[Json] = None,
    val mouthing : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val philliloo : Option[Json] = None,
    val planetal : Option[Json] = None,
    val poney : Option[Json] = None,
    val punctualist : Option[Json] = None,
    val returnlessly : Option[Json] = None,
    val skelder : Option[Json] = None,
    val windwaywardly : Option[Json] = None,
    val Yuman : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Unbeginning = Map[String, Long] | Seq[Option[Json]] | String
given Decoder[Unbeginning] = {
    List[Decoder[Unbeginning]](
        Decoder[String].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Unbeginning] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Undesirability = Seq[Long] | Map[String, Long] | String
given Decoder[Undesirability] = {
    List[Decoder[Undesirability]](
        Decoder[String].widen,
        Decoder[Seq[Long]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Undesirability] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Unerasing = Map[String, Long] | Long | Seq[Option[Json]]
given Decoder[Unerasing] = {
    List[Decoder[Unerasing]](
        Decoder[Long].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Unerasing] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Unguentarium = Long | Seq[Option[Json]] | NullValue
given Decoder[Unguentarium] = {
    List[Decoder[Unguentarium]](
        Decoder[Long].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Unguentarium] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type UnimpeachablyElement = Boolean | UnimpeachablyClass
given Decoder[UnimpeachablyElement] = {
    List[Decoder[UnimpeachablyElement]](
        Decoder[Boolean].widen,
        Decoder[UnimpeachablyClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnimpeachablyElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : UnimpeachablyClass => Encoder.AsObject[UnimpeachablyClass].apply(enc1)
}

case class UnimpeachablyClass (
    val acerin : Option[Long] = None,
    val Bobadil : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val chlorophylligenous : Option[Long] = None,
    val conversational : Option[Long] = None,
    val demiowl : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val ectorhinal : Option[Long] = None,
    val gamblesomeness : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val irrorate : Option[Long] = None,
    val kindergartening : Option[Long] = None,
    val lateritic : Option[Long] = None,
    val mespil : Option[Long] = None,
    val misconfiguration : Option[Long] = None,
    val nonbookish : Option[Json] = None,
    val planometry : Option[Long] = None,
    val Quiina : Option[Long] = None,
    val Robert : Option[Long] = None,
    val rot : Option[Long] = None,
    val subcinctorium : Option[Long] = None,
    val tussocker : Option[Long] = None,
    val ultraproud : Option[Long] = None,
    val unsuggestedness : Option[Long] = None
) derives Encoder.AsObject, Decoder

type Unmortgaged = Double | Map[String, Long] | NullValue
given Decoder[Unmortgaged] = {
    List[Decoder[Unmortgaged]](
        Decoder[Double].widen,
        Decoder[Map[String, Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Unmortgaged] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Unobstructed = Long | QuebrachineClass | NullValue
given Decoder[Unobstructed] = {
    List[Decoder[Unobstructed]](
        Decoder[Long].widen,
        Decoder[QuebrachineClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Unobstructed] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : QuebrachineClass => Encoder.AsObject[QuebrachineClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Unreceptivity = Long | Seq[Option[Json]] | String
given Decoder[Unreceptivity] = {
    List[Decoder[Unreceptivity]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Unreceptivity] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc2)
}

type Unsatisfactoriness = Boolean | Seq[Long] | Long
given Decoder[Unsatisfactoriness] = {
    List[Decoder[Unsatisfactoriness]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Unsatisfactoriness] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc2)
}

type UnstressedElement = Boolean | String | UnstressedClass
given Decoder[UnstressedElement] = {
    List[Decoder[UnstressedElement]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[UnstressedClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[UnstressedElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : UnstressedClass => Encoder.AsObject[UnstressedClass].apply(enc2)
}

case class UnstressedClass (
    val Alain : Option[Json] = None,
    val Amphirhina : Option[Json] = None,
    val antimachinery : Option[Json] = None,
    val coldish : Option[Json] = None,
    val crantara : Option[Json] = None,
    val distinguishing : Option[Json] = None,
    val elytroposis : Option[Json] = None,
    val gentianwort : Option[Json] = None,
    val heliosis : Option[Json] = None,
    val instrumental : Option[Json] = None,
    val introinflection : Option[Json] = None,
    val kala : Option[Json] = None,
    val Lincolnian : Option[Json] = None,
    val metad : Option[Json] = None,
    val Sarcophilus : Option[Json] = None,
    val swingingly : Option[Json] = None,
    val unconformity : Option[Json] = None,
    val undecreed : Option[Json] = None,
    val venerable : Option[Json] = None,
    val vowellessness : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Untasked = Double | Map[String, Long] | Seq[Option[Json]]
given Decoder[Untasked] = {
    List[Decoder[Untasked]](
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Untasked] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Unvarying = Boolean | Double | Map[String, Long]
given Decoder[Unvarying] = {
    List[Decoder[Unvarying]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Unvarying] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Vehemently = Boolean | Seq[Option[Json]] | NullValue
given Decoder[Vehemently] = {
    List[Decoder[Vehemently]](
        Decoder[Boolean].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Vehemently] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Whitepot = Double | QuebrachineClass
given Decoder[Whitepot] = {
    List[Decoder[Whitepot]](
        Decoder[Double].widen,
        Decoder[QuebrachineClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Whitepot] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : QuebrachineClass => Encoder.AsObject[QuebrachineClass].apply(enc1)
}

type WrothyElement = Seq[Option[Json]] | WrothyClass
given Decoder[WrothyElement] = {
    List[Decoder[WrothyElement]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[WrothyClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[WrothyElement] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : WrothyClass => Encoder.AsObject[WrothyClass].apply(enc1)
}

case class WrothyClass (
    val Aeschynanthus : Option[Json] = None,
    val aquiferous : Option[Json] = None,
    val cheapener : Option[Json] = None,
    val enumeration : Option[Json] = None,
    val Ephesine : Option[Json] = None,
    val escadrille : Option[Json] = None,
    val estrous : Option[Json] = None,
    val interestedly : Option[Json] = None,
    val katakinetomer : Option[Json] = None,
    val mortification : Option[Json] = None,
    val morula : Option[Json] = None,
    val orthosymmetrical : Option[Json] = None,
    val overbark : Option[Json] = None,
    val politist : Option[Json] = None,
    val qualified : Option[Json] = None,
    val sphenomalar : Option[Json] = None,
    val throatful : Option[Json] = None,
    val transhumance : Option[Json] = None,
    val triandrian : Option[Json] = None,
    val unbooked : Option[Json] = None
) derives Encoder.AsObject, Decoder
