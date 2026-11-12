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


type TopLevel = List[TopLevelUnion]

type TopLevelUnion = FluffyTopLevel | Seq[PurpleTopLevel]
given unionReaderTopLevelUnion: OptionPickler.Reader[TopLevelUnion] = JsonExt.badMerge[TopLevelUnion](
    summon[OptionPickler.Reader[Seq[PurpleTopLevel]]],
    summon[OptionPickler.Reader[FluffyTopLevel]],
    )

given unionWriterTopLevelUnion: OptionPickler.Writer[TopLevelUnion] = OptionPickler.writer[ujson.Value].comap[TopLevelUnion]{ _v =>
    (_v: @unchecked) match 
        case v: Seq[PurpleTopLevel] => OptionPickler.writeJs[Seq[PurpleTopLevel]](v)
        case v: FluffyTopLevel => OptionPickler.writeJs[FluffyTopLevel](v)
}

case class PurpleTopLevel (
    val adminregion : Adminregion,
    val capitalCity : String,
    val id : String,
    val incomeLevel : Adminregion,
    val iso2Code : String,
    val latitude : String,
    val lendingType : Adminregion,
    val longitude : String,
    val name : String,
    val region : Adminregion
) derives OptionPickler.ReadWriter

case class Adminregion (
    val id : ID,
    val value : Value
) derives OptionPickler.ReadWriter

enum ID : 
    case Empty
    case SAS
    case SSA
    case Eca
    case Lac
    case EAP
    case Mna
    case Hic
    case Lic
    case Na
    case Lmc
    case Umc
    case Lnx
    case Idx
    case Ibd
    case Idb
    case Lcn
    case Ssf
    case Ecs
    case Mea
    case EAS
    case Nac

given OptionPickler.ReadWriter[ID] = OptionPickler.readwriter[String].bimap[ID](
    {
        case ID.Empty => ""
        case ID.SAS => "SAS"
        case ID.SSA => "SSA"
        case ID.Eca => "ECA"
        case ID.Lac => "LAC"
        case ID.EAP => "EAP"
        case ID.Mna => "MNA"
        case ID.Hic => "HIC"
        case ID.Lic => "LIC"
        case ID.Na => "NA"
        case ID.Lmc => "LMC"
        case ID.Umc => "UMC"
        case ID.Lnx => "LNX"
        case ID.Idx => "IDX"
        case ID.Ibd => "IBD"
        case ID.Idb => "IDB"
        case ID.Lcn => "LCN"
        case ID.Ssf => "SSF"
        case ID.Ecs => "ECS"
        case ID.Mea => "MEA"
        case ID.EAS => "EAS"
        case ID.Nac => "NAC"
    },
    {
        case "" => ID.Empty
        case "SAS" => ID.SAS
        case "SSA" => ID.SSA
        case "ECA" => ID.Eca
        case "LAC" => ID.Lac
        case "EAP" => ID.EAP
        case "MNA" => ID.Mna
        case "HIC" => ID.Hic
        case "LIC" => ID.Lic
        case "NA" => ID.Na
        case "LMC" => ID.Lmc
        case "UMC" => ID.Umc
        case "LNX" => ID.Lnx
        case "IDX" => ID.Idx
        case "IBD" => ID.Ibd
        case "IDB" => ID.Idb
        case "LCN" => ID.Lcn
        case "SSF" => ID.Ssf
        case "ECS" => ID.Ecs
        case "MEA" => ID.Mea
        case "EAS" => ID.EAS
        case "NAC" => ID.Nac
        case other => throw new upickle.core.Abort("invalid ID: " + other)
    }
)

enum Value : 
    case Empty
    case SouthAsia
    case SubSaharanAfricaExcludingHighIncome
    case EuropeCentralAsiaExcludingHighIncome
    case LatinAmericaCaribbeanExcludingHighIncome
    case EastAsiaPacificExcludingHighIncome
    case MiddleEastNorthAfricaExcludingHighIncome
    case HighIncome
    case LowIncome
    case Aggregates
    case LowerMiddleIncome
    case UpperMiddleIncome
    case NotClassified
    case Ida
    case Ibrd
    case Blend
    case LatinAmericaCaribbean
    case SubSaharanAfrica
    case EuropeCentralAsia
    case MiddleEastNorthAfrica
    case EastAsiaPacific
    case NorthAmerica

given OptionPickler.ReadWriter[Value] = OptionPickler.readwriter[String].bimap[Value](
    {
        case Value.Empty => ""
        case Value.SouthAsia => "South Asia"
        case Value.SubSaharanAfricaExcludingHighIncome => "Sub-Saharan Africa (excluding high income)"
        case Value.EuropeCentralAsiaExcludingHighIncome => "Europe & Central Asia (excluding high income)"
        case Value.LatinAmericaCaribbeanExcludingHighIncome => "Latin America & Caribbean (excluding high income)"
        case Value.EastAsiaPacificExcludingHighIncome => "East Asia & Pacific (excluding high income)"
        case Value.MiddleEastNorthAfricaExcludingHighIncome => "Middle East & North Africa (excluding high income)"
        case Value.HighIncome => "High income"
        case Value.LowIncome => "Low income"
        case Value.Aggregates => "Aggregates"
        case Value.LowerMiddleIncome => "Lower middle income"
        case Value.UpperMiddleIncome => "Upper middle income"
        case Value.NotClassified => "Not classified"
        case Value.Ida => "IDA"
        case Value.Ibrd => "IBRD"
        case Value.Blend => "Blend"
        case Value.LatinAmericaCaribbean => "Latin America & Caribbean "
        case Value.SubSaharanAfrica => "Sub-Saharan Africa "
        case Value.EuropeCentralAsia => "Europe & Central Asia"
        case Value.MiddleEastNorthAfrica => "Middle East & North Africa"
        case Value.EastAsiaPacific => "East Asia & Pacific"
        case Value.NorthAmerica => "North America"
    },
    {
        case "" => Value.Empty
        case "South Asia" => Value.SouthAsia
        case "Sub-Saharan Africa (excluding high income)" => Value.SubSaharanAfricaExcludingHighIncome
        case "Europe & Central Asia (excluding high income)" => Value.EuropeCentralAsiaExcludingHighIncome
        case "Latin America & Caribbean (excluding high income)" => Value.LatinAmericaCaribbeanExcludingHighIncome
        case "East Asia & Pacific (excluding high income)" => Value.EastAsiaPacificExcludingHighIncome
        case "Middle East & North Africa (excluding high income)" => Value.MiddleEastNorthAfricaExcludingHighIncome
        case "High income" => Value.HighIncome
        case "Low income" => Value.LowIncome
        case "Aggregates" => Value.Aggregates
        case "Lower middle income" => Value.LowerMiddleIncome
        case "Upper middle income" => Value.UpperMiddleIncome
        case "Not classified" => Value.NotClassified
        case "IDA" => Value.Ida
        case "IBRD" => Value.Ibrd
        case "Blend" => Value.Blend
        case "Latin America & Caribbean " => Value.LatinAmericaCaribbean
        case "Sub-Saharan Africa " => Value.SubSaharanAfrica
        case "Europe & Central Asia" => Value.EuropeCentralAsia
        case "Middle East & North Africa" => Value.MiddleEastNorthAfrica
        case "East Asia & Pacific" => Value.EastAsiaPacific
        case "North America" => Value.NorthAmerica
        case other => throw new upickle.core.Abort("invalid Value: " + other)
    }
)

case class FluffyTopLevel (
    val page : Long,
    val pages : Long,
    val per_page : String,
    val total : Long
) derives OptionPickler.ReadWriter
