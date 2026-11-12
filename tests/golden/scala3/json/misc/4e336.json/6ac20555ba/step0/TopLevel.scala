package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val total_population : Seq[TotalPopulation]
) derives Encoder.AsObject, Decoder

case class TotalPopulation (
    val date : String,
    val population : Long
) derives Encoder.AsObject, Decoder
