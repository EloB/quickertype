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
    val version : Option[String] = None,
    val fruits : Option[Seq[Fruit]] = None,
    val vehicles : Option[Seq[Vehicle]] = None
) derives OptionPickler.ReadWriter

case class Fruit (
    val apple : Option[Boolean] = None,
    val berries : Option[Seq[Berry]] = None,
    val orange : Option[Boolean] = None
) derives OptionPickler.ReadWriter

case class Berry (
    val color : Option[Color] = None,
    val name : Option[String] = None,
    val shapes : Option[Seq[Shape]] = None
) derives OptionPickler.ReadWriter

case class Color (
    val rgb : Option[Double] = None
) derives OptionPickler.ReadWriter

case class Shape (
    val geometry : Option[Geometry] = None,
    val history : Option[History] = None
) derives OptionPickler.ReadWriter

case class Geometry (
    val rectShape : Option[RectShape] = None,
    val circularShape : Option[Seq[CircularShape]] = None
) derives OptionPickler.ReadWriter

case class CircularShape (
    val shapeName : Option[String] = None
) derives OptionPickler.ReadWriter

case class RectShape (
    val parts : Option[Seq[Part]] = None
) derives OptionPickler.ReadWriter

case class Part (
    val depth : Option[String] = None,
    val length : Option[String] = None,
    val width : Option[String] = None
) derives OptionPickler.ReadWriter

case class History (
    val `class` : Option[String] = None
) derives OptionPickler.ReadWriter

case class Vehicle (
    val brand : Option[String] = None,
    val id : Option[String] = None,
    val speed : Option[Speed] = None,
    val subModule : Option[Boolean] = None,
    val `type` : Option[VehicleType] = None,
    val year : Option[String] = None
) derives OptionPickler.ReadWriter

case class Speed (
    val velocity : Option[Limit] = None
) derives OptionPickler.ReadWriter

case class Limit (
    val maximum : Option[Double] = None,
    val minimum : Option[Double] = None
) derives OptionPickler.ReadWriter

case class VehicleType (
    val name : Option[Name] = None,
    val width : Option[Axis] = None,
    val length : Option[Axis] = None
) derives OptionPickler.ReadWriter

enum Axis : 
    case X
    case Y
    case Z
    case Xy
    case Yz
    case Zx

given OptionPickler.ReadWriter[Axis] = OptionPickler.readwriter[String].bimap[Axis](
    {
        case Axis.X => "X"
        case Axis.Y => "Y"
        case Axis.Z => "Z"
        case Axis.Xy => "XY"
        case Axis.Yz => "YZ"
        case Axis.Zx => "ZX"
    },
    {
        case "X" => Axis.X
        case "Y" => Axis.Y
        case "Z" => Axis.Z
        case "XY" => Axis.Xy
        case "YZ" => Axis.Yz
        case "ZX" => Axis.Zx
        case other => throw new upickle.core.Abort("invalid Axis: " + other)
    }
)

enum Name : 
    case Truck
    case Bus
    case Car
    case Van
    case Train
    case Bike
    case Aeroplane
    case Jeep
    case Trolley

given OptionPickler.ReadWriter[Name] = OptionPickler.readwriter[String].bimap[Name](
    {
        case Name.Truck => "truck"
        case Name.Bus => "bus"
        case Name.Car => "car"
        case Name.Van => "van"
        case Name.Train => "train"
        case Name.Bike => "Bike"
        case Name.Aeroplane => "Aeroplane"
        case Name.Jeep => "Jeep"
        case Name.Trolley => "Trolley"
    },
    {
        case "truck" => Name.Truck
        case "bus" => Name.Bus
        case "car" => Name.Car
        case "van" => Name.Van
        case "train" => Name.Train
        case "Bike" => Name.Bike
        case "Aeroplane" => Name.Aeroplane
        case "Jeep" => Name.Jeep
        case "Trolley" => Name.Trolley
        case other => throw new upickle.core.Abort("invalid Name: " + other)
    }
)
