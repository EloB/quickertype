package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val Date : java.time.Instant,
    val ID : Long,
    val Sponsor : String,
    val Title : String
) derives Encoder.AsObject, Decoder
