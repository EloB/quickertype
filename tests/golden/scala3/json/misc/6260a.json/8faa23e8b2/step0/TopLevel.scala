package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val base : String,
    val date : String,
    val rates : Map[String, Double]
) derives Encoder.AsObject, Decoder
