package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TextClassificationOutputElement]
given (using ev : TextClassificationOutputElement): Encoder[Seq[TextClassificationOutputElement]] = Encoder.encodeSeq[TextClassificationOutputElement]

case class TextClassificationOutputElement (
    val label : String,
    val score : Double
) derives Encoder.AsObject, Decoder
