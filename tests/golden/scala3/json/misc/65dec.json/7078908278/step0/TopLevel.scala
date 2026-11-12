package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

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
) derives Encoder.AsObject, Decoder

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
) derives Encoder.AsObject, Decoder

enum ColorIdentity : 
    case W
    case R
    case B
    case G
    case U

given Decoder[ColorIdentity] = Decoder.decodeString.emap {
    case "W" => scala.Right(ColorIdentity.W)
    case "R" => scala.Right(ColorIdentity.R)
    case "B" => scala.Right(ColorIdentity.B)
    case "G" => scala.Right(ColorIdentity.G)
    case "U" => scala.Right(ColorIdentity.U)
    case other => scala.Left("invalid ColorIdentity: " + other)
}
given Encoder[ColorIdentity] = Encoder.encodeString.contramap {
    case ColorIdentity.W => "W"
    case ColorIdentity.R => "R"
    case ColorIdentity.B => "B"
    case ColorIdentity.G => "G"
    case ColorIdentity.U => "U"
}

enum Watermark : 
    case White
    case Red
    case Black
    case Green
    case Blue

given Decoder[Watermark] = Decoder.decodeString.emap {
    case "White" => scala.Right(Watermark.White)
    case "Red" => scala.Right(Watermark.Red)
    case "Black" => scala.Right(Watermark.Black)
    case "Green" => scala.Right(Watermark.Green)
    case "Blue" => scala.Right(Watermark.Blue)
    case other => scala.Left("invalid Watermark: " + other)
}
given Encoder[Watermark] = Encoder.encodeString.contramap {
    case Watermark.White => "White"
    case Watermark.Red => "Red"
    case Watermark.Black => "Black"
    case Watermark.Green => "Green"
    case Watermark.Blue => "Blue"
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
    val format : String,
    val legality : LegalityEnum
) derives Encoder.AsObject, Decoder

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

enum Type : 
    case Creature
    case Artifact
    case Instant
    case Land
    case Enchantment
    case Sorcery

given Decoder[Type] = Decoder.decodeString.emap {
    case "Creature" => scala.Right(Type.Creature)
    case "Artifact" => scala.Right(Type.Artifact)
    case "Instant" => scala.Right(Type.Instant)
    case "Land" => scala.Right(Type.Land)
    case "Enchantment" => scala.Right(Type.Enchantment)
    case "Sorcery" => scala.Right(Type.Sorcery)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
    case Type.Creature => "Creature"
    case Type.Artifact => "Artifact"
    case Type.Instant => "Instant"
    case Type.Land => "Land"
    case Type.Enchantment => "Enchantment"
    case Type.Sorcery => "Sorcery"
}
