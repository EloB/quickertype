package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val input : Seq[Item]
) derives Encoder.AsObject, Decoder

case class Item (
    val content : Option[String] = None,
    val id : Option[String] = None,
    val output : Option[String] = None,
    val summary : Option[String] = None
) derives Encoder.AsObject, Decoder
