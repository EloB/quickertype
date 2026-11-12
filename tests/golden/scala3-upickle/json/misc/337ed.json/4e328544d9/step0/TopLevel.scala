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
    val count : Long,
    val facets : Facets,
    val limit : Long,
    val next : String,
    val offset : Long,
    val previous : Boolean,
    val results : Seq[Result]
) derives OptionPickler.ReadWriter

case class Facets()
 derives OptionPickler.ReadWriter
case class Result (
    val cost_absolute : Option[Long],
    val cost_max : Option[Long],
    val cost_min : Option[Long],
    val created_at : java.time.Instant,
    val customIncomes : Seq[CustomIncome],
    val direct_rep_costs_max : Option[ujson.Value],
    val direct_rep_costs_min : Option[ujson.Value],
    val end_date : java.time.Instant,
    val eur_sources_grants : Long,
    val eur_sources_grants_src : Option[String],
    val eur_sources_procurement : Long,
    val eur_sources_procurement_src : Option[String],
    val id : String,
    val new_organisation : Option[ujson.Value],
    val no_clients : Option[String],
    val other_financial_information : Option[String],
    val other_sources_contributions : Option[Long],
    val other_sources_donation : Option[Long],
    val other_sources_total : Option[Long],
    val public_financing_infranational : Option[Long],
    val public_financing_national : Option[Long],
    val public_financing_total : Option[Long],
    val representative : String,
    val `type` : ResultType,
    val start_date : java.time.Instant,
    val status : Status,
    val total_budget : Option[Long],
    val turnover_absolute : Option[Long],
    val turnover_max : Option[Long],
    val turnover_min : Option[Long],
    val updated_at : java.time.Instant,
    val uri : String
) derives OptionPickler.ReadWriter

case class CustomIncome (
    val amount : Long,
    val created_at : java.time.Instant,
    val `type` : CustomIncomeType,
    val id : String,
    val name : String,
    val status : Status,
    val updated_at : java.time.Instant,
    val uri : String
) derives OptionPickler.ReadWriter

enum CustomIncomeType : 
    case Public
    case Other

given OptionPickler.ReadWriter[CustomIncomeType] = OptionPickler.readwriter[String].bimap[CustomIncomeType](
    {
        case CustomIncomeType.Public => "public"
        case CustomIncomeType.Other => "other"
    },
    {
        case "public" => CustomIncomeType.Public
        case "other" => CustomIncomeType.Other
        case other => throw new upickle.core.Abort("invalid CustomIncomeType: " + other)
    }
)

enum Status : 
    case Active
    case Inactive

given OptionPickler.ReadWriter[Status] = OptionPickler.readwriter[String].bimap[Status](
    {
        case Status.Active => "active"
        case Status.Inactive => "inactive"
    },
    {
        case "active" => Status.Active
        case "inactive" => Status.Inactive
        case other => throw new upickle.core.Abort("invalid Status: " + other)
    }
)

enum ResultType : 
    case FinancialDataNGO
    case FinancialDataLawyer
    case FinancialDataTradeAssociation

given OptionPickler.ReadWriter[ResultType] = OptionPickler.readwriter[String].bimap[ResultType](
    {
        case ResultType.FinancialDataNGO => "FinancialDataNGO"
        case ResultType.FinancialDataLawyer => "FinancialDataLawyer"
        case ResultType.FinancialDataTradeAssociation => "FinancialDataTradeAssociation"
    },
    {
        case "FinancialDataNGO" => ResultType.FinancialDataNGO
        case "FinancialDataLawyer" => ResultType.FinancialDataLawyer
        case "FinancialDataTradeAssociation" => ResultType.FinancialDataTradeAssociation
        case other => throw new upickle.core.Abort("invalid ResultType: " + other)
    }
)
