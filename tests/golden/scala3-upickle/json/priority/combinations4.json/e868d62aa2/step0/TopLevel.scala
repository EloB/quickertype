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
) derives OptionPickler.ReadWriter

type Protrusive = Double | Seq[Option[Long]]
given unionReaderProtrusive: OptionPickler.Reader[Protrusive] = JsonExt.badMerge[Protrusive](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[Long]]]],
    )

given unionWriterProtrusive: OptionPickler.Writer[Protrusive] = OptionPickler.writer[ujson.Value].comap[Protrusive]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[Long]] => OptionPickler.writeJs[Seq[Option[Long]]](v)
}

type PulpitismElement = Double | Seq[Long] | PulpitismClass
given unionReaderPulpitismElement: OptionPickler.Reader[PulpitismElement] = JsonExt.badMerge[PulpitismElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[PulpitismClass]],
    )

given unionWriterPulpitismElement: OptionPickler.Writer[PulpitismElement] = OptionPickler.writer[ujson.Value].comap[PulpitismElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: PulpitismClass => OptionPickler.writeJs[PulpitismClass](v)
}

case class PulpitismClass (
    val abnet : Option[ujson.Value],
    val buckhorn : Option[ujson.Value],
    val calciform : Option[ujson.Value],
    val chelophore : Option[ujson.Value],
    val cogitation : Option[ujson.Value],
    val decreeable : Option[ujson.Value],
    val despicable : Option[ujson.Value],
    val isodiazo : Option[ujson.Value],
    val jadedly : Option[ujson.Value],
    val leptochlorite : Option[ujson.Value],
    val nursling : Option[ujson.Value],
    val palamedean : Option[ujson.Value],
    val photoheliograph : Option[ujson.Value],
    val pipewood : Option[ujson.Value],
    val roberd : Option[ujson.Value],
    val statable : Option[ujson.Value],
    val superassume : Option[ujson.Value],
    val syllabe : Option[ujson.Value],
    val toughhead : Option[ujson.Value],
    val underburn : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type PyodermiaElement = Long | PyodermiaClass
given unionReaderPyodermiaElement: OptionPickler.Reader[PyodermiaElement] = JsonExt.badMerge[PyodermiaElement](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[PyodermiaClass]],
    )

given unionWriterPyodermiaElement: OptionPickler.Writer[PyodermiaElement] = OptionPickler.writer[ujson.Value].comap[PyodermiaElement]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: PyodermiaClass => OptionPickler.writeJs[PyodermiaClass](v)
}

case class PyodermiaClass (
    val aphoristically : Option[ujson.Value],
    val apophyllous : Option[ujson.Value],
    val cognize : Option[ujson.Value],
    val dermonosology : Option[ujson.Value],
    val Gyppo : Option[ujson.Value],
    val ither : Option[ujson.Value],
    val juglandaceous : Option[ujson.Value],
    val litho : Option[ujson.Value],
    val macropterous : Option[ujson.Value],
    val photographer : Option[ujson.Value],
    val romancing : Option[ujson.Value],
    val rumness : Option[ujson.Value],
    val somniloquist : Option[ujson.Value],
    val stressfully : Option[ujson.Value],
    val tactically : Option[ujson.Value],
    val tracheophony : Option[ujson.Value],
    val unappositely : Option[ujson.Value],
    val unclothedly : Option[ujson.Value],
    val unimplied : Option[ujson.Value],
    val unsyncopated : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type QuebrachineElement = Boolean | QuebrachineClass | NullValue
given unionReaderQuebrachineElement: OptionPickler.Reader[QuebrachineElement] = JsonExt.badMerge[QuebrachineElement](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[QuebrachineClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterQuebrachineElement: OptionPickler.Writer[QuebrachineElement] = OptionPickler.writer[ujson.Value].comap[QuebrachineElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: QuebrachineClass => OptionPickler.writeJs[QuebrachineClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

case class QuebrachineClass (
    val catharticalness : Double,
    val Chirotherium : Long,
    val disdiapason : String,
    val homocerc : Boolean,
    val nonbookish : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Querier = Boolean | Map[String, Long]
given unionReaderQuerier: OptionPickler.Reader[Querier] = JsonExt.badMerge[Querier](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterQuerier: OptionPickler.Writer[Querier] = OptionPickler.writer[ujson.Value].comap[Querier]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Rebarbative = Boolean | Double | Seq[Long]
given unionReaderRebarbative: OptionPickler.Reader[Rebarbative] = JsonExt.badMerge[Rebarbative](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterRebarbative: OptionPickler.Writer[Rebarbative] = OptionPickler.writer[ujson.Value].comap[Rebarbative]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

case class Reimagine (
    val adducible : Option[ujson.Value] = None,
    val anabolin : Option[ujson.Value] = None,
    val brainy : Option[ujson.Value] = None,
    val catharticalness : Option[Double] = None,
    val Chirotherium : Option[Long] = None,
    val chrysamine : Option[ujson.Value] = None,
    val disdiapason : Option[String] = None,
    val fluxweed : Option[ujson.Value] = None,
    val glaucine : Option[ujson.Value] = None,
    val grobianism : Option[ujson.Value] = None,
    val Hermo : Option[ujson.Value] = None,
    val hieroglyphist : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val icteroid : Option[ujson.Value] = None,
    val immortal : Option[ujson.Value] = None,
    val impetulant : Option[ujson.Value] = None,
    val irrigate : Option[ujson.Value] = None,
    val myxedema : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val onyx : Option[ujson.Value] = None,
    val repasser : Option[ujson.Value] = None,
    val septomarginal : Option[ujson.Value] = None,
    val subdie : Option[ujson.Value] = None,
    val tibiometatarsal : Option[ujson.Value] = None,
    val waltzlike : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

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
) derives OptionPickler.ReadWriter

type Retrocervical = Long | Seq[Option[Long]]
given unionReaderRetrocervical: OptionPickler.Reader[Retrocervical] = JsonExt.badMerge[Retrocervical](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Option[Long]]]],
    )

given unionWriterRetrocervical: OptionPickler.Writer[Retrocervical] = OptionPickler.writer[ujson.Value].comap[Retrocervical]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Option[Long]] => OptionPickler.writeJs[Seq[Option[Long]]](v)
}

type Revert = Boolean | String
given unionReaderRevert: OptionPickler.Reader[Revert] = JsonExt.badMerge[Revert](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    )

given unionWriterRevert: OptionPickler.Writer[Revert] = OptionPickler.writer[ujson.Value].comap[Revert]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
}

type RewriteElement = Double | Seq[Option[ujson.Value]] | RewriteClass
given unionReaderRewriteElement: OptionPickler.Reader[RewriteElement] = JsonExt.badMerge[RewriteElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[RewriteClass]],
    )

given unionWriterRewriteElement: OptionPickler.Writer[RewriteElement] = OptionPickler.writer[ujson.Value].comap[RewriteElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: RewriteClass => OptionPickler.writeJs[RewriteClass](v)
}

case class RewriteClass (
    val accountancy : Option[ujson.Value],
    val cacotrophic : Option[ujson.Value],
    val contest : Option[ujson.Value],
    val couthily : Option[ujson.Value],
    val falculate : Option[ujson.Value],
    val foreseize : Option[ujson.Value],
    val Hyades : Option[ujson.Value],
    val lemnad : Option[ujson.Value],
    val monotheistically : Option[ujson.Value],
    val nonflying : Option[ujson.Value],
    val Ptenoglossa : Option[ujson.Value],
    val repatch : Option[ujson.Value],
    val rodman : Option[ujson.Value],
    val strung : Option[ujson.Value],
    val titmal : Option[ujson.Value],
    val twalpennyworth : Option[ujson.Value],
    val unblamable : Option[ujson.Value],
    val vertical : Option[ujson.Value],
    val Whiggification : Option[ujson.Value],
    val yardman : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Saccoderm = Seq[Long] | String | NullValue
given unionReaderSaccoderm: OptionPickler.Reader[Saccoderm] = JsonExt.badMerge[Saccoderm](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterSaccoderm: OptionPickler.Writer[Saccoderm] = OptionPickler.writer[ujson.Value].comap[Saccoderm]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type SantirElement = Double | SantirClass
given unionReaderSantirElement: OptionPickler.Reader[SantirElement] = JsonExt.badMerge[SantirElement](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[SantirClass]],
    )

given unionWriterSantirElement: OptionPickler.Writer[SantirElement] = OptionPickler.writer[ujson.Value].comap[SantirElement]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: SantirClass => OptionPickler.writeJs[SantirClass](v)
}

case class SantirClass (
    val admiredly : Option[ujson.Value],
    val demicaponier : Option[ujson.Value],
    val epitympanic : Option[ujson.Value],
    val investitor : Option[ujson.Value],
    val lupiform : Option[ujson.Value],
    val monoflagellate : Option[ujson.Value],
    val paleoethnic : Option[ujson.Value],
    val prediscountable : Option[ujson.Value],
    val rhetoricals : Option[ujson.Value],
    val roomth : Option[ujson.Value],
    val saccharose : Option[ujson.Value],
    val septonasal : Option[ujson.Value],
    val serpenticide : Option[ujson.Value],
    val setarious : Option[ujson.Value],
    val spaework : Option[ujson.Value],
    val stylite : Option[ujson.Value],
    val Suessiones : Option[ujson.Value],
    val timelily : Option[ujson.Value],
    val unprofaned : Option[ujson.Value],
    val vorticular : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Saprophilous = Map[String, Long] | String | NullValue
given unionReaderSaprophilous: OptionPickler.Reader[Saprophilous] = JsonExt.badMerge[Saprophilous](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Map[String, Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterSaprophilous: OptionPickler.Writer[Saprophilous] = OptionPickler.writer[ujson.Value].comap[Saprophilous]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type SaxtenElement = SaxtenClass | String
given unionReaderSaxtenElement: OptionPickler.Reader[SaxtenElement] = JsonExt.badMerge[SaxtenElement](
    JsonExt.strictString,
    summon[OptionPickler.Reader[SaxtenClass]],
    )

given unionWriterSaxtenElement: OptionPickler.Writer[SaxtenElement] = OptionPickler.writer[ujson.Value].comap[SaxtenElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: SaxtenClass => OptionPickler.writeJs[SaxtenClass](v)
}

case class SaxtenClass (
    val algarrobilla : Option[ujson.Value] = None,
    val bowgrace : Option[ujson.Value] = None,
    val catharticalness : Option[Double] = None,
    val Centaurid : Option[ujson.Value] = None,
    val Chirotherium : Option[Long] = None,
    val disdiapason : Option[String] = None,
    val flix : Option[ujson.Value] = None,
    val germanely : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val inhume : Option[ujson.Value] = None,
    val lepidote : Option[ujson.Value] = None,
    val megalochirous : Option[ujson.Value] = None,
    val ninepenny : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val nondeist : Option[ujson.Value] = None,
    val nymphaeaceous : Option[ujson.Value] = None,
    val parietofrontal : Option[ujson.Value] = None,
    val sancyite : Option[ujson.Value] = None,
    val subjectivist : Option[ujson.Value] = None,
    val tibiad : Option[ujson.Value] = None,
    val transonic : Option[ujson.Value] = None,
    val tripetalous : Option[ujson.Value] = None,
    val trunchman : Option[ujson.Value] = None,
    val urger : Option[ujson.Value] = None,
    val withdrawnness : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

case class Scatty (
    val aeriferous : Option[ujson.Value],
    val antical : Option[ujson.Value],
    val antighostism : Option[ujson.Value],
    val arcanum : Option[ujson.Value],
    val autotrophy : Option[ujson.Value],
    val baronial : Option[ujson.Value],
    val caffeine : Option[ujson.Value],
    val gorgoniacean : Option[ujson.Value],
    val heroical : Option[ujson.Value],
    val hydropical : Option[ujson.Value],
    val mechanology : Option[ujson.Value],
    val musicopoetic : Option[ujson.Value],
    val officiality : Option[ujson.Value],
    val oftentimes : Option[ujson.Value],
    val ophthalmotonometer : Option[ujson.Value],
    val reflectively : Option[ujson.Value],
    val springer : Option[ujson.Value],
    val Tabasco : Option[ujson.Value],
    val teleianthous : Option[ujson.Value],
    val uncombated : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Scoffer = Map[String, Long] | Seq[Option[ujson.Value]] | NullValue
given unionReaderScoffer: OptionPickler.Reader[Scoffer] = JsonExt.badMerge[Scoffer](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterScoffer: OptionPickler.Writer[Scoffer] = OptionPickler.writer[ujson.Value].comap[Scoffer]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Scrampum = Boolean | Seq[Long] | NullValue
given unionReaderScrampum: OptionPickler.Reader[Scrampum] = JsonExt.badMerge[Scrampum](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterScrampum: OptionPickler.Writer[Scrampum] = OptionPickler.writer[ujson.Value].comap[Scrampum]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Serpentinic = Double | Seq[Long]
given unionReaderSerpentinic: OptionPickler.Reader[Serpentinic] = JsonExt.badMerge[Serpentinic](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterSerpentinic: OptionPickler.Writer[Serpentinic] = OptionPickler.writer[ujson.Value].comap[Serpentinic]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

type Shadowable = Boolean | Seq[Option[Long]]
given unionReaderShadowable: OptionPickler.Reader[Shadowable] = JsonExt.badMerge[Shadowable](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Option[Long]]]],
    )

given unionWriterShadowable: OptionPickler.Writer[Shadowable] = OptionPickler.writer[ujson.Value].comap[Shadowable]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Option[Long]] => OptionPickler.writeJs[Seq[Option[Long]]](v)
}

type SisteringElement = Long | Seq[Option[ujson.Value]] | SisteringClass
given unionReaderSisteringElement: OptionPickler.Reader[SisteringElement] = JsonExt.badMerge[SisteringElement](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[SisteringClass]],
    )

given unionWriterSisteringElement: OptionPickler.Writer[SisteringElement] = OptionPickler.writer[ujson.Value].comap[SisteringElement]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: SisteringClass => OptionPickler.writeJs[SisteringClass](v)
}

case class SisteringClass (
    val amphicarpic : Option[ujson.Value],
    val Chianti : Option[ujson.Value],
    val frigorific : Option[ujson.Value],
    val Haplomi : Option[ujson.Value],
    val hyperkinesis : Option[ujson.Value],
    val laudable : Option[ujson.Value],
    val madwoman : Option[ujson.Value],
    val maimedly : Option[ujson.Value],
    val Micropterygidae : Option[ujson.Value],
    val microrhabdus : Option[ujson.Value],
    val nondense : Option[ujson.Value],
    val phlebemphraxis : Option[ujson.Value],
    val redsear : Option[ujson.Value],
    val schismatical : Option[ujson.Value],
    val tartryl : Option[ujson.Value],
    val unabhorred : Option[ujson.Value],
    val undeliberateness : Option[ujson.Value],
    val unmixable : Option[ujson.Value],
    val untruckling : Option[ujson.Value],
    val vineal : Option[ujson.Value]
) derives OptionPickler.ReadWriter

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
    val nonbookish : Option[ujson.Value] = None,
    val overtrump : Option[Long] = None,
    val scotino : Option[Long] = None,
    val seasonable : Option[Long] = None,
    val sephen : Option[Long] = None,
    val stigmarioid : Option[Long] = None,
    val tired : Option[Long] = None,
    val trifid : Option[Long] = None,
    val undefeatedly : Option[Long] = None,
    val ungirlish : Option[Long] = None
) derives OptionPickler.ReadWriter

type Stagmometer = String | Seq[Option[Long]]
given unionReaderStagmometer: OptionPickler.Reader[Stagmometer] = JsonExt.badMerge[Stagmometer](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Option[Long]]]],
    )

given unionWriterStagmometer: OptionPickler.Writer[Stagmometer] = OptionPickler.writer[ujson.Value].comap[Stagmometer]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Option[Long]] => OptionPickler.writeJs[Seq[Option[Long]]](v)
}

type Stimulability = Boolean | Map[String, Long] | Long
given unionReaderStimulability: OptionPickler.Reader[Stimulability] = JsonExt.badMerge[Stimulability](
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterStimulability: OptionPickler.Writer[Stimulability] = OptionPickler.writer[ujson.Value].comap[Stimulability]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Strangleable = Double | Seq[Option[ujson.Value]]
given unionReaderStrangleable: OptionPickler.Reader[Strangleable] = JsonExt.badMerge[Strangleable](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterStrangleable: OptionPickler.Writer[Strangleable] = OptionPickler.writer[ujson.Value].comap[Strangleable]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

type StrenuosityElement = Seq[Option[ujson.Value]] | StrenuosityClass
given unionReaderStrenuosityElement: OptionPickler.Reader[StrenuosityElement] = JsonExt.badMerge[StrenuosityElement](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[StrenuosityClass]],
    )

given unionWriterStrenuosityElement: OptionPickler.Writer[StrenuosityElement] = OptionPickler.writer[ujson.Value].comap[StrenuosityElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: StrenuosityClass => OptionPickler.writeJs[StrenuosityClass](v)
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
    val nonbookish : Option[ujson.Value] = None,
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
) derives OptionPickler.ReadWriter

type Tabaxir = Boolean | Double
given unionReaderTabaxir: OptionPickler.Reader[Tabaxir] = JsonExt.badMerge[Tabaxir](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    )

given unionWriterTabaxir: OptionPickler.Writer[Tabaxir] = OptionPickler.writer[ujson.Value].comap[Tabaxir]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
}

type Talpiform = Double | QuebrachineClass | NullValue
given unionReaderTalpiform: OptionPickler.Reader[Talpiform] = JsonExt.badMerge[Talpiform](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[QuebrachineClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterTalpiform: OptionPickler.Writer[Talpiform] = OptionPickler.writer[ujson.Value].comap[Talpiform]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: QuebrachineClass => OptionPickler.writeJs[QuebrachineClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Thwack = Boolean | Double | QuebrachineClass
given unionReaderThwack: OptionPickler.Reader[Thwack] = JsonExt.badMerge[Thwack](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[QuebrachineClass]],
    )

given unionWriterThwack: OptionPickler.Writer[Thwack] = OptionPickler.writer[ujson.Value].comap[Thwack]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: QuebrachineClass => OptionPickler.writeJs[QuebrachineClass](v)
}

type Tortricine = QuebrachineClass | Seq[Option[Long]]
given unionReaderTortricine: OptionPickler.Reader[Tortricine] = JsonExt.badMerge[Tortricine](
    summon[OptionPickler.Reader[Seq[Option[Long]]]],
    summon[OptionPickler.Reader[QuebrachineClass]],
    )

given unionWriterTortricine: OptionPickler.Writer[Tortricine] = OptionPickler.writer[ujson.Value].comap[Tortricine]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[Long]] => OptionPickler.writeJs[Seq[Option[Long]]](v)
        case v: QuebrachineClass => OptionPickler.writeJs[QuebrachineClass](v)
}

type TruantcyElement = Boolean | TruantcyClass
given unionReaderTruantcyElement: OptionPickler.Reader[TruantcyElement] = JsonExt.badMerge[TruantcyElement](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[TruantcyClass]],
    )

given unionWriterTruantcyElement: OptionPickler.Writer[TruantcyElement] = OptionPickler.writer[ujson.Value].comap[TruantcyElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: TruantcyClass => OptionPickler.writeJs[TruantcyClass](v)
}

case class TruantcyClass (
    val alfiona : Option[ujson.Value] = None,
    val ascaridiasis : Option[ujson.Value] = None,
    val bungey : Option[ujson.Value] = None,
    val catharticalness : Option[Double] = None,
    val ceroxyle : Option[ujson.Value] = None,
    val Chirotherium : Option[Long] = None,
    val chorology : Option[ujson.Value] = None,
    val disdiapason : Option[String] = None,
    val enmarble : Option[ujson.Value] = None,
    val Epeira : Option[ujson.Value] = None,
    val Eurylaimi : Option[ujson.Value] = None,
    val germination : Option[ujson.Value] = None,
    val hallelujah : Option[ujson.Value] = None,
    val homocerc : Option[Boolean] = None,
    val lev : Option[ujson.Value] = None,
    val mouthing : Option[ujson.Value] = None,
    val nonbookish : Option[ujson.Value] = None,
    val philliloo : Option[ujson.Value] = None,
    val planetal : Option[ujson.Value] = None,
    val poney : Option[ujson.Value] = None,
    val punctualist : Option[ujson.Value] = None,
    val returnlessly : Option[ujson.Value] = None,
    val skelder : Option[ujson.Value] = None,
    val windwaywardly : Option[ujson.Value] = None,
    val Yuman : Option[ujson.Value] = None
) derives OptionPickler.ReadWriter

type Unbeginning = Map[String, Long] | Seq[Option[ujson.Value]] | String
given unionReaderUnbeginning: OptionPickler.Reader[Unbeginning] = JsonExt.badMerge[Unbeginning](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterUnbeginning: OptionPickler.Writer[Unbeginning] = OptionPickler.writer[ujson.Value].comap[Unbeginning]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Undesirability = Seq[Long] | Map[String, Long] | String
given unionReaderUndesirability: OptionPickler.Reader[Undesirability] = JsonExt.badMerge[Undesirability](
    JsonExt.strictString,
    summon[OptionPickler.Reader[Seq[Long]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterUndesirability: OptionPickler.Writer[Undesirability] = OptionPickler.writer[ujson.Value].comap[Undesirability]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Unerasing = Map[String, Long] | Long | Seq[Option[ujson.Value]]
given unionReaderUnerasing: OptionPickler.Reader[Unerasing] = JsonExt.badMerge[Unerasing](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterUnerasing: OptionPickler.Writer[Unerasing] = OptionPickler.writer[ujson.Value].comap[Unerasing]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Unguentarium = Long | Seq[Option[ujson.Value]] | NullValue
given unionReaderUnguentarium: OptionPickler.Reader[Unguentarium] = JsonExt.badMerge[Unguentarium](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterUnguentarium: OptionPickler.Writer[Unguentarium] = OptionPickler.writer[ujson.Value].comap[Unguentarium]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type UnimpeachablyElement = Boolean | UnimpeachablyClass
given unionReaderUnimpeachablyElement: OptionPickler.Reader[UnimpeachablyElement] = JsonExt.badMerge[UnimpeachablyElement](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[UnimpeachablyClass]],
    )

given unionWriterUnimpeachablyElement: OptionPickler.Writer[UnimpeachablyElement] = OptionPickler.writer[ujson.Value].comap[UnimpeachablyElement]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: UnimpeachablyClass => OptionPickler.writeJs[UnimpeachablyClass](v)
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
    val nonbookish : Option[ujson.Value] = None,
    val planometry : Option[Long] = None,
    val Quiina : Option[Long] = None,
    val Robert : Option[Long] = None,
    val rot : Option[Long] = None,
    val subcinctorium : Option[Long] = None,
    val tussocker : Option[Long] = None,
    val ultraproud : Option[Long] = None,
    val unsuggestedness : Option[Long] = None
) derives OptionPickler.ReadWriter

type Unmortgaged = Double | Map[String, Long] | NullValue
given unionReaderUnmortgaged: OptionPickler.Reader[Unmortgaged] = JsonExt.badMerge[Unmortgaged](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Map[String, Long]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterUnmortgaged: OptionPickler.Writer[Unmortgaged] = OptionPickler.writer[ujson.Value].comap[Unmortgaged]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Unobstructed = Long | QuebrachineClass | NullValue
given unionReaderUnobstructed: OptionPickler.Reader[Unobstructed] = JsonExt.badMerge[Unobstructed](
    JsonExt.strictLong,
    summon[OptionPickler.Reader[QuebrachineClass]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterUnobstructed: OptionPickler.Writer[Unobstructed] = OptionPickler.writer[ujson.Value].comap[Unobstructed]{ _v =>
    (_v: @unchecked) match 
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: QuebrachineClass => OptionPickler.writeJs[QuebrachineClass](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Unreceptivity = Long | Seq[Option[ujson.Value]] | String
given unionReaderUnreceptivity: OptionPickler.Reader[Unreceptivity] = JsonExt.badMerge[Unreceptivity](
    JsonExt.strictString,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    )

given unionWriterUnreceptivity: OptionPickler.Writer[Unreceptivity] = OptionPickler.writer[ujson.Value].comap[Unreceptivity]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
}

type Unsatisfactoriness = Boolean | Seq[Long] | Long
given unionReaderUnsatisfactoriness: OptionPickler.Reader[Unsatisfactoriness] = JsonExt.badMerge[Unsatisfactoriness](
    JsonExt.strictBoolean,
    JsonExt.strictLong,
    summon[OptionPickler.Reader[Seq[Long]]],
    )

given unionWriterUnsatisfactoriness: OptionPickler.Writer[Unsatisfactoriness] = OptionPickler.writer[ujson.Value].comap[Unsatisfactoriness]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Long => OptionPickler.writeJs[Long](v)
        case v: Seq[Long] => OptionPickler.writeJs[Seq[Long]](v)
}

type UnstressedElement = Boolean | String | UnstressedClass
given unionReaderUnstressedElement: OptionPickler.Reader[UnstressedElement] = JsonExt.badMerge[UnstressedElement](
    JsonExt.strictString,
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[UnstressedClass]],
    )

given unionWriterUnstressedElement: OptionPickler.Writer[UnstressedElement] = OptionPickler.writer[ujson.Value].comap[UnstressedElement]{ _v =>
    (_v: @unchecked) match 
        case v: String => OptionPickler.writeJs[String](v)
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: UnstressedClass => OptionPickler.writeJs[UnstressedClass](v)
}

case class UnstressedClass (
    val Alain : Option[ujson.Value],
    val Amphirhina : Option[ujson.Value],
    val antimachinery : Option[ujson.Value],
    val coldish : Option[ujson.Value],
    val crantara : Option[ujson.Value],
    val distinguishing : Option[ujson.Value],
    val elytroposis : Option[ujson.Value],
    val gentianwort : Option[ujson.Value],
    val heliosis : Option[ujson.Value],
    val instrumental : Option[ujson.Value],
    val introinflection : Option[ujson.Value],
    val kala : Option[ujson.Value],
    val Lincolnian : Option[ujson.Value],
    val metad : Option[ujson.Value],
    val Sarcophilus : Option[ujson.Value],
    val swingingly : Option[ujson.Value],
    val unconformity : Option[ujson.Value],
    val undecreed : Option[ujson.Value],
    val venerable : Option[ujson.Value],
    val vowellessness : Option[ujson.Value]
) derives OptionPickler.ReadWriter

type Untasked = Double | Map[String, Long] | Seq[Option[ujson.Value]]
given unionReaderUntasked: OptionPickler.Reader[Untasked] = JsonExt.badMerge[Untasked](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterUntasked: OptionPickler.Writer[Untasked] = OptionPickler.writer[ujson.Value].comap[Untasked]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Unvarying = Boolean | Double | Map[String, Long]
given unionReaderUnvarying: OptionPickler.Reader[Unvarying] = JsonExt.badMerge[Unvarying](
    JsonExt.strictBoolean,
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[Map[String, Long]]],
    )

given unionWriterUnvarying: OptionPickler.Writer[Unvarying] = OptionPickler.writer[ujson.Value].comap[Unvarying]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: Map[String, Long] => OptionPickler.writeJs[Map[String, Long]](v)
}

type Vehemently = Boolean | Seq[Option[ujson.Value]] | NullValue
given unionReaderVehemently: OptionPickler.Reader[Vehemently] = JsonExt.badMerge[Vehemently](
    JsonExt.strictBoolean,
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[NullValue]],
    )

given unionWriterVehemently: OptionPickler.Writer[Vehemently] = OptionPickler.writer[ujson.Value].comap[Vehemently]{ _v =>
    (_v: @unchecked) match 
        case v: Boolean => OptionPickler.writeJs[Boolean](v)
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: NullValue => OptionPickler.writeJs[NullValue](v)
}

type Whitepot = Double | QuebrachineClass
given unionReaderWhitepot: OptionPickler.Reader[Whitepot] = JsonExt.badMerge[Whitepot](
    JsonExt.strictDouble,
    summon[OptionPickler.Reader[QuebrachineClass]],
    )

given unionWriterWhitepot: OptionPickler.Writer[Whitepot] = OptionPickler.writer[ujson.Value].comap[Whitepot]{ _v =>
    (_v: @unchecked) match 
        case v: Double => OptionPickler.writeJs[Double](v)
        case v: QuebrachineClass => OptionPickler.writeJs[QuebrachineClass](v)
}

type WrothyElement = Seq[Option[ujson.Value]] | WrothyClass
given unionReaderWrothyElement: OptionPickler.Reader[WrothyElement] = JsonExt.badMerge[WrothyElement](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[WrothyClass]],
    )

given unionWriterWrothyElement: OptionPickler.Writer[WrothyElement] = OptionPickler.writer[ujson.Value].comap[WrothyElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: WrothyClass => OptionPickler.writeJs[WrothyClass](v)
}

case class WrothyClass (
    val Aeschynanthus : Option[ujson.Value],
    val aquiferous : Option[ujson.Value],
    val cheapener : Option[ujson.Value],
    val enumeration : Option[ujson.Value],
    val Ephesine : Option[ujson.Value],
    val escadrille : Option[ujson.Value],
    val estrous : Option[ujson.Value],
    val interestedly : Option[ujson.Value],
    val katakinetomer : Option[ujson.Value],
    val mortification : Option[ujson.Value],
    val morula : Option[ujson.Value],
    val orthosymmetrical : Option[ujson.Value],
    val overbark : Option[ujson.Value],
    val politist : Option[ujson.Value],
    val qualified : Option[ujson.Value],
    val sphenomalar : Option[ujson.Value],
    val throatful : Option[ujson.Value],
    val transhumance : Option[ujson.Value],
    val triandrian : Option[ujson.Value],
    val unbooked : Option[ujson.Value]
) derives OptionPickler.ReadWriter
