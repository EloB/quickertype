package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val laureates : Seq[Laureate]
) derives Encoder.AsObject, Decoder

case class Laureate (
    val born : String,
    val bornCity : Option[String] = None,
    val bornCountry : Option[String] = None,
    val bornCountryCode : Option[String] = None,
    val died : String,
    val diedCity : Option[String] = None,
    val diedCountry : Option[String] = None,
    val diedCountryCode : Option[String] = None,
    val firstname : Option[String] = None,
    val gender : Gender,
    val id : String,
    val prizes : Seq[Prize],
    val surname : Option[String] = None
) derives Encoder.AsObject, Decoder

enum Gender : 
    case Male
    case Female
    case Org

given Decoder[Gender] = Decoder.decodeString.emap {
    case "male" => scala.Right(Gender.Male)
    case "female" => scala.Right(Gender.Female)
    case "org" => scala.Right(Gender.Org)
    case other => scala.Left("invalid Gender: " + other)
}
given Encoder[Gender] = Encoder.encodeString.contramap {
    case Gender.Male => "male"
    case Gender.Female => "female"
    case Gender.Org => "org"
}

case class Prize (
    val affiliations : Seq[AffiliationElement],
    val category : Option[Category] = None,
    val motivation : Option[String] = None,
    val overallMotivation : Option[String] = None,
    val share : Option[String] = None,
    val year : Option[String] = None
) derives Encoder.AsObject, Decoder

type AffiliationElement = AffiliationClass | Seq[Option[Json]]
given Decoder[AffiliationElement] = {
    List[Decoder[AffiliationElement]](
        Decoder[Seq[Option[Json]]].widen,
        Decoder[AffiliationClass].widen,
    ).reduceLeft(_ or _)
}

given Encoder[AffiliationElement] = Encoder.instance {
    case enc0 : Seq[Option[Json]] => Encoder.encodeSeq[Option[Json]].apply(enc0)
    case enc1 : AffiliationClass => Encoder.AsObject[AffiliationClass].apply(enc1)
}

case class AffiliationClass (
    val city : Option[String] = None,
    val country : Option[String] = None,
    val name : Option[String] = None
) derives Encoder.AsObject, Decoder

enum Category : 
    case Physics
    case Chemistry
    case Peace
    case Medicine
    case Literature
    case Economics

given Decoder[Category] = Decoder.decodeString.emap {
    case "physics" => scala.Right(Category.Physics)
    case "chemistry" => scala.Right(Category.Chemistry)
    case "peace" => scala.Right(Category.Peace)
    case "medicine" => scala.Right(Category.Medicine)
    case "literature" => scala.Right(Category.Literature)
    case "economics" => scala.Right(Category.Economics)
    case other => scala.Left("invalid Category: " + other)
}
given Encoder[Category] = Encoder.encodeString.contramap {
    case Category.Physics => "physics"
    case Category.Chemistry => "chemistry"
    case Category.Peace => "peace"
    case Category.Medicine => "medicine"
    case Category.Literature => "literature"
    case Category.Economics => "economics"
}
