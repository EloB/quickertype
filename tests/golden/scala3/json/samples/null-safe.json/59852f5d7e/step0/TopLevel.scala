package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val item : Seq[Item]
) derives Encoder.AsObject, Decoder

case class Item (
    val address : Option[Address] = None,
    val created_at : Option[java.time.Instant] = None,
    val name : String,
    val sex : Option[Long] = None
) derives Encoder.AsObject, Decoder

case class Address (
    val city : String,
    val country : String,
    val street : String
) derives Encoder.AsObject, Decoder
