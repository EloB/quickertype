package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val coordinates : Option[Seq[Coordinate]] = None,
    val count : Option[Long] = None,
    val label : Option[String] = None,
    val requiredCoordinates : Seq[Coordinate],
    val requiredCount : Long,
    val requiredLabel : String,
    val weight : Option[Double] = None
) derives Encoder.AsObject, Decoder

case class Coordinate (
    val latitude : Double,
    val longitude : Double
) derives Encoder.AsObject, Decoder
