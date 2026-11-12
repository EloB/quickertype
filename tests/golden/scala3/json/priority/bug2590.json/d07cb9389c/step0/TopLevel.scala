package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val invoices : Seq[Invoice]
) derives Encoder.AsObject, Decoder

case class Invoice (
    val createdAt : Option[java.time.Instant] = None,
    val dueDate : Option[String] = None,
    val name : String
) derives Encoder.AsObject, Decoder
