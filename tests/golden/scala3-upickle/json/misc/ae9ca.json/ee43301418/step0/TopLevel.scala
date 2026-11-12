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
    val features : Seq[Feature],
    val name : String,
    val `type` : String
) derives OptionPickler.ReadWriter

case class Feature (
    val `type` : FeatureType,
    val geometry : Geometry,
    val properties : Properties
) derives OptionPickler.ReadWriter

enum FeatureType : 
    case Feature

given OptionPickler.ReadWriter[FeatureType] = OptionPickler.readwriter[String].bimap[FeatureType](
    {
        case FeatureType.Feature => "Feature"
    },
    {
        case "Feature" => FeatureType.Feature
        case other => throw new upickle.core.Abort("invalid FeatureType: " + other)
    }
)

case class Geometry (
    val coordinates : Seq[Double],
    val `type` : GeometryType
) derives OptionPickler.ReadWriter

enum GeometryType : 
    case Point

given OptionPickler.ReadWriter[GeometryType] = OptionPickler.readwriter[String].bimap[GeometryType](
    {
        case GeometryType.Point => "Point"
    },
    {
        case "Point" => GeometryType.Point
        case other => throw new upickle.core.Abort("invalid GeometryType: " + other)
    }
)

case class Properties (
    val Area : String,
    val `Central Asset ID` : String,
    val `Feature Location` : String,
    val lat : String,
    val long : String,
    val `Maintaining Authority` : MaintainingAuthority,
    val Number : String,
    val Class : Class,
    val `Site Name` : String,
    val Ward : Ward
) derives OptionPickler.ReadWriter

enum MaintainingAuthority : 
    case CityOfBallarat

given OptionPickler.ReadWriter[MaintainingAuthority] = OptionPickler.readwriter[String].bimap[MaintainingAuthority](
    {
        case MaintainingAuthority.CityOfBallarat => "City of Ballarat"
    },
    {
        case "City of Ballarat" => MaintainingAuthority.CityOfBallarat
        case other => throw new upickle.core.Abort("invalid MaintainingAuthority: " + other)
    }
)

enum Class : 
    case NoCodeAllocated
    case OSDistrict
    case OSNeighbourhood
    case OSRegional

given OptionPickler.ReadWriter[Class] = OptionPickler.readwriter[String].bimap[Class](
    {
        case Class.NoCodeAllocated => "No Code Allocated"
        case Class.OSDistrict => "OS-District"
        case Class.OSNeighbourhood => "OS-Neighbourhood"
        case Class.OSRegional => "OS-Regional"
    },
    {
        case "No Code Allocated" => Class.NoCodeAllocated
        case "OS-District" => Class.OSDistrict
        case "OS-Neighbourhood" => Class.OSNeighbourhood
        case "OS-Regional" => Class.OSRegional
        case other => throw new upickle.core.Abort("invalid Class: " + other)
    }
)

enum Ward : 
    case South
    case North
    case Central

given OptionPickler.ReadWriter[Ward] = OptionPickler.readwriter[String].bimap[Ward](
    {
        case Ward.South => "South"
        case Ward.North => "North"
        case Ward.Central => "Central"
    },
    {
        case "South" => Ward.South
        case "North" => Ward.North
        case "Central" => Ward.Central
        case other => throw new upickle.core.Abort("invalid Ward: " + other)
    }
)
