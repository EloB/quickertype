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


type TopLevel = List[TopLevelElement]

case class TopLevelElement (
    val designation : String,
    val discovery_date : java.time.Instant,
    val h_mag : Option[String] = None,
    val i_deg : String,
    val moid_au : String,
    val orbit_class : OrbitClass,
    val period_yr : Option[String] = None,
    val pha : Pha,
    val q_au_1 : String,
    val q_au_2 : Option[String] = None
) derives OptionPickler.ReadWriter

enum OrbitClass : 
    case Apollo
    case Amor
    case Aten
    case Comet
    case JupiterFamilyComet
    case HalleyTypeComet
    case ParabolicComet
    case OrbitClassJupiterFamilyComet
    case EnckeTypeComet

given OptionPickler.ReadWriter[OrbitClass] = OptionPickler.readwriter[String].bimap[OrbitClass](
    {
        case OrbitClass.Apollo => "Apollo"
        case OrbitClass.Amor => "Amor"
        case OrbitClass.Aten => "Aten"
        case OrbitClass.Comet => "Comet"
        case OrbitClass.JupiterFamilyComet => "Jupiter-family Comet"
        case OrbitClass.HalleyTypeComet => "Halley-type Comet*"
        case OrbitClass.ParabolicComet => "Parabolic Comet"
        case OrbitClass.OrbitClassJupiterFamilyComet => "Jupiter-family Comet*"
        case OrbitClass.EnckeTypeComet => "Encke-type Comet"
    },
    {
        case "Apollo" => OrbitClass.Apollo
        case "Amor" => OrbitClass.Amor
        case "Aten" => OrbitClass.Aten
        case "Comet" => OrbitClass.Comet
        case "Jupiter-family Comet" => OrbitClass.JupiterFamilyComet
        case "Halley-type Comet*" => OrbitClass.HalleyTypeComet
        case "Parabolic Comet" => OrbitClass.ParabolicComet
        case "Jupiter-family Comet*" => OrbitClass.OrbitClassJupiterFamilyComet
        case "Encke-type Comet" => OrbitClass.EnckeTypeComet
        case other => throw new upickle.core.Abort("invalid OrbitClass: " + other)
    }
)

enum Pha : 
    case Y
    case N
    case NA

given OptionPickler.ReadWriter[Pha] = OptionPickler.readwriter[String].bimap[Pha](
    {
        case Pha.Y => "Y"
        case Pha.N => "N"
        case Pha.NA => "n/a"
    },
    {
        case "Y" => Pha.Y
        case "N" => Pha.N
        case "n/a" => Pha.NA
        case other => throw new upickle.core.Abort("invalid Pha: " + other)
    }
)
