package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val data : Map[String, Datum],
    val description : Description
) derives Encoder.AsObject, Decoder

case class Datum (
    val anomaly : String,
    val value : String
) derives Encoder.AsObject, Decoder

case class Description (
    val base_period : String,
    val missing : Long,
    val title : String,
    val units : String
) derives Encoder.AsObject, Decoder
