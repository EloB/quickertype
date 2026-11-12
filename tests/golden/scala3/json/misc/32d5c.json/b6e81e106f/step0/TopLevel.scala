package quicktype

import io.circe.syntax._
import io.circe._
import cats.syntax.functor._

// If a union has a null in, then we'll need this too... 
type NullValue = None.type

type TopLevel = List[TopLevelElement]
given (using ev : TopLevelElement): Encoder[Seq[TopLevelElement]] = Encoder.encodeSeq[TopLevelElement]

case class TopLevelElement (
    val BirthDate : Option[java.time.Instant] = None,
    val BirthDateIsProtected : Boolean,
    val GenderTypeID : Long,
    val Notes : String,
    val ParliamentaryName : String,
    val PersonID : Long,
    val PhotoURL : String,
    val PreferredName : String
) derives Encoder.AsObject, Decoder
