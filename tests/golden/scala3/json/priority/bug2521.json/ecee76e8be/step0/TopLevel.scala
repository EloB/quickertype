package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

case class TopLevel (
    val options : Seq[OptionElement]
) derives Encoder.AsObject, Decoder

case class OptionElement (
    val foo : Option[String] = None,
    val name : String
) derives Encoder.AsObject, Decoder
