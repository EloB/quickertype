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
    val booster : Seq[String],
    val border : String,
    val cards : Seq[Card],
    val code : String,
    val gathererCode : String,
    val magicCardsInfoCode : String,
    val mkm_id : Long,
    val mkm_name : String,
    val name : String,
    val releaseDate : String,
    val `type` : String
) derives OptionPickler.ReadWriter

case class Card (
    val artist : String,
    val `type` : String,
    val cmc : Long,
    val colorIdentity : Option[Seq[ColorIdentity]] = None,
    val colors : Option[Seq[Watermark]] = None,
    val flavor : Option[String] = None,
    val id : String,
    val imageName : String,
    val layout : Layout,
    val legalities : Seq[LegalityElement],
    val manaCost : Option[String] = None,
    val mciNumber : Option[String] = None,
    val multiverseid : Long,
    val name : String,
    val originalText : String,
    val originalType : String,
    val power : Option[String] = None,
    val printings : Seq[String],
    val rarity : Rarity,
    val reserved : Option[Boolean] = None,
    val rulings : Option[Seq[Ruling]] = None,
    val subtypes : Option[Seq[String]] = None,
    val supertypes : Option[Seq[String]] = None,
    val text : Option[String] = None,
    val toughness : Option[String] = None,
    val types : Seq[Type],
    val variations : Option[Seq[Long]] = None,
    val watermark : Option[Watermark] = None
) derives OptionPickler.ReadWriter

enum ColorIdentity : 
    case W
    case R
    case B
    case G
    case U

given OptionPickler.ReadWriter[ColorIdentity] = OptionPickler.readwriter[String].bimap[ColorIdentity](
    {
        case ColorIdentity.W => "W"
        case ColorIdentity.R => "R"
        case ColorIdentity.B => "B"
        case ColorIdentity.G => "G"
        case ColorIdentity.U => "U"
    },
    {
        case "W" => ColorIdentity.W
        case "R" => ColorIdentity.R
        case "B" => ColorIdentity.B
        case "G" => ColorIdentity.G
        case "U" => ColorIdentity.U
        case other => throw new upickle.core.Abort("invalid ColorIdentity: " + other)
    }
)

enum Watermark : 
    case White
    case Red
    case Black
    case Green
    case Blue

given OptionPickler.ReadWriter[Watermark] = OptionPickler.readwriter[String].bimap[Watermark](
    {
        case Watermark.White => "White"
        case Watermark.Red => "Red"
        case Watermark.Black => "Black"
        case Watermark.Green => "Green"
        case Watermark.Blue => "Blue"
    },
    {
        case "White" => Watermark.White
        case "Red" => Watermark.Red
        case "Black" => Watermark.Black
        case "Green" => Watermark.Green
        case "Blue" => Watermark.Blue
        case other => throw new upickle.core.Abort("invalid Watermark: " + other)
    }
)

enum Layout : 
    case Normal

given OptionPickler.ReadWriter[Layout] = OptionPickler.readwriter[String].bimap[Layout](
    {
        case Layout.Normal => "normal"
    },
    {
        case "normal" => Layout.Normal
        case other => throw new upickle.core.Abort("invalid Layout: " + other)
    }
)

case class LegalityElement (
    val format : String,
    val legality : LegalityEnum
) derives OptionPickler.ReadWriter

enum LegalityEnum : 
    case Legal
    case Banned
    case Restricted

given OptionPickler.ReadWriter[LegalityEnum] = OptionPickler.readwriter[String].bimap[LegalityEnum](
    {
        case LegalityEnum.Legal => "Legal"
        case LegalityEnum.Banned => "Banned"
        case LegalityEnum.Restricted => "Restricted"
    },
    {
        case "Legal" => LegalityEnum.Legal
        case "Banned" => LegalityEnum.Banned
        case "Restricted" => LegalityEnum.Restricted
        case other => throw new upickle.core.Abort("invalid LegalityEnum: " + other)
    }
)

enum Rarity : 
    case Uncommon
    case Rare
    case Common
    case BasicLand

given OptionPickler.ReadWriter[Rarity] = OptionPickler.readwriter[String].bimap[Rarity](
    {
        case Rarity.Uncommon => "Uncommon"
        case Rarity.Rare => "Rare"
        case Rarity.Common => "Common"
        case Rarity.BasicLand => "Basic Land"
    },
    {
        case "Uncommon" => Rarity.Uncommon
        case "Rare" => Rarity.Rare
        case "Common" => Rarity.Common
        case "Basic Land" => Rarity.BasicLand
        case other => throw new upickle.core.Abort("invalid Rarity: " + other)
    }
)

case class Ruling (
    val date : String,
    val text : String
) derives OptionPickler.ReadWriter

enum Type : 
    case Creature
    case Artifact
    case Instant
    case Land
    case Enchantment
    case Sorcery

given OptionPickler.ReadWriter[Type] = OptionPickler.readwriter[String].bimap[Type](
    {
        case Type.Creature => "Creature"
        case Type.Artifact => "Artifact"
        case Type.Instant => "Instant"
        case Type.Land => "Land"
        case Type.Enchantment => "Enchantment"
        case Type.Sorcery => "Sorcery"
    },
    {
        case "Creature" => Type.Creature
        case "Artifact" => Type.Artifact
        case "Instant" => Type.Instant
        case "Land" => Type.Land
        case "Enchantment" => Type.Enchantment
        case "Sorcery" => Type.Sorcery
        case other => throw new upickle.core.Abort("invalid Type: " + other)
    }
)
