package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val pokemon : Seq[Pokemon]
) derives Encoder.AsObject, Decoder

case class Pokemon (
    val avg_spawns : Double,
    val candy : String,
    val candy_count : Option[Long] = None,
    val egg : Egg,
    val height : String,
    val id : Long,
    val img : String,
    val multipliers : Option[Seq[Double]] = None,
    val name : String,
    val next_evolution : Option[Seq[Evolution]] = None,
    val num : String,
    val `type` : Seq[Type],
    val prev_evolution : Option[Seq[Evolution]] = None,
    val spawn_chance : Double,
    val spawn_time : String,
    val weaknesses : Seq[Type],
    val weight : String
) derives Encoder.AsObject, Decoder

enum Egg : 
    case The2KM
    case NotInEggs
    case The5KM
    case The10KM
    case OmanyteCandy

given Decoder[Egg] = Decoder.decodeString.emap {
    case "2 km" => scala.Right(Egg.The2KM)
    case "Not in Eggs" => scala.Right(Egg.NotInEggs)
    case "5 km" => scala.Right(Egg.The5KM)
    case "10 km" => scala.Right(Egg.The10KM)
    case "Omanyte Candy" => scala.Right(Egg.OmanyteCandy)
    case other => scala.Left("invalid Egg: " + other)
}
given Encoder[Egg] = Encoder.encodeString.contramap {
    case Egg.The2KM => "2 km"
    case Egg.NotInEggs => "Not in Eggs"
    case Egg.The5KM => "5 km"
    case Egg.The10KM => "10 km"
    case Egg.OmanyteCandy => "Omanyte Candy"
}

case class Evolution (
    val name : String,
    val num : String
) derives Encoder.AsObject, Decoder

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

given Decoder[Type] = Decoder.decodeString.emap {
    case "Fire" => scala.Right(Type.Fire)
    case "Ice" => scala.Right(Type.Ice)
    case "Flying" => scala.Right(Type.Flying)
    case "Psychic" => scala.Right(Type.Psychic)
    case "Water" => scala.Right(Type.Water)
    case "Ground" => scala.Right(Type.Ground)
    case "Rock" => scala.Right(Type.Rock)
    case "Electric" => scala.Right(Type.Electric)
    case "Grass" => scala.Right(Type.Grass)
    case "Fighting" => scala.Right(Type.Fighting)
    case "Poison" => scala.Right(Type.Poison)
    case "Bug" => scala.Right(Type.Bug)
    case "Fairy" => scala.Right(Type.Fairy)
    case "Ghost" => scala.Right(Type.Ghost)
    case "Dark" => scala.Right(Type.Dark)
    case "Steel" => scala.Right(Type.Steel)
    case "Dragon" => scala.Right(Type.Dragon)
    case "Normal" => scala.Right(Type.Normal)
    case other => scala.Left("invalid Type: " + other)
}
given Encoder[Type] = Encoder.encodeString.contramap {
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
}
