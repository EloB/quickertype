package quicktype

// Custom pickler so that missing keys and JSON nulls both read as None,
// and None is left out when writing (upickle's default for Option is a
// JSON array).
object OptionPickler extends upickle.AttributeTagged:
    import upickle.default.Writer
    import upickle.default.Reader
    override implicit def OptionWriter[T: Writer]: Writer[Option[T]] =
        implicitly[Writer[T]].comap[Option[T]] {
            case None => null.asInstanceOf[T]
            case Some(x) => x
        }

    override implicit def OptionReader[T: Reader]: Reader[Option[T]] = {
        new Reader.Delegate[Any, Option[T]](implicitly[Reader[T]].map(Some(_))){
        override def visitNull(index: Int) = None
        }
    }
end OptionPickler

// If a union has a null in, then we'll need this too...
type NullValue = None.type
given OptionPickler.ReadWriter[NullValue] = OptionPickler.readwriter[ujson.Value].bimap[NullValue](
    _ => ujson.Null,
    json => if json.isNull then None else throw new upickle.core.Abort("not null")
)
given OptionPickler.ReadWriter[java.time.Instant] = OptionPickler.readwriter[ujson.Value].bimap(
    value => ujson.Str(value.toString),
    json => json match
        case ujson.Str(value) => java.time.Instant.parse(value)
        case other => throw new upickle.core.Abort("expected date-time, got " + other)
)
given OptionPickler.ReadWriter[java.util.UUID] = OptionPickler.readwriter[String].bimap(
    _.toString,
    value =>
        val uuid = java.util.UUID.fromString(value)
        if uuid.toString.equalsIgnoreCase(value) then uuid else throw new upickle.core.Abort("invalid UUID")
)

object JsonExt:
    val valueReader = OptionPickler.readwriter[ujson.Value]

    // upickle's built-in primitive readers are lenient -- the numeric and
    // boolean readers accept strings, and the string reader accepts
    // numbers and booleans -- so untagged unions need strict readers to
    // pick the right member.
    val strictString: OptionPickler.Reader[String] = valueReader.map {
        case ujson.Str(s) => s
        case json => throw new upickle.core.Abort("expected string, got " + json)
    }
    val strictLong: OptionPickler.Reader[Long] = valueReader.map {
        case ujson.Num(n) if n.isWhole => n.toLong
        case json => throw new upickle.core.Abort("expected integer, got " + json)
    }
    val strictDouble: OptionPickler.Reader[Double] = valueReader.map {
        case ujson.Num(n) => n
        case json => throw new upickle.core.Abort("expected number, got " + json)
    }
    val strictBoolean: OptionPickler.Reader[Boolean] = valueReader.map {
        case ujson.Bool(b) => b
        case json => throw new upickle.core.Abort("expected boolean, got " + json)
    }

    def badMerge[T](r1: => OptionPickler.Reader[?], rest: OptionPickler.Reader[?]*): OptionPickler.Reader[T] = valueReader.map { json =>
        var t: T | Null = null
        val stack       = Vector.newBuilder[Throwable]
        (r1 +: rest).foreach { reader =>
            if t == null then
            try
                t = OptionPickler.read[T](json, trace = true)(using reader.asInstanceOf[OptionPickler.Reader[T]])
            catch
                case exc => stack += exc
        }
        if t != null then t.nn else throw new Exception(json.toString(), stack.result().headOption.getOrElse(null))
    }
end JsonExt
given OptionPickler.Reader[Long] = JsonExt.strictLong


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
    val dissolution : Seq[Option[Seq[Option[ujson.Value]]]],
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
) derives OptionPickler.ReadWriter

type CerographElement = CerographClass | String | NullValue
given unionReaderCerographElement: OptionPickler.Reader[CerographElement] = JsonExt.badMerge[CerographElement](
    JsonExt.strictString,
    summon[OptionPickler.Reader[CerographClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterCerographElement: OptionPickler.Writer[CerographElement] = OptionPickler.writer[ujson.Value].comap[CerographElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: CerographClass => OptionPickler.writeJs[CerographClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class CerographClass (
    val apotropaion : Option[ujson.Value],
    val casuary : Option[ujson.Value],
    val creaker : Option[ujson.Value],
    val disqualification : Option[ujson.Value],
    val imperatorious : Option[ujson.Value],
    val impermeabilize : Option[ujson.Value],
    val metastoma : Option[ujson.Value],
    val noctidiurnal : Option[ujson.Value],
    val nonreserve : Option[ujson.Value],
    val ophthalmotonometry : Option[ujson.Value],
    val pailful : Option[ujson.Value],
    val pigfish : Option[ujson.Value],
    val pongee : Option[ujson.Value],
    val prosodical : Option[ujson.Value],
    val scrofuloderm : Option[ujson.Value],
    val storekeeping : Option[ujson.Value],
    val therologist : Option[ujson.Value],
    val Tolowa : Option[ujson.Value],
    val tradeful : Option[ujson.Value],
    val unriveting : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type ChemotherapeuticElement = ChemotherapeuticClass | Long
given unionReaderChemotherapeuticElement: OptionPickler.Reader[ChemotherapeuticElement] = JsonExt.badMerge[ChemotherapeuticElement](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[ChemotherapeuticClass]],
    )

given unionWriterChemotherapeuticElement: OptionPickler.Writer[ChemotherapeuticElement] = OptionPickler.writer[ujson.Value].comap[ChemotherapeuticElement]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: ChemotherapeuticClass => OptionPickler.writeJs[ChemotherapeuticClass](v)
}

case class ChemotherapeuticClass (
    val angioneurotic : Option[ujson.Value] = None,
    val availment : Option[ujson.Value] = None,
    val bladelet : Option[ujson.Value] = None,
    val catharticalness : Option[Double] = None,
    val caulis : Option[ujson.Value] = None,
    val chalcus : Option[ujson.Value] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val enteradenological : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val imporosity : Option[ujson.Value] = None,
    val insistently : Option[ujson.Value] = None,
    val intraparietal : Option[ujson.Value] = None,
    val ivied : Option[ujson.Value] = None,
    val Maureen : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val nostochine : Option[ujson.Value] = None,
    val nutcracker : Option[ujson.Value] = None,
    val ofttimes : Option[ujson.Value] = None,
    val phenocryst : Option[ujson.Value] = None,
    val precoincident : Option[ujson.Value] = None,
    val ramiferous : Option[ujson.Value] = None,
    val stagmometer : Option[ujson.Value] = None,
    val tetherball : Option[ujson.Value] = None,
    val unshy : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

type CimeliaElement = CimeliaClass | Seq[Long] | NullValue
given unionReaderCimeliaElement: OptionPickler.Reader[CimeliaElement] = JsonExt.badMerge[CimeliaElement](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[CimeliaClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterCimeliaElement: OptionPickler.Writer[CimeliaElement] = OptionPickler.writer[ujson.Value].comap[CimeliaElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: CimeliaClass => OptionPickler.writeJs[CimeliaClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class CimeliaClass (
    val catharticalness : Double,
    val Chirotherium : Long,
    val disdiapason : String,
    val homocerc : Boolean,
    val nonbookish : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Clinodome = Double | String
given unionReaderClinodome: OptionPickler.Reader[Clinodome] = JsonExt.badMerge[Clinodome](
    JsonExt.strictString,
    JsonExt.strictDouble,
    )

given unionWriterClinodome: OptionPickler.Writer[Clinodome] = OptionPickler.writer[ujson.Value].comap[Clinodome]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

type CoadjustElement = CoadjustClass | Double
given unionReaderCoadjustElement: OptionPickler.Reader[CoadjustElement] = JsonExt.badMerge[CoadjustElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[CoadjustClass]],
    )

given unionWriterCoadjustElement: OptionPickler.Writer[CoadjustElement] = OptionPickler.writer[ujson.Value].comap[CoadjustElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: CoadjustClass => OptionPickler.writeJs[CoadjustClass](v)
}

case class CoadjustClass (
    val amidosulphonal : Option[ujson.Value] = None,
    val Benny : Option[ujson.Value] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val ensnare : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val hybridizer : Option[ujson.Value] = None,
    val leastwise : Option[ujson.Value] = None,
    val lof : Option[ujson.Value] = None,
    val monkhood : Option[ujson.Value] = None,
    val Netherlandish : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val peonism : Option[ujson.Value] = None,
    val Phonelescope : Option[ujson.Value] = None,
    val porphyrogeniture : Option[ujson.Value] = None,
    val preindemnify : Option[ujson.Value] = None,
    val rosal : Option[ujson.Value] = None,
    val scalenous : Option[ujson.Value] = None,
    val scopine : Option[ujson.Value] = None,
    val Sedaceae : Option[ujson.Value] = None,
    val suberinize : Option[ujson.Value] = None,
    val symbiot : Option[ujson.Value] = None,
    val tablefellow : Option[ujson.Value] = None,
    val unchargeable : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

type Consilience = Double | Map[String, Long]
given unionReaderConsilience: OptionPickler.Reader[Consilience] = JsonExt.badMerge[Consilience](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterConsilience: OptionPickler.Writer[Consilience] = OptionPickler.writer[ujson.Value].comap[Consilience]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Constructor = Boolean | Map[String, Option[Long]]
given unionReaderConstructor: OptionPickler.Reader[Constructor] = JsonExt.badMerge[Constructor](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Map[String, Option[Long]]]],
    )

given unionWriterConstructor: OptionPickler.Writer[Constructor] = OptionPickler.writer[ujson.Value].comap[Constructor]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Map[String, Option[Long]] => OptionPickler.writeJs[Map[String, Option[Long]]](v)
}

type Continuative = Map[String, Long] | String
given unionReaderContinuative: OptionPickler.Reader[Continuative] = JsonExt.badMerge[Continuative](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterContinuative: OptionPickler.Writer[Continuative] = OptionPickler.writer[ujson.Value].comap[Continuative]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type CredulityElement = CredulityClass | Long | String
given unionReaderCredulityElement: OptionPickler.Reader[CredulityElement] = JsonExt.badMerge[CredulityElement](
    JsonExt.strictString,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[CredulityClass]],
    )

given unionWriterCredulityElement: OptionPickler.Writer[CredulityElement] = OptionPickler.writer[ujson.Value].comap[CredulityElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: CredulityClass => OptionPickler.writeJs[CredulityClass](v)
}

case class CredulityClass (
    val ammonolytic : Option[ujson.Value],
    val bushmaster : Option[ujson.Value],
    val considering : Option[ujson.Value],
    val consuetudinary : Option[ujson.Value],
    val embarras : Option[ujson.Value],
    val fineness : Option[ujson.Value],
    val flaithship : Option[ujson.Value],
    val Flavia : Option[ujson.Value],
    val gruffly : Option[ujson.Value],
    val Hedychium : Option[ujson.Value],
    val leadwort : Option[ujson.Value],
    val overseriously : Option[ujson.Value],
    val parabola : Option[ujson.Value],
    val pectinatodenticulate : Option[ujson.Value],
    val Popean : Option[ujson.Value],
    val pornocrat : Option[ujson.Value],
    val quadrisect : Option[ujson.Value],
    val seriality : Option[ujson.Value],
    val vamphorn : Option[ujson.Value],
    val wharp : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Creviced = Boolean | Map[String, Long] | String
given unionReaderCreviced: OptionPickler.Reader[Creviced] = JsonExt.badMerge[Creviced](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterCreviced: OptionPickler.Writer[Creviced] = OptionPickler.writer[ujson.Value].comap[Creviced]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type DeruralizeElement = Boolean | DeruralizeClass | Seq[Option[ujson.Value]]
given unionReaderDeruralizeElement: OptionPickler.Reader[DeruralizeElement] = JsonExt.badMerge[DeruralizeElement](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[DeruralizeClass]],
    )

given unionWriterDeruralizeElement: OptionPickler.Writer[DeruralizeElement] = OptionPickler.writer[ujson.Value].comap[DeruralizeElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: DeruralizeClass => OptionPickler.writeJs[DeruralizeClass](v)
}

case class DeruralizeClass (
    val bockerel : Option[ujson.Value],
    val boulder : Option[ujson.Value],
    val churrus : Option[ujson.Value],
    val counterdigged : Option[ujson.Value],
    val dialogite : Option[ujson.Value],
    val digenic : Option[ujson.Value],
    val dunbird : Option[ujson.Value],
    val ergatogyne : Option[ujson.Value],
    val fiendful : Option[ujson.Value],
    val jackrod : Option[ujson.Value],
    val Jehovistic : Option[ujson.Value],
    val Paninean : Option[ujson.Value],
    val panther : Option[ujson.Value],
    val placentigerous : Option[ujson.Value],
    val Romney : Option[ujson.Value],
    val sparm : Option[ujson.Value],
    val tocsin : Option[ujson.Value],
    val unnicked : Option[ujson.Value],
    val unstavable : Option[ujson.Value],
    val windfirm : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type DiaereseElement = Boolean | DiaereseClass | Seq[Long]
given unionReaderDiaereseElement: OptionPickler.Reader[DiaereseElement] = JsonExt.badMerge[DiaereseElement](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[DiaereseClass]],
    )

given unionWriterDiaereseElement: OptionPickler.Writer[DiaereseElement] = OptionPickler.writer[ujson.Value].comap[DiaereseElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: DiaereseClass => OptionPickler.writeJs[DiaereseClass](v)
}

case class DiaereseClass (
    val Amoreuxia : Option[ujson.Value],
    val ani : Option[ujson.Value],
    val bernicle : Option[ujson.Value],
    val blackwasher : Option[ujson.Value],
    val blowhard : Option[ujson.Value],
    val broma : Option[ujson.Value],
    val closecross : Option[ujson.Value],
    val congregationalism : Option[ujson.Value],
    val grayly : Option[ujson.Value],
    val historically : Option[ujson.Value],
    val hoast : Option[ujson.Value],
    val irretentive : Option[ujson.Value],
    val parcener : Option[ujson.Value],
    val pedder : Option[ujson.Value],
    val pseudoanatomic : Option[ujson.Value],
    val rhizocarpian : Option[ujson.Value],
    val samel : Option[ujson.Value],
    val silker : Option[ujson.Value],
    val subdentated : Option[ujson.Value],
    val subobscure : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Downstroke = Boolean | Seq[Option[ujson.Value]] | String
given unionReaderDownstroke: OptionPickler.Reader[Downstroke] = JsonExt.badMerge[Downstroke](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterDownstroke: OptionPickler.Writer[Downstroke] = OptionPickler.writer[ujson.Value].comap[Downstroke]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

type Eleutheromania = Double | Map[String, Long] | String
given unionReaderEleutheromania: OptionPickler.Reader[Eleutheromania] = JsonExt.badMerge[Eleutheromania](
    JsonExt.strictString,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterEleutheromania: OptionPickler.Writer[Eleutheromania] = OptionPickler.writer[ujson.Value].comap[Eleutheromania]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

case class Encrust (
    val comradely : Option[ujson.Value],
    val diacanthous : Option[ujson.Value],
    val feminineness : Option[ujson.Value],
    val gossamered : Option[ujson.Value],
    val Hibernia : Option[ujson.Value],
    val Hibiscus : Option[ujson.Value],
    val Lepidosauria : Option[ujson.Value],
    val lollingly : Option[ujson.Value],
    val manager : Option[ujson.Value],
    val mechanic : Option[ujson.Value],
    val overminuteness : Option[ujson.Value],
    val papelonne : Option[ujson.Value],
    val plebification : Option[ujson.Value],
    val pugmiller : Option[ujson.Value],
    val recoveror : Option[ujson.Value],
    val spermatoblastic : Option[ujson.Value],
    val Syllidae : Option[ujson.Value],
    val ungyved : Option[ujson.Value],
    val whirlabout : Option[ujson.Value],
    val woodenware : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Entomoid = CimeliaClass | Long
given unionReaderEntomoid: OptionPickler.Reader[Entomoid] = JsonExt.badMerge[Entomoid](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[CimeliaClass]],
    )

given unionWriterEntomoid: OptionPickler.Writer[Entomoid] = OptionPickler.writer[ujson.Value].comap[Entomoid]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: CimeliaClass => OptionPickler.writeJs[CimeliaClass](v)
}

type Epipaleolithic = Double | Seq[Long]
given unionReaderEpipaleolithic: OptionPickler.Reader[Epipaleolithic] = JsonExt.badMerge[Epipaleolithic](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterEpipaleolithic: OptionPickler.Writer[Epipaleolithic] = OptionPickler.writer[ujson.Value].comap[Epipaleolithic]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

type Expropriable = CimeliaClass | Double | Seq[Option[ujson.Value]]
given unionReaderExpropriable: OptionPickler.Reader[Expropriable] = JsonExt.badMerge[Expropriable](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[CimeliaClass]],
    )

given unionWriterExpropriable: OptionPickler.Writer[Expropriable] = OptionPickler.writer[ujson.Value].comap[Expropriable]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: CimeliaClass => OptionPickler.writeJs[CimeliaClass](v)
}

type FagginglyElement = Double | FagginglyClass
given unionReaderFagginglyElement: OptionPickler.Reader[FagginglyElement] = JsonExt.badMerge[FagginglyElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[FagginglyClass]],
    )

given unionWriterFagginglyElement: OptionPickler.Writer[FagginglyElement] = OptionPickler.writer[ujson.Value].comap[FagginglyElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: FagginglyClass => OptionPickler.writeJs[FagginglyClass](v)
}

case class FagginglyClass (
    val abranchian : Option[ujson.Value],
    val aculeiform : Option[ujson.Value],
    val adiaphoristic : Option[ujson.Value],
    val adoptionism : Option[ujson.Value],
    val Anglic : Option[ujson.Value],
    val antrotomy : Option[ujson.Value],
    val coerciveness : Option[ujson.Value],
    val decorist : Option[ujson.Value],
    val duckhood : Option[ujson.Value],
    val Heteromeri : Option[ujson.Value],
    val hypochnose : Option[ujson.Value],
    val lochage : Option[ujson.Value],
    val melee : Option[ujson.Value],
    val nonconformitant : Option[ujson.Value],
    val Poinsettia : Option[ujson.Value],
    val putatively : Option[ujson.Value],
    val semivolatile : Option[ujson.Value],
    val soleas : Option[ujson.Value],
    val unfastenable : Option[ujson.Value],
    val unmillinered : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type FenkElement = FenkClass | String
given unionReaderFenkElement: OptionPickler.Reader[FenkElement] = JsonExt.badMerge[FenkElement](
    JsonExt.strictString,
    summon[OptionPickler.Reader[FenkClass]],
    )

given unionWriterFenkElement: OptionPickler.Writer[FenkElement] = OptionPickler.writer[ujson.Value].comap[FenkElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: FenkClass => OptionPickler.writeJs[FenkClass](v)
}

case class FenkClass (
    val apoise : Option[ujson.Value],
    val astronomize : Option[ujson.Value],
    val cockhorse : Option[ujson.Value],
    val copular : Option[ujson.Value],
    val Dagomba : Option[ujson.Value],
    val draffy : Option[ujson.Value],
    val foreigner : Option[ujson.Value],
    val Guyandot : Option[ujson.Value],
    val neurogliosis : Option[ujson.Value],
    val osmious : Option[ujson.Value],
    val palpitate : Option[ujson.Value],
    val rebukeable : Option[ujson.Value],
    val Reinwardtia : Option[ujson.Value],
    val reservatory : Option[ujson.Value],
    val scalt : Option[ujson.Value],
    val scripturalize : Option[ujson.Value],
    val tintometer : Option[ujson.Value],
    val Tritoness : Option[ujson.Value],
    val undergrade : Option[ujson.Value],
    val undermountain : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type FlagmakingElement = Boolean | Double | FlagmakingClass
given unionReaderFlagmakingElement: OptionPickler.Reader[FlagmakingElement] = JsonExt.badMerge[FlagmakingElement](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[FlagmakingClass]],
    )

given unionWriterFlagmakingElement: OptionPickler.Writer[FlagmakingElement] = OptionPickler.writer[ujson.Value].comap[FlagmakingElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: FlagmakingClass => OptionPickler.writeJs[FlagmakingClass](v)
}

case class FlagmakingClass (
    val albarco : Option[ujson.Value],
    val Bunodonta : Option[ujson.Value],
    val hornify : Option[ujson.Value],
    val Hydrocorisae : Option[ujson.Value],
    val hypoglossus : Option[ujson.Value],
    val inexpiably : Option[ujson.Value],
    val ingratitude : Option[ujson.Value],
    val ladyfly : Option[ujson.Value],
    val medicament : Option[ujson.Value],
    val monogrammatic : Option[ujson.Value],
    val nobbut : Option[ujson.Value],
    val Notacanthidae : Option[ujson.Value],
    val polyplacophore : Option[ujson.Value],
    val proexercise : Option[ujson.Value],
    val protoplast : Option[ujson.Value],
    val puzzling : Option[ujson.Value],
    val splanchnoskeleton : Option[ujson.Value],
    val unloveliness : Option[ujson.Value],
    val unquarantined : Option[ujson.Value],
    val unrenounceable : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Fluorometer = Long | String | NullValue
given unionReaderFluorometer: OptionPickler.Reader[Fluorometer] = JsonExt.badMerge[Fluorometer](
    JsonExt.strictString,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterFluorometer: OptionPickler.Writer[Fluorometer] = OptionPickler.writer[ujson.Value].comap[Fluorometer]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Fuzzy = Long | Map[String, Option[Long]]
given unionReaderFuzzy: OptionPickler.Reader[Fuzzy] = JsonExt.badMerge[Fuzzy](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Map[String, Option[Long]]]],
    )

given unionWriterFuzzy: OptionPickler.Writer[Fuzzy] = OptionPickler.writer[ujson.Value].comap[Fuzzy]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Map[String, Option[Long]] => OptionPickler.writeJs[Map[String, Option[Long]]](v)
}

type Gardenward = Boolean | Seq[Long] | String
given unionReaderGardenward: OptionPickler.Reader[Gardenward] = JsonExt.badMerge[Gardenward](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterGardenward: OptionPickler.Writer[Gardenward] = OptionPickler.writer[ujson.Value].comap[Gardenward]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

type Generalissimo = Boolean | Map[String, Long] | NullValue
given unionReaderGeneralissimo: OptionPickler.Reader[Generalissimo] = JsonExt.badMerge[Generalissimo](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Map[String, Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterGeneralissimo: OptionPickler.Writer[Generalissimo] = OptionPickler.writer[ujson.Value].comap[Generalissimo]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Hemicrystalline = CimeliaClass | String
given unionReaderHemicrystalline: OptionPickler.Reader[Hemicrystalline] = JsonExt.badMerge[Hemicrystalline](
    JsonExt.strictString,
    summon[OptionPickler.Reader[CimeliaClass]],
    )

given unionWriterHemicrystalline: OptionPickler.Writer[Hemicrystalline] = OptionPickler.writer[ujson.Value].comap[Hemicrystalline]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: CimeliaClass => OptionPickler.writeJs[CimeliaClass](v)
}

type HemocoeleElement = HemocoeleClass | Seq[Long]
given unionReaderHemocoeleElement: OptionPickler.Reader[HemocoeleElement] = JsonExt.badMerge[HemocoeleElement](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[HemocoeleClass]],
    )

given unionWriterHemocoeleElement: OptionPickler.Writer[HemocoeleElement] = OptionPickler.writer[ujson.Value].comap[HemocoeleElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: HemocoeleClass => OptionPickler.writeJs[HemocoeleClass](v)
}

case class HemocoeleClass (
    val acrogamy : Option[ujson.Value] = None,
    val amelification : Option[ujson.Value] = None,
    val autobiographic : Option[ujson.Value] = None,
    val berat : Option[ujson.Value] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val disproportionably : Option[ujson.Value] = None,
    val erythrite : Option[ujson.Value] = None,
    val graphic : Option[ujson.Value] = None,
    val hepatological : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val incommensurably : Option[ujson.Value] = None,
    val misaffirm : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val pocketbook : Option[ujson.Value] = None,
    val sclerometric : Option[ujson.Value] = None,
    val stambouline : Option[ujson.Value] = None,
    val stickpin : Option[ujson.Value] = None,
    val tubulure : Option[ujson.Value] = None,
    val undelated : Option[ujson.Value] = None,
    val unsalt : Option[ujson.Value] = None,
    val untutelar : Option[ujson.Value] = None,
    val vagrant : Option[ujson.Value] = None,
    val Walt : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

type Hoister = CimeliaClass | String | NullValue
given unionReaderHoister: OptionPickler.Reader[Hoister] = JsonExt.badMerge[Hoister](
    JsonExt.strictString,
    summon[OptionPickler.Reader[CimeliaClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterHoister: OptionPickler.Writer[Hoister] = OptionPickler.writer[ujson.Value].comap[Hoister]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: CimeliaClass => OptionPickler.writeJs[CimeliaClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Hyperpiesi = CimeliaClass | Seq[Option[ujson.Value]] | NullValue
given unionReaderHyperpiesi: OptionPickler.Reader[Hyperpiesi] = JsonExt.badMerge[Hyperpiesi](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[CimeliaClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterHyperpiesi: OptionPickler.Writer[Hyperpiesi] = OptionPickler.writer[ujson.Value].comap[Hyperpiesi]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: CimeliaClass => OptionPickler.writeJs[CimeliaClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Hyppish = Boolean | String | NullValue
given unionReaderHyppish: OptionPickler.Reader[Hyppish] = JsonExt.badMerge[Hyppish](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterHyppish: OptionPickler.Writer[Hyppish] = OptionPickler.writer[ujson.Value].comap[Hyppish]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Idealizer = CimeliaClass | Long | Seq[Option[ujson.Value]]
given unionReaderIdealizer: OptionPickler.Reader[Idealizer] = JsonExt.badMerge[Idealizer](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[CimeliaClass]],
    )

given unionWriterIdealizer: OptionPickler.Writer[Idealizer] = OptionPickler.writer[ujson.Value].comap[Idealizer]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: CimeliaClass => OptionPickler.writeJs[CimeliaClass](v)
}

type Incrustator = Seq[Long] | Long | String
given unionReaderIncrustator: OptionPickler.Reader[Incrustator] = JsonExt.badMerge[Incrustator](
    JsonExt.strictString,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterIncrustator: OptionPickler.Writer[Incrustator] = OptionPickler.writer[ujson.Value].comap[Incrustator]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

type Intentiveness = CimeliaClass | Double | String
given unionReaderIntentiveness: OptionPickler.Reader[Intentiveness] = JsonExt.badMerge[Intentiveness](
    JsonExt.strictString,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[CimeliaClass]],
    )

given unionWriterIntentiveness: OptionPickler.Writer[Intentiveness] = OptionPickler.writer[ujson.Value].comap[Intentiveness]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: CimeliaClass => OptionPickler.writeJs[CimeliaClass](v)
}

case class Interacinar (
    val assapan : Double,
    val benefactorship : Boolean,
    val triseriatim : String,
    val tubbing : Long,
    val untrimmed : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Jacutinga = Seq[Long] | Map[String, Option[Long]]
given unionReaderJacutinga: OptionPickler.Reader[Jacutinga] = JsonExt.badMerge[Jacutinga](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Map[String, Option[Long]]]],
    )

given unionWriterJacutinga: OptionPickler.Writer[Jacutinga] = OptionPickler.writer[ujson.Value].comap[Jacutinga]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Map[String, Option[Long]] => OptionPickler.writeJs[Map[String, Option[Long]]](v)
}
