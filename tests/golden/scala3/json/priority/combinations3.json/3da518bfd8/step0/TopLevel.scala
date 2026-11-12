package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val juror : Seq[JurorElement],
    val kongoni : Seq[Kongoni],
    val ladronism : Seq[LadronismElement],
    val landlubberly : Seq[LandlubberlyElement],
    val listener : Seq[Listener],
    val lupus : Seq[LupusElement],
    val maslin : Seq[Maslin],
    val monazite : Seq[MonaziteElement],
    val monoliteral : Seq[Monoliteral],
    val monotheistically : Seq[MonotheisticallyElement],
    val montage : Seq[Montage],
    val moralness : Seq[Moralness],
    val mowra : Seq[Option[MonaziteClass]],
    val mulishly : Seq[Mulishly],
    val myoscope : Seq[Myoscope],
    val nach : Seq[Option[Seq[Option[Long]]]],
    val neuromastic : Seq[Neuromastic],
    val noncontributing : Seq[Noncontributing],
    val nonnervous : Seq[Nonnervous],
    val nonvaluation : Seq[Nonvaluation],
    val occupationalist : Seq[OccupationalistElement],
    val outrival : Seq[OutrivalElement],
    val paleographically : Seq[Paleographically],
    val pamphletwise : Seq[Pamphletwise],
    val pediatrics : Seq[Pediatric],
    val perceptive : Seq[Boolean],
    val piaculum : Seq[PiaculumElement],
    val piccadilly : Seq[Piccadilly],
    val piffler : Seq[Piffler],
    val pithful : Seq[Pithful],
    val placuntitis : Seq[Placuntiti],
    val plectopterous : Seq[Plectopterous],
    val pneumocele : Seq[Option[Pneumocele]],
    val poliorcetic : Seq[Poliorcetic],
    val poormaster : Seq[Poormaster],
    val potwhisky : Seq[PotwhiskyElement],
    val practicalizer : Seq[Practicalizer],
    val prefreshman : Seq[PrefreshmanElement],
    val prehensility : Seq[Prehensility],
    val prevoidance : Seq[Prevoidance],
    val probant : Seq[Map[String, Option[Long]]],
    val protext : Seq[Protext]
) derives Encoder.AsObject, Decoder

type JurorElement = Boolean | JurorClass
given Decoder[JurorElement] = {
    List[Decoder[JurorElement]](
        Decoder[Boolean].widen,
        Decoder[JurorClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[JurorElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : JurorClass => Encoder.AsObject[JurorClass].apply(enc1)
}

case class JurorClass (
    val adipsy : Option[Json] = None,
    val auxiliator : Option[Json] = None,
    val benda : Option[Json] = None,
    val benjamin : Option[Json] = None,
    val brandling : Option[Json] = None,
    val epicurishly : Option[Json] = None,
    val eremochaetous : Option[Json] = None,
    val marten : Option[Json] = None,
    val monocline : Option[Json] = None,
    val Olea : Option[Json] = None,
    val palgat : Option[Json] = None,
    val pennyworth : Option[Json] = None,
    val pioury : Option[Json] = None,
    val pragmatistic : Option[Json] = None,
    val stylelessness : Option[Json] = None,
    val systematical : Option[Json] = None,
    val thready : Option[Json] = None,
    val uncontemporary : Option[Json] = None,
    val uncouched : Option[Json] = None,
    val uninhabitedness : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Kongoni = Seq[Long] | Map[String, Long]
given Decoder[Kongoni] = {
    List[Decoder[Kongoni]](
        Decoder[Seq[Long]].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Kongoni] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
}

type LadronismElement = Double | LadronismClass | String
given Decoder[LadronismElement] = {
    List[Decoder[LadronismElement]](
        Decoder[String].widen,
        Decoder[Double].widen,
        Decoder[LadronismClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[LadronismElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : LadronismClass => Encoder.AsObject[LadronismClass].apply(enc2)
}

case class LadronismClass (
    val acclaimer : Option[Json] = None,
    val achree : Option[Json] = None,
    val base : Option[Json] = None,
    val conundrumize : Option[Json] = None,
    val degerminator : Option[Json] = None,
    val describable : Option[Json] = None,
    val exasperatedly : Option[Json] = None,
    val heroine : Option[Json] = None,
    val indazin : Option[Json] = None,
    val luteous : Option[Json] = None,
    val papular : Option[Json] = None,
    val pritch : Option[Json] = None,
    val Prodenia : Option[Json] = None,
    val seege : Option[Json] = None,
    val shopgirl : Option[Json] = None,
    val tragedietta : Option[Json] = None,
    val unsparse : Option[Json] = None,
    val uplook : Option[Json] = None,
    val vermiformis : Option[Json] = None,
    val whafabout : Option[Json] = None
) derives Encoder.AsObject, Decoder

type LandlubberlyElement = Boolean | Long | LandlubberlyClass
given Decoder[LandlubberlyElement] = {
    List[Decoder[LandlubberlyElement]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[LandlubberlyClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[LandlubberlyElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : LandlubberlyClass => Encoder.AsObject[LandlubberlyClass].apply(enc2)
}

case class LandlubberlyClass (
    val acropoleis : Option[Json] = None,
    val aminate : Option[Json] = None,
    val Amyraldism : Option[Json] = None,
    val bipenniform : Option[Json] = None,
    val bugre : Option[Json] = None,
    val calycule : Option[Json] = None,
    val caoutchouc : Option[Json] = None,
    val disprover : Option[Json] = None,
    val fitroot : Option[Json] = None,
    val fulgently : Option[Json] = None,
    val kickup : Option[Json] = None,
    val laevoversion : Option[Json] = None,
    val moter : Option[Json] = None,
    val objectivity : Option[Json] = None,
    val posterity : Option[Json] = None,
    val postnuptial : Option[Json] = None,
    val precedentary : Option[Json] = None,
    val saddling : Option[Json] = None,
    val subcurrent : Option[Json] = None,
    val unrecriminative : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Listener = Long | Seq[Option[Json]]
given Decoder[Listener] = {
    List[Decoder[Listener]](
        Decoder[Long].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Listener] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
}

type LupusElement = Long | LupusClass
given Decoder[LupusElement] = {
    List[Decoder[LupusElement]](
        Decoder[Long].widen,
        Decoder[LupusClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[LupusElement] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : LupusClass => Encoder.AsObject[LupusClass].apply(enc1)
}

case class LupusClass (
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val Chlorioninae : Option[Long] = None,
    val Corvinae : Option[Long] = None,
    val Crassina : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val exiguity : Option[Long] = None,
    val farcist : Option[Long] = None,
    val holographical : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val ichthyophagan : Option[Long] = None,
    val implacable : Option[Long] = None,
    val nonbookish : Option[Json] = None,
    val outshiner : Option[Long] = None,
    val overweather : Option[Long] = None,
    val protonegroid : Option[Long] = None,
    val shallowish : Option[Long] = None,
    val snoke : Option[Long] = None,
    val snout : Option[Long] = None,
    val surveillance : Option[Long] = None,
    val threshingtime : Option[Long] = None,
    val Thysanocarpus : Option[Long] = None,
    val unsignificantly : Option[Long] = None,
    val unsnap : Option[Long] = None,
    val vendible : Option[Long] = None
) derives Encoder.AsObject, Decoder

case class Maslin (
    val Alicant : Option[Long] = None,
    val antiatonement : Option[Json] = None,
    val anticorrosive : Option[Long] = None,
    val aphidozer : Option[Json] = None,
    val Bakuninist : Option[Json] = None,
    val be : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val chub : Option[Long] = None,
    val cuprosilicon : Option[Long] = None,
    val curtailedly : Option[Long] = None,
    val dellenite : Option[Long] = None,
    val Dimitry : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val edifying : Option[Json] = None,
    val ethmoiditis : Option[Long] = None,
    val gastralgy : Option[Json] = None,
    val goatherd : Option[Long] = None,
    val hammerdress : Option[Long] = None,
    val hangfire : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val lacunosity : Option[Long] = None,
    val longiloquence : Option[Json] = None,
    val mameliere : Option[Long] = None,
    val motherless : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val noncorrodible : Option[Json] = None,
    val nonsensicality : Option[Json] = None,
    val oafishly : Option[Long] = None,
    val pfund : Option[Json] = None,
    val preadvisory : Option[Json] = None,
    val retroflexed : Option[Json] = None,
    val saccharulmic : Option[Long] = None,
    val scowlful : Option[Long] = None,
    val secluded : Option[Json] = None,
    val slackage : Option[Json] = None,
    val sphaeridial : Option[Long] = None,
    val spondulics : Option[Json] = None,
    val subsecive : Option[Long] = None,
    val swellmobsman : Option[Json] = None,
    val trachyglossate : Option[Long] = None,
    val trialogue : Option[Json] = None,
    val unassuaged : Option[Long] = None,
    val ungross : Option[Json] = None,
    val unjudiciously : Option[Json] = None
) derives Encoder.AsObject, Decoder

type MonaziteElement = Double | MonaziteClass
given Decoder[MonaziteElement] = {
    List[Decoder[MonaziteElement]](
        Decoder[Double].widen,
        Decoder[MonaziteClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[MonaziteElement] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : MonaziteClass => Encoder.AsObject[MonaziteClass].apply(enc1)
}

case class MonaziteClass (
    val catharticalness : Double,
    val Chirotherium : Long,
    val disdiapason : String,
    val homocerc : Boolean,
    val nonbookish : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Monoliteral = Boolean | Seq[Option[Json]]
given Decoder[Monoliteral] = {
    List[Decoder[Monoliteral]](
        Decoder[Boolean].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Monoliteral] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
}

type MonotheisticallyElement = MonotheisticallyClass | Seq[Option[Json]]
given Decoder[MonotheisticallyElement] = {
    List[Decoder[MonotheisticallyElement]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[MonotheisticallyClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[MonotheisticallyElement] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : MonotheisticallyClass => Encoder.AsObject[MonotheisticallyClass].apply(enc1)
}

case class MonotheisticallyClass (
    val blaspheme : Option[Json] = None,
    val catharticalness : Option[Double] = None,
    val celiosalpingectomy : Option[Json] = None,
    val Chirotherium : Option[Long] = None,
    val consummativeness : Option[Json] = None,
    val disdiapason : Option[String] = None,
    val egestive : Option[Json] = None,
    val enchylema : Option[Json] = None,
    val gasconade : Option[Json] = None,
    val holidayer : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val intuitionalism : Option[Json] = None,
    val lophiostomate : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val nonvolition : Option[Json] = None,
    val palatableness : Option[Json] = None,
    val pimpery : Option[Json] = None,
    val previolation : Option[Json] = None,
    val reconveyance : Option[Json] = None,
    val registership : Option[Json] = None,
    val rhyacolite : Option[Json] = None,
    val smithereens : Option[Json] = None,
    val superedification : Option[Json] = None,
    val trust : Option[Json] = None,
    val whitestone : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Montage = Double | Seq[Option[Json]] | String
given Decoder[Montage] = {
    List[Decoder[Montage]](
        Decoder[String].widen,
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Montage] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc2)
}

type Moralness = Double | Seq[Option[Json]] | NullValue
given Decoder[Moralness] = {
    List[Decoder[Moralness]](
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Moralness] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Mulishly = Double | Seq[Long] | NullValue
given Decoder[Mulishly] = {
    List[Decoder[Mulishly]](
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Mulishly] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Myoscope = Boolean | Long | Seq[Option[Json]]
given Decoder[Myoscope] = {
    List[Decoder[Myoscope]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Myoscope] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc2)
}

type Neuromastic = Double | Seq[Option[Json]]
given Decoder[Neuromastic] = {
    List[Decoder[Neuromastic]](
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Neuromastic] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
}

case class Noncontributing (
    val estevin : String,
    val jolterhead : Double,
    val sauternes : Long,
    val sparsely : Boolean,
    val unrequested : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Nonnervous = Boolean | Long
given Decoder[Nonnervous] = {
    List[Decoder[Nonnervous]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Nonnervous] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
}

type Nonvaluation = Boolean | Double | Seq[Option[Json]]
given Decoder[Nonvaluation] = {
    List[Decoder[Nonvaluation]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Nonvaluation] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc2)
}

type OccupationalistElement = Seq[Option[Json]] | OccupationalistClass | NullValue
given Decoder[OccupationalistElement] = {
    List[Decoder[OccupationalistElement]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[OccupationalistClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[OccupationalistElement] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : OccupationalistClass => Encoder.AsObject[OccupationalistClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class OccupationalistClass (
    val beholdable : Option[Json] = None,
    val brotuliform : Option[Json] = None,
    val Chimakum : Option[Json] = None,
    val doodler : Option[Json] = None,
    val emulsin : Option[Json] = None,
    val Fin : Option[Json] = None,
    val flourishing : Option[Json] = None,
    val flueless : Option[Json] = None,
    val furtively : Option[Json] = None,
    val gritter : Option[Json] = None,
    val interwish : Option[Json] = None,
    val monoxylic : Option[Json] = None,
    val myristic : Option[Json] = None,
    val nightwear : Option[Json] = None,
    val peruser : Option[Json] = None,
    val theoastrological : Option[Json] = None,
    val thumby : Option[Json] = None,
    val tingitid : Option[Json] = None,
    val trailless : Option[Json] = None,
    val unpocketed : Option[Json] = None
) derives Encoder.AsObject, Decoder

type OutrivalElement = Double | OutrivalClass | NullValue
given Decoder[OutrivalElement] = {
    List[Decoder[OutrivalElement]](
        Decoder[Double].widen,
        Decoder[OutrivalClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[OutrivalElement] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : OutrivalClass => Encoder.AsObject[OutrivalClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class OutrivalClass (
    val adroitly : Option[Json] = None,
    val bridehood : Option[Json] = None,
    val Castoroides : Option[Json] = None,
    val Czechoslovak : Option[Json] = None,
    val diagenesis : Option[Json] = None,
    val dihexahedron : Option[Json] = None,
    val dopester : Option[Json] = None,
    val eumerism : Option[Json] = None,
    val flyness : Option[Json] = None,
    val fouler : Option[Json] = None,
    val laudanosine : Option[Json] = None,
    val Lingulidae : Option[Json] = None,
    val minutary : Option[Json] = None,
    val mitra : Option[Json] = None,
    val opisthorchiasis : Option[Json] = None,
    val pensively : Option[Json] = None,
    val pubigerous : Option[Json] = None,
    val rebellious : Option[Json] = None,
    val recodify : Option[Json] = None,
    val unpaced : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Paleographically = Double | Map[String, Option[Long]]
given Decoder[Paleographically] = {
    List[Decoder[Paleographically]](
        Decoder[Double].widen,
        Decoder[Map[String, Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Paleographically] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Map[String, Option[Long]] => Encoder.encodeMap[String,Option[Long]].apply(enc1)
}

type Pamphletwise = Map[String, Long] | Long | String
given Decoder[Pamphletwise] = {
    List[Decoder[Pamphletwise]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Pamphletwise] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type Pediatric = Boolean | Double | NullValue
given Decoder[Pediatric] = {
    List[Decoder[Pediatric]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Pediatric] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type PiaculumElement = Double | PiaculumClass
given Decoder[PiaculumElement] = {
    List[Decoder[PiaculumElement]](
        Decoder[Double].widen,
        Decoder[PiaculumClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[PiaculumElement] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : PiaculumClass => Encoder.AsObject[PiaculumClass].apply(enc1)
}

case class PiaculumClass (
    val alada : Option[Long] = None,
    val amphistomous : Option[Long] = None,
    val boysenberry : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val decardinalize : Option[Long] = None,
    val discouragement : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val doitrified : Option[Long] = None,
    val hexaspermous : Option[Long] = None,
    val homocerc : Option[Boolean] = None,
    val insinking : Option[Long] = None,
    val loathfulness : Option[Long] = None,
    val miasmatical : Option[Long] = None,
    val neurofibril : Option[Long] = None,
    val nonbookish : Option[Json] = None,
    val phonendoscope : Option[Long] = None,
    val pilferment : Option[Long] = None,
    val predismissory : Option[Long] = None,
    val preinscription : Option[Long] = None,
    val quotative : Option[Long] = None,
    val sienna : Option[Long] = None,
    val thorax : Option[Long] = None,
    val yachting : Option[Long] = None,
    val Zipper : Option[Long] = None
) derives Encoder.AsObject, Decoder

type Piccadilly = Double | String | NullValue
given Decoder[Piccadilly] = {
    List[Decoder[Piccadilly]](
        Decoder[String].widen,
        Decoder[Double].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Piccadilly] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Piffler = MonaziteClass | Seq[Option[Json]]
given Decoder[Piffler] = {
    List[Decoder[Piffler]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[MonaziteClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Piffler] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : MonaziteClass => Encoder.AsObject[MonaziteClass].apply(enc1)
}

type Pithful = Boolean | Long | NullValue
given Decoder[Pithful] = {
    List[Decoder[Pithful]](
        Decoder[Boolean].widen,
        Decoder[Long].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Pithful] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Placuntiti = Map[String, Long] | Long
given Decoder[Placuntiti] = {
    List[Decoder[Placuntiti]](
        Decoder[Long].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Placuntiti] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
}

type Plectopterous = Double | Map[String, Long]
given Decoder[Plectopterous] = {
    List[Decoder[Plectopterous]](
        Decoder[Double].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Plectopterous] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
}

case class Pneumocele (
    val Carbonarism : Option[Json] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val cineolic : Option[Json] = None,
    val cobbly : Option[Json] = None,
    val conchyliferous : Option[Json] = None,
    val congregation : Option[Json] = None,
    val disdiapason : Option[String] = None,
    val enterotomy : Option[Json] = None,
    val entophytal : Option[Json] = None,
    val fewtrils : Option[Json] = None,
    val herem : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val Koniga : Option[Json] = None,
    val meticulosity : Option[Json] = None,
    val Micky : Option[Json] = None,
    val mismarriage : Option[Json] = None,
    val neurotrophic : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val persuasively : Option[Json] = None,
    val replaceable : Option[Json] = None,
    val silex : Option[Json] = None,
    val taillight : Option[Json] = None,
    val unjealous : Option[Json] = None,
    val visitorial : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Poliorcetic = Boolean | MonaziteClass
given Decoder[Poliorcetic] = {
    List[Decoder[Poliorcetic]](
        Decoder[Boolean].widen,
        Decoder[MonaziteClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Poliorcetic] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : MonaziteClass => Encoder.AsObject[MonaziteClass].apply(enc1)
}

type Poormaster = Seq[Long] | Map[String, Long] | NullValue
given Decoder[Poormaster] = {
    List[Decoder[Poormaster]](
        Decoder[Seq[Long]].widen,
        Decoder[Map[String, Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Poormaster] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type PotwhiskyElement = Long | PotwhiskyClass | NullValue
given Decoder[PotwhiskyElement] = {
    List[Decoder[PotwhiskyElement]](
        Decoder[Long].widen,
        Decoder[PotwhiskyClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[PotwhiskyElement] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : PotwhiskyClass => Encoder.AsObject[PotwhiskyClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class PotwhiskyClass (
    val arciform : Option[Json] = None,
    val cresolin : Option[Json] = None,
    val disheartener : Option[Json] = None,
    val disproportionable : Option[Json] = None,
    val Euchorda : Option[Json] = None,
    val ferryway : Option[Json] = None,
    val filamentiferous : Option[Json] = None,
    val flemish : Option[Json] = None,
    val forgainst : Option[Json] = None,
    val grainering : Option[Json] = None,
    val irrevoluble : Option[Json] = None,
    val kindredship : Option[Json] = None,
    val pinguitudinous : Option[Json] = None,
    val simpletonic : Option[Json] = None,
    val singsong : Option[Json] = None,
    val submergement : Option[Json] = None,
    val supraoesophagal : Option[Json] = None,
    val thrashel : Option[Json] = None,
    val tyremesis : Option[Json] = None,
    val Yoruba : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Practicalizer = MonaziteClass | Seq[Option[Json]] | String
given Decoder[Practicalizer] = {
    List[Decoder[Practicalizer]](
        Decoder[String].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[MonaziteClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Practicalizer] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : MonaziteClass => Encoder.AsObject[MonaziteClass].apply(enc2)
}

type PrefreshmanElement = Seq[Option[Json]] | PrefreshmanClass | String
given Decoder[PrefreshmanElement] = {
    List[Decoder[PrefreshmanElement]](
        Decoder[String].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[PrefreshmanClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[PrefreshmanElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : PrefreshmanClass => Encoder.AsObject[PrefreshmanClass].apply(enc2)
}

case class PrefreshmanClass (
    val azorubine : Option[Json] = None,
    val choroiditis : Option[Json] = None,
    val coagulatory : Option[Json] = None,
    val cyclorama : Option[Json] = None,
    val Dolphus : Option[Json] = None,
    val duckhearted : Option[Json] = None,
    val Ficus : Option[Json] = None,
    val Gemaric : Option[Json] = None,
    val jugation : Option[Json] = None,
    val myoliposis : Option[Json] = None,
    val nonnomination : Option[Json] = None,
    val palay : Option[Json] = None,
    val pentactinal : Option[Json] = None,
    val Phaet : Option[Json] = None,
    val piquant : Option[Json] = None,
    val registration : Option[Json] = None,
    val remancipation : Option[Json] = None,
    val scutatiform : Option[Json] = None,
    val theodolite : Option[Json] = None,
    val underward : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Prehensility = Boolean | MonaziteClass | Seq[Option[Json]]
given Decoder[Prehensility] = {
    List[Decoder[Prehensility]](
        Decoder[Boolean].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[MonaziteClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Prehensility] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : MonaziteClass => Encoder.AsObject[MonaziteClass].apply(enc2)
}

type Prevoidance = Seq[Long] | Long | MonaziteClass
given Decoder[Prevoidance] = {
    List[Decoder[Prevoidance]](
        Decoder[Long].widen,
        Decoder[Seq[Long]].widen,
        Decoder[MonaziteClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Prevoidance] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : MonaziteClass => Encoder.AsObject[MonaziteClass].apply(enc2)
}

type Protext = Boolean | Seq[Long] | MonaziteClass
given Decoder[Protext] = {
    List[Decoder[Protext]](
        Decoder[Boolean].widen,
        Decoder[Seq[Long]].widen,
        Decoder[MonaziteClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Protext] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : MonaziteClass => Encoder.AsObject[MonaziteClass].apply(enc2)
}
