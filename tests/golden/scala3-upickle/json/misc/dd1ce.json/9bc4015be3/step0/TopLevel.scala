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
    val booster : Seq[Booster],
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

enum Booster : 
    case Rare
    case Uncommon
    case Common

given OptionPickler.ReadWriter[Booster] = OptionPickler.readwriter[String].bimap[Booster](
    {
        case Booster.Rare => "rare"
        case Booster.Uncommon => "uncommon"
        case Booster.Common => "common"
    },
    {
        case "rare" => Booster.Rare
        case "uncommon" => Booster.Uncommon
        case "common" => Booster.Common
        case other => throw new upickle.core.Abort("invalid Booster: " + other)
    }
)

case class Card (
    val artist : String,
    val `type` : String,
    val cmc : Long,
    val colorIdentity : Option[Seq[ColorIdentity]] = None,
    val colors : Option[Seq[Color]] = None,
    val flavor : Option[String] = None,
    val id : String,
    val imageName : String,
    val layout : Layout,
    val legalities : Seq[LegalityElement],
    val manaCost : Option[String] = None,
    val mciNumber : Option[String] = None,
    val multiverseid : Long,
    val name : String,
    val originalText : Option[String] = None,
    val originalType : String,
    val power : Option[String] = None,
    val printings : Seq[String],
    val rarity : Rarity,
    val reserved : Option[Boolean] = None,
    val rulings : Option[Seq[Ruling]] = None,
    val subtypes : Option[Seq[String]] = None,
    val supertypes : Option[Seq[Supertype]] = None,
    val text : Option[String] = None,
    val toughness : Option[String] = None,
    val types : Seq[Type],
    val variations : Option[Seq[Long]] = None
) derives OptionPickler.ReadWriter

enum ColorIdentity : 
    case U
    case B
    case W
    case G
    case R

given OptionPickler.ReadWriter[ColorIdentity] = OptionPickler.readwriter[String].bimap[ColorIdentity](
    {
        case ColorIdentity.U => "U"
        case ColorIdentity.B => "B"
        case ColorIdentity.W => "W"
        case ColorIdentity.G => "G"
        case ColorIdentity.R => "R"
    },
    {
        case "U" => ColorIdentity.U
        case "B" => ColorIdentity.B
        case "W" => ColorIdentity.W
        case "G" => ColorIdentity.G
        case "R" => ColorIdentity.R
        case other => throw new upickle.core.Abort("invalid ColorIdentity: " + other)
    }
)

enum Color : 
    case Blue
    case Black
    case White
    case Green
    case Red

given OptionPickler.ReadWriter[Color] = OptionPickler.readwriter[String].bimap[Color](
    {
        case Color.Blue => "Blue"
        case Color.Black => "Black"
        case Color.White => "White"
        case Color.Green => "Green"
        case Color.Red => "Red"
    },
    {
        case "Blue" => Color.Blue
        case "Black" => Color.Black
        case "White" => Color.White
        case "Green" => Color.Green
        case "Red" => Color.Red
        case other => throw new upickle.core.Abort("invalid Color: " + other)
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
    val format : Format,
    val legality : LegalityEnum
) derives OptionPickler.ReadWriter

enum Format : 
    case Commander
    case Legacy
    case Modern
    case Vintage
    case TimeSpiralBlock
    case RavnicaBlock
    case IceAgeBlock
    case TempestBlock
    case OnslaughtBlock
    case MasquesBlock
    case MirageBlock
    case UrzaBlock
    case ScarsOfMirrodinBlock
    case MirrodinBlock
    case AmonkhetBlock
    case BattleForZendikarBlock
    case InnistradBlock
    case InvasionBlock
    case KaladeshBlock
    case KamigawaBlock
    case KhansOfTarkirBlock
    case LorwynShadowmoorBlock
    case OdysseyBlock
    case ReturnToRavnicaBlock
    case ShadowsOverInnistradBlock
    case ShardsOfAlaraBlock
    case Standard
    case TherosBlock
    case UnSets
    case ZendikarBlock

given OptionPickler.ReadWriter[Format] = OptionPickler.readwriter[String].bimap[Format](
    {
        case Format.Commander => "Commander"
        case Format.Legacy => "Legacy"
        case Format.Modern => "Modern"
        case Format.Vintage => "Vintage"
        case Format.TimeSpiralBlock => "Time Spiral Block"
        case Format.RavnicaBlock => "Ravnica Block"
        case Format.IceAgeBlock => "Ice Age Block"
        case Format.TempestBlock => "Tempest Block"
        case Format.OnslaughtBlock => "Onslaught Block"
        case Format.MasquesBlock => "Masques Block"
        case Format.MirageBlock => "Mirage Block"
        case Format.UrzaBlock => "Urza Block"
        case Format.ScarsOfMirrodinBlock => "Scars of Mirrodin Block"
        case Format.MirrodinBlock => "Mirrodin Block"
        case Format.AmonkhetBlock => "Amonkhet Block"
        case Format.BattleForZendikarBlock => "Battle for Zendikar Block"
        case Format.InnistradBlock => "Innistrad Block"
        case Format.InvasionBlock => "Invasion Block"
        case Format.KaladeshBlock => "Kaladesh Block"
        case Format.KamigawaBlock => "Kamigawa Block"
        case Format.KhansOfTarkirBlock => "Khans of Tarkir Block"
        case Format.LorwynShadowmoorBlock => "Lorwyn-Shadowmoor Block"
        case Format.OdysseyBlock => "Odyssey Block"
        case Format.ReturnToRavnicaBlock => "Return to Ravnica Block"
        case Format.ShadowsOverInnistradBlock => "Shadows over Innistrad Block"
        case Format.ShardsOfAlaraBlock => "Shards of Alara Block"
        case Format.Standard => "Standard"
        case Format.TherosBlock => "Theros Block"
        case Format.UnSets => "Un-Sets"
        case Format.ZendikarBlock => "Zendikar Block"
    },
    {
        case "Commander" => Format.Commander
        case "Legacy" => Format.Legacy
        case "Modern" => Format.Modern
        case "Vintage" => Format.Vintage
        case "Time Spiral Block" => Format.TimeSpiralBlock
        case "Ravnica Block" => Format.RavnicaBlock
        case "Ice Age Block" => Format.IceAgeBlock
        case "Tempest Block" => Format.TempestBlock
        case "Onslaught Block" => Format.OnslaughtBlock
        case "Masques Block" => Format.MasquesBlock
        case "Mirage Block" => Format.MirageBlock
        case "Urza Block" => Format.UrzaBlock
        case "Scars of Mirrodin Block" => Format.ScarsOfMirrodinBlock
        case "Mirrodin Block" => Format.MirrodinBlock
        case "Amonkhet Block" => Format.AmonkhetBlock
        case "Battle for Zendikar Block" => Format.BattleForZendikarBlock
        case "Innistrad Block" => Format.InnistradBlock
        case "Invasion Block" => Format.InvasionBlock
        case "Kaladesh Block" => Format.KaladeshBlock
        case "Kamigawa Block" => Format.KamigawaBlock
        case "Khans of Tarkir Block" => Format.KhansOfTarkirBlock
        case "Lorwyn-Shadowmoor Block" => Format.LorwynShadowmoorBlock
        case "Odyssey Block" => Format.OdysseyBlock
        case "Return to Ravnica Block" => Format.ReturnToRavnicaBlock
        case "Shadows over Innistrad Block" => Format.ShadowsOverInnistradBlock
        case "Shards of Alara Block" => Format.ShardsOfAlaraBlock
        case "Standard" => Format.Standard
        case "Theros Block" => Format.TherosBlock
        case "Un-Sets" => Format.UnSets
        case "Zendikar Block" => Format.ZendikarBlock
        case other => throw new upickle.core.Abort("invalid Format: " + other)
    }
)

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

enum Supertype : 
    case Basic

given OptionPickler.ReadWriter[Supertype] = OptionPickler.readwriter[String].bimap[Supertype](
    {
        case Supertype.Basic => "Basic"
    },
    {
        case "Basic" => Supertype.Basic
        case other => throw new upickle.core.Abort("invalid Supertype: " + other)
    }
)

enum Type : 
    case Creature
    case Instant
    case Enchantment
    case Artifact
    case Sorcery
    case Land

given OptionPickler.ReadWriter[Type] = OptionPickler.readwriter[String].bimap[Type](
    {
        case Type.Creature => "Creature"
        case Type.Instant => "Instant"
        case Type.Enchantment => "Enchantment"
        case Type.Artifact => "Artifact"
        case Type.Sorcery => "Sorcery"
        case Type.Land => "Land"
    },
    {
        case "Creature" => Type.Creature
        case "Instant" => Type.Instant
        case "Enchantment" => Type.Enchantment
        case "Artifact" => Type.Artifact
        case "Sorcery" => Type.Sorcery
        case "Land" => Type.Land
        case other => throw new upickle.core.Abort("invalid Type: " + other)
    }
)
