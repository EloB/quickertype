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
    val crs : CRS,
    val features : Seq[Feature],
    val `type` : String,
    val totalFeatures : Long
) derives OptionPickler.ReadWriter

case class CRS (
    val `type` : String,
    val properties : CRSProperties
) derives OptionPickler.ReadWriter

case class CRSProperties (
    val name : String
) derives OptionPickler.ReadWriter

case class Feature (
    val `type` : FeatureType,
    val geometry : Geometry,
    val geometry_name : GeometryName,
    val id : String,
    val properties : FeatureProperties
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

enum GeometryName : 
    case Geom

given OptionPickler.ReadWriter[GeometryName] = OptionPickler.readwriter[String].bimap[GeometryName](
    {
        case GeometryName.Geom => "geom"
    },
    {
        case "geom" => GeometryName.Geom
        case other => throw new upickle.core.Abort("invalid GeometryName: " + other)
    }
)

case class FeatureProperties (
    val division : String,
    val fax : Double,
    val fire_ban_r : Option[FireBanR],
    val latitude : Double,
    val local_govt : String,
    val longitude : Double,
    val no : Option[String],
    val phone : Double,
    val postcode : Long,
    val `type` : Option[PropertiesType],
    val psa : String,
    val region : Region,
    val station : String,
    val street : String,
    val suburb : String
) derives OptionPickler.ReadWriter

enum FireBanR : 
    case NorthCentral
    case Central
    case SouthWest
    case Wimmera
    case NorthernCountry
    case EastGippsland
    case NorthEast
    case Mallee
    case WestSouthGippsland
    case Ballarat

given OptionPickler.ReadWriter[FireBanR] = OptionPickler.readwriter[String].bimap[FireBanR](
    {
        case FireBanR.NorthCentral => "North Central"
        case FireBanR.Central => "Central"
        case FireBanR.SouthWest => "South West"
        case FireBanR.Wimmera => "Wimmera"
        case FireBanR.NorthernCountry => "Northern Country"
        case FireBanR.EastGippsland => "East Gippsland"
        case FireBanR.NorthEast => "North East"
        case FireBanR.Mallee => "Mallee"
        case FireBanR.WestSouthGippsland => "West &South Gippsland"
        case FireBanR.Ballarat => "Ballarat"
    },
    {
        case "North Central" => FireBanR.NorthCentral
        case "Central" => FireBanR.Central
        case "South West" => FireBanR.SouthWest
        case "Wimmera" => FireBanR.Wimmera
        case "Northern Country" => FireBanR.NorthernCountry
        case "East Gippsland" => FireBanR.EastGippsland
        case "North East" => FireBanR.NorthEast
        case "Mallee" => FireBanR.Mallee
        case "West &South Gippsland" => FireBanR.WestSouthGippsland
        case "Ballarat" => FireBanR.Ballarat
        case other => throw new upickle.core.Abort("invalid FireBanR: " + other)
    }
)

enum PropertiesType : 
    case Street
    case Avenue
    case Road
    case Highway
    case Boulevard
    case Court
    case Way
    case Drive
    case South
    case Hill
    case Lane
    case Close
    case Parade
    case TypeRoad
    case Place
    case RD

given OptionPickler.ReadWriter[PropertiesType] = OptionPickler.readwriter[String].bimap[PropertiesType](
    {
        case PropertiesType.Street => "STREET"
        case PropertiesType.Avenue => "AVENUE"
        case PropertiesType.Road => "ROAD"
        case PropertiesType.Highway => "HIGHWAY"
        case PropertiesType.Boulevard => "BOULEVARD"
        case PropertiesType.Court => "COURT"
        case PropertiesType.Way => "WAY"
        case PropertiesType.Drive => "DRIVE"
        case PropertiesType.South => "SOUTH"
        case PropertiesType.Hill => "HILL"
        case PropertiesType.Lane => "LANE"
        case PropertiesType.Close => "CLOSE"
        case PropertiesType.Parade => "PARADE"
        case PropertiesType.TypeRoad => "Road"
        case PropertiesType.Place => "PLACE"
        case PropertiesType.RD => "RD"
    },
    {
        case "STREET" => PropertiesType.Street
        case "AVENUE" => PropertiesType.Avenue
        case "ROAD" => PropertiesType.Road
        case "HIGHWAY" => PropertiesType.Highway
        case "BOULEVARD" => PropertiesType.Boulevard
        case "COURT" => PropertiesType.Court
        case "WAY" => PropertiesType.Way
        case "DRIVE" => PropertiesType.Drive
        case "SOUTH" => PropertiesType.South
        case "HILL" => PropertiesType.Hill
        case "LANE" => PropertiesType.Lane
        case "CLOSE" => PropertiesType.Close
        case "PARADE" => PropertiesType.Parade
        case "Road" => PropertiesType.TypeRoad
        case "PLACE" => PropertiesType.Place
        case "RD" => PropertiesType.RD
        case other => throw new upickle.core.Abort("invalid PropertiesType: " + other)
    }
)

enum Region : 
    case Eastern
    case NorthernMetro
    case Western
    case SouthernMetro

given OptionPickler.ReadWriter[Region] = OptionPickler.readwriter[String].bimap[Region](
    {
        case Region.Eastern => "Eastern"
        case Region.NorthernMetro => "Northern Metro"
        case Region.Western => "Western"
        case Region.SouthernMetro => "Southern Metro"
    },
    {
        case "Eastern" => Region.Eastern
        case "Northern Metro" => Region.NorthernMetro
        case "Western" => Region.Western
        case "Southern Metro" => Region.SouthernMetro
        case other => throw new upickle.core.Abort("invalid Region: " + other)
    }
)
