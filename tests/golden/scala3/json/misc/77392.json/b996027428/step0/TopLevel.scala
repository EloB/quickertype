package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val designation : String,
    val discovery_date : java.time.Instant,
    val h_mag : Option[String] = None,
    val i_deg : String,
    val moid_au : String,
    val orbit_class : OrbitClass,
    val period_yr : Option[String] = None,
    val pha : Pha,
    val q_au_1 : String,
    val q_au_2 : Option[String] = None
) derives Encoder.AsObject, Decoder

enum OrbitClass : 
    case Apollo
    case Amor
    case Aten
    case Comet
    case JupiterFamilyComet
    case HalleyTypeComet
    case ParabolicComet
    case OrbitClassJupiterFamilyComet
    case EnckeTypeComet

given Decoder[OrbitClass] = Decoder.decodeString.emap {
    case "Apollo" => scala.Right(OrbitClass.Apollo)
    case "Amor" => scala.Right(OrbitClass.Amor)
    case "Aten" => scala.Right(OrbitClass.Aten)
    case "Comet" => scala.Right(OrbitClass.Comet)
    case "Jupiter-family Comet" => scala.Right(OrbitClass.JupiterFamilyComet)
    case "Halley-type Comet*" => scala.Right(OrbitClass.HalleyTypeComet)
    case "Parabolic Comet" => scala.Right(OrbitClass.ParabolicComet)
    case "Jupiter-family Comet*" => scala.Right(OrbitClass.OrbitClassJupiterFamilyComet)
    case "Encke-type Comet" => scala.Right(OrbitClass.EnckeTypeComet)
    case other => scala.Left("invalid OrbitClass: " + other)
}
given Encoder[OrbitClass] = Encoder.encodeString.contramap {
    case OrbitClass.Apollo => "Apollo"
    case OrbitClass.Amor => "Amor"
    case OrbitClass.Aten => "Aten"
    case OrbitClass.Comet => "Comet"
    case OrbitClass.JupiterFamilyComet => "Jupiter-family Comet"
    case OrbitClass.HalleyTypeComet => "Halley-type Comet*"
    case OrbitClass.ParabolicComet => "Parabolic Comet"
    case OrbitClass.OrbitClassJupiterFamilyComet => "Jupiter-family Comet*"
    case OrbitClass.EnckeTypeComet => "Encke-type Comet"
}

enum Pha : 
    case Y
    case N
    case NA

given Decoder[Pha] = Decoder.decodeString.emap {
    case "Y" => scala.Right(Pha.Y)
    case "N" => scala.Right(Pha.N)
    case "n/a" => scala.Right(Pha.NA)
    case other => scala.Left("invalid Pha: " + other)
}
given Encoder[Pha] = Encoder.encodeString.contramap {
    case Pha.Y => "Y"
    case Pha.N => "N"
    case Pha.NA => "n/a"
}
