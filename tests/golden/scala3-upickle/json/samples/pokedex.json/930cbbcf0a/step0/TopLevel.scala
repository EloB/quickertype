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
    val pokemon : Seq[Pokemon]
) derives OptionPickler.ReadWriter

case class Pokemon (
    val avg_spawns : Double,
    val candy : String,
    val candy_count : Option[Long] = None,
    val egg : Egg,
    val height : String,
    val id : Long,
    val img : String,
    val multipliers : Option[Seq[Double]],
    val name : String,
    val next_evolution : Option[Seq[Evolution]] = None,
    val num : String,
    val `type` : Seq[Type],
    val prev_evolution : Option[Seq[Evolution]] = None,
    val spawn_chance : Double,
    val spawn_time : String,
    val weaknesses : Seq[Type],
    val weight : String
) derives OptionPickler.ReadWriter

enum Egg : 
    case The2KM
    case NotInEggs
    case The5KM
    case The10KM
    case OmanyteCandy

given OptionPickler.ReadWriter[Egg] = OptionPickler.readwriter[String].bimap[Egg](
    {
        case Egg.The2KM => "2 km"
        case Egg.NotInEggs => "Not in Eggs"
        case Egg.The5KM => "5 km"
        case Egg.The10KM => "10 km"
        case Egg.OmanyteCandy => "Omanyte Candy"
    },
    {
        case "2 km" => Egg.The2KM
        case "Not in Eggs" => Egg.NotInEggs
        case "5 km" => Egg.The5KM
        case "10 km" => Egg.The10KM
        case "Omanyte Candy" => Egg.OmanyteCandy
        case other => throw new upickle.core.Abort("invalid Egg: " + other)
    }
)

case class Evolution (
    val name : String,
    val num : String
) derives OptionPickler.ReadWriter

enum Type : 
    case Fire
    case Ice
    case Flying
    case Psychic
    case Water
    case Ground
    case Rock
    case Electric
    case Grass
    case Fighting
    case Poison
    case Bug
    case Fairy
    case Ghost
    case Dark
    case Steel
    case Dragon
    case Normal

given OptionPickler.ReadWriter[Type] = OptionPickler.readwriter[String].bimap[Type](
    {
        case Type.Fire => "Fire"
        case Type.Ice => "Ice"
        case Type.Flying => "Flying"
        case Type.Psychic => "Psychic"
        case Type.Water => "Water"
        case Type.Ground => "Ground"
        case Type.Rock => "Rock"
        case Type.Electric => "Electric"
        case Type.Grass => "Grass"
        case Type.Fighting => "Fighting"
        case Type.Poison => "Poison"
        case Type.Bug => "Bug"
        case Type.Fairy => "Fairy"
        case Type.Ghost => "Ghost"
        case Type.Dark => "Dark"
        case Type.Steel => "Steel"
        case Type.Dragon => "Dragon"
        case Type.Normal => "Normal"
    },
    {
        case "Fire" => Type.Fire
        case "Ice" => Type.Ice
        case "Flying" => Type.Flying
        case "Psychic" => Type.Psychic
        case "Water" => Type.Water
        case "Ground" => Type.Ground
        case "Rock" => Type.Rock
        case "Electric" => Type.Electric
        case "Grass" => Type.Grass
        case "Fighting" => Type.Fighting
        case "Poison" => Type.Poison
        case "Bug" => Type.Bug
        case "Fairy" => Type.Fairy
        case "Ghost" => Type.Ghost
        case "Dark" => Type.Dark
        case "Steel" => Type.Steel
        case "Dragon" => Type.Dragon
        case "Normal" => Type.Normal
        case other => throw new upickle.core.Abort("invalid Type: " + other)
    }
)
