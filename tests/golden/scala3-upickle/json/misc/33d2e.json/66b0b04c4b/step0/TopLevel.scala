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
    val laureates : Seq[Laureate]
) derives OptionPickler.ReadWriter

case class Laureate (
    val born : String,
    val bornCity : Option[String] = None,
    val bornCountry : Option[String] = None,
    val bornCountryCode : Option[String] = None,
    val died : String,
    val diedCity : Option[String] = None,
    val diedCountry : Option[String] = None,
    val diedCountryCode : Option[String] = None,
    val firstname : Option[String] = None,
    val gender : Gender,
    val id : String,
    val prizes : Seq[Prize],
    val surname : Option[String] = None
) derives OptionPickler.ReadWriter

enum Gender : 
    case Male
    case Female
    case Org

given OptionPickler.ReadWriter[Gender] = OptionPickler.readwriter[String].bimap[Gender](
    {
        case Gender.Male => "male"
        case Gender.Female => "female"
        case Gender.Org => "org"
    },
    {
        case "male" => Gender.Male
        case "female" => Gender.Female
        case "org" => Gender.Org
        case other => throw new upickle.core.Abort("invalid Gender: " + other)
    }
)

case class Prize (
    val affiliations : Seq[AffiliationElement],
    val category : Option[Category] = None,
    val motivation : Option[String] = None,
    val overallMotivation : Option[String] = None,
    val share : Option[String] = None,
    val year : Option[String] = None
) derives OptionPickler.ReadWriter

type AffiliationElement = AffiliationClass | Seq[Option[ujson.Value]]
given unionReaderAffiliationElement: OptionPickler.Reader[AffiliationElement] = JsonExt.badMerge[AffiliationElement](
    summon[OptionPickler.Reader[Seq[Option[ujson.Value]]]],
    summon[OptionPickler.Reader[AffiliationClass]],
    )

given unionWriterAffiliationElement: OptionPickler.Writer[AffiliationElement] = OptionPickler.writer[ujson.Value].comap[AffiliationElement]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[Option[ujson.Value]] => OptionPickler.writeJs[Seq[Option[ujson.Value]]](v)
        case v: AffiliationClass => OptionPickler.writeJs[AffiliationClass](v)
}

case class AffiliationClass (
    val city : Option[String] = None,
    val country : Option[String] = None,
    val name : Option[String] = None
) derives OptionPickler.ReadWriter

enum Category : 
    case Physics
    case Chemistry
    case Peace
    case Medicine
    case Literature
    case Economics

given OptionPickler.ReadWriter[Category] = OptionPickler.readwriter[String].bimap[Category](
    {
        case Category.Physics => "physics"
        case Category.Chemistry => "chemistry"
        case Category.Peace => "peace"
        case Category.Medicine => "medicine"
        case Category.Literature => "literature"
        case Category.Economics => "economics"
    },
    {
        case "physics" => Category.Physics
        case "chemistry" => Category.Chemistry
        case "peace" => Category.Peace
        case "medicine" => Category.Medicine
        case "literature" => Category.Literature
        case "economics" => Category.Economics
        case other => throw new upickle.core.Abort("invalid Category: " + other)
    }
)
