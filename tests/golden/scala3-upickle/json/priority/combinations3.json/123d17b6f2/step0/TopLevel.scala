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
) derives OptionPickler.ReadWriter

type JurorElement = Boolean | JurorClass
given unionReaderJurorElement: OptionPickler.Reader[JurorElement] = JsonExt.badMerge[JurorElement](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[JurorClass]],
    )

given unionWriterJurorElement: OptionPickler.Writer[JurorElement] = OptionPickler.writer[ujson.Value].comap[JurorElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: JurorClass => OptionPickler.writeJs[JurorClass](v)
}

case class JurorClass (
    val adipsy : Option[ujson.Value],
    val auxiliator : Option[ujson.Value],
    val benda : Option[ujson.Value],
    val benjamin : Option[ujson.Value],
    val brandling : Option[ujson.Value],
    val epicurishly : Option[ujson.Value],
    val eremochaetous : Option[ujson.Value],
    val marten : Option[ujson.Value],
    val monocline : Option[ujson.Value],
    val Olea : Option[ujson.Value],
    val palgat : Option[ujson.Value],
    val pennyworth : Option[ujson.Value],
    val pioury : Option[ujson.Value],
    val pragmatistic : Option[ujson.Value],
    val stylelessness : Option[ujson.Value],
    val systematical : Option[ujson.Value],
    val thready : Option[ujson.Value],
    val uncontemporary : Option[ujson.Value],
    val uncouched : Option[ujson.Value],
    val uninhabitedness : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Kongoni = Seq[Long] | Map[String, Long]
given unionReaderKongoni: OptionPickler.Reader[Kongoni] = JsonExt.badMerge[Kongoni](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterKongoni: OptionPickler.Writer[Kongoni] = OptionPickler.writer[ujson.Value].comap[Kongoni]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type LadronismElement = Double | LadronismClass | String
given unionReaderLadronismElement: OptionPickler.Reader[LadronismElement] = JsonExt.badMerge[LadronismElement](
    JsonExt.strictString,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[LadronismClass]],
    )

given unionWriterLadronismElement: OptionPickler.Writer[LadronismElement] = OptionPickler.writer[ujson.Value].comap[LadronismElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: LadronismClass => OptionPickler.writeJs[LadronismClass](v)
}

case class LadronismClass (
    val acclaimer : Option[ujson.Value],
    val achree : Option[ujson.Value],
    val base : Option[ujson.Value],
    val conundrumize : Option[ujson.Value],
    val degerminator : Option[ujson.Value],
    val describable : Option[ujson.Value],
    val exasperatedly : Option[ujson.Value],
    val heroine : Option[ujson.Value],
    val indazin : Option[ujson.Value],
    val luteous : Option[ujson.Value],
    val papular : Option[ujson.Value],
    val pritch : Option[ujson.Value],
    val Prodenia : Option[ujson.Value],
    val seege : Option[ujson.Value],
    val shopgirl : Option[ujson.Value],
    val tragedietta : Option[ujson.Value],
    val unsparse : Option[ujson.Value],
    val uplook : Option[ujson.Value],
    val vermiformis : Option[ujson.Value],
    val whafabout : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type LandlubberlyElement = Boolean | Long | LandlubberlyClass
given unionReaderLandlubberlyElement: OptionPickler.Reader[LandlubberlyElement] = JsonExt.badMerge[LandlubberlyElement](
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[LandlubberlyClass]],
    )

given unionWriterLandlubberlyElement: OptionPickler.Writer[LandlubberlyElement] = OptionPickler.writer[ujson.Value].comap[LandlubberlyElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: LandlubberlyClass => OptionPickler.writeJs[LandlubberlyClass](v)
}

case class LandlubberlyClass (
    val acropoleis : Option[ujson.Value],
    val aminate : Option[ujson.Value],
    val Amyraldism : Option[ujson.Value],
    val bipenniform : Option[ujson.Value],
    val bugre : Option[ujson.Value],
    val calycule : Option[ujson.Value],
    val caoutchouc : Option[ujson.Value],
    val disprover : Option[ujson.Value],
    val fitroot : Option[ujson.Value],
    val fulgently : Option[ujson.Value],
    val kickup : Option[ujson.Value],
    val laevoversion : Option[ujson.Value],
    val moter : Option[ujson.Value],
    val objectivity : Option[ujson.Value],
    val posterity : Option[ujson.Value],
    val postnuptial : Option[ujson.Value],
    val precedentary : Option[ujson.Value],
    val saddling : Option[ujson.Value],
    val subcurrent : Option[ujson.Value],
    val unrecriminative : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Listener = Long | Seq[Option[ujson.Value]]
given unionReaderListener: OptionPickler.Reader[Listener] = JsonExt.badMerge[Listener](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterListener: OptionPickler.Writer[Listener] = OptionPickler.writer[ujson.Value].comap[Listener]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

type LupusElement = Long | LupusClass
given unionReaderLupusElement: OptionPickler.Reader[LupusElement] = JsonExt.badMerge[LupusElement](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[LupusClass]],
    )

given unionWriterLupusElement: OptionPickler.Writer[LupusElement] = OptionPickler.writer[ujson.Value].comap[LupusElement]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: LupusClass => OptionPickler.writeJs[LupusClass](v)
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
    val nonbookish : Option[ujson.Value] = None,
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
) derives OptionPickler.ReadWriter

case class Maslin (
    val Alicant : Option[Long] = None,
    val antiatonement : Option[ujson.Value] = None,
    val anticorrosive : Option[Long] = None,
    val aphidozer : Option[ujson.Value] = None,
    val Bakuninist : Option[ujson.Value] = None,
    val be : Option[Long] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val chub : Option[Long] = None,
    val cuprosilicon : Option[Long] = None,
    val curtailedly : Option[Long] = None,
    val dellenite : Option[Long] = None,
    val Dimitry : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val edifying : Option[ujson.Value] = None,
    val ethmoiditis : Option[Long] = None,
    val gastralgy : Option[ujson.Value] = None,
    val goatherd : Option[Long] = None,
    val hammerdress : Option[Long] = None,
    val hangfire : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val lacunosity : Option[Long] = None,
    val longiloquence : Option[ujson.Value] = None,
    val mameliere : Option[Long] = None,
    val motherless : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val noncorrodible : Option[ujson.Value] = None,
    val nonsensicality : Option[ujson.Value] = None,
    val oafishly : Option[Long] = None,
    val pfund : Option[ujson.Value] = None,
    val preadvisory : Option[ujson.Value] = None,
    val retroflexed : Option[ujson.Value] = None,
    val saccharulmic : Option[Long] = None,
    val scowlful : Option[Long] = None,
    val secluded : Option[ujson.Value] = None,
    val slackage : Option[ujson.Value] = None,
    val sphaeridial : Option[Long] = None,
    val spondulics : Option[ujson.Value] = None,
    val subsecive : Option[Long] = None,
    val swellmobsman : Option[ujson.Value] = None,
    val trachyglossate : Option[Long] = None,
    val trialogue : Option[ujson.Value] = None,
    val unassuaged : Option[Long] = None,
    val ungross : Option[ujson.Value] = None,
    val unjudiciously : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

type MonaziteElement = Double | MonaziteClass
given unionReaderMonaziteElement: OptionPickler.Reader[MonaziteElement] = JsonExt.badMerge[MonaziteElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[MonaziteClass]],
    )

given unionWriterMonaziteElement: OptionPickler.Writer[MonaziteElement] = OptionPickler.writer[ujson.Value].comap[MonaziteElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: MonaziteClass => OptionPickler.writeJs[MonaziteClass](v)
}

case class MonaziteClass (
    val catharticalness : Double,
    val Chirotherium : Long,
    val disdiapason : String,
    val homocerc : Boolean,
    val nonbookish : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Monoliteral = Boolean | Seq[Option[ujson.Value]]
given unionReaderMonoliteral: OptionPickler.Reader[Monoliteral] = JsonExt.badMerge[Monoliteral](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterMonoliteral: OptionPickler.Writer[Monoliteral] = OptionPickler.writer[ujson.Value].comap[Monoliteral]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

type MonotheisticallyElement = MonotheisticallyClass | Seq[Option[ujson.Value]]
given unionReaderMonotheisticallyElement: OptionPickler.Reader[MonotheisticallyElement] = JsonExt.badMerge[MonotheisticallyElement](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[MonotheisticallyClass]],
    )

given unionWriterMonotheisticallyElement: OptionPickler.Writer[MonotheisticallyElement] = OptionPickler.writer[ujson.Value].comap[MonotheisticallyElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: MonotheisticallyClass => OptionPickler.writeJs[MonotheisticallyClass](v)
}

case class MonotheisticallyClass (
    val blaspheme : Option[ujson.Value] = None,
    val catharticalness : Option[Double] = None,
    val celiosalpingectomy : Option[ujson.Value] = None,
    val Chirotherium : Option[Long] = None,
    val consummativeness : Option[ujson.Value] = None,
    val disdiapason : Option[String] = None,
    val egestive : Option[ujson.Value] = None,
    val enchylema : Option[ujson.Value] = None,
    val gasconade : Option[ujson.Value] = None,
    val holidayer : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val intuitionalism : Option[ujson.Value] = None,
    val lophiostomate : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val nonvolition : Option[ujson.Value] = None,
    val palatableness : Option[ujson.Value] = None,
    val pimpery : Option[ujson.Value] = None,
    val previolation : Option[ujson.Value] = None,
    val reconveyance : Option[ujson.Value] = None,
    val registership : Option[ujson.Value] = None,
    val rhyacolite : Option[ujson.Value] = None,
    val smithereens : Option[ujson.Value] = None,
    val superedification : Option[ujson.Value] = None,
    val trust : Option[ujson.Value] = None,
    val whitestone : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

type Montage = Double | Seq[Option[ujson.Value]] | String
given unionReaderMontage: OptionPickler.Reader[Montage] = JsonExt.badMerge[Montage](
    JsonExt.strictString,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterMontage: OptionPickler.Writer[Montage] = OptionPickler.writer[ujson.Value].comap[Montage]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

type Moralness = Double | Seq[Option[ujson.Value]] | NullValue
given unionReaderMoralness: OptionPickler.Reader[Moralness] = JsonExt.badMerge[Moralness](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterMoralness: OptionPickler.Writer[Moralness] = OptionPickler.writer[ujson.Value].comap[Moralness]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Mulishly = Double | Seq[Long] | NullValue
given unionReaderMulishly: OptionPickler.Reader[Mulishly] = JsonExt.badMerge[Mulishly](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterMulishly: OptionPickler.Writer[Mulishly] = OptionPickler.writer[ujson.Value].comap[Mulishly]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Myoscope = Boolean | Long | Seq[Option[ujson.Value]]
given unionReaderMyoscope: OptionPickler.Reader[Myoscope] = JsonExt.badMerge[Myoscope](
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterMyoscope: OptionPickler.Writer[Myoscope] = OptionPickler.writer[ujson.Value].comap[Myoscope]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

type Neuromastic = Double | Seq[Option[ujson.Value]]
given unionReaderNeuromastic: OptionPickler.Reader[Neuromastic] = JsonExt.badMerge[Neuromastic](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterNeuromastic: OptionPickler.Writer[Neuromastic] = OptionPickler.writer[ujson.Value].comap[Neuromastic]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

case class Noncontributing (
    val estevin : String,
    val jolterhead : Double,
    val sauternes : Long,
    val sparsely : Boolean,
    val unrequested : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Nonnervous = Boolean | Long
given unionReaderNonnervous: OptionPickler.Reader[Nonnervous] = JsonExt.badMerge[Nonnervous](
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    )

given unionWriterNonnervous: OptionPickler.Writer[Nonnervous] = OptionPickler.writer[ujson.Value].comap[Nonnervous]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
}

type Nonvaluation = Boolean | Double | Seq[Option[ujson.Value]]
given unionReaderNonvaluation: OptionPickler.Reader[Nonvaluation] = JsonExt.badMerge[Nonvaluation](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterNonvaluation: OptionPickler.Writer[Nonvaluation] = OptionPickler.writer[ujson.Value].comap[Nonvaluation]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

type OccupationalistElement = Seq[Option[ujson.Value]] | OccupationalistClass | NullValue
given unionReaderOccupationalistElement: OptionPickler.Reader[OccupationalistElement] = JsonExt.badMerge[OccupationalistElement](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[OccupationalistClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterOccupationalistElement: OptionPickler.Writer[OccupationalistElement] = OptionPickler.writer[ujson.Value].comap[OccupationalistElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: OccupationalistClass => OptionPickler.writeJs[OccupationalistClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class OccupationalistClass (
    val beholdable : Option[ujson.Value],
    val brotuliform : Option[ujson.Value],
    val Chimakum : Option[ujson.Value],
    val doodler : Option[ujson.Value],
    val emulsin : Option[ujson.Value],
    val Fin : Option[ujson.Value],
    val flourishing : Option[ujson.Value],
    val flueless : Option[ujson.Value],
    val furtively : Option[ujson.Value],
    val gritter : Option[ujson.Value],
    val interwish : Option[ujson.Value],
    val monoxylic : Option[ujson.Value],
    val myristic : Option[ujson.Value],
    val nightwear : Option[ujson.Value],
    val peruser : Option[ujson.Value],
    val theoastrological : Option[ujson.Value],
    val thumby : Option[ujson.Value],
    val tingitid : Option[ujson.Value],
    val trailless : Option[ujson.Value],
    val unpocketed : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type OutrivalElement = Double | OutrivalClass | NullValue
given unionReaderOutrivalElement: OptionPickler.Reader[OutrivalElement] = JsonExt.badMerge[OutrivalElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[OutrivalClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterOutrivalElement: OptionPickler.Writer[OutrivalElement] = OptionPickler.writer[ujson.Value].comap[OutrivalElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: OutrivalClass => OptionPickler.writeJs[OutrivalClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class OutrivalClass (
    val adroitly : Option[ujson.Value],
    val bridehood : Option[ujson.Value],
    val Castoroides : Option[ujson.Value],
    val Czechoslovak : Option[ujson.Value],
    val diagenesis : Option[ujson.Value],
    val dihexahedron : Option[ujson.Value],
    val dopester : Option[ujson.Value],
    val eumerism : Option[ujson.Value],
    val flyness : Option[ujson.Value],
    val fouler : Option[ujson.Value],
    val laudanosine : Option[ujson.Value],
    val Lingulidae : Option[ujson.Value],
    val minutary : Option[ujson.Value],
    val mitra : Option[ujson.Value],
    val opisthorchiasis : Option[ujson.Value],
    val pensively : Option[ujson.Value],
    val pubigerous : Option[ujson.Value],
    val rebellious : Option[ujson.Value],
    val recodify : Option[ujson.Value],
    val unpaced : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Paleographically = Double | Map[String, Option[Long]]
given unionReaderPaleographically: OptionPickler.Reader[Paleographically] = JsonExt.badMerge[Paleographically](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Map[String, Option[Long]]]],
    )

given unionWriterPaleographically: OptionPickler.Writer[Paleographically] = OptionPickler.writer[ujson.Value].comap[Paleographically]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Map[String, Option[Long]] => OptionPickler.writeJs[Map[String, Option[Long]]](v)
}

type Pamphletwise = Map[String, Long] | Long | String
given unionReaderPamphletwise: OptionPickler.Reader[Pamphletwise] = JsonExt.badMerge[Pamphletwise](
    JsonExt.strictString,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterPamphletwise: OptionPickler.Writer[Pamphletwise] = OptionPickler.writer[ujson.Value].comap[Pamphletwise]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Pediatric = Boolean | Double | NullValue
given unionReaderPediatric: OptionPickler.Reader[Pediatric] = JsonExt.badMerge[Pediatric](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterPediatric: OptionPickler.Writer[Pediatric] = OptionPickler.writer[ujson.Value].comap[Pediatric]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type PiaculumElement = Double | PiaculumClass
given unionReaderPiaculumElement: OptionPickler.Reader[PiaculumElement] = JsonExt.badMerge[PiaculumElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[PiaculumClass]],
    )

given unionWriterPiaculumElement: OptionPickler.Writer[PiaculumElement] = OptionPickler.writer[ujson.Value].comap[PiaculumElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: PiaculumClass => OptionPickler.writeJs[PiaculumClass](v)
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
    val nonbookish : Option[ujson.Value] = None,
    val phonendoscope : Option[Long] = None,
    val pilferment : Option[Long] = None,
    val predismissory : Option[Long] = None,
    val preinscription : Option[Long] = None,
    val quotative : Option[Long] = None,
    val sienna : Option[Long] = None,
    val thorax : Option[Long] = None,
    val yachting : Option[Long] = None,
    val Zipper : Option[Long] = None
) derives OptionPickler.ReadWriter

type Piccadilly = Double | String | NullValue
given unionReaderPiccadilly: OptionPickler.Reader[Piccadilly] = JsonExt.badMerge[Piccadilly](
    JsonExt.strictString,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterPiccadilly: OptionPickler.Writer[Piccadilly] = OptionPickler.writer[ujson.Value].comap[Piccadilly]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Piffler = MonaziteClass | Seq[Option[ujson.Value]]
given unionReaderPiffler: OptionPickler.Reader[Piffler] = JsonExt.badMerge[Piffler](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[MonaziteClass]],
    )

given unionWriterPiffler: OptionPickler.Writer[Piffler] = OptionPickler.writer[ujson.Value].comap[Piffler]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: MonaziteClass => OptionPickler.writeJs[MonaziteClass](v)
}

type Pithful = Boolean | Long | NullValue
given unionReaderPithful: OptionPickler.Reader[Pithful] = JsonExt.badMerge[Pithful](
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterPithful: OptionPickler.Writer[Pithful] = OptionPickler.writer[ujson.Value].comap[Pithful]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Placuntiti = Map[String, Long] | Long
given unionReaderPlacuntiti: OptionPickler.Reader[Placuntiti] = JsonExt.badMerge[Placuntiti](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterPlacuntiti: OptionPickler.Writer[Placuntiti] = OptionPickler.writer[ujson.Value].comap[Placuntiti]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Plectopterous = Double | Map[String, Long]
given unionReaderPlectopterous: OptionPickler.Reader[Plectopterous] = JsonExt.badMerge[Plectopterous](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterPlectopterous: OptionPickler.Writer[Plectopterous] = OptionPickler.writer[ujson.Value].comap[Plectopterous]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

case class Pneumocele (
    val Carbonarism : Option[ujson.Value] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val cineolic : Option[ujson.Value] = None,
    val cobbly : Option[ujson.Value] = None,
    val conchyliferous : Option[ujson.Value] = None,
    val congregation : Option[ujson.Value] = None,
    val disdiapason : Option[String] = None,
    val enterotomy : Option[ujson.Value] = None,
    val entophytal : Option[ujson.Value] = None,
    val fewtrils : Option[ujson.Value] = None,
    val herem : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val Koniga : Option[ujson.Value] = None,
    val meticulosity : Option[ujson.Value] = None,
    val Micky : Option[ujson.Value] = None,
    val mismarriage : Option[ujson.Value] = None,
    val neurotrophic : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val persuasively : Option[ujson.Value] = None,
    val replaceable : Option[ujson.Value] = None,
    val silex : Option[ujson.Value] = None,
    val taillight : Option[ujson.Value] = None,
    val unjealous : Option[ujson.Value] = None,
    val visitorial : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

type Poliorcetic = Boolean | MonaziteClass
given unionReaderPoliorcetic: OptionPickler.Reader[Poliorcetic] = JsonExt.badMerge[Poliorcetic](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[MonaziteClass]],
    )

given unionWriterPoliorcetic: OptionPickler.Writer[Poliorcetic] = OptionPickler.writer[ujson.Value].comap[Poliorcetic]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: MonaziteClass => OptionPickler.writeJs[MonaziteClass](v)
}

type Poormaster = Seq[Long] | Map[String, Long] | NullValue
given unionReaderPoormaster: OptionPickler.Reader[Poormaster] = JsonExt.badMerge[Poormaster](
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterPoormaster: OptionPickler.Writer[Poormaster] = OptionPickler.writer[ujson.Value].comap[Poormaster]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type PotwhiskyElement = Long | PotwhiskyClass | NullValue
given unionReaderPotwhiskyElement: OptionPickler.Reader[PotwhiskyElement] = JsonExt.badMerge[PotwhiskyElement](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[PotwhiskyClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterPotwhiskyElement: OptionPickler.Writer[PotwhiskyElement] = OptionPickler.writer[ujson.Value].comap[PotwhiskyElement]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: PotwhiskyClass => OptionPickler.writeJs[PotwhiskyClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class PotwhiskyClass (
    val arciform : Option[ujson.Value],
    val cresolin : Option[ujson.Value],
    val disheartener : Option[ujson.Value],
    val disproportionable : Option[ujson.Value],
    val Euchorda : Option[ujson.Value],
    val ferryway : Option[ujson.Value],
    val filamentiferous : Option[ujson.Value],
    val flemish : Option[ujson.Value],
    val forgainst : Option[ujson.Value],
    val grainering : Option[ujson.Value],
    val irrevoluble : Option[ujson.Value],
    val kindredship : Option[ujson.Value],
    val pinguitudinous : Option[ujson.Value],
    val simpletonic : Option[ujson.Value],
    val singsong : Option[ujson.Value],
    val submergement : Option[ujson.Value],
    val supraoesophagal : Option[ujson.Value],
    val thrashel : Option[ujson.Value],
    val tyremesis : Option[ujson.Value],
    val Yoruba : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Practicalizer = MonaziteClass | Seq[Option[ujson.Value]] | String
given unionReaderPracticalizer: OptionPickler.Reader[Practicalizer] = JsonExt.badMerge[Practicalizer](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[MonaziteClass]],
    )

given unionWriterPracticalizer: OptionPickler.Writer[Practicalizer] = OptionPickler.writer[ujson.Value].comap[Practicalizer]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: MonaziteClass => OptionPickler.writeJs[MonaziteClass](v)
}

type PrefreshmanElement = Seq[Option[ujson.Value]] | PrefreshmanClass | String
given unionReaderPrefreshmanElement: OptionPickler.Reader[PrefreshmanElement] = JsonExt.badMerge[PrefreshmanElement](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[PrefreshmanClass]],
    )

given unionWriterPrefreshmanElement: OptionPickler.Writer[PrefreshmanElement] = OptionPickler.writer[ujson.Value].comap[PrefreshmanElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: PrefreshmanClass => OptionPickler.writeJs[PrefreshmanClass](v)
}

case class PrefreshmanClass (
    val azorubine : Option[ujson.Value],
    val choroiditis : Option[ujson.Value],
    val coagulatory : Option[ujson.Value],
    val cyclorama : Option[ujson.Value],
    val Dolphus : Option[ujson.Value],
    val duckhearted : Option[ujson.Value],
    val Ficus : Option[ujson.Value],
    val Gemaric : Option[ujson.Value],
    val jugation : Option[ujson.Value],
    val myoliposis : Option[ujson.Value],
    val nonnomination : Option[ujson.Value],
    val palay : Option[ujson.Value],
    val pentactinal : Option[ujson.Value],
    val Phaet : Option[ujson.Value],
    val piquant : Option[ujson.Value],
    val registration : Option[ujson.Value],
    val remancipation : Option[ujson.Value],
    val scutatiform : Option[ujson.Value],
    val theodolite : Option[ujson.Value],
    val underward : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Prehensility = Boolean | MonaziteClass | Seq[Option[ujson.Value]]
given unionReaderPrehensility: OptionPickler.Reader[Prehensility] = JsonExt.badMerge[Prehensility](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[MonaziteClass]],
    )

given unionWriterPrehensility: OptionPickler.Writer[Prehensility] = OptionPickler.writer[ujson.Value].comap[Prehensility]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: MonaziteClass => OptionPickler.writeJs[MonaziteClass](v)
}

type Prevoidance = Seq[Long] | Long | MonaziteClass
given unionReaderPrevoidance: OptionPickler.Reader[Prevoidance] = JsonExt.badMerge[Prevoidance](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[MonaziteClass]],
    )

given unionWriterPrevoidance: OptionPickler.Writer[Prevoidance] = OptionPickler.writer[ujson.Value].comap[Prevoidance]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: MonaziteClass => OptionPickler.writeJs[MonaziteClass](v)
}

type Protext = Boolean | Seq[Long] | MonaziteClass
given unionReaderProtext: OptionPickler.Reader[Protext] = JsonExt.badMerge[Protext](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[MonaziteClass]],
    )

given unionWriterProtext: OptionPickler.Writer[Protext] = OptionPickler.writer[ujson.Value].comap[Protext]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: MonaziteClass => OptionPickler.writeJs[MonaziteClass](v)
}
