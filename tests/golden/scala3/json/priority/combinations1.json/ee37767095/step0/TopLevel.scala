package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val centrodesmose : String,
    val cerograph : Seq[CerographElement],
    val chemotherapeutics : Seq[ChemotherapeuticElement],
    val cimelia : Seq[CimeliaElement],
    val citrated : Long,
    val clinodome : Seq[Clinodome],
    val coadjust : Seq[CoadjustElement],
    val consilience : Seq[Consilience],
    val constructor : Seq[Constructor],
    val continuative : Seq[Continuative],
    val credulity : Seq[CredulityElement],
    val creviced : Seq[Creviced],
    val cubiculum : Seq[Seq[Option[Long]]],
    val deruralize : Seq[DeruralizeElement],
    val diaereses : Seq[DiaereseElement],
    val dissolution : Seq[Option[Seq[Option[Json]]]],
    val downstroke : Seq[Downstroke],
    val electrotautomerism : Seq[Option[Double]],
    val eleutheromania : Seq[Eleutheromania],
    val encrust : Encrust,
    val entomoid : Seq[Entomoid],
    val epipaleolithic : Seq[Epipaleolithic],
    val expropriable : Seq[Expropriable],
    val faggingly : Seq[FagginglyElement],
    val fenks : Seq[FenkElement],
    val flagmaking : Seq[FlagmakingElement],
    val fluorometer : Seq[Fluorometer],
    val fulsome : Seq[Option[Long]],
    val fuzzy : Seq[Fuzzy],
    val gardenwards : Seq[Gardenward],
    val generalissimo : Seq[Generalissimo],
    val habeas : Seq[Option[Map[String, Long]]],
    val hemicrystalline : Seq[Hemicrystalline],
    val hemocoele : Seq[HemocoeleElement],
    val hoister : Seq[Hoister],
    val hyperpiesis : Seq[Hyperpiesi],
    val hyppish : Seq[Hyppish],
    val idealizer : Seq[Idealizer],
    val incrustator : Seq[Incrustator],
    val intentiveness : Seq[Intentiveness],
    val interacinar : Interacinar,
    val intercorrelation : Seq[Option[Seq[Long]]],
    val jacutinga : Seq[Jacutinga]
) derives Encoder.AsObject, Decoder

type CerographElement = CerographClass | String | NullValue
given Decoder[CerographElement] = {
    List[Decoder[CerographElement]](
        Decoder[String].widen,
        Decoder[CerographClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[CerographElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : CerographClass => Encoder.AsObject[CerographClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class CerographClass (
    val apotropaion : Option[Json] = None,
    val casuary : Option[Json] = None,
    val creaker : Option[Json] = None,
    val disqualification : Option[Json] = None,
    val imperatorious : Option[Json] = None,
    val impermeabilize : Option[Json] = None,
    val metastoma : Option[Json] = None,
    val noctidiurnal : Option[Json] = None,
    val nonreserve : Option[Json] = None,
    val ophthalmotonometry : Option[Json] = None,
    val pailful : Option[Json] = None,
    val pigfish : Option[Json] = None,
    val pongee : Option[Json] = None,
    val prosodical : Option[Json] = None,
    val scrofuloderm : Option[Json] = None,
    val storekeeping : Option[Json] = None,
    val therologist : Option[Json] = None,
    val Tolowa : Option[Json] = None,
    val tradeful : Option[Json] = None,
    val unriveting : Option[Json] = None
) derives Encoder.AsObject, Decoder

type ChemotherapeuticElement = ChemotherapeuticClass | Long
given Decoder[ChemotherapeuticElement] = {
    List[Decoder[ChemotherapeuticElement]](
        Decoder[Long].widen,
        Decoder[ChemotherapeuticClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[ChemotherapeuticElement] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : ChemotherapeuticClass => Encoder.AsObject[ChemotherapeuticClass].apply(enc1)
}

case class ChemotherapeuticClass (
    val angioneurotic : Option[Json] = None,
    val availment : Option[Json] = None,
    val bladelet : Option[Json] = None,
    val catharticalness : Option[Double] = None,
    val caulis : Option[Json] = None,
    val chalcus : Option[Json] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val enteradenological : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val imporosity : Option[Json] = None,
    val insistently : Option[Json] = None,
    val intraparietal : Option[Json] = None,
    val ivied : Option[Json] = None,
    val Maureen : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val nostochine : Option[Json] = None,
    val nutcracker : Option[Json] = None,
    val ofttimes : Option[Json] = None,
    val phenocryst : Option[Json] = None,
    val precoincident : Option[Json] = None,
    val ramiferous : Option[Json] = None,
    val stagmometer : Option[Json] = None,
    val tetherball : Option[Json] = None,
    val unshy : Option[Json] = None
) derives Encoder.AsObject, Decoder

type CimeliaElement = CimeliaClass | Seq[Long] | NullValue
given Decoder[CimeliaElement] = {
    List[Decoder[CimeliaElement]](
        Decoder[Seq[Long]].widen,
        Decoder[CimeliaClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[CimeliaElement] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : CimeliaClass => Encoder.AsObject[CimeliaClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

case class CimeliaClass (
    val catharticalness : Double,
    val Chirotherium : Long,
    val disdiapason : String,
    val homocerc : Boolean,
    val nonbookish : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Clinodome = Double | String
given Decoder[Clinodome] = {
    List[Decoder[Clinodome]](
        Decoder[String].widen,
        Decoder[Double].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Clinodome] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
}

type CoadjustElement = CoadjustClass | Double
given Decoder[CoadjustElement] = {
    List[Decoder[CoadjustElement]](
        Decoder[Double].widen,
        Decoder[CoadjustClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[CoadjustElement] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : CoadjustClass => Encoder.AsObject[CoadjustClass].apply(enc1)
}

case class CoadjustClass (
    val amidosulphonal : Option[Json] = None,
    val Benny : Option[Json] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val ensnare : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val hybridizer : Option[Json] = None,
    val leastwise : Option[Json] = None,
    val lof : Option[Json] = None,
    val monkhood : Option[Json] = None,
    val Netherlandish : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val peonism : Option[Json] = None,
    val Phonelescope : Option[Json] = None,
    val porphyrogeniture : Option[Json] = None,
    val preindemnify : Option[Json] = None,
    val rosal : Option[Json] = None,
    val scalenous : Option[Json] = None,
    val scopine : Option[Json] = None,
    val Sedaceae : Option[Json] = None,
    val suberinize : Option[Json] = None,
    val symbiot : Option[Json] = None,
    val tablefellow : Option[Json] = None,
    val unchargeable : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Consilience = Double | Map[String, Long]
given Decoder[Consilience] = {
    List[Decoder[Consilience]](
        Decoder[Double].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Consilience] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
}

type Constructor = Boolean | Map[String, Option[Long]]
given Decoder[Constructor] = {
    List[Decoder[Constructor]](
        Decoder[Boolean].widen,
        Decoder[Map[String, Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Constructor] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Map[String, Option[Long]] => Encoder.encodeMap[String,Option[Long]].apply(enc1)
}

type Continuative = Map[String, Long] | String
given Decoder[Continuative] = {
    List[Decoder[Continuative]](
        Decoder[String].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Continuative] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
}

type CredulityElement = CredulityClass | Long | String
given Decoder[CredulityElement] = {
    List[Decoder[CredulityElement]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[CredulityClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[CredulityElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : CredulityClass => Encoder.AsObject[CredulityClass].apply(enc2)
}

case class CredulityClass (
    val ammonolytic : Option[Json] = None,
    val bushmaster : Option[Json] = None,
    val considering : Option[Json] = None,
    val consuetudinary : Option[Json] = None,
    val embarras : Option[Json] = None,
    val fineness : Option[Json] = None,
    val flaithship : Option[Json] = None,
    val Flavia : Option[Json] = None,
    val gruffly : Option[Json] = None,
    val Hedychium : Option[Json] = None,
    val leadwort : Option[Json] = None,
    val overseriously : Option[Json] = None,
    val parabola : Option[Json] = None,
    val pectinatodenticulate : Option[Json] = None,
    val Popean : Option[Json] = None,
    val pornocrat : Option[Json] = None,
    val quadrisect : Option[Json] = None,
    val seriality : Option[Json] = None,
    val vamphorn : Option[Json] = None,
    val wharp : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Creviced = Boolean | Map[String, Long] | String
given Decoder[Creviced] = {
    List[Decoder[Creviced]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Creviced] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

type DeruralizeElement = Boolean | DeruralizeClass | Seq[Option[Json]]
given Decoder[DeruralizeElement] = {
    List[Decoder[DeruralizeElement]](
        Decoder[Boolean].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[DeruralizeClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[DeruralizeElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : DeruralizeClass => Encoder.AsObject[DeruralizeClass].apply(enc2)
}

case class DeruralizeClass (
    val bockerel : Option[Json] = None,
    val boulder : Option[Json] = None,
    val churrus : Option[Json] = None,
    val counterdigged : Option[Json] = None,
    val dialogite : Option[Json] = None,
    val digenic : Option[Json] = None,
    val dunbird : Option[Json] = None,
    val ergatogyne : Option[Json] = None,
    val fiendful : Option[Json] = None,
    val jackrod : Option[Json] = None,
    val Jehovistic : Option[Json] = None,
    val Paninean : Option[Json] = None,
    val panther : Option[Json] = None,
    val placentigerous : Option[Json] = None,
    val Romney : Option[Json] = None,
    val sparm : Option[Json] = None,
    val tocsin : Option[Json] = None,
    val unnicked : Option[Json] = None,
    val unstavable : Option[Json] = None,
    val windfirm : Option[Json] = None
) derives Encoder.AsObject, Decoder

type DiaereseElement = Boolean | DiaereseClass | Seq[Long]
given Decoder[DiaereseElement] = {
    List[Decoder[DiaereseElement]](
        Decoder[Boolean].widen,
        Decoder[Seq[Long]].widen,
        Decoder[DiaereseClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[DiaereseElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
    case enc2 : DiaereseClass => Encoder.AsObject[DiaereseClass].apply(enc2)
}

case class DiaereseClass (
    val Amoreuxia : Option[Json] = None,
    val ani : Option[Json] = None,
    val bernicle : Option[Json] = None,
    val blackwasher : Option[Json] = None,
    val blowhard : Option[Json] = None,
    val broma : Option[Json] = None,
    val closecross : Option[Json] = None,
    val congregationalism : Option[Json] = None,
    val grayly : Option[Json] = None,
    val historically : Option[Json] = None,
    val hoast : Option[Json] = None,
    val irretentive : Option[Json] = None,
    val parcener : Option[Json] = None,
    val pedder : Option[Json] = None,
    val pseudoanatomic : Option[Json] = None,
    val rhizocarpian : Option[Json] = None,
    val samel : Option[Json] = None,
    val silker : Option[Json] = None,
    val subdentated : Option[Json] = None,
    val subobscure : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Downstroke = Boolean | Seq[Option[Json]] | String
given Decoder[Downstroke] = {
    List[Decoder[Downstroke]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Seq[Option[Json]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Downstroke] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc2)
}

type Eleutheromania = Double | Map[String, Long] | String
given Decoder[Eleutheromania] = {
    List[Decoder[Eleutheromania]](
        Decoder[String].widen,
        Decoder[Double].widen,
        Decoder[Map[String, Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Eleutheromania] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc2)
}

case class Encrust (
    val comradely : Option[Json] = None,
    val diacanthous : Option[Json] = None,
    val feminineness : Option[Json] = None,
    val gossamered : Option[Json] = None,
    val Hibernia : Option[Json] = None,
    val Hibiscus : Option[Json] = None,
    val Lepidosauria : Option[Json] = None,
    val lollingly : Option[Json] = None,
    val manager : Option[Json] = None,
    val mechanic : Option[Json] = None,
    val overminuteness : Option[Json] = None,
    val papelonne : Option[Json] = None,
    val plebification : Option[Json] = None,
    val pugmiller : Option[Json] = None,
    val recoveror : Option[Json] = None,
    val spermatoblastic : Option[Json] = None,
    val Syllidae : Option[Json] = None,
    val ungyved : Option[Json] = None,
    val whirlabout : Option[Json] = None,
    val woodenware : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Entomoid = CimeliaClass | Long
given Decoder[Entomoid] = {
    List[Decoder[Entomoid]](
        Decoder[Long].widen,
        Decoder[CimeliaClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Entomoid] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : CimeliaClass => Encoder.AsObject[CimeliaClass].apply(enc1)
}

type Epipaleolithic = Double | Seq[Long]
given Decoder[Epipaleolithic] = {
    List[Decoder[Epipaleolithic]](
        Decoder[Double].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Epipaleolithic] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc1)
}

type Expropriable = CimeliaClass | Double | Seq[Option[Json]]
given Decoder[Expropriable] = {
    List[Decoder[Expropriable]](
        Decoder[Double].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[CimeliaClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Expropriable] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : CimeliaClass => Encoder.AsObject[CimeliaClass].apply(enc2)
}

type FagginglyElement = Double | FagginglyClass
given Decoder[FagginglyElement] = {
    List[Decoder[FagginglyElement]](
        Decoder[Double].widen,
        Decoder[FagginglyClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[FagginglyElement] = Encoder.instance {
    case enc0 : Double => Encoder.encodeDouble(enc0)
    case enc1 : FagginglyClass => Encoder.AsObject[FagginglyClass].apply(enc1)
}

case class FagginglyClass (
    val abranchian : Option[Json] = None,
    val aculeiform : Option[Json] = None,
    val adiaphoristic : Option[Json] = None,
    val adoptionism : Option[Json] = None,
    val Anglic : Option[Json] = None,
    val antrotomy : Option[Json] = None,
    val coerciveness : Option[Json] = None,
    val decorist : Option[Json] = None,
    val duckhood : Option[Json] = None,
    val Heteromeri : Option[Json] = None,
    val hypochnose : Option[Json] = None,
    val lochage : Option[Json] = None,
    val melee : Option[Json] = None,
    val nonconformitant : Option[Json] = None,
    val Poinsettia : Option[Json] = None,
    val putatively : Option[Json] = None,
    val semivolatile : Option[Json] = None,
    val soleas : Option[Json] = None,
    val unfastenable : Option[Json] = None,
    val unmillinered : Option[Json] = None
) derives Encoder.AsObject, Decoder

type FenkElement = FenkClass | String
given Decoder[FenkElement] = {
    List[Decoder[FenkElement]](
        Decoder[String].widen,
        Decoder[FenkClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[FenkElement] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : FenkClass => Encoder.AsObject[FenkClass].apply(enc1)
}

case class FenkClass (
    val apoise : Option[Json] = None,
    val astronomize : Option[Json] = None,
    val cockhorse : Option[Json] = None,
    val copular : Option[Json] = None,
    val Dagomba : Option[Json] = None,
    val draffy : Option[Json] = None,
    val foreigner : Option[Json] = None,
    val Guyandot : Option[Json] = None,
    val neurogliosis : Option[Json] = None,
    val osmious : Option[Json] = None,
    val palpitate : Option[Json] = None,
    val rebukeable : Option[Json] = None,
    val Reinwardtia : Option[Json] = None,
    val reservatory : Option[Json] = None,
    val scalt : Option[Json] = None,
    val scripturalize : Option[Json] = None,
    val tintometer : Option[Json] = None,
    val Tritoness : Option[Json] = None,
    val undergrade : Option[Json] = None,
    val undermountain : Option[Json] = None
) derives Encoder.AsObject, Decoder

type FlagmakingElement = Boolean | Double | FlagmakingClass
given Decoder[FlagmakingElement] = {
    List[Decoder[FlagmakingElement]](
        Decoder[Boolean].widen,
        Decoder[Double].widen,
        Decoder[FlagmakingClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[FlagmakingElement] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : FlagmakingClass => Encoder.AsObject[FlagmakingClass].apply(enc2)
}

case class FlagmakingClass (
    val albarco : Option[Json] = None,
    val Bunodonta : Option[Json] = None,
    val hornify : Option[Json] = None,
    val Hydrocorisae : Option[Json] = None,
    val hypoglossus : Option[Json] = None,
    val inexpiably : Option[Json] = None,
    val ingratitude : Option[Json] = None,
    val ladyfly : Option[Json] = None,
    val medicament : Option[Json] = None,
    val monogrammatic : Option[Json] = None,
    val nobbut : Option[Json] = None,
    val Notacanthidae : Option[Json] = None,
    val polyplacophore : Option[Json] = None,
    val proexercise : Option[Json] = None,
    val protoplast : Option[Json] = None,
    val puzzling : Option[Json] = None,
    val splanchnoskeleton : Option[Json] = None,
    val unloveliness : Option[Json] = None,
    val unquarantined : Option[Json] = None,
    val unrenounceable : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Fluorometer = Long | String | NullValue
given Decoder[Fluorometer] = {
    List[Decoder[Fluorometer]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Fluorometer] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Fuzzy = Long | Map[String, Option[Long]]
given Decoder[Fuzzy] = {
    List[Decoder[Fuzzy]](
        Decoder[Long].widen,
        Decoder[Map[String, Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Fuzzy] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Map[String, Option[Long]] => Encoder.encodeMap[String,Option[Long]].apply(enc1)
}

type Gardenward = Boolean | Seq[Long] | String
given Decoder[Gardenward] = {
    List[Decoder[Gardenward]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Gardenward] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc2)
}

type Generalissimo = Boolean | Map[String, Long] | NullValue
given Decoder[Generalissimo] = {
    List[Decoder[Generalissimo]](
        Decoder[Boolean].widen,
        Decoder[Map[String, Long]].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Generalissimo] = Encoder.instance {
    case enc0 : Boolean => Encoder.encodeBoolean(enc0)
    case enc1 : Map[String, Long] => Encoder.encodeMap[String,Long].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Hemicrystalline = CimeliaClass | String
given Decoder[Hemicrystalline] = {
    List[Decoder[Hemicrystalline]](
        Decoder[String].widen,
        Decoder[CimeliaClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Hemicrystalline] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : CimeliaClass => Encoder.AsObject[CimeliaClass].apply(enc1)
}

type HemocoeleElement = HemocoeleClass | Seq[Long]
given Decoder[HemocoeleElement] = {
    List[Decoder[HemocoeleElement]](
        Decoder[Seq[Long]].widen,
        Decoder[HemocoeleClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[HemocoeleElement] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : HemocoeleClass => Encoder.AsObject[HemocoeleClass].apply(enc1)
}

case class HemocoeleClass (
    val acrogamy : Option[Json] = None,
    val amelification : Option[Json] = None,
    val autobiographic : Option[Json] = None,
    val berat : Option[Json] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val disproportionably : Option[Json] = None,
    val erythrite : Option[Json] = None,
    val graphic : Option[Json] = None,
    val hepatological : Option[Json] = None,
    val homocerc : Option[Boolean] = None,
    val incommensurably : Option[Json] = None,
    val misaffirm : Option[Json] = None,
    val nonbookish : Option[Json] = None,
    val pocketbook : Option[Json] = None,
    val sclerometric : Option[Json] = None,
    val stambouline : Option[Json] = None,
    val stickpin : Option[Json] = None,
    val tubulure : Option[Json] = None,
    val undelated : Option[Json] = None,
    val unsalt : Option[Json] = None,
    val untutelar : Option[Json] = None,
    val vagrant : Option[Json] = None,
    val Walt : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Hoister = CimeliaClass | String | NullValue
given Decoder[Hoister] = {
    List[Decoder[Hoister]](
        Decoder[String].widen,
        Decoder[CimeliaClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Hoister] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : CimeliaClass => Encoder.AsObject[CimeliaClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Hyperpiesi = CimeliaClass | Seq[Option[Json]] | NullValue
given Decoder[Hyperpiesi] = {
    List[Decoder[Hyperpiesi]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[CimeliaClass].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Hyperpiesi] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : CimeliaClass => Encoder.AsObject[CimeliaClass].apply(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Hyppish = Boolean | String | NullValue
given Decoder[Hyppish] = {
    List[Decoder[Hyppish]](
        Decoder[String].widen,
        Decoder[Boolean].widen,
        Decoder[NullValue].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Hyppish] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Boolean => Encoder.encodeBoolean(enc1)
    case enc2 : NullValue => Encoder.encodeNone(enc2)
}

type Idealizer = CimeliaClass | Long | Seq[Option[Json]]
given Decoder[Idealizer] = {
    List[Decoder[Idealizer]](
        Decoder[Long].widen,
        Decoder[Seq[Option[Json]]].widen,
        Decoder[CimeliaClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Idealizer] = Encoder.instance {
    case enc0 : Long => Encoder.encodeLong(enc0)
    case enc1 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc1)
    case enc2 : CimeliaClass => Encoder.AsObject[CimeliaClass].apply(enc2)
}

type Incrustator = Seq[Long] | Long | String
given Decoder[Incrustator] = {
    List[Decoder[Incrustator]](
        Decoder[String].widen,
        Decoder[Long].widen,
        Decoder[Seq[Long]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Incrustator] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Long => Encoder.encodeLong(enc1)
    case enc2 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc2)
}

type Intentiveness = CimeliaClass | Double | String
given Decoder[Intentiveness] = {
    List[Decoder[Intentiveness]](
        Decoder[String].widen,
        Decoder[Double].widen,
        Decoder[CimeliaClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Intentiveness] = Encoder.instance {
    case enc0 : String => Encoder.encodeString(enc0)
    case enc1 : Double => Encoder.encodeDouble(enc1)
    case enc2 : CimeliaClass => Encoder.AsObject[CimeliaClass].apply(enc2)
}

case class Interacinar (
    val assapan : Double,
    val benefactorship : Boolean,
    val triseriatim : String,
    val tubbing : Long,
    val untrimmed : Option[Json] = None
) derives Encoder.AsObject, Decoder

type Jacutinga = Seq[Long] | Map[String, Option[Long]]
given Decoder[Jacutinga] = {
    List[Decoder[Jacutinga]](
        Decoder[Seq[Long]].widen,
        Decoder[Map[String, Option[Long]]].widen,
    ).reduceLeft(_ or _)
}

given Encoder[Jacutinga] = Encoder.instance {
    case enc0 : Seq[Long] => Encoder.encodeSeq[Long].apply(enc0)
    case enc1 : Map[String, Option[Long]] => Encoder.encodeMap[String,Option[Long]].apply(enc1)
}
