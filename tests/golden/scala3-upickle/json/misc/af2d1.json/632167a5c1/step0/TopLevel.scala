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
    val coordinates : Seq[Seq[Seq[Seq[Double]]]],
    val `type` : GeometryType
) derives OptionPickler.ReadWriter

enum GeometryType : 
    case MultiPolygon

given OptionPickler.ReadWriter[GeometryType] = OptionPickler.readwriter[String].bimap[GeometryType](
    {
        case GeometryType.MultiPolygon => "MultiPolygon"
    },
    {
        case "MultiPolygon" => GeometryType.MultiPolygon
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
    val add_improv : Option[AddImprov],
    val `area_` : Double,
    val asset_numb : String,
    val comments : Option[String],
    val condition : Long,
    val constructi : Option[String],
    val createdate : Option[ujson.Value],
    val createuser : Option[ujson.Value],
    val disposal_d : Option[ujson.Value],
    val documents : String,
    val drawing_nu : Option[String],
    val file_numbe : Option[String],
    val folder_num : Option[String],
    val funding_ba : Option[FundingBa],
    val historic_c : Long,
    val inspection : String,
    val inspectors : Option[ujson.Value],
    val last_updat : Option[ujson.Value],
    val level_accu : Option[LevelAccu],
    val material : Material,
    val mi_prinx : Long,
    val mi_symbolo : MiSymbolo,
    val number_lan : Long,
    val owner : Option[String],
    val positional : Option[LevelAccu],
    val project_nu : Option[String],
    val `type` : Option[PropertiesType],
    val rec_id : Long,
    val record_cre : Option[String],
    val shape_area : Double,
    val shape_leng : Double,
    val status : Status,
    val survey_num : Option[ujson.Value],
    val toe_rl : Double,
    val top_rl : Double,
    val update_dat : String,
    val updatedate : Option[ujson.Value],
    val updateuser : Option[ujson.Value]
) derives OptionPickler.ReadWriter

enum AddImprov : 
    case F
    case AddImprovF
    case T

given OptionPickler.ReadWriter[AddImprov] = OptionPickler.readwriter[String].bimap[AddImprov](
    {
        case AddImprov.F => "f"
        case AddImprov.AddImprovF => "F"
        case AddImprov.T => "t"
    },
    {
        case "f" => AddImprov.F
        case "F" => AddImprov.AddImprovF
        case "t" => AddImprov.T
        case other => throw new upickle.core.Abort("invalid AddImprov: " + other)
    }
)

enum FundingBa : 
    case NonGCCC
    case Capex
    case Initial
    case Contribute

given OptionPickler.ReadWriter[FundingBa] = OptionPickler.readwriter[String].bimap[FundingBa](
    {
        case FundingBa.NonGCCC => "Non GCCC"
        case FundingBa.Capex => "Capex"
        case FundingBa.Initial => "Initial"
        case FundingBa.Contribute => "Contribute"
    },
    {
        case "Non GCCC" => FundingBa.NonGCCC
        case "Capex" => FundingBa.Capex
        case "Initial" => FundingBa.Initial
        case "Contribute" => FundingBa.Contribute
        case other => throw new upickle.core.Abort("invalid FundingBa: " + other)
    }
)

enum LevelAccu : 
    case GPSCorrected10M
    case Approx
    case GPSCOrrected10M

given OptionPickler.ReadWriter[LevelAccu] = OptionPickler.readwriter[String].bimap[LevelAccu](
    {
        case LevelAccu.GPSCorrected10M => "GPS Corrected 1.0M"
        case LevelAccu.Approx => "APPROX"
        case LevelAccu.GPSCOrrected10M => "GPS COrrected 1.0M"
    },
    {
        case "GPS Corrected 1.0M" => LevelAccu.GPSCorrected10M
        case "APPROX" => LevelAccu.Approx
        case "GPS COrrected 1.0M" => LevelAccu.GPSCOrrected10M
        case other => throw new upickle.core.Abort("invalid LevelAccu: " + other)
    }
)

enum Material : 
    case Gravel
    case Concrete
    case Bitumen
    case InterlockConcBlock
    case Other
    case Earth

given OptionPickler.ReadWriter[Material] = OptionPickler.readwriter[String].bimap[Material](
    {
        case Material.Gravel => "Gravel"
        case Material.Concrete => "Concrete"
        case Material.Bitumen => "Bitumen"
        case Material.InterlockConcBlock => "Interlock Conc Block"
        case Material.Other => "Other"
        case Material.Earth => "Earth"
    },
    {
        case "Gravel" => Material.Gravel
        case "Concrete" => Material.Concrete
        case "Bitumen" => Material.Bitumen
        case "Interlock Conc Block" => Material.InterlockConcBlock
        case "Other" => Material.Other
        case "Earth" => Material.Earth
        case other => throw new upickle.core.Abort("invalid Material: " + other)
    }
)

enum MiSymbolo : 
    case Pen2265535Brush1016777215

given OptionPickler.ReadWriter[MiSymbolo] = OptionPickler.readwriter[String].bimap[MiSymbolo](
    {
        case MiSymbolo.Pen2265535Brush1016777215 => "Pen (2, 2, 65535) Brush (1, 0, 16777215)"
    },
    {
        case "Pen (2, 2, 65535) Brush (1, 0, 16777215)" => MiSymbolo.Pen2265535Brush1016777215
        case other => throw new upickle.core.Abort("invalid MiSymbolo: " + other)
    }
)

enum PropertiesType : 
    case BoatRamp

given OptionPickler.ReadWriter[PropertiesType] = OptionPickler.readwriter[String].bimap[PropertiesType](
    {
        case PropertiesType.BoatRamp => "Boat Ramp"
    },
    {
        case "Boat Ramp" => PropertiesType.BoatRamp
        case other => throw new upickle.core.Abort("invalid PropertiesType: " + other)
    }
)

enum Status : 
    case Current

given OptionPickler.ReadWriter[Status] = OptionPickler.readwriter[String].bimap[Status](
    {
        case Status.Current => "CURRENT"
    },
    {
        case "CURRENT" => Status.Current
        case other => throw new upickle.core.Abort("invalid Status: " + other)
    }
)
