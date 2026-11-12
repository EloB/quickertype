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
    val acronym : Option[String],
    val activity_consult_committees : String,
    val activity_eu_legislative : String,
    val activity_expert_groups : String,
    val activity_high_level_groups : String,
    val activity_industry_forums : String,
    val activity_inter_groups : String,
    val activity_other : Option[String],
    val activity_relevant_comm : String,
    val be_office_country : Option[String] = None,
    val be_office_lat : Option[Double] = None,
    val be_office_lon : Option[Double] = None,
    val be_office_phone : Option[String] = None,
    val be_office_post_code : Option[String] = None,
    val be_office_postbox : Option[String] = None,
    val be_office_street : Option[String] = None,
    val be_office_town : Option[String] = None,
    val code_of_conduct : String,
    val contact_country : Long,
    val created_at : java.time.Instant,
    val entity : String,
    val goals : String,
    val head : String,
    val head_office_country : String,
    val head_office_lat : Option[Double],
    val head_office_lon : Option[Double],
    val head_office_phone : String,
    val head_office_post_code : Option[String],
    val head_office_postbox : Option[String],
    val head_office_street : String,
    val head_office_town : String,
    val id : String,
    val identification_code : String,
    val info_members : String,
    val last_update_date : java.time.Instant,
    val legal : String,
    val legal_status : String,
    val main_category : Long,
    val main_category_title : String,
    val members : Long,
    val members_100 : Option[Long],
    val members_25 : Option[Long],
    val members_50 : Option[Long],
    val members_75 : Option[Long],
    val members_fte : Double,
    val name : String,
    val native_name : Option[ujson.Value],
    val networking : Option[String],
    val number_of_natural_persons : Option[Long],
    val other_code_of_conduct : Option[String],
    val registration_date : java.time.Instant,
    val status : Status,
    val structure_members : String,
    val sub_category : Long,
    val sub_category_title : String,
    val updated_at : java.time.Instant,
    val uri : String,
    val web_site_url : Option[String]
) derives OptionPickler.ReadWriter

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
