package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

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
) derives Encoder.AsObject, Decoder

enum Booster : 
    case Rare
    case Uncommon
    case Common

given Decoder[Booster] = Decoder.decodeString.emap {
    case "rare" => scala.Right(Booster.Rare)
    case "uncommon" => scala.Right(Booster.Uncommon)
    case "common" => scala.Right(Booster.Common)
    case other => scala.Left("invalid Booster: " + other)
}
given Encoder[Booster] = Encoder.encodeString.contramap {
    case Booster.Rare => "rare"
    case Booster.Uncommon => "uncommon"
    case Booster.Common => "common"
}

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
) derives Encoder.AsObject, Decoder

enum ColorIdentity : 
    case U
    case B
    case W
    case G
    case R

given Decoder[ColorIdentity] = Decoder.decodeString.emap {
    case "U" => scala.Right(ColorIdentity.U)
    case "B" => scala.Right(ColorIdentity.B)
    case "W" => scala.Right(ColorIdentity.W)
    case "G" => scala.Right(ColorIdentity.G)
    case "R" => scala.Right(ColorIdentity.R)
    case other => scala.Left("invalid ColorIdentity: " + other)
}
given Encoder[ColorIdentity] = Encoder.encodeString.contramap {
    case ColorIdentity.U => "U"
    case ColorIdentity.B => "B"
    case ColorIdentity.W => "W"
    case ColorIdentity.G => "G"
    case ColorIdentity.R => "R"
}

enum Color : 
    case Blue
    case Black
    case White
    case Green
    case Red

given Decoder[Color] = Decoder.decodeString.emap {
    case "Blue" => scala.Right(Color.Blue)
    case "Black" => scala.Right(Color.Black)
    case "White" => scala.Right(Color.White)
    case "Green" => scala.Right(Color.Green)
    case "Red" => scala.Right(Color.Red)
    case other => scala.Left("invalid Color: " + other)
}
given Encoder[Color] = Encoder.encodeString.contramap {
    case Color.Blue => "Blue"
    case Color.Black => "Black"
    case Color.White => "White"
    case Color.Green => "Green"
    case Color.Red => "Red"
}

enum Layout : 
    case Normal

given Decoder[Layout] = Decoder.decodeString.emap {
    case "normal" => scala.Right(Layout.Normal)
    case other => scala.Left("invalid Layout: " + other)
}
given Encoder[Layout] = Encoder.encodeString.contramap {
    case Layout.Normal => "normal"
}

case class LegalityElement (
    val format : Format,
    val legality : LegalityEnum
) derives Encoder.AsObject, Decoder

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

given Decoder[Format] = Decoder.decodeString.emap {
    case "Commander" => scala.Right(Format.Commander)
    case "Legacy" => scala.Right(Format.Legacy)
    case "Modern" => scala.Right(Format.Modern)
    case "Vintage" => scala.Right(Format.Vintage)
    case "Time Spiral Block" => scala.Right(Format.TimeSpiralBlock)
    case "Ravnica Block" => scala.Right(Format.RavnicaBlock)
    case "Ice Age Block" => scala.Right(Format.IceAgeBlock)
    case "Tempest Block" => scala.Right(Format.TempestBlock)
    case "Onslaught Block" => scala.Right(Format.OnslaughtBlock)
    case "Masques Block" => scala.Right(Format.MasquesBlock)
    case "Mirage Block" => scala.Right(Format.MirageBlock)
    case "Urza Block" => scala.Right(Format.UrzaBlock)
    case "Scars of Mirrodin Block" => scala.Right(Format.ScarsOfMirrodinBlock)
    case "Mirrodin Block" => scala.Right(Format.MirrodinBlock)
    case "Amonkhet Block" => scala.Right(Format.AmonkhetBlock)
    case "Battle for Zendikar Block" => scala.Right(Format.BattleForZendikarBlock)
    case "Innistrad Block" => scala.Right(Format.InnistradBlock)
    case "Invasion Block" => scala.Right(Format.InvasionBlock)
    case "Kaladesh Block" => scala.Right(Format.KaladeshBlock)
    case "Kamigawa Block" => scala.Right(Format.KamigawaBlock)
    case "Khans of Tarkir Block" => scala.Right(Format.KhansOfTarkirBlock)
    case "Lorwyn-Shadowmoor Block" => scala.Right(Format.LorwynShadowmoorBlock)
    case "Odyssey Block" => scala.Right(Format.OdysseyBlock)
    case "Return to Ravnica Block" => scala.Right(Format.ReturnToRavnicaBlock)
    case "Shadows over Innistrad Block" => scala.Right(Format.ShadowsOverInnistradBlock)
    case "Shards of Alara Block" => scala.Right(Format.ShardsOfAlaraBlock)
    case "Standard" => scala.Right(Format.Standard)
    case "Theros Block" => scala.Right(Format.TherosBlock)
    case "Un-Sets" => scala.Right(Format.UnSets)
    case "Zendikar Block" => scala.Right(Format.ZendikarBlock)
    case other => scala.Left("invalid Format: " + other)
}
given Encoder[Format] = Encoder.encodeString.contramap {
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
}

enum LegalityEnum : 
    case Legal
    case Banned
    case Restricted

given Decoder[LegalityEnum] = Decoder.decodeString.emap {
    case "Legal" => scala.Right(LegalityEnum.Legal)
    case "Banned" => scala.Right(LegalityEnum.Banned)
    case "Restricted" => scala.Right(LegalityEnum.Restricted)
    case other => scala.Left("invalid LegalityEnum: " + other)
}
given Encoder[LegalityEnum] = Encoder.encodeString.contramap {
    case LegalityEnum.Legal => "Legal"
    case LegalityEnum.Banned => "Banned"
    case LegalityEnum.Restricted => "Restricted"
}

enum Rarity : 
    case Uncommon
    case Rare
    case Common
    case BasicLand

given Decoder[Rarity] = Decoder.decodeString.emap {
    case "Uncommon" => scala.Right(Rarity.Uncommon)
    case "Rare" => scala.Right(Rarity.Rare)
    case "Common" => scala.Right(Rarity.Common)
    case "Basic Land" => scala.Right(Rarity.BasicLand)
    case other => scala.Left("invalid Rarity: " + other)
}
given Encoder[Rarity] = Encoder.encodeString.contramap {
    case Rarity.Uncommon => "Uncommon"
    case Rarity.Rare => "Rare"
    case Rarity.Common => "Common"
    case Rarity.BasicLand => "Basic Land"
}

case class Ruling (
    val date : String,
    val text : String
) derives Encoder.AsObject, Decoder

enum Supertype : 
    case Basic

given Decoder[Supertype] = Decoder.decodeString.emap {
    case "Basic" => scala.Right(Supertype.Basic)
    case other => scala.Left("invalid Supertype: " + other)
}
given Encoder[Supertype] = Encoder.encodeString.contramap {
    case Supertype.Basic => "Basic"
}

enum Type : 
    case Creature
    case Instant
    case Enchantment
    case Artifact
    case Sorcery
    case Land

given Decoder[Type] = Decoder.decodeString.emap {
    case "Creature" => scala.Right(Type.Creature)
    case "Instant" => scala.Right(Type.Instant)
    case "Enchantment" => scala.Right(Type.Enchantment)
    case "Artifact" => scala.Right(Type.Artifact)
    case "Sorcery" => scala.Right(Type.Sorcery)
    case "Land" => scala.Right(Type.Land)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.Creature => "Creature"
    case Type.Instant => "Instant"
    case Type.Enchantment => "Enchantment"
    case Type.Artifact => "Artifact"
    case Type.Sorcery => "Sorcery"
    case Type.Land => "Land"
}
